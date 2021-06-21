package top.tobing.platform.auth.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import top.tobing.common.api.Result;
import top.tobing.common.constant.PlatformAuthConstant;
import top.tobing.common.api.BziCodeEnum;
import top.tobing.common.constant.PlatformConstant;
import top.tobing.common.to.MemberRespVo;
import top.tobing.common.utils.R;
import top.tobing.platform.auth.feign.MemberFeignService;
import top.tobing.platform.auth.feign.ThirdPartFeignService;
import top.tobing.platform.auth.vo.UserLoginVo;
import top.tobing.platform.auth.vo.UserRegisterVo;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.TimeUnit;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

/**
 * @Author tobing
 * @Date 2021/4/15 16:51
 * @Description
 */
@Slf4j
@Controller
public class LoginController {

    @Autowired
    private StringRedisTemplate redisTemplate;
    @Autowired
    private ThirdPartFeignService thirdPartFeignService;
    @Autowired
    private MemberFeignService memberFeignService;

    /**
     * 发送验证码
     * 1、校验电话号码格式是否正确：正则表达式
     * 2、校核是合法请求，接口防刷，redis中放置过期时间key(验证码_上传发送验证码的时间)
     * 3、生成验证码，调用第三方服务发送
     */
    @GetMapping("/sms/sendCode")
    @ResponseBody
    public R sendCode(@RequestParam("phone") String phone) {
        // 1、校验电话号码格式是否正确
        boolean flag = Pattern.matches("^(13[0-9]|14[5|7]|15[0|1|2|3|4|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\\d{8}$", phone);
        if (!flag) {
            return R.error(BziCodeEnum.PHONE_ILLEGAL_EXCEPTION.getCode(), BziCodeEnum.PHONE_ILLEGAL_EXCEPTION.getMsg());
        }

        // 2、校核是合法请求，接口防刷
        String key = PlatformAuthConstant.SMS_CODE_CACHE_PREFIX + phone;
        String value = redisTemplate.opsForValue().get(key);
        if (!StringUtils.isEmpty(value)) {
            String ttl = value.split("_")[1];
            long time = Long.parseLong(ttl);
            if (System.currentTimeMillis() - time < PlatformAuthConstant.SMS_CODE_TIMEOUT) {
                return R.error(BziCodeEnum.AUTH_SMS_FREQUENTLY.getCode(), BziCodeEnum.AUTH_SMS_FREQUENTLY.getMsg());
            }
        }

        // 3、生成验证码，调用第三方服务发送
        String code = String.valueOf(10000 + new Random().nextInt(9999));
        String msg = code + "_" + System.currentTimeMillis();
        redisTemplate.opsForValue().set(PlatformAuthConstant.SMS_CODE_CACHE_PREFIX + phone, msg, 10, TimeUnit.MINUTES);
        // 对于发送验证码，如果调用失败，无需处理，只需要等待用下次再次点击
        Result result = thirdPartFeignService.sendCode(phone, code);
        log.info("发送验证码完毕：{}", result.toString());
        return R.ok();
    }

    /**
     * 用户注册
     * 1、校验用户提交的数据
     * 2、校验验证码信息
     * 3、调用第三方服务保存会员信息
     *
     * @param userRegisterVo     用户表单信息
     * @param bindingResult      封装了校验结果的信息
     * @param redirectAttributes 实现在重定向是携带数据，实现原理是将数据放到Session
     */
    @PostMapping("/register")
    public String register(@Valid UserRegisterVo userRegisterVo,
                           BindingResult bindingResult,
                           RedirectAttributes redirectAttributes) {

        // 1、校验用户提交的数据
        if (bindingResult.hasErrors()) {
            // 如果校验出错，将对应的出错的信息分装到Map，并返回
            Map<String, String> errorMap = bindingResult.getFieldErrors()
                    .stream().collect(Collectors.toMap(FieldError::getField, FieldError::getDefaultMessage, (oldKey, newKey) -> oldKey));
            redirectAttributes.addFlashAttribute("errorMap", errorMap);
            return "redirect:" + PlatformAuthConstant.PLATFORM_AUTH_DOMAIN + "/register.html";
        }

        // 2、校验验证码信息
        String key = PlatformAuthConstant.SMS_CODE_CACHE_PREFIX + userRegisterVo.getPhone();
        String value = redisTemplate.opsForValue().get(key);
        if (value == null || !userRegisterVo.getCode().equals(value.split("_")[0])) {
            Map<String, String> errorMap = new HashMap<>();
            errorMap.put("msg", "验证码错误");
            redirectAttributes.addFlashAttribute("errorMap", errorMap);
            return "redirect:" + PlatformAuthConstant.PLATFORM_AUTH_DOMAIN + "/register.html";
        }

        // 3、调用第三方服务保存会员信息
        Result result = memberFeignService.register(userRegisterVo);
        if (result.getCode() != BziCodeEnum.SUCCESS.getCode()) {
            Map<String, String> errorMap = new HashMap<>();
            errorMap.put("msg", result.getMsg());
            redirectAttributes.addFlashAttribute("errorMap", errorMap);
            return "redirect:" + PlatformAuthConstant.PLATFORM_AUTH_DOMAIN + "/register.html";
        }
        log.info("登录成功");
        return "redirect:" + PlatformAuthConstant.PLATFORM_AUTH_DOMAIN + "/login.html";
    }

    /**
     * 用户登录
     * 1、校验用户表单数据
     * 2、调用远程服务查询用户数据
     * 3、将数据保存到Session
     *
     * @param userLoginVo        用户提交的表单数据
     * @param bindingResult      参数校验结果封装
     * @param session            将用户数据放到Session中
     * @param redirectAttributes 重定向
     */
    @PostMapping("/login")
    public String login(@Valid UserLoginVo userLoginVo,
                        BindingResult bindingResult,
                        HttpSession session,
                        RedirectAttributes redirectAttributes) {
        // 1、校验用户表单数据
        if (bindingResult.hasErrors()) {
            Map<String, String> errorMap = bindingResult.getFieldErrors()
                    .stream().collect(Collectors.toMap(FieldError::getField, FieldError::getDefaultMessage, (oldKey, newKey) -> oldKey));
            redirectAttributes.addFlashAttribute("errorMap", errorMap);
            return "redirect:" + PlatformAuthConstant.PLATFORM_AUTH_DOMAIN + "/login.html";
        }

        // 2、调用远程服务查询用户数据
        Result<MemberRespVo> login = memberFeignService.login(userLoginVo);
        MemberRespVo memberRespVo = login.getData();
        if (memberRespVo == null) {
            Map<String, String> errorMap = new HashMap<>();
            errorMap.put("msg", login.getMsg());
            redirectAttributes.addFlashAttribute("errorMap", errorMap);
            return "redirect:" + PlatformAuthConstant.PLATFORM_AUTH_DOMAIN + "/login.html";
        }

        // 3、将数据保存到Session
        session.setAttribute(PlatformAuthConstant.LOGIN_USER, memberRespVo);
        return "redirect:" + PlatformConstant.PLATFORM_DOMAIN_FULL_NAME;
    }

    @GetMapping("/login.html")
    public String loginHtml(HttpSession session) {
        if (session.getAttribute(PlatformAuthConstant.LOGIN_USER) == null) {
            return "login";
        }
        return "redirect:" + PlatformConstant.PLATFORM_DOMAIN_FULL_NAME;
    }
}

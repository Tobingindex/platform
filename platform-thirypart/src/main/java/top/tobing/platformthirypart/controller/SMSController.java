package top.tobing.platformthirypart.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import top.tobing.common.api.BziCodeEnum;
import top.tobing.common.api.Result;
import top.tobing.common.utils.R;
import top.tobing.platformthirypart.config.impl.AliSmsConfig;
import top.tobing.platformthirypart.config.impl.TencentSmsConfig;


/**
 * @Author tobing
 * @Date 2021/4/15 19:59
 * @Description
 */
@Slf4j
@RestController
public class SMSController {

    @Autowired
    private TencentSmsConfig tencentSmsConfig;

    /**
     * 发送给指定手机号发送短信验证码
     */
    @GetMapping("/sms/sendCode")
    public Result sendCode(@RequestParam("phone") String phone, @RequestParam("code") String code) {
        try {
            tencentSmsConfig.sendSms(phone, code);
        } catch (Exception e) {
            log.error("验证码发送失败：{}", e.getMessage());
            return Result.error(BziCodeEnum.THIRD_PART_SEND_SMS_ERROR.getCode(), BziCodeEnum.THIRD_PART_ERROR.getMsg());
        }
        return Result.ok();
    }

}

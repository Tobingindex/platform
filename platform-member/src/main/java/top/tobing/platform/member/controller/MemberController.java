package top.tobing.platform.member.controller;

import java.util.Arrays;
import java.util.Map;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import top.tobing.common.api.BziCodeEnum;
import top.tobing.common.api.Result;
import top.tobing.common.to.MemberRespVo;
import top.tobing.platform.member.entity.MemberEntity;
import top.tobing.platform.member.exception.AccountOrPasswordException;
import top.tobing.platform.member.exception.PhoneExistException;
import top.tobing.platform.member.exception.UserExistException;
import top.tobing.platform.member.service.MemberService;
import top.tobing.common.utils.PageUtils;
import top.tobing.common.utils.R;
import top.tobing.platform.member.vo.MemberLoginVo;
import top.tobing.platform.member.vo.MemberRegisterVo;


/**
 * 会员
 *
 * @author tobing
 * @email tobing6379@gmail.com
 * @date 2021-03-07 21:14:09
 */
@Slf4j
@RestController
@RequestMapping("member/member")
public class MemberController {
    @Autowired
    private MemberService memberService;

    // 注册会员
    @PostMapping("/register")
    public Result register(@RequestBody MemberRegisterVo memberRegisterVo) {
        try {
            memberService.register(memberRegisterVo);
        } catch (UserExistException userExistException) {
            log.warn("{}:用户名已存在", memberRegisterVo.getUsername());
            return Result.error(BziCodeEnum.USERNAME_EXIST_EXCEPTION.getCode(), BziCodeEnum.USERNAME_EXIST_EXCEPTION.getMsg());
        } catch (PhoneExistException phoneExistException) {
            log.warn("{}:手机号已存在", memberRegisterVo.getPhone());
            return Result.error(BziCodeEnum.PHONE_EXIST_EXCEPTION.getCode(), BziCodeEnum.PHONE_EXIST_EXCEPTION.getMsg());
        } catch (Exception e) {
            log.error("未知异常：", e);
            return Result.error(BziCodeEnum.SERVER_ERROR.getCode(), BziCodeEnum.SERVER_ERROR.getMsg());
        }
        return Result.ok();
    }

    // 会员登录
    @PostMapping("/login")
    public Result<MemberRespVo> login(@RequestBody MemberLoginVo memberLoginVo) {
        MemberRespVo memberRespVo;
        try {
            memberRespVo = memberService.login(memberLoginVo);
        } catch (AccountOrPasswordException e) {
            log.warn("账号或密码错误！");
            return Result.error(BziCodeEnum.INVALID_ACCOUNT_PASSWORD_EXCEPTION.getCode(),
                    BziCodeEnum.INVALID_ACCOUNT_PASSWORD_EXCEPTION.getMsg());
        }
        return Result.ok(memberRespVo);
    }

    /**
     * 列表
     */
    @RequestMapping("/list")
    //@RequiresPermissions("member:member:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = memberService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    //@RequiresPermissions("member:member:info")
    public R info(@PathVariable("id") Long id) {
        MemberEntity member = memberService.getById(id);

        return R.ok().put("member", member);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    //@RequiresPermissions("member:member:save")
    public R save(@RequestBody MemberEntity member) {
        memberService.save(member);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    //@RequiresPermissions("member:member:update")
    public R update(@RequestBody MemberEntity member) {
        memberService.updateById(member);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    //@RequiresPermissions("member:member:delete")
    public R delete(@RequestBody Long[] ids) {
        memberService.removeByIds(Arrays.asList(ids));

        return R.ok();
    }

}

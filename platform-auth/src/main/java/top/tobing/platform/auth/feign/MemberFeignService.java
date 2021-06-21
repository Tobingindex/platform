package top.tobing.platform.auth.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import top.tobing.common.api.Result;
import top.tobing.common.to.MemberRespVo;
import top.tobing.platform.auth.vo.UserLoginVo;
import top.tobing.platform.auth.vo.UserRegisterVo;

/**
 * @Author tobing
 * @Date 2021/4/16 21:01
 * @Description
 */
@FeignClient("platform-member")
public interface MemberFeignService {

    @PostMapping("/member/member/register")
    Result register(@RequestBody UserRegisterVo UserRegisterVo);

    @PostMapping("/member/member/login")
    Result<MemberRespVo> login(@RequestBody UserLoginVo userLoginVo);
}

package top.tobing.platform.auth.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import top.tobing.common.api.Result;
import top.tobing.common.utils.R;

/**
 * @Author tobing
 * @Date 2021/4/15 20:38
 * @Description
 */
@FeignClient("platform-thirypart")
public interface ThirdPartFeignService {

    @GetMapping("/sms/sendCode")
    public Result sendCode(@RequestParam("phone") String phone, @RequestParam("code") String code);
}

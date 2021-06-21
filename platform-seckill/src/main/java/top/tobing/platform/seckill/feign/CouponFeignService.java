package top.tobing.platform.seckill.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import top.tobing.platform.seckill.vo.SeckillSessionWithSkusVo;

import java.util.List;

/**
 * @Author tobing
 * @Date 2021/5/2 10:10
 * @Description
 */
@FeignClient("platform-coupon")
public interface CouponFeignService {

    @GetMapping("/coupon/seckillsession/recently3DaySession")
    public List<SeckillSessionWithSkusVo> recently3DaySession();

}

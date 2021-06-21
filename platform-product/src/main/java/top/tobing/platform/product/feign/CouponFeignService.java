package top.tobing.platform.product.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import top.tobing.common.to.SkuFullReductionTo;
import top.tobing.common.to.SpuBoundsTo;
import top.tobing.common.utils.R;
import top.tobing.platform.product.feign.fallback.CouponFeignServiceFallback;

/**
 * @Author tobing
 * @Date 2021/3/9 16:05
 * @Description feing远程调用
 * 1、扫描到@FeignClient注解，获取platform-coupon服务IP端口
 * 2、@RequestBody将参数内容封装为json放到请求体中
 * 3、通过IP和端口以及@RequestMapping调用对应服务的对应接口
 * 4、返回
 */
@FeignClient(value = "platform-coupon", fallback = CouponFeignServiceFallback.class)
public interface CouponFeignService {

    /**
     * 保存积分信息
     */
    @PostMapping("coupon/spubounds/save")
    R saveSpuBounds(@RequestBody SpuBoundsTo spuBoundsTo);

    /**
     * 保存满减、优惠信息
     */
    @PostMapping("coupon/skufullreduction/save/full")
    R saveSkuFullReduction(@RequestBody SkuFullReductionTo skuFullReductionTo);
}

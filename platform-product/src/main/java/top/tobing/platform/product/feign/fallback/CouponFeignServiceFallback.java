package top.tobing.platform.product.feign.fallback;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import top.tobing.common.api.BziCodeEnum;
import top.tobing.common.to.SkuFullReductionTo;
import top.tobing.common.to.SpuBoundsTo;
import top.tobing.common.utils.R;
import top.tobing.platform.product.feign.CouponFeignService;

/**
 * @Author tobing
 * @Date 2021/5/3 17:13
 * @Description
 */
@Slf4j
@Component
public class CouponFeignServiceFallback implements CouponFeignService {
    @Override
    public R saveSpuBounds(SpuBoundsTo spuBoundsTo) {
        log.error("远程服务调用异常，现进行熔断处理!!!");
        return R.error(BziCodeEnum.TOO_MANY_REQUEST.getCode(), BziCodeEnum.TOO_MANY_REQUEST.getMsg());
    }

    @Override
    public R saveSkuFullReduction(SkuFullReductionTo skuFullReductionTo) {
        log.error("远程服务调用异常，现进行熔断处理!!!");
        return R.error(BziCodeEnum.TOO_MANY_REQUEST.getCode(), BziCodeEnum.TOO_MANY_REQUEST.getMsg());
    }
}

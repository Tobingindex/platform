package top.tobing.platform.product.feign.fallback;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import top.tobing.platform.product.feign.SeckillFeignService;
import top.tobing.platform.product.vo.SkuSeckillVo;

/**
 * @Author tobing
 * @Date 2021/5/3 17:18
 * @Description
 */
@Slf4j
@Component
public class SeckillFeignServiceFallback implements SeckillFeignService {
    @Override
    public SkuSeckillVo getSeckillSkuBySkuId(Long skuId) {
        log.error("远程服务调用异常，现进行熔断处理!!!");
        return null;
    }
}

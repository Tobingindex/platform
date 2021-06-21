package top.tobing.platform.product.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import top.tobing.platform.product.feign.fallback.SeckillFeignServiceFallback;
import top.tobing.platform.product.vo.SkuSeckillVo;

/**
 * @Author tobing
 * @Date 2021/5/2 20:27
 * @Description
 */
@FeignClient(value = "platform-seckill", fallback = SeckillFeignServiceFallback.class)
public interface SeckillFeignService {

    /**
     * 根据skuId查询商品秒杀信息
     */
    @GetMapping("/getSeckillSkuBySkuId/{skuId}")
    public SkuSeckillVo getSeckillSkuBySkuId(@PathVariable("skuId") Long skuId);
}

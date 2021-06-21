package top.tobing.platform.order.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import top.tobing.platform.order.vo.SpuInfoVo;

/**
 * @Author tobing
 * @Date 2021/4/24 20:35
 * @Description
 */
@FeignClient("platform-product")
public interface ProductFeignService {

    /**
     * 根据skuId查询对应spu信息
     */
    @GetMapping("/product/spuinfo/infoBySkuId/{skuId}")
    public SpuInfoVo getBySkuId(@PathVariable("skuId") Long skuId);
}

package top.tobing.platform.seckill.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import top.tobing.platform.seckill.vo.SkuInfoVo;

import java.util.List;

/**
 * @Author tobing
 * @Date 2021/5/2 10:39
 * @Description
 */
@FeignClient("platform-product")
public interface ProductFeignService {

    /**
     * 根据skuId批量查询sku信息【远程调用】
     */
    @PostMapping("/product/skuinfo/listSkuInfoBySkuId")
    public List<SkuInfoVo> listBySkuId(@RequestBody List<Long> skuIds);
}

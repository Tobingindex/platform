package top.tobing.platform.ware.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import top.tobing.common.utils.R;

/**
 * @Author tobing
 * @Date 2021/3/30 16:37
 * @Description 商品服务调用
 */
@FeignClient("platform-product")
public interface ProductFeignService {

    @RequestMapping("product/skuinfo/info/{skuId}")
    public R info(@PathVariable("skuId") Long skuId);
}

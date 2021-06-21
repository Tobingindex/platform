package top.tobing.platform.cart.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import top.tobing.platform.cart.vo.SkuInfoTo;

import java.math.BigDecimal;
import java.util.List;

/**
 * @Author tobing
 * @Date 2021/4/20 10:52
 * @Description 商品服务远程调用
 */
@FeignClient("platform-product")
public interface ProductFeignService {

    /**
     * 根据skuId查询商品的价格
     */
    @GetMapping("/product/skuinfo/priceBySkuId/{skuId}")
    public BigDecimal priceBySkuId(@PathVariable("skuId") Long skuId);

    /**
     * 根据skuId查询商品详情
     */
    @RequestMapping("/product/skuinfo/detail/{skuId}")
    SkuInfoTo detail(@PathVariable("skuId") Long skuId);


    /**
     * 根据skuId查询商品销售属性
     */
    @GetMapping("/product/skuinfo/saleList/{skuId}")
    public List<String> getSkuSaleList(@PathVariable("skuId") Long skuId);
}

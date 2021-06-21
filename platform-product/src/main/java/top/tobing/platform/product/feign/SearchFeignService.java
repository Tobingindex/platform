package top.tobing.platform.product.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import top.tobing.common.to.es.ProductEsTo;
import top.tobing.common.utils.R;
import top.tobing.platform.product.feign.fallback.SearchFeignServiceFallback;

import java.util.List;

/**
 * @Author tobing
 * @Date 2021/4/6 22:27
 * @Description Platform-Search远程调用接口
 */
@FeignClient(value = "platform-search", fallback = SearchFeignServiceFallback.class)
public interface SearchFeignService {

    /**
     * 商品上架：保存数据到ES中
     */
    @PostMapping("/search/save/product")
    public R saveProductESTo(@RequestBody List<ProductEsTo> productEsToList);
}

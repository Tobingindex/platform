package top.tobing.platform.product.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import top.tobing.common.to.SkuStockSearchVo;
import top.tobing.common.utils.R;
import top.tobing.platform.product.feign.fallback.WareFeignServiceFallback;

import java.util.List;

/**
 * @Author tobing
 * @Date 2021/4/3 12:59
 * @Description
 */
@FeignClient(value = "platform-ware", fallback = WareFeignServiceFallback.class)
public interface WareFeignService {
    /**
     * 批量查询库存信息
     */
    @RequestMapping("/ware/waresku/batch")
    public List<SkuStockSearchVo> batchSkuStock(@RequestBody List<Long> ids);
}

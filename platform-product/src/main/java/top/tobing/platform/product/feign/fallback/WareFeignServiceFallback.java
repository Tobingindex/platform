package top.tobing.platform.product.feign.fallback;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import top.tobing.common.to.SkuStockSearchVo;
import top.tobing.platform.product.feign.WareFeignService;

import java.util.List;

/**
 * @Author tobing
 * @Date 2021/5/3 17:19
 * @Description
 */
@Slf4j
@Component
public class WareFeignServiceFallback implements WareFeignService {
    @Override
    public List<SkuStockSearchVo> batchSkuStock(List<Long> ids) {
        log.error("远程服务调用异常，现进行熔断处理!!!");
        return null;
    }
}

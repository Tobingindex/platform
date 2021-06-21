package top.tobing.platform.product.feign.fallback;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import top.tobing.common.api.BziCodeEnum;
import top.tobing.common.to.es.ProductEsTo;
import top.tobing.common.utils.R;
import top.tobing.platform.product.feign.SearchFeignService;

import java.util.List;

/**
 * @Author tobing
 * @Date 2021/5/3 17:17
 * @Description
 */
@Slf4j
@Component
public class SearchFeignServiceFallback implements SearchFeignService {
    @Override
    public R saveProductESTo(List<ProductEsTo> productEsToList) {
        log.error("远程服务调用异常，现进行熔断处理!!!");
        return R.error(BziCodeEnum.TOO_MANY_REQUEST.getCode(), BziCodeEnum.TOO_MANY_REQUEST.getMsg());
    }
}

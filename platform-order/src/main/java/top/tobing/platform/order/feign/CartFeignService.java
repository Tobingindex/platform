package top.tobing.platform.order.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import top.tobing.common.api.Result;
import top.tobing.platform.order.vo.OrderItemVo;

import java.util.List;

/**
 * @Author tobing
 * @Date 2021/4/23 21:33
 * @Description
 */
@FeignClient("platform-cart")
public interface CartFeignService {

    // 查询登录用户选中的购物项
    @GetMapping("listOwnCheckItem")
    Result<List<OrderItemVo>> listOwnCheckItem();
}

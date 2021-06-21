package top.tobing.platform.ware.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import top.tobing.common.to.OrderTo;

/**
 * @Author tobing
 * @Date 2021/4/27 21:16
 * @Description
 */
@FeignClient("platform-order")
public interface OrderFeignService {

    /**
     * 根据订单号OrderSn查询订单状态信息
     */
    @GetMapping("/order/order/status/{orderSn}")
    public OrderTo getStatusByOrderSn(@PathVariable("orderSn") String orderSn);
}

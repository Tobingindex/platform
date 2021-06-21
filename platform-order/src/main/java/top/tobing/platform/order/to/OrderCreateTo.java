package top.tobing.platform.order.to;

import lombok.Data;
import top.tobing.platform.order.entity.OrderEntity;
import top.tobing.platform.order.entity.OrderItemEntity;

import java.math.BigDecimal;
import java.util.List;

/**
 * @Author tobing
 * @Date 2021/4/24 18:11
 * @Description 订单创建ViewObject
 */
@Data
public class OrderCreateTo {
    // 订单
    private OrderEntity order;
    // 订单项
    private List<OrderItemEntity> orderItems;
    // 计算的应付价格
    private BigDecimal payPrice;
    // 运费
    private BigDecimal fare;
}

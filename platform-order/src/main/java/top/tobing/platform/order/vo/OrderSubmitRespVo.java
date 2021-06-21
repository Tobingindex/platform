package top.tobing.platform.order.vo;

import lombok.Data;
import top.tobing.platform.order.entity.OrderEntity;

/**
 * @Author tobing
 * @Date 2021/4/24 16:57
 * @Description 订单表达提交响应Vo
 */
@Data
public class OrderSubmitRespVo {
    // 订单内容
    private OrderEntity orderEntity;
    // 状态码信息：0-成功 其他-错误
    private Integer code;
}

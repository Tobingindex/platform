package top.tobing.platform.order.vo;

import lombok.Data;

import java.math.BigDecimal;

/**
 * @Author tobing
 * @Date 2021/4/24 16:36
 * @Description 封装「订单确认页」提交的数据
 */
@Data
public class OrderSubmitVo {
    // 收货地址id
    private Long addrId;
    // 支付类型
    private Integer payType;
    // 防重令牌
    private String orderToken;
    // 应付价格：用于验证价格
    private BigDecimal payPrice;
    // 用户信息：通过session获取
    // 购物项信息：类似京东，到购物车中查找选中的商品
}

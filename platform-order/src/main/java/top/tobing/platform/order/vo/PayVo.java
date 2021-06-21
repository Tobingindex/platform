package top.tobing.platform.order.vo;

import lombok.Data;

/**
 * @Author tobing
 * @Date 2021/4/30 11:22
 * @Description
 */
@Data
public class PayVo {
    private String out_trade_no; // 商户订单号 必填
    private String subject; // 订单名称 必填
    private String total_amount;  // 付款金额 必填
    private String body; // 商品描述 可空
}

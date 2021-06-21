package top.tobing.common.to.mq;

import lombok.Data;

import java.math.BigDecimal;

/**
 * @Author tobing
 * @Date 2021/5/3 10:32
 * @Description
 */
@Data
public class SeckillOrderTo {
    // 订单号
    private String orderSn;
    // 活动场次id
    private Long promotionId;
    // 商品skuId
    private Long skuId;
    // 秒杀价格
    private BigDecimal seckillPrice;
    // 购买数量
    private Integer num;
    // 会员id
    private Long memberId;
}

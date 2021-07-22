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

    public String getOrderSn() {
        return orderSn;
    }

    public void setOrderSn(String orderSn) {
        this.orderSn = orderSn;
    }

    public Long getPromotionId() {
        return promotionId;
    }

    public void setPromotionId(Long promotionId) {
        this.promotionId = promotionId;
    }

    public Long getSkuId() {
        return skuId;
    }

    public void setSkuId(Long skuId) {
        this.skuId = skuId;
    }

    public BigDecimal getSeckillPrice() {
        return seckillPrice;
    }

    public void setSeckillPrice(BigDecimal seckillPrice) {
        this.seckillPrice = seckillPrice;
    }

    public Integer getNum() {
        return num;
    }

    public void setNum(Integer num) {
        this.num = num;
    }

    public Long getMemberId() {
        return memberId;
    }

    public void setMemberId(Long memberId) {
        this.memberId = memberId;
    }
}

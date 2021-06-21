package top.tobing.platform.product.vo;

import lombok.Data;

import java.math.BigDecimal;

/**
 * @Author tobing
 * @Date 2021/5/2 20:04
 * @Description 商品秒杀信息
 */
@Data
public class SkuSeckillVo {
    /**
     * 活动id
     */
    private Long promotionId;
    /**
     * 活动场次id
     */
    private Long promotionSessionId;
    /**
     * 商品id
     */
    private Long skuId;
    /**
     * 秒杀价格
     */
    private BigDecimal seckillPrice;
    /**
     * 秒杀总量
     */
    private BigDecimal seckillCount;
    /**
     * 每人限购数量
     */
    private BigDecimal seckillLimit;
    /**
     * 排序
     */
    private Integer seckillSort;
    /**
     * 商品活动开始时间
     */
    private Long startTime;
    /**
     * 商品活动结束时间
     */
    private Long endTime;
    /**
     * 商品参与此次活动的随机码
     */
    private String randomCode;
}

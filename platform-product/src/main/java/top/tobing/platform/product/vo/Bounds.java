package top.tobing.platform.product.vo;

import lombok.Data;

import java.math.BigDecimal;

/**
 * 积分
 */
@Data
public class Bounds {

    /**
     * 金币积分
     */
    private BigDecimal buyBounds;
    /**
     * 成长积分
     */
    private BigDecimal growBounds;
}
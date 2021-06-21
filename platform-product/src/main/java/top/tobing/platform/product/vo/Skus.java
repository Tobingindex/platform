package top.tobing.platform.product.vo;

import lombok.Data;

import java.math.BigDecimal;
import java.util.List;
import java.util.Date;

/**
 * 商品SKU信息
 */
@Data
public class Skus {
    /**
     * SKU属性信息
     */
    private List<Attr> attr;
    /**
     * SKU名称
     */
    private String skuName;
    /**
     * SKU价格
     */
    private BigDecimal price;
    /**
     * SKU标题
     */
    private String skuTitle;
    /**
     * SKU子标题
     */
    private String skuSubtitle;
    /**
     * SKU图片
     */
    private List<Images> images;
    /**
     * SKU笛卡尔积
     */
    private List<String> descar;
    /**
     * 满打折：满 fullCount 打 discount 折
     */
    private Integer fullCount;
    /**
     * 满打折：满 fullCount 打 discount 折
     */
    private BigDecimal discount;
    /**
     * 优惠是否可叠加
     */
    private int countStatus;
    /**
     * 满减：满 fullPrice 减去 reducePrice
     */
    private BigDecimal fullPrice;
    /**
     * 满减：满 fullPrice 减去 reducePrice
     */
    private BigDecimal reducePrice;
    /**
     * 优惠是否可叠加
     */
    private int priceStatus;
    /**
     * 不同类型的会员价格
     */
    private List<MemberPrice> memberPrice;
}
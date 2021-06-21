package top.tobing.platform.product.vo;

import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

/**
 * 商品保存信息
 */
@Data
public class SpuSaveVo {

    /**
     * SPU名称
     */
    private String spuName;
    /**
     * SPU描述
     */
    private String spuDescription;
    /**
     * 商品所属品牌ID
     */
    private Long brandId;
    /**
     * 商品分类ID
     */
    private Long catalogId;
    /**
     * 商品重量
     */
    private BigDecimal weight;
    /**
     * 商品发布状态
     */
    private Integer publishStatus;
    /**
     * 商品描述图片
     */
    private List<String> decript;
    /**
     * 商品展示图集
     */
    private List<Images> images;
    /**
     * 商品积分信息：金币、成长值
     */
    private Bounds bounds;
    /**
     * 基础属性
     */
    private List<BaseAttrs> baseAttrs;
    /**
     * 商品SKU信息
     */
    private List<Skus> skus;

}
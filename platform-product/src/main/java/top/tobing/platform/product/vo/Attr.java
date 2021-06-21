package top.tobing.platform.product.vo;

import lombok.Data;

/**
 * SKU属性信息
 */
@Data
public class Attr {
    /**
     * 属性ID
     */
    private Long attrId;
    /**
     * 属性名称
     */
    private String attrName;
    /**
     * 属性值
     */
    private String attrValue;
}
package top.tobing.platform.product.vo;

import lombok.Data;

/**
 * 基础属性信息
 */
@Data
public class BaseAttrs {
    /**
     * 属性ID
     */
    private Long attrId;
    /**
     * 属性名
     */
    private String attrName;
    /**
     * 属性值
     */
    private String attrValues;
    /**
     * 显示状态
     */
    private Integer showDesc;
}
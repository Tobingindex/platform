package top.tobing.common.to.es;

import lombok.Data;

/**
 * @Author tobing
 * @Date 2021/4/3 12:03
 * @Description
 */
@Data
public class Attrs {
    // 属性id
    private Long attrId;
    // 属性名称
    private String attrName;
    // 属性值；不减少、不聚合
    private String attrValue;

    public Long getAttrId() {
        return attrId;
    }

    public void setAttrId(Long attrId) {
        this.attrId = attrId;
    }

    public String getAttrName() {
        return attrName;
    }

    public void setAttrName(String attrName) {
        this.attrName = attrName;
    }

    public String getAttrValue() {
        return attrValue;
    }

    public void setAttrValue(String attrValue) {
        this.attrValue = attrValue;
    }
}

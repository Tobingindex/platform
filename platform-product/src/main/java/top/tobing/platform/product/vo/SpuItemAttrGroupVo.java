package top.tobing.platform.product.vo;

import lombok.Data;

import java.util.List;

/**
 * @Author tobing
 * @Date 2021/4/14 21:30
 * @Description
 */
@Data
public class SpuItemAttrGroupVo {
    private String groupName;
    private List<SpuBaseAttrVo> attrs;
}

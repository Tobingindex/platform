package top.tobing.platform.product.vo;

import lombok.Data;
import top.tobing.platform.product.entity.AttrEntity;
import top.tobing.platform.product.entity.AttrGroupEntity;

import java.util.List;

/**
 * @Author tobing
 * @Date 2021/3/8 12:16
 * @Description 分组以及关联的属性信息
 */
@Data
public class AttrGroupComplexRespVo extends AttrGroupEntity {
    private List<AttrEntity> attrs;
}

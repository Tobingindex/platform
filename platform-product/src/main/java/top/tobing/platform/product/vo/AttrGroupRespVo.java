package top.tobing.platform.product.vo;

import lombok.Data;
import top.tobing.platform.product.entity.AttrGroupEntity;

/**
 * @Author tobing
 * @Date 2021/2/5 13:02
 * @Description
 */
@Data
public class AttrGroupRespVo extends AttrGroupEntity {
    private Long[] catelogPath;
}

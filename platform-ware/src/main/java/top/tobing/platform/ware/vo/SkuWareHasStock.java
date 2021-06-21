package top.tobing.platform.ware.vo;

import lombok.Data;

import java.util.List;

/**
 * @Author tobing
 * @Date 2021/4/24 22:29
 * @Description 库存情况
 */
@Data
public class SkuWareHasStock {
    // sku
    private Long skuId;
    // 具有库存量的仓库id结合
    private List<Long> wareIds;
    private Integer num;
}

package top.tobing.platform.ware.vo;

import lombok.Data;

import java.util.List;

/**
 * @Author tobing
 * @Date 2021/3/30 15:58
 * @Description 采购完成Vo
 */
@Data
public class PurchaseDoneVo {
    private Long id;
    private List<PurchaseDoneItemVo> items;
}

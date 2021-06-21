package top.tobing.platform.ware.vo;

import lombok.Data;

/**
 * @Author tobing
 * @Date 2021/3/30 15:59
 * @Description 采购完成-采购项VO
 */
@Data
public class PurchaseDoneItemVo {
    private Long itemId;
    private Integer status;
    private String reason;
}

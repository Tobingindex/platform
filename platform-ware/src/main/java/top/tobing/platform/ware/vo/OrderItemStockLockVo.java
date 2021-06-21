package top.tobing.platform.ware.vo;

import lombok.Data;

/**
 * @Author tobing
 * @Date 2021/4/24 22:06
 * @Description 锁库存Vo
 */
@Data
public class OrderItemStockLockVo {
    private Long skuId;
    private String name;
    private Integer num;
    private String orderSn;
}

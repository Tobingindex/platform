package top.tobing.common.to.mq;

import lombok.Data;

/**
 * @Author tobing
 * @Date 2021/4/27 17:53
 * @Description
 */
@Data
public class WareOrderTaskDetailTo {
    private Long id;
    /**
     * sku_id
     */
    private Long skuId;
    /**
     * sku_name
     */
    private String skuName;
    /**
     * 购买个数
     */
    private Integer skuNum;
    /**
     * 工作单id
     */
    private Long taskId;
    /**
     * 仓库id
     */
    private Long wareId;
    /**
     * 锁状态
     * 1-锁定 2-解锁 3-扣减成功
     */
    private Integer lockStatus;
}

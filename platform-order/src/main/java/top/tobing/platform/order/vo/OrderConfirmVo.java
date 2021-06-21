package top.tobing.platform.order.vo;

import lombok.Data;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

/**
 * @Author tobing
 * @Date 2021/4/23 21:04
 * @Description 订单确认页 View Object
 */
@Data
public class OrderConfirmVo {
    // 订单用户地址信息
    private List<MemberAddressVo> addressList;
    // 订单商品项信息
    private List<OrderItemVo> itemVoList;
    // 用户积分信息
    private Integer integration;
    // 防重复令牌
    private String orderToken;
    // 商品项货物状态
    private Map<Long, Boolean> hasStockMap;

    // 总金额
    public BigDecimal getTotalPrice() {
        BigDecimal count = new BigDecimal("0");
        if (itemVoList != null) {
            for (OrderItemVo orderItemVo : itemVoList) {
                count = count.add(orderItemVo.getTotalPrice());
            }
        }
        return count;
    }

    // 总件数
    public Integer getTotalCount() {
        int count = 0;
        if (itemVoList != null) {
            for (OrderItemVo orderItemVo : itemVoList) {
                count += orderItemVo.getCount();
            }
        }
        return count;
    }
}

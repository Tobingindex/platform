package top.tobing.platform.cart.vo;

import java.math.BigDecimal;
import java.util.List;

/**
 * @Author tobing
 * @Date 2021/4/19 16:38
 * @Description 购物车所有数据
 */
public class Cart {
    // 购物车项
    private List<CartItem> items;
    // 商品数量
    private Integer countNum;
    // 商品种类
    private Integer countType;
    // 商品总价
    private BigDecimal totalAmount;
    // 减免价格
    private BigDecimal reduce;

    public List<CartItem> getItems() {
        return items;
    }

    public void setItems(List<CartItem> items) {
        this.items = items;
    }

    public Integer getCountNum() {
        if (items == null) {
            return 0;
        } else {
            int count = 0;
            for (CartItem item : items) {
                count += item.getCount();
            }
            return count;
        }
    }


    public Integer getCountType() {
        return items == null ? 0 : items.size();
    }


    public BigDecimal getTotalAmount() {
        if (items == null) {
            return new BigDecimal("0");
        } else {
            BigDecimal count = new BigDecimal("0");
            for (CartItem item : items) {
                if (item.getCheck()) {
                    count = count.add(item.getTotalPrice());
                }
            }
            return count;
        }
    }


    public BigDecimal getReduce() {
        return reduce;
    }

    public void setReduce(BigDecimal reduce) {
        this.reduce = reduce;
    }
}

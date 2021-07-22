package top.tobing.common.to;

import lombok.Data;

import java.math.BigDecimal;

/**
 * 不同价格享受的折扣
 */
@Data
public class MemberPrice {
    /**
     * id
     */
    private long id;
    /**
     * 会员的名称
     */
    private String name;
    /**
     * 会员购买商品享受的价格
     */
    private BigDecimal price;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }
}
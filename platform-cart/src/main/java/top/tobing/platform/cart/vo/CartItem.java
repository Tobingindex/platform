package top.tobing.platform.cart.vo;

import java.math.BigDecimal;
import java.util.List;

/**
 * @Author tobing
 * @Date 2021/4/19 16:38
 * @Description 购物车项目，每个项目一种商品
 */
public class CartItem {
    /**
     * skuId
     */
    private Long skuId;
    /**
     * 是否选中
     */
    private Boolean check;
    /**
     * 商品图片
     */
    private String image;
    /**
     * 商品标题
     */
    private String title;
    /**
     * 属性信息
     */
    private List<String> skuAttr;
    /**
     * 商品单价
     */
    private BigDecimal price;
    /**
     * 数量
     */
    private Integer count;
    /**
     * 每个商品的总价
     */
    private BigDecimal totalPrice;

    public Long getSkuId() {
        return skuId;
    }

    public void setSkuId(Long skuId) {
        this.skuId = skuId;
    }

    public Boolean getCheck() {
        return check;
    }

    public void setCheck(Boolean check) {
        this.check = check;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public List<String> getSkuAttr() {
        return skuAttr;
    }

    public void setSkuAttr(List<String> skuAttr) {
        this.skuAttr = skuAttr;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public BigDecimal getTotalPrice() {
        if (price != null) {
            return new BigDecimal(count).multiply(price);
        } else {
            return new BigDecimal("0");
        }
    }
}

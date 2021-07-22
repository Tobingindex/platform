package top.tobing.common.to;

import lombok.Data;

/**
 * @Author tobing
 * @Date 2021/4/3 12:50
 * @Description
 */
@Data
public class SkuStockSearchVo {
    private Long skuId;
    private Boolean stock;

    public Long getSkuId() {
        return skuId;
    }

    public void setSkuId(Long skuId) {
        this.skuId = skuId;
    }

    public Boolean getStock() {
        return stock;
    }

    public void setStock(Boolean stock) {
        this.stock = stock;
    }
}

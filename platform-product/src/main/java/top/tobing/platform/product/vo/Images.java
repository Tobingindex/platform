package top.tobing.platform.product.vo;

import lombok.Data;

/**
 *  SKU图片
 */
@Data
public class Images {

    public Images() {
    }

    public Images(String imgUrl) {
        this.imgUrl = imgUrl;
    }

    public Images(String imgUrl, int defaultImg) {
        this.imgUrl = imgUrl;
        this.defaultImg = defaultImg;
    }

    /**
     * 图片URL
     */
    private String imgUrl;
    /**
     * 是否默认图片
     */
    private Integer defaultImg;
}
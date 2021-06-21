package top.tobing.common.to.es;

import lombok.Data;

import java.math.BigDecimal;
import java.util.List;

/**
 * @Author tobing
 * @Date 2021/4/3 11:57
 * @Description 商品搜索服务
 */
@Data
public class ProductEsTo {
    // spuId
    private Long spuId;
    // skuId：不可分词
    private Long skuId;
    // sku标题：中文分词
    private String skuTitle;
    // sku价格：保证精度
    private BigDecimal skuPrice;
    // sku图片：不分词
    private String skuImg;
    // 销量
    private Long saleCount;
    // 是否还要库存，不直接展示库存量，只有在【有】【无】库存状态转换才更新，否则不修改。
    private Boolean hasStock;
    // 热度
    private Long hotScore;
    // 品牌
    private Long brandId;
    // 分类
    private Long catalogId;
    // 品牌名称
    private String brandName;
    // 品牌图片：不检索、不生成index、不聚合
    private String brandImg;
    // 分类名称
    private String catalogName;
    // 属性信息
    private List<Attrs> attrs;
}

package top.tobing.platform.search.vo;

import lombok.Data;
import top.tobing.common.to.es.ProductEsTo;

import java.util.List;

/**
 * @Author tobing
 * @Date 2021/4/11 22:35
 * @Description 查询结果
 */
@Data
public class SearchResult {
    // 所有商品信息
    private List<ProductEsTo> porducts;
    // 当前页码
    private Integer pageNum;
    // 总记录数
    private Long total;
    // 总页数
    private Integer totalPage;
    // 品牌信息
    private List<BrandVo> brands;
    // 分类信息
    private List<CatalogVo> catalogs;
    // 属性分组信息
    private List<AttrVo> attrs;
    // 导航信息
    private List<Integer> pageVos;
    // 导航数据
    private List<NavVo> navVos;

    @Data
    public static class BrandVo {
        private Long brandId;
        private String brandName;
        private String brandImg;

        public BrandVo() {
        }

        public BrandVo(Long brandId, String brandName, String brandImg) {
            this.brandId = brandId;
            this.brandName = brandName;
            this.brandImg = brandImg;
        }
    }

    @Data
    public static class CatalogVo {
        private Long catalogId;
        private String catalogName;

        public CatalogVo() {
        }

        public CatalogVo(Long catalogId, String catalogName) {
            this.catalogId = catalogId;
            this.catalogName = catalogName;
        }
    }

    @Data
    public static class AttrVo {
        private Long attrId;
        private String attrName;
        private List<String> attrValue;

        public AttrVo() {
        }

        public AttrVo(Long attrId, String attrName, List<String> attrValue) {
            this.attrId = attrId;
            this.attrName = attrName;
            this.attrValue = attrValue;
        }
    }

    @Data
    public static class NavVo {
        private String name;
        private String navValue;
        private String link;
    }
}

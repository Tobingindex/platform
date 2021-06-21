package top.tobing.platform.search.vo;

import lombok.Data;

import java.util.List;

/**
 * @Author tobing
 * @Date 2021/4/11 22:28
 * @Description 搜索参数
 */
@Data
public class SearchParam {
    /**
     * 搜索关键字
     * keyword=小米
     */
    private String keyword;
    /**
     * 三级分类id
     * catalog3Id=1
     */
    private Long catalog3Id;
    /**
     * 排序条件
     * sort=saleCount_desc/asc
     */
    private String sort;
    /**
     * 是否有货
     * hasStock=0/1
     */
    private Integer hashStock;
    /**
     * 价格区间
     * skuPrice=400_1900
     */
    private String skuPrice;
    /**
     * 品牌id，多选
     * brandId=1
     */
    private List<Long> brandId;
    /**
     * 属性筛选
     * attrs=1_3G:4G:5G
     * attrs=2_骁龙845
     * attrs=4_高清屏
     */
    private List<String> attrs;
    /**
     * 页码
     */
    private Integer pageNum = 1;
    /**
     * 原生查询所有查询属性
     */
    private String queryString;
}

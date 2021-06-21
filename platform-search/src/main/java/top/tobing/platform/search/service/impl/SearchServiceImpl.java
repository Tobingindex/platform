package top.tobing.platform.search.service.impl;

import com.alibaba.fastjson.JSON;
import lombok.extern.slf4j.Slf4j;
import org.apache.lucene.search.join.ScoreMode;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.NestedQueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.index.query.RangeQueryBuilder;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.SearchHits;
import org.elasticsearch.search.aggregations.Aggregation;
import org.elasticsearch.search.aggregations.AggregationBuilders;
import org.elasticsearch.search.aggregations.Aggregations;
import org.elasticsearch.search.aggregations.bucket.nested.NestedAggregationBuilder;
import org.elasticsearch.search.aggregations.bucket.nested.ParsedNested;
import org.elasticsearch.search.aggregations.bucket.terms.ParsedLongTerms;
import org.elasticsearch.search.aggregations.bucket.terms.ParsedStringTerms;
import org.elasticsearch.search.aggregations.bucket.terms.Terms;
import org.elasticsearch.search.aggregations.bucket.terms.TermsAggregationBuilder;
import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.elasticsearch.search.fetch.subphase.highlight.HighlightBuilder;
import org.elasticsearch.search.fetch.subphase.highlight.HighlightField;
import org.elasticsearch.search.sort.SortOrder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import top.tobing.common.to.es.ProductEsTo;
import top.tobing.platform.search.config.PlatformElasticSearchConfig;
import top.tobing.platform.search.constant.ElasticSearchConstant;
import top.tobing.platform.search.service.SearchService;
import top.tobing.platform.search.vo.SearchParam;
import top.tobing.platform.search.vo.SearchResult;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * @Author tobing
 * @Date 2021/4/12 16:00
 * @Description
 */
@Slf4j
@Service
public class SearchServiceImpl implements SearchService {

    @Autowired
    private RestHighLevelClient restHighLevelClient;

    @Override
    public SearchResult getSearchResult(SearchParam searchParam) {
        SearchResult searchResult = null;
        // 通过产生构造查询查询请求
        SearchRequest request = buildSearchRequest(searchParam);
        try {
            SearchResponse searchResponse = restHighLevelClient.search(request, PlatformElasticSearchConfig.COMMON_OPTIONS);
            searchResult = buildSearchResult(searchParam, searchResponse);
        } catch (Exception e) {
            log.error("【SearchServiceImpl】检索数据出错：", e);
        }
        return searchResult;
    }

    /**
     * 将查询响应封装为查询结果
     */
    private SearchResult buildSearchResult(SearchParam searchParam, SearchResponse searchResponse) {
        SearchResult searchResult = new SearchResult();
        SearchHits hits = searchResponse.getHits();

        // 1、封装查询到的商品信息
        if (hits.getHits() != null && hits.getHits().length > 0) {
            List<ProductEsTo> productEsToList = new ArrayList<>();
            for (SearchHit hit : hits.getHits()) {
                String sourceAsString = hit.getSourceAsString();
                ProductEsTo productEsTo = JSON.parseObject(sourceAsString, ProductEsTo.class);
                // 设置高亮
                if (!StringUtils.isEmpty(searchParam.getKeyword())) {
                    HighlightField skuTitle = hit.getHighlightFields().get("skuTitle");
                    String highLight = skuTitle.getFragments()[0].string();
                    productEsTo.setSkuTitle(highLight);
                }
                productEsToList.add(productEsTo);
            }
            searchResult.setPorducts(productEsToList);
        }

        // 2、封装分页信息
        // 当前页码
        searchResult.setPageNum(searchParam.getPageNum());
        // 当前记录数
        long total = hits.getTotalHits().value;
        searchResult.setTotal(total);
        // 总页码
        Integer totalPages = total % ElasticSearchConstant.PRODUCT_PAGESIZE == 0 ?
                (int) total / ElasticSearchConstant.PRODUCT_PAGESIZE : (int) (total / ElasticSearchConstant.PRODUCT_PAGESIZE + 1);
        searchResult.setTotalPage(totalPages);

        // 获取聚合信息
        Aggregations aggregations = searchResponse.getAggregations();

        // 3、封装品牌聚合信息
        List<SearchResult.BrandVo> brandVoList = new ArrayList<>();
        ParsedLongTerms brandAgg = aggregations.get("brandAgg");
        for (Terms.Bucket bucket : brandAgg.getBuckets()) {
            long brandId = bucket.getKeyAsNumber().longValue();
            Aggregations subBrandAggs = bucket.getAggregations();
            // 获取品牌图片
            ParsedStringTerms brandImgAgg = subBrandAggs.get("brandImgAgg");
            String brandImg = brandImgAgg.getBuckets().get(0).getKeyAsString();
            // 获取品牌名字
            ParsedStringTerms brandNameAgg = subBrandAggs.get("brandNameAgg");
            String brandName = brandNameAgg.getBuckets().get(0).getKeyAsString();
            SearchResult.BrandVo brandVo = new SearchResult.BrandVo(brandId, brandName, brandImg);
            brandVoList.add(brandVo);
        }
        searchResult.setBrands(brandVoList);

        // 4、封装分类信息
        List<SearchResult.CatalogVo> catalogVoList = new ArrayList<>();
        ParsedLongTerms catalogAgg = aggregations.get("catalogAgg");
        for (Terms.Bucket bucket : catalogAgg.getBuckets()) {
            // 获取分类id
            long catalogId = bucket.getKeyAsNumber().longValue();
            Aggregations subCatalogAgg = bucket.getAggregations();
            ParsedStringTerms catalogNameAgg = subCatalogAgg.get("catalogNameAgg");
            // 获取分类名称
            String catalogName = catalogNameAgg.getBuckets().get(0).getKeyAsString();
            SearchResult.CatalogVo catalogVo = new SearchResult.CatalogVo(catalogId, catalogName);
            catalogVoList.add(catalogVo);
        }
        searchResult.setCatalogs(catalogVoList);

        // 5、封装属性信息
        List<SearchResult.AttrVo> attrVoList = new ArrayList<>();
        ParsedNested parsedNested = aggregations.get("attrs");
        ParsedLongTerms attrIdAgg = parsedNested.getAggregations().get("attrIdAgg");
        for (Terms.Bucket bucket : attrIdAgg.getBuckets()) {
            long attrId = bucket.getKeyAsNumber().longValue();
            Aggregations subAttrAgg = bucket.getAggregations();
            ParsedStringTerms attrNameAgg = subAttrAgg.get("attrNameAgg");
            String attrName = attrNameAgg.getBuckets().get(0).getKeyAsString();
            ParsedStringTerms attrValueAgg = subAttrAgg.get("attrValueAgg");
            List<String> attrValues = new ArrayList<>();
            for (Terms.Bucket attrValueAggBucket : attrValueAgg.getBuckets()) {
                String attrValue = attrValueAggBucket.getKeyAsString();
                attrValues.add(attrValue);
            }
            SearchResult.AttrVo attrVo = new SearchResult.AttrVo(attrId, attrName, attrValues);
            attrVoList.add(attrVo);
        }
        searchResult.setAttrs(attrVoList);

        // 6、封装分页导航信息
        List<Integer> pageNavs = new ArrayList<>();
        for (int i = 0; i < totalPages; i++) {
            pageNavs.add(i);
        }
        searchResult.setPageVos(pageNavs);



        return searchResult;
    }

    /**
     * 构造查询条件
     */
    private SearchRequest buildSearchRequest(SearchParam searchParam) {
        // 用于构造DSL语句
        SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();

        // 1、构造bool query
        BoolQueryBuilder boolQueryBuilder = new BoolQueryBuilder();

        // 1.1、添加must
        // 根据关键词检索skuTitle
        if (!StringUtils.isEmpty(searchParam.getKeyword())) {
            boolQueryBuilder.must(QueryBuilders.matchQuery("skuTitle", searchParam.getKeyword()));
        }

        // 1.2、添加filter
        // 通过三级分类过滤
        if (searchParam.getCatalog3Id() != null) {
            boolQueryBuilder.filter(QueryBuilders.termQuery("catalogId", searchParam.getCatalog3Id()));
        }
        // 通过品牌过滤
        if (searchParam.getBrandId() != null && searchParam.getBrandId().size() > 0) {
            boolQueryBuilder.filter(QueryBuilders.termsQuery("brandId", searchParam.getBrandId()));
        }
        // 通过库存过滤
        if (searchParam.getHashStock() != null) {
            boolQueryBuilder.filter(QueryBuilders.termQuery("hasStock", searchParam.getHashStock() == 0));
        }
        // 通过价格区间过滤 「skuPrice=400_1900」
        RangeQueryBuilder rangeQueryBuilder = QueryBuilders.rangeQuery("skuPrice");
        if (!StringUtils.isEmpty(searchParam.getSkuPrice())) {
            String[] ranges = searchParam.getSkuPrice().split("_");
            if (ranges.length == 1) {               // 情况1：200_
                rangeQueryBuilder.lte(Integer.parseInt(ranges[0]));
            } else if (ranges.length == 2) {        // 情况2：_100 或者 100_200
                String leftRange = ranges[0];   // 左边界
                String rightRange = ranges[1];  // 右边界
                if (!StringUtils.isEmpty(leftRange)) {
                    rangeQueryBuilder.gte(Integer.parseInt(leftRange));
                }
                if (!StringUtils.isEmpty(rightRange)) {
                    rangeQueryBuilder.lte(Integer.parseInt(rightRange));
                }
            }
            boolQueryBuilder.filter(rangeQueryBuilder);
        }
        // 通过属性查询 「1_3G:4G:5G」 「2_骁龙845」 「4_高清屏」
        List<String> attrs = searchParam.getAttrs();
        BoolQueryBuilder boolQueryBuilder1 = new BoolQueryBuilder();
        if (attrs != null && attrs.size() > 0) {
            for (String attr : attrs) { // 格式：「属性id_属性值1:属性值2」
                String[] attrParams = attr.split("_");
                String attrId = attrParams[0];
                String attrValues = attrParams[1];
                String[] vals = attrValues.split(":");
                boolQueryBuilder1.must(QueryBuilders.termQuery("attrs.attrId", attrId));
                boolQueryBuilder1.must(QueryBuilders.termsQuery("attrs.attrValue", attrValues));
            }
        }
        NestedQueryBuilder nestedQueryBuilder = QueryBuilders.nestedQuery("attrs", boolQueryBuilder1, ScoreMode.None);
        boolQueryBuilder.filter(nestedQueryBuilder);
        searchSourceBuilder.query(boolQueryBuilder);


        // 2、构造sort 「sort=saleCount_desc/asc」
        if (!StringUtils.isEmpty(searchParam.getSort())) {
            String[] sortParam = searchParam.getSort().split("_");
            // 排序字段
            String attr = sortParam[0];
            // 排序方式
            SortOrder type = "asc".equalsIgnoreCase(sortParam[1]) ? SortOrder.ASC : SortOrder.DESC;
            searchSourceBuilder.sort(attr, type);
        }


        // 3、构造分页
        int from = searchParam.getPageNum() == null ? 1 : (searchParam.getPageNum() - 1) * ElasticSearchConstant.PRODUCT_PAGESIZE;
        searchSourceBuilder.from(from);
        searchSourceBuilder.size(ElasticSearchConstant.PRODUCT_PAGESIZE);


        // 4、高亮显示
        if (!StringUtils.isEmpty(searchParam.getKeyword())) {
            HighlightBuilder highlightBuilder = new HighlightBuilder();
            highlightBuilder.field("skuTitle");
            highlightBuilder.preTags("<b style='color:red'>");
            highlightBuilder.postTags("</b>");
            searchSourceBuilder.highlighter(highlightBuilder);
        }

        // 5、聚合
        // 按照brand聚合
        TermsAggregationBuilder brandAgg = AggregationBuilders.terms("brandAgg").field("brandId");
        TermsAggregationBuilder brandNameAgg = AggregationBuilders.terms("brandNameAgg").field("brandName");
        TermsAggregationBuilder brandImgAgg = AggregationBuilders.terms("brandImgAgg").field("brandImg");
        brandAgg.subAggregation(brandNameAgg);
        brandAgg.subAggregation(brandImgAgg);
        searchSourceBuilder.aggregation(brandAgg);

        // 按照catalog聚合
        TermsAggregationBuilder catalogAgg = AggregationBuilders.terms("catalogAgg").field("catalogId");
        TermsAggregationBuilder catalogNameAgg = AggregationBuilders.terms("catalogNameAgg").field("catalogName");
        catalogAgg.subAggregation(catalogNameAgg);
        searchSourceBuilder.aggregation(catalogAgg);

        // 按照attrs聚合
        NestedAggregationBuilder nestedAggregationBuilder = new NestedAggregationBuilder("attrs", "attrs");
        TermsAggregationBuilder attrIdAgg = AggregationBuilders.terms("attrIdAgg").field("attrs.attrId");
        TermsAggregationBuilder attrNameAgg = AggregationBuilders.terms("attrNameAgg").field("attrs.attrName");
        TermsAggregationBuilder attrValueAgg = AggregationBuilders.terms("attrValueAgg").field("attrs.attrValue");
        attrIdAgg.subAggregation(attrNameAgg);
        attrIdAgg.subAggregation(attrValueAgg);
        nestedAggregationBuilder.subAggregation(attrIdAgg);
        searchSourceBuilder.aggregation(nestedAggregationBuilder);

        log.info("生成的DSL语句：{}", searchSourceBuilder.toString());

        SearchRequest searchRequest = new SearchRequest(new String[]{ElasticSearchConstant.PRODUCT_INDEX}, searchSourceBuilder);
        return searchRequest;
    }
}

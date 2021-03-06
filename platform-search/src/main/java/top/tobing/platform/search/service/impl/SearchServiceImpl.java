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
        // ????????????????????????????????????
        SearchRequest request = buildSearchRequest(searchParam);
        try {
            SearchResponse searchResponse = restHighLevelClient.search(request, PlatformElasticSearchConfig.COMMON_OPTIONS);
            searchResult = buildSearchResult(searchParam, searchResponse);
        } catch (Exception e) {
            log.error("???SearchServiceImpl????????????????????????", e);
        }
        return searchResult;
    }

    /**
     * ????????????????????????????????????
     */
    private SearchResult buildSearchResult(SearchParam searchParam, SearchResponse searchResponse) {
        SearchResult searchResult = new SearchResult();
        SearchHits hits = searchResponse.getHits();

        // 1?????????????????????????????????
        if (hits.getHits() != null && hits.getHits().length > 0) {
            List<ProductEsTo> productEsToList = new ArrayList<>();
            for (SearchHit hit : hits.getHits()) {
                String sourceAsString = hit.getSourceAsString();
                ProductEsTo productEsTo = JSON.parseObject(sourceAsString, ProductEsTo.class);
                // ????????????
                if (!StringUtils.isEmpty(searchParam.getKeyword())) {
                    HighlightField skuTitle = hit.getHighlightFields().get("skuTitle");
                    String highLight = skuTitle.getFragments()[0].string();
                    productEsTo.setSkuTitle(highLight);
                }
                productEsToList.add(productEsTo);
            }
            searchResult.setPorducts(productEsToList);
        }

        // 2?????????????????????
        // ????????????
        searchResult.setPageNum(searchParam.getPageNum());
        // ???????????????
        long total = hits.getTotalHits().value;
        searchResult.setTotal(total);
        // ?????????
        Integer totalPages = total % ElasticSearchConstant.PRODUCT_PAGESIZE == 0 ?
                (int) total / ElasticSearchConstant.PRODUCT_PAGESIZE : (int) (total / ElasticSearchConstant.PRODUCT_PAGESIZE + 1);
        searchResult.setTotalPage(totalPages);

        // ??????????????????
        Aggregations aggregations = searchResponse.getAggregations();

        // 3???????????????????????????
        List<SearchResult.BrandVo> brandVoList = new ArrayList<>();
        ParsedLongTerms brandAgg = aggregations.get("brandAgg");
        for (Terms.Bucket bucket : brandAgg.getBuckets()) {
            long brandId = bucket.getKeyAsNumber().longValue();
            Aggregations subBrandAggs = bucket.getAggregations();
            // ??????????????????
            ParsedStringTerms brandImgAgg = subBrandAggs.get("brandImgAgg");
            String brandImg = brandImgAgg.getBuckets().get(0).getKeyAsString();
            // ??????????????????
            ParsedStringTerms brandNameAgg = subBrandAggs.get("brandNameAgg");
            String brandName = brandNameAgg.getBuckets().get(0).getKeyAsString();
            SearchResult.BrandVo brandVo = new SearchResult.BrandVo(brandId, brandName, brandImg);
            brandVoList.add(brandVo);
        }
        searchResult.setBrands(brandVoList);

        // 4?????????????????????
        List<SearchResult.CatalogVo> catalogVoList = new ArrayList<>();
        ParsedLongTerms catalogAgg = aggregations.get("catalogAgg");
        for (Terms.Bucket bucket : catalogAgg.getBuckets()) {
            // ????????????id
            long catalogId = bucket.getKeyAsNumber().longValue();
            Aggregations subCatalogAgg = bucket.getAggregations();
            ParsedStringTerms catalogNameAgg = subCatalogAgg.get("catalogNameAgg");
            // ??????????????????
            String catalogName = catalogNameAgg.getBuckets().get(0).getKeyAsString();
            SearchResult.CatalogVo catalogVo = new SearchResult.CatalogVo(catalogId, catalogName);
            catalogVoList.add(catalogVo);
        }
        searchResult.setCatalogs(catalogVoList);

        // 5?????????????????????
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

        // 6???????????????????????????
        List<Integer> pageNavs = new ArrayList<>();
        for (int i = 0; i < totalPages; i++) {
            pageNavs.add(i);
        }
        searchResult.setPageVos(pageNavs);



        return searchResult;
    }

    /**
     * ??????????????????
     */
    private SearchRequest buildSearchRequest(SearchParam searchParam) {
        // ????????????DSL??????
        SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();

        // 1?????????bool query
        BoolQueryBuilder boolQueryBuilder = new BoolQueryBuilder();

        // 1.1?????????must
        // ?????????????????????skuTitle
        if (!StringUtils.isEmpty(searchParam.getKeyword())) {
            boolQueryBuilder.must(QueryBuilders.matchQuery("skuTitle", searchParam.getKeyword()));
        }

        // 1.2?????????filter
        // ????????????????????????
        if (searchParam.getCatalog3Id() != null) {
            boolQueryBuilder.filter(QueryBuilders.termQuery("catalogId", searchParam.getCatalog3Id()));
        }
        // ??????????????????
        if (searchParam.getBrandId() != null && searchParam.getBrandId().size() > 0) {
            boolQueryBuilder.filter(QueryBuilders.termsQuery("brandId", searchParam.getBrandId()));
        }
        // ??????????????????
        if (searchParam.getHashStock() != null) {
            boolQueryBuilder.filter(QueryBuilders.termQuery("hasStock", searchParam.getHashStock() == 0));
        }
        // ???????????????????????? ???skuPrice=400_1900???
        RangeQueryBuilder rangeQueryBuilder = QueryBuilders.rangeQuery("skuPrice");
        if (!StringUtils.isEmpty(searchParam.getSkuPrice())) {
            String[] ranges = searchParam.getSkuPrice().split("_");
            if (ranges.length == 1) {               // ??????1???200_
                rangeQueryBuilder.lte(Integer.parseInt(ranges[0]));
            } else if (ranges.length == 2) {        // ??????2???_100 ?????? 100_200
                String leftRange = ranges[0];   // ?????????
                String rightRange = ranges[1];  // ?????????
                if (!StringUtils.isEmpty(leftRange)) {
                    rangeQueryBuilder.gte(Integer.parseInt(leftRange));
                }
                if (!StringUtils.isEmpty(rightRange)) {
                    rangeQueryBuilder.lte(Integer.parseInt(rightRange));
                }
            }
            boolQueryBuilder.filter(rangeQueryBuilder);
        }
        // ?????????????????? ???1_3G:4G:5G??? ???2_??????845??? ???4_????????????
        List<String> attrs = searchParam.getAttrs();
        BoolQueryBuilder boolQueryBuilder1 = new BoolQueryBuilder();
        if (attrs != null && attrs.size() > 0) {
            for (String attr : attrs) { // ??????????????????id_?????????1:?????????2???
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


        // 2?????????sort ???sort=saleCount_desc/asc???
        if (!StringUtils.isEmpty(searchParam.getSort())) {
            String[] sortParam = searchParam.getSort().split("_");
            // ????????????
            String attr = sortParam[0];
            // ????????????
            SortOrder type = "asc".equalsIgnoreCase(sortParam[1]) ? SortOrder.ASC : SortOrder.DESC;
            searchSourceBuilder.sort(attr, type);
        }


        // 3???????????????
        int from = searchParam.getPageNum() == null ? 1 : (searchParam.getPageNum() - 1) * ElasticSearchConstant.PRODUCT_PAGESIZE;
        searchSourceBuilder.from(from);
        searchSourceBuilder.size(ElasticSearchConstant.PRODUCT_PAGESIZE);


        // 4???????????????
        if (!StringUtils.isEmpty(searchParam.getKeyword())) {
            HighlightBuilder highlightBuilder = new HighlightBuilder();
            highlightBuilder.field("skuTitle");
            highlightBuilder.preTags("<b style='color:red'>");
            highlightBuilder.postTags("</b>");
            searchSourceBuilder.highlighter(highlightBuilder);
        }

        // 5?????????
        // ??????brand??????
        TermsAggregationBuilder brandAgg = AggregationBuilders.terms("brandAgg").field("brandId");
        TermsAggregationBuilder brandNameAgg = AggregationBuilders.terms("brandNameAgg").field("brandName");
        TermsAggregationBuilder brandImgAgg = AggregationBuilders.terms("brandImgAgg").field("brandImg");
        brandAgg.subAggregation(brandNameAgg);
        brandAgg.subAggregation(brandImgAgg);
        searchSourceBuilder.aggregation(brandAgg);

        // ??????catalog??????
        TermsAggregationBuilder catalogAgg = AggregationBuilders.terms("catalogAgg").field("catalogId");
        TermsAggregationBuilder catalogNameAgg = AggregationBuilders.terms("catalogNameAgg").field("catalogName");
        catalogAgg.subAggregation(catalogNameAgg);
        searchSourceBuilder.aggregation(catalogAgg);

        // ??????attrs??????
        NestedAggregationBuilder nestedAggregationBuilder = new NestedAggregationBuilder("attrs", "attrs");
        TermsAggregationBuilder attrIdAgg = AggregationBuilders.terms("attrIdAgg").field("attrs.attrId");
        TermsAggregationBuilder attrNameAgg = AggregationBuilders.terms("attrNameAgg").field("attrs.attrName");
        TermsAggregationBuilder attrValueAgg = AggregationBuilders.terms("attrValueAgg").field("attrs.attrValue");
        attrIdAgg.subAggregation(attrNameAgg);
        attrIdAgg.subAggregation(attrValueAgg);
        nestedAggregationBuilder.subAggregation(attrIdAgg);
        searchSourceBuilder.aggregation(nestedAggregationBuilder);

        log.info("?????????DSL?????????{}", searchSourceBuilder.toString());

        SearchRequest searchRequest = new SearchRequest(new String[]{ElasticSearchConstant.PRODUCT_INDEX}, searchSourceBuilder);
        return searchRequest;
    }
}

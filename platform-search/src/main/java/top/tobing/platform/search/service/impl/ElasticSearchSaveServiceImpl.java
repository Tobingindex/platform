package top.tobing.platform.search.service.impl;

import com.alibaba.fastjson.JSON;
import lombok.extern.slf4j.Slf4j;
import org.elasticsearch.action.bulk.BulkRequest;
import org.elasticsearch.action.bulk.BulkResponse;
import org.elasticsearch.action.index.IndexRequest;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.common.xcontent.XContentType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.tobing.common.to.es.ProductEsTo;
import top.tobing.platform.search.config.PlatformElasticSearchConfig;
import top.tobing.platform.search.constant.ElasticSearchConstant;
import top.tobing.platform.search.service.ElasticSearchSaveService;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @Author tobing
 * @Date 2021/4/6 22:11
 * @Description
 */
@Slf4j
@Service
public class ElasticSearchSaveServiceImpl implements ElasticSearchSaveService {

    @Autowired
    private RestHighLevelClient restHighLevelClient;

    @Override
    public boolean saveProductESTo(List<ProductEsTo> productEsToList) throws IOException {
        BulkRequest bulkRequest = new BulkRequest(ElasticSearchConstant.PRODUCT_INDEX);
        for (ProductEsTo productEsTo : productEsToList) {
            // 构造查询请求
            IndexRequest indexRequest = new IndexRequest(ElasticSearchConstant.PRODUCT_INDEX);
            indexRequest.id(productEsTo.getSkuId().toString());
            String json = JSON.toJSONString(productEsTo);
            indexRequest.source(json, XContentType.JSON);
            // 添加到批量查询请求
            bulkRequest.add(indexRequest);
        }
        BulkResponse bulk = restHighLevelClient.bulk(bulkRequest, PlatformElasticSearchConfig.COMMON_OPTIONS);
        List<String> ids = Arrays.stream(bulk.getItems()).map(item -> item.getId()).collect(Collectors.toList());
        log.error("商品上架出错：{}", ids);
        // TODO 处理批量错误
        return bulk.hasFailures();

    }
}

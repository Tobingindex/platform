package top.tobing.platform.search;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import lombok.Data;
import org.elasticsearch.action.index.IndexRequest;
import org.elasticsearch.action.index.IndexResponse;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.Request;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.common.unit.TimeValue;
import org.elasticsearch.common.xcontent.XContentType;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.SearchHits;
import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import top.tobing.platform.search.config.PlatformElasticSearchConfig;

import javax.naming.directory.SearchResult;
import java.io.IOException;

@SpringBootTest
class PlatformSearchApplicationTests {
    @Autowired
    private RestHighLevelClient client;

//    @Test
//    public void testEsClent() {
//        System.out.println(client);
//    }

    /**
     * 测试保存
     */
//    @Test
    public void testSave() throws IOException {
        IndexRequest indexRequest = new IndexRequest("users");
        // 设置id
        indexRequest.id("1");
        // 创建对象
        User user = new User();
        user.setAge(22);
        user.setGender("男");
        user.setUsername("tobing");
        // 将对象转换为json字符串
        String jsonString = JSON.toJSONString(user);
        // 使用client保存json字符串信息
        indexRequest.source(jsonString, XContentType.JSON);
        IndexResponse index = client.index(indexRequest, PlatformElasticSearchConfig.COMMON_OPTIONS);
    }

    @Data
    class User {
        private String username;
        private String gender;
        private Integer age;
    }

    /**
     * 测试搜索全部
     */
//    @Test
    public void testSearchMatchAll() throws IOException {
        // 1、创建查询请求
        SearchRequest searchRequest = new SearchRequest();
        // 2、创建查询构造器
        SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
        // 3、添加match_all查询条件到查询构造器
        searchSourceBuilder.query(QueryBuilders.matchAllQuery());
        // 4、把查询条件添加到查询请求中
        searchRequest.source(searchSourceBuilder);
        // 5、执行查询
        SearchResponse searchResponse = client.search(searchRequest, PlatformElasticSearchConfig.COMMON_OPTIONS);
        // 6、查看查询结果
        System.out.println("请求参数：" + searchRequest);
        System.out.println("请求结果：" + searchResponse);
    }

    /**
     * 测试根据模糊查询地址
     */
//    @Test
    public void testSearchByBalance() throws IOException {
        // 1、创建查询请求，并指定要查询的索引（数据库）
        SearchRequest searchRequest = new SearchRequest("bank");
        // 2、创建查询构造器
        SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
        // 3、把模糊查询添加查询构造器中
        searchSourceBuilder.query(QueryBuilders.matchQuery("address", "mill lane"));
        // 4、将条件到查询请求
        searchRequest.source(searchSourceBuilder);
        // 5、执行查询
        SearchResponse response = client.search(searchRequest, PlatformElasticSearchConfig.COMMON_OPTIONS);
        // 6、输出结果
        SearchHits hits = response.getHits();
        TimeValue took = response.getTook();
        System.out.println("hits:" + hits);
        System.out.println("took:" + took);
        System.out.println("总记录数：" + hits.getTotalHits());
        System.out.println("最大分数：" + hits.getMaxScore());
        for (SearchHit hit : hits) {
            System.out.println(hit);
        }
    }

    public void testBulider() {
        SearchRequest request = new SearchRequest();
    }
}

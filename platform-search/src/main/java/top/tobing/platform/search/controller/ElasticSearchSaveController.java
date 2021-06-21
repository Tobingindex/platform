package top.tobing.platform.search.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import top.tobing.common.to.es.ProductEsTo;
import top.tobing.common.utils.R;
import top.tobing.platform.search.service.ElasticSearchSaveService;

import java.io.IOException;
import java.util.List;

/**
 * @Author tobing
 * @Date 2021/4/6 22:08
 * @Description
 */
@Slf4j
@RestController
@RequestMapping("/search/save")
public class ElasticSearchSaveController {

    @Autowired
    private ElasticSearchSaveService elasticSearchSaveService;

    /**
     * 保存数据到 ElasticSearch
     */
    @PostMapping("/product")
    public R saveProductESTo(@RequestBody List<ProductEsTo> productEsToList) {
        boolean flag = false;
        try {
            flag = elasticSearchSaveService.saveProductESTo(productEsToList);
        } catch (IOException e) {
            log.error("【ElasticSearchSaveController】添加数据查询异常:", e);
            return R.error();
        }
        return flag ? R.ok() : R.error();
    }

}

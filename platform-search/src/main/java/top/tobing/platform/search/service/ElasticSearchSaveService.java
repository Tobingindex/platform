package top.tobing.platform.search.service;

import top.tobing.common.to.es.ProductEsTo;

import java.io.IOException;
import java.util.List;

/**
 * @Author tobing
 * @Date 2021/4/6 22:11
 * @Description
 */
public interface ElasticSearchSaveService {
    /**
     * 将数据批量保存的ES中，用于商品上架
     */
    boolean saveProductESTo(List<ProductEsTo> productEsToList) throws IOException;
}

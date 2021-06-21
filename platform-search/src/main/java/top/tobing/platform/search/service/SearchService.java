package top.tobing.platform.search.service;

import top.tobing.platform.search.vo.SearchParam;
import top.tobing.platform.search.vo.SearchResult;

/**
 * @Author tobing
 * @Date 2021/4/12 15:59
 * @Description
 */
public interface SearchService {

    /**
     * 封装DSL语句、查询数据
     */
    SearchResult getSearchResult(SearchParam searchParam);
}

package top.tobing.platform.search.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import top.tobing.platform.search.service.SearchService;
import top.tobing.platform.search.vo.SearchParam;
import top.tobing.platform.search.vo.SearchResult;

/**
 * @Author tobing
 * @Date 2021/4/11 18:03
 * @Description
 */
@Controller
public class SearchController {

    @Autowired
    private SearchService searchService;

    @GetMapping({"/", "/list.html"})
    public String search(SearchParam searchParam, Model model) {
        SearchResult searchResult = searchService.getSearchResult(searchParam);
        model.addAttribute("searchResult", searchResult);
        return "list";
    }

}

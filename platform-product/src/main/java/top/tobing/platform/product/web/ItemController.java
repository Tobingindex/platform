package top.tobing.platform.product.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;
import top.tobing.common.utils.R;
import top.tobing.platform.product.service.SkuInfoService;
import top.tobing.platform.product.vo.SkuItemVo;

/**
 * @Author tobing
 * @Date 2021/4/14 21:16
 * @Description
 */
@Controller
public class ItemController {

    @Autowired
    private SkuInfoService skuInfoService;


    @GetMapping("/{skuId}.html")
    public String item(@PathVariable("skuId") Long skuId, Model model) {
        System.out.println("查询商品详情页");
        SkuItemVo skuItemVo = skuInfoService.item(skuId);
        model.addAttribute("item", skuItemVo);
        return "item";
    }

    @ResponseBody
    @GetMapping("/item/test/{skuId}")
    public R test(@PathVariable("skuId") Long skuId) {
        SkuItemVo skuItemVo = skuInfoService.item(skuId);
        return R.ok().put("data", skuItemVo);
    }

}

package top.tobing.platform.product.controller;

import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import top.tobing.platform.product.entity.SkuInfoEntity;
import top.tobing.platform.product.service.SkuInfoService;
import top.tobing.common.utils.PageUtils;
import top.tobing.common.utils.R;


/**
 * sku信息
 *
 * @author tobing
 * @email 652916578@qq.com
 * @date 2021-02-02 21:09:57
 */
@RestController
@RequestMapping("product/skuinfo")
public class SkuInfoController {
    @Autowired
    private SkuInfoService skuInfoService;

    /**
     * 根据skuId批量查询sku信息【远程调用】
     */
    @PostMapping("listSkuInfoBySkuId")
    public List<SkuInfoEntity> listBySkuId(@RequestBody List<Long> skuIds) {
        return skuInfoService.listBySkuId(skuIds);
    }

    /**
     * 根据skuId查询商品的价格【远程调用】
     */
    @GetMapping("priceBySkuId/{skuId}")
    public BigDecimal priceBySkuId(@PathVariable("skuId") Long skuId) {
        return skuInfoService.priceBySkuId(skuId);
    }


    /**
     * 根据skuId查询商品销售属性【远程调用】
     */
    @GetMapping("saleList/{skuId}")
    public List<String> getSkuSaleList(@PathVariable("skuId") Long skuId) {
        return skuInfoService.getSkuSaleListBySkuId(skuId);
    }

    /**
     * 列表：模糊查询
     */
    @RequestMapping("/list")
    //@RequiresPermissions("product:skuinfo:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = skuInfoService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{skuId}")
    //@RequiresPermissions("product:skuinfo:info")
    public R info(@PathVariable("skuId") Long skuId) {
        SkuInfoEntity skuInfo = skuInfoService.getById(skuId);

        return R.ok().put("skuInfo", skuInfo);
    }

    /**
     * 信息【用于远程调用】
     */
    @RequestMapping("/detail/{skuId}")
    public SkuInfoEntity detail(@PathVariable("skuId") Long skuId) {
        return skuInfoService.getById(skuId);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    //@RequiresPermissions("product:skuinfo:save")
    public R save(@RequestBody SkuInfoEntity skuInfo) {
        skuInfoService.save(skuInfo);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    //@RequiresPermissions("product:skuinfo:update")
    public R update(@RequestBody SkuInfoEntity skuInfo) {
        skuInfoService.updateById(skuInfo);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    //@RequiresPermissions("product:skuinfo:delete")
    public R delete(@RequestBody Long[] skuIds) {
        skuInfoService.removeByIds(Arrays.asList(skuIds));

        return R.ok();
    }

}

package top.tobing.platform.ware.controller;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import top.tobing.common.to.SkuStockSearchVo;
import top.tobing.platform.ware.entity.WareSkuEntity;
import top.tobing.platform.ware.service.WareSkuService;
import top.tobing.common.utils.PageUtils;
import top.tobing.common.utils.R;
import top.tobing.platform.ware.vo.OrderItemStockLockVo;


/**
 * 商品库存
 *
 * @author tobing
 * @email tobing6379@gmail.com
 * @date 2021-03-29 22:27:14
 */
@Slf4j
@RestController
@RequestMapping("ware/waresku")
public class WareSkuController {
    @Autowired
    private WareSkuService wareSkuService;

    /**
     * 锁库存
     */
    @PostMapping("/lockSkuStocks")
    public R lockSkuStocks(@RequestBody List<OrderItemStockLockVo> stockLockVos) {
        Boolean isLockSuccess = null;
        try {
            isLockSuccess = wareSkuService.lockSkuStocks(stockLockVos);
        } catch (Exception e) {
            isLockSuccess = false;
        }
        return isLockSuccess ? R.ok() : R.error();
    }

    /**
     * 根据skuId批量查询商品库存
     */
    @RequestMapping("/batch")
    public List<SkuStockSearchVo> batchSkuStock(@RequestBody List<Long> ids) {
        List<SkuStockSearchVo> skuStockByIds = wareSkuService.batchSkuStockByIds(ids);
//        R<List<SkuStockSearchVo>> r = new R<>();
//        r.put("data", skuStockByIds);
//        log.info("【WareSkuController】sku库存信息：{},{}", r, r.getData());
        return skuStockByIds;
    }

    /**
     * 列表
     */
    @RequestMapping("/list")
    //@RequiresPermissions("ware:waresku:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = wareSkuService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    //@RequiresPermissions("ware:waresku:info")
    public R info(@PathVariable("id") Long id) {
        WareSkuEntity wareSku = wareSkuService.getById(id);

        return R.ok().put("wareSku", wareSku);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    //@RequiresPermissions("ware:waresku:save")
    public R save(@RequestBody WareSkuEntity wareSku) {
        wareSkuService.save(wareSku);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    //@RequiresPermissions("ware:waresku:update")
    public R update(@RequestBody WareSkuEntity wareSku) {
        wareSkuService.updateById(wareSku);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    //@RequiresPermissions("ware:waresku:delete")
    public R delete(@RequestBody Long[] ids) {
        wareSkuService.removeByIds(Arrays.asList(ids));

        return R.ok();
    }

}

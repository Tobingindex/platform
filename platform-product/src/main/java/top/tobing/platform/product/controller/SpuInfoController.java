package top.tobing.platform.product.controller;

import java.util.Arrays;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import top.tobing.platform.product.entity.SpuInfoEntity;
import top.tobing.platform.product.service.SpuInfoService;
import top.tobing.common.utils.PageUtils;
import top.tobing.common.utils.R;
import top.tobing.platform.product.vo.SpuSaveVo;


/**
 * spu信息
 *
 * @author tobing
 * @email 652916578@qq.com
 * @date 2021-02-02 21:09:57
 */
@RestController
@RequestMapping("product/spuinfo")
public class SpuInfoController {
    @Autowired
    private SpuInfoService spuInfoService;

    @GetMapping("infoBySkuId/{skuId}")
    public SpuInfoEntity getBySkuId(@PathVariable("skuId") Long skuId) {
        return spuInfoService.getBySkuId(skuId);
    }

    /**
     * 商品上架
     */
    @PostMapping("/{spuId}/up")
    public R up(@PathVariable("spuId") Long spuId) {
        spuInfoService.up(spuId);
        return R.ok();
    }

    /**
     * 列表
     */
    @RequestMapping("/list")
    //@RequiresPermissions("product:spuinfo:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = spuInfoService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    //@RequiresPermissions("product:spuinfo:info")
    public R info(@PathVariable("id") Long id) {
        SpuInfoEntity spuInfo = spuInfoService.getById(id);

        return R.ok().put("spuInfo", spuInfo);
    }

    /**
     * 保存商品详细信息
     *
     * @author tobing
     */
    @RequestMapping("/save")
    public R save(@RequestBody SpuSaveVo spuSaveVo) {
        spuInfoService.saveSpuSaveVo(spuSaveVo);
        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    //@RequiresPermissions("product:spuinfo:update")
    public R update(@RequestBody SpuInfoEntity spuInfo) {
        spuInfoService.updateById(spuInfo);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    //@RequiresPermissions("product:spuinfo:delete")
    public R delete(@RequestBody Long[] ids) {
        spuInfoService.removeByIds(Arrays.asList(ids));

        return R.ok();
    }

}

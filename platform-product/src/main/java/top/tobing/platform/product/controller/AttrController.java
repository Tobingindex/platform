package top.tobing.platform.product.controller;

import java.util.Arrays;
import java.util.Map;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import top.tobing.platform.product.entity.AttrEntity;
import top.tobing.platform.product.service.AttrService;
import top.tobing.common.utils.PageUtils;
import top.tobing.common.utils.R;
import top.tobing.platform.product.vo.AtrrReqVo;
import top.tobing.platform.product.vo.AttrRespVo;


/**
 * 商品属性
 *
 * @author tobing
 * @email 652916578@qq.com
 * @date 2021-02-02 21:09:57
 */
@Slf4j
@RestController
@RequestMapping("product/attr")
public class AttrController {
    @Autowired
    private AttrService attrService;

    /**
     * 根据分类id查询下面的【销售属性】
     *
     * @param params    分页参数
     * @param catelogId 分类id
     * @return
     */
    @GetMapping("/sale/list/{catelogId}")
    public R listSale(@RequestParam Map<String, Object> params, @PathVariable("catelogId") Long catelogId) {
        log.info("查询销售属性：{}", catelogId);
        PageUtils page = attrService.querySalePage(params, catelogId);
        return R.ok().put("page", page);
    }

    /**
     * 根据分类的id查询所有【规格参数】
     * TODO 回显「所属分类」「所属分组」
     */
    @GetMapping("/base/list/{catelogId}")
    public R listBase(@RequestParam Map<String, Object> params, @PathVariable("catelogId") Long catelogId) {
        PageUtils page = attrService.queryBasePage(params, catelogId);
        return R.ok().put("page", page);
    }


    /**
     * 列表
     */
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = attrService.queryPage(params);
        return R.ok().put("page", page);
    }


    /**
     * 根据属性id查询属性详细信息
     */
    @RequestMapping("/info/{attrId}")
    public R info(@PathVariable("attrId") Long attrId) {
        AttrRespVo attr = attrService.getDetailById(attrId);
        return R.ok().put("attr", attr);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody AttrRespVo attr) {
        attrService.saveDetail(attr);
        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    public R update(@RequestBody AtrrReqVo attr) {
        attrService.updateDetailById(attr);
        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Long[] attrIds) {
        attrService.removeByIds(Arrays.asList(attrIds));
        return R.ok();
    }

}

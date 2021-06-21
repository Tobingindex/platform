package top.tobing.platform.product.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import top.tobing.platform.product.entity.AttrAttrgroupRelationEntity;
import top.tobing.platform.product.entity.AttrEntity;
import top.tobing.platform.product.entity.AttrGroupEntity;
import top.tobing.platform.product.service.AttrAttrgroupRelationService;
import top.tobing.platform.product.service.AttrGroupService;
import top.tobing.common.utils.PageUtils;
import top.tobing.common.utils.R;
import top.tobing.platform.product.service.AttrService;
import top.tobing.platform.product.vo.AttrGroupComplexRespVo;
import top.tobing.platform.product.vo.AttrGroupRespVo;


/**
 * 属性分组
 *
 * @author tobing
 * @email 652916578@qq.com
 * @date 2021-02-02 21:09:57
 */
@Slf4j
@RestController
@RequestMapping("product/attrgroup")
public class AttrGroupController {
    @Autowired
    private AttrAttrgroupRelationService attrAttrgroupRelationService;
    @Autowired
    private AttrGroupService attrGroupService;
    @Autowired
    private AttrService attrService;


    /**
     * 获取分类下所有的分组&分组关联属性
     */
    @GetMapping("/{catelogId}/withattr")
    public R attrGroupWithAttr(@PathVariable("catelogId") Long catelogId) {
        log.info("查询分类管理的属性分组以及属性分组的详细信息：{}", catelogId);
        List<AttrGroupComplexRespVo> attrGroupsList = attrGroupService.getAttrDetailsByCategoryId(catelogId);
        return R.ok().put("data", attrGroupsList);
    }

    /**
     * 获取属性分组的关联的所有属性
     */
    @GetMapping("/{attrgroupId}/attr/relation")
    public R attrRelation(@RequestParam Map<String, Object> params, @PathVariable("attrgroupId") Long attrgroupId) {
        List<AttrEntity> list = attrService.attrRelation(params, attrgroupId);
        return R.ok().put("data", list);
    }

    /**
     * 获取属性分组的没关联的所有属性
     */
    @GetMapping("/{attrgroupId}/noattr/relation")
    public R noattrRelation(@RequestParam Map<String, Object> params, @PathVariable("attrgroupId") Long attrgroupId) {
        PageUtils page = attrService.noattrRelation(params, attrgroupId);
        return R.ok().put("page", page);
    }


    /**
     * 新增属性关联
     */
    @RequestMapping("/attr/relation")
    public R saveAttrRelation(@RequestBody List<AttrAttrgroupRelationEntity> mapping) {
        log.info("新增关联：{}", mapping);
        attrAttrgroupRelationService.saveBatch(mapping);
        return R.ok();
    }

    /**
     * 批量删除属性与属性组的关联关系
     *
     * @param mapping 关联关系
     * @return
     */
    @RequestMapping("/attr/relation/delete")
    public R deleteAttrRelation(@RequestBody List<AttrAttrgroupRelationEntity> mapping) {
        log.info("删除关联：{}", mapping);
        attrAttrgroupRelationService.deleteBatch(mapping);
        return R.ok();
    }


    /**
     * 根据分类id查询属性分组
     */
    @RequestMapping("/list/{categoryId}")
    public R list(@RequestParam Map<String, Object> params, @PathVariable("categoryId") Long categoryId) {
        PageUtils page = attrGroupService.queryPage(params, categoryId);
        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{attrGroupId}")
    public R info(@PathVariable("attrGroupId") Long attrGroupId) {
        AttrGroupRespVo attrGroupRespVo = attrGroupService.getDetailById(attrGroupId);
        return R.ok().put("attrGroup", attrGroupRespVo);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody AttrGroupEntity attrGroup) {
        attrGroupService.save(attrGroup);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    public R update(@RequestBody AttrGroupEntity attrGroup) {
        attrGroupService.updateById(attrGroup);
        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Long[] attrGroupIds) {
        attrGroupService.removeByIds(Arrays.asList(attrGroupIds));
        return R.ok();
    }

}

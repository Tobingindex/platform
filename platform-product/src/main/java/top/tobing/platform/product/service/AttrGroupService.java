package top.tobing.platform.product.service;

import com.baomidou.mybatisplus.extension.service.IService;
import top.tobing.common.utils.PageUtils;
import top.tobing.platform.product.entity.AttrGroupEntity;
import top.tobing.platform.product.vo.AttrGroupComplexRespVo;
import top.tobing.platform.product.vo.AttrGroupRespVo;
import top.tobing.platform.product.vo.SpuItemAttrGroupVo;

import java.util.List;
import java.util.Map;

/**
 * 属性分组
 *
 * @author tobing
 * @email 652916578@qq.com
 * @date 2021-02-02 21:09:57
 */
public interface AttrGroupService extends IService<AttrGroupEntity> {

    PageUtils queryPage(Map<String, Object> params);

    PageUtils queryPage(Map<String, Object> params, Long categoryId);

    AttrGroupRespVo getDetailById(Long attrGroupId);

    /**
     * 根据分类Id获取分类下的属性组以及属性组的属性
     */
    List<AttrGroupComplexRespVo> getAttrDetailsByCategoryId(Long catelogId);

    /**
     * 根据分类id和商品id、查询出对应的属性组，以及属性组下的属性、属性值
     */
    List<SpuItemAttrGroupVo> getAttrGroupWithAttrByCatalogIdAndSpuId(Long catalogId, Long spuId);
}


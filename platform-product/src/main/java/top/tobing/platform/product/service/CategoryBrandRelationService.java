package top.tobing.platform.product.service;

import com.baomidou.mybatisplus.extension.service.IService;
import top.tobing.common.utils.PageUtils;
import top.tobing.platform.product.entity.CategoryBrandRelationEntity;
import top.tobing.platform.product.vo.BrandRespVo;
import top.tobing.platform.product.vo.CategoryRespVo;

import java.util.List;
import java.util.Map;

/**
 * 品牌分类关联
 *
 * @author tobing
 * @email 652916578@qq.com
 * @date 2021-02-02 21:09:57
 */
public interface CategoryBrandRelationService extends IService<CategoryBrandRelationEntity> {

    PageUtils queryPage(Map<String, Object> params);

    /**
     * 根据品牌id，查询关联的分类
     *
     * @param brandId 品牌id
     * @return 品牌与分类
     */
    List<CategoryBrandRelationEntity> catelogList(Long brandId);

    /**
     * 保存分类与品牌的映射
     *
     * @param categoryBrandRelation 分类品牌映射信息
     */
    void saveDetail(CategoryBrandRelationEntity categoryBrandRelation);


    /**
     * 查询某个分类下的品牌
     *
     * @param categoryId 分类id
     * @return
     */
    List<BrandRespVo> getBrandListByCategoryId(Long categoryId);
}


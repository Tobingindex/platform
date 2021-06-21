package top.tobing.platform.product.dao;

import org.apache.ibatis.annotations.Param;
import top.tobing.platform.product.entity.CategoryBrandRelationEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * 品牌分类关联
 *
 * @author tobing
 * @email 652916578@qq.com
 * @date 2021-02-02 21:09:57
 */
@Mapper
public interface CategoryBrandRelationDao extends BaseMapper<CategoryBrandRelationEntity> {

    void updateByrandNameByBrandId(@Param("brandId") Long brandId, @Param("name") String name);

    void updateCategoryNameByCategoryId(@Param("catId") Long catId, @Param("name") String name);
}

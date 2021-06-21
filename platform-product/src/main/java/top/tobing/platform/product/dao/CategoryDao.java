package top.tobing.platform.product.dao;

import top.tobing.platform.product.entity.CategoryEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * 商品三级分类
 * 
 * @author tobing
 * @email 652916578@qq.com
 * @date 2021-02-02 21:09:57
 */
@Mapper
public interface CategoryDao extends BaseMapper<CategoryEntity> {
	
}

package top.tobing.platform.product.dao;

import org.springframework.stereotype.Repository;
import top.tobing.platform.product.entity.AttrAttrgroupRelationEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * 属性&属性分组关联
 * 
 * @author tobing
 * @email 652916578@qq.com
 * @date 2021-02-02 21:09:57
 */
@Mapper
public interface AttrAttrgroupRelationDao extends BaseMapper<AttrAttrgroupRelationEntity> {
	
}

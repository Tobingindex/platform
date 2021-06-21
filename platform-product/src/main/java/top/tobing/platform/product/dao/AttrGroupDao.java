package top.tobing.platform.product.dao;

import org.apache.ibatis.annotations.Param;
import top.tobing.platform.product.entity.AttrGroupEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import top.tobing.platform.product.vo.SpuItemAttrGroupVo;

import java.util.List;

/**
 * 属性分组
 *
 * @author tobing
 * @email 652916578@qq.com
 * @date 2021-02-02 21:09:57
 */
@Mapper
public interface AttrGroupDao extends BaseMapper<AttrGroupEntity> {

    List<SpuItemAttrGroupVo> getAttrGroupWithAttrByCatalogIdAndSpuId(@Param("catalogId") Long catalogId, @Param("spuId") Long spuId);

}

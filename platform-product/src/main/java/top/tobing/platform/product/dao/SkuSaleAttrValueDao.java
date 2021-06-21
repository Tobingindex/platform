package top.tobing.platform.product.dao;

import org.apache.ibatis.annotations.Param;
import top.tobing.platform.product.entity.SkuSaleAttrValueEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import top.tobing.platform.product.vo.SkuItemSaleAttrVo;

import java.util.List;

/**
 * sku销售属性&值
 * 
 * @author tobing
 * @email 652916578@qq.com
 * @date 2021-02-02 21:09:57
 */
@Mapper
public interface SkuSaleAttrValueDao extends BaseMapper<SkuSaleAttrValueEntity> {

    List<SkuItemSaleAttrVo> getSaleAttrBySpuId(@Param("spuId") Long spuId);

}

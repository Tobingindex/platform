package top.tobing.platform.product.dao;

import org.apache.ibatis.annotations.Param;
import top.tobing.platform.product.entity.SkuInfoEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * sku信息
 *
 * @author tobing
 * @email 652916578@qq.com
 * @date 2021-02-02 21:09:57
 */
@Mapper
public interface SkuInfoDao extends BaseMapper<SkuInfoEntity> {

    /**
     * 根据skuId查询对应的销售属性
     */
    List<String> getSkuSaleListBySkuId(@Param("skuId") Long skuId);
}

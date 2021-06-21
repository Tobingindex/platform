package top.tobing.platform.ware.dao;

import org.apache.ibatis.annotations.Param;
import top.tobing.platform.ware.entity.WareSkuEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * 商品库存
 *
 * @author tobing
 * @email tobing6379@gmail.com
 * @date 2021-03-29 22:27:14
 */
@Mapper
public interface WareSkuDao extends BaseMapper<WareSkuEntity> {

    void addStack(@Param("skuId") Long skuId, @Param("wareId") Long wareId, @Param("skuNum") Integer skuNum);

    Integer batchGetSkuStockById(Long id);

    List<Long> listWareBySkuId(Long skuId);

    Integer lockSkuStock(@Param("skuId") Long skuId, @Param("wareId") Long wareId, @Param("num") Integer num);

    void unlockStockBySkuIdAndWareId(@Param("skuId") Long skuId, @Param("wareId") Long wareId, @Param("skuNum") Integer skuNum);
}

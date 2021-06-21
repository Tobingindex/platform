package top.tobing.platform.product.dao;

import top.tobing.platform.product.entity.SpuInfoEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * spu信息
 * 
 * @author tobing
 * @email 652916578@qq.com
 * @date 2021-02-02 21:09:57
 */
@Mapper
public interface SpuInfoDao extends BaseMapper<SpuInfoEntity> {

    /**
     * 更新商品状态
     */
    void updateStatusById(SpuInfoEntity newState);

}

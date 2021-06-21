package top.tobing.platform.ware.dao;

import org.apache.ibatis.annotations.Param;
import top.tobing.platform.ware.entity.WareOrderTaskDetailEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * 库存工作单
 * 
 * @author tobing
 * @email tobing6379@gmail.com
 * @date 2021-03-29 22:27:14
 */
@Mapper
public interface WareOrderTaskDetailDao extends BaseMapper<WareOrderTaskDetailEntity> {

    /**
     * 更新订单状态为解锁状态
     */
    Integer updateLockStatusToUnlock(@Param("id") Long id);
}

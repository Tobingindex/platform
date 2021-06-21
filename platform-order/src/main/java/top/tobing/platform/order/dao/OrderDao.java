package top.tobing.platform.order.dao;

import org.apache.ibatis.annotations.Param;
import top.tobing.platform.order.entity.OrderEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * 订单
 *
 * @author tobing
 * @email tobing6379@gmail.com
 * @date 2021-04-22 16:54:38
 */
@Mapper
public interface OrderDao extends BaseMapper<OrderEntity> {

    Integer updateOrderStatusToOverdue(@Param("orderSn") String orderSn);

    void updateOrderStatusByOrderSn(@Param("orderSn") String orderSn, @Param("status") Integer status);
}

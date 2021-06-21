package top.tobing.platform.order.dao;

import top.tobing.platform.order.entity.OrderSettingEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * 订单配置信息
 * 
 * @author tobing
 * @email tobing6379@gmail.com
 * @date 2021-04-22 16:54:38
 */
@Mapper
public interface OrderSettingDao extends BaseMapper<OrderSettingEntity> {
	
}

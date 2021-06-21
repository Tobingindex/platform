package top.tobing.platform.order.dao;

import top.tobing.platform.order.entity.PaymentInfoEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * 支付信息表
 * 
 * @author tobing
 * @email tobing6379@gmail.com
 * @date 2021-04-22 16:54:38
 */
@Mapper
public interface PaymentInfoDao extends BaseMapper<PaymentInfoEntity> {
	
}

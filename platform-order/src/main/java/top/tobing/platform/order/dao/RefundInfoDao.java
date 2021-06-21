package top.tobing.platform.order.dao;

import top.tobing.platform.order.entity.RefundInfoEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * 退款信息
 * 
 * @author tobing
 * @email tobing6379@gmail.com
 * @date 2021-04-22 16:54:39
 */
@Mapper
public interface RefundInfoDao extends BaseMapper<RefundInfoEntity> {
	
}

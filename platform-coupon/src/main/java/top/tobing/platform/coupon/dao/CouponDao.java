package top.tobing.platform.coupon.dao;

import top.tobing.platform.coupon.entity.CouponEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * 优惠券信息
 * 
 * @author tobing
 * @email tobing6379@gmail.com
 * @date 2021-03-09 16:09:33
 */
@Mapper
public interface CouponDao extends BaseMapper<CouponEntity> {
	
}

package top.tobing.platform.member.dao;

import top.tobing.platform.member.entity.MemberReceiveAddressEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * 会员收货地址
 * 
 * @author tobing
 * @email tobing6379@gmail.com
 * @date 2021-03-07 21:14:08
 */
@Mapper
public interface MemberReceiveAddressDao extends BaseMapper<MemberReceiveAddressEntity> {
	
}

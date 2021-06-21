package top.tobing.platform.ware.dao;

import top.tobing.platform.ware.entity.PurchaseEntity;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * 采购信息
 * 
 * @author tobing
 * @email tobing6379@gmail.com
 * @date 2021-03-29 22:27:14
 */
@Mapper
public interface PurchaseDao extends BaseMapper<PurchaseEntity> {
	
}

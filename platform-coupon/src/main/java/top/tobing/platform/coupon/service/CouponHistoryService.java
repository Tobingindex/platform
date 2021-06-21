package top.tobing.platform.coupon.service;

import com.baomidou.mybatisplus.extension.service.IService;
import top.tobing.common.utils.PageUtils;
import top.tobing.platform.coupon.entity.CouponHistoryEntity;

import java.util.Map;

/**
 * 优惠券领取历史记录
 *
 * @author tobing
 * @email tobing6379@gmail.com
 * @date 2021-03-09 16:09:33
 */
public interface CouponHistoryService extends IService<CouponHistoryEntity> {

    PageUtils queryPage(Map<String, Object> params);
}


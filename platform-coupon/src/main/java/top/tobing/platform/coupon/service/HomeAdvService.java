package top.tobing.platform.coupon.service;

import com.baomidou.mybatisplus.extension.service.IService;
import top.tobing.common.utils.PageUtils;
import top.tobing.platform.coupon.entity.HomeAdvEntity;

import java.util.Map;

/**
 * 首页轮播广告
 *
 * @author tobing
 * @email tobing6379@gmail.com
 * @date 2021-03-09 16:09:33
 */
public interface HomeAdvService extends IService<HomeAdvEntity> {

    PageUtils queryPage(Map<String, Object> params);
}


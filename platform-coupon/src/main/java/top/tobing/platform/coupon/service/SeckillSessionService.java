package top.tobing.platform.coupon.service;

import com.baomidou.mybatisplus.extension.service.IService;
import top.tobing.common.utils.PageUtils;
import top.tobing.platform.coupon.entity.SeckillSessionEntity;
import top.tobing.platform.coupon.vo.SeckillSessionWithSkusVo;

import java.util.List;
import java.util.Map;

/**
 * 秒杀活动场次
 *
 * @author tobing
 * @email tobing6379@gmail.com
 * @date 2021-03-09 16:09:33
 */
public interface SeckillSessionService extends IService<SeckillSessionEntity> {

    PageUtils queryPage(Map<String, Object> params);

    List<SeckillSessionWithSkusVo> recently3DaySession();

}


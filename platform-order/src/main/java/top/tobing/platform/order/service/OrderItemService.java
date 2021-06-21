package top.tobing.platform.order.service;

import com.baomidou.mybatisplus.extension.service.IService;
import top.tobing.common.utils.PageUtils;
import top.tobing.platform.order.entity.OrderItemEntity;

import java.util.Map;

/**
 * 订单项信息
 *
 * @author tobing
 * @email tobing6379@gmail.com
 * @date 2021-04-22 16:54:38
 */
public interface OrderItemService extends IService<OrderItemEntity> {

    PageUtils queryPage(Map<String, Object> params);
}


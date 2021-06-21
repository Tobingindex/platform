package top.tobing.platform.order.service;

import com.baomidou.mybatisplus.extension.service.IService;
import top.tobing.common.to.mq.SeckillOrderTo;
import top.tobing.common.utils.PageUtils;
import top.tobing.platform.order.entity.OrderEntity;
import top.tobing.platform.order.vo.*;

import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

/**
 * 订单
 *
 * @author tobing
 * @email tobing6379@gmail.com
 * @date 2021-04-22 16:54:38
 */
public interface OrderService extends IService<OrderEntity> {

    PageUtils queryPage(Map<String, Object> params);

    /**
     * 根据选中的商品生成订单
     */
    OrderConfirmVo toTrade() throws ExecutionException, InterruptedException;

    /**
     * 提交订单
     */
    OrderSubmitRespVo submitOrder(OrderSubmitVo orderSubmitVo);

    /**
     * 根据订单号查询订单状态
     */
    OrderEntity getStatusByOrderSn(String orderSn);

    /**
     * 将订单从「待付款」状态更新到「已关闭」状态
     */
    Integer updateOrderStatusToOverdue(String orderSn);

    /**
     * 根据订单号封装支付信息
     */
    PayVo getOrderPay(String orderSn);

    /**
     * 查询订单详情
     */
    List<OrderRespVo> getOrderDetailList();

    /**
     * 根据支付异步回调，更新订单状态
     */
    String updateOrderStatusByAlipay(PayAsyncVo payVo);

    /**
     * 保存秒杀订单
     */
    void saveSeckillOrder(SeckillOrderTo seckillOrderTo);
}


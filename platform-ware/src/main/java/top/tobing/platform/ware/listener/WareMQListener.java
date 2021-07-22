package top.tobing.platform.ware.listener;

import com.rabbitmq.client.Channel;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.annotation.RabbitHandler;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import top.tobing.common.to.OrderTo;
import top.tobing.common.to.mq.WareTaskTo;
import top.tobing.platform.ware.entity.WareOrderTaskDetailEntity;
import top.tobing.platform.ware.entity.WareOrderTaskEntity;
import top.tobing.platform.ware.feign.OrderFeignService;
import top.tobing.platform.ware.service.WareOrderTaskDetailService;
import top.tobing.platform.ware.service.WareOrderTaskService;
import top.tobing.platform.ware.service.WareSkuService;

import java.io.IOException;
import java.util.List;

/**
 * @Author tobing
 * @Date 2021/4/27 20:52
 * @Description
 */
@Slf4j
@Component
@RabbitListener(queues = "stock.release.stock.queue")
public class WareMQListener {

    @Autowired
    private WareOrderTaskDetailService wareOrderTaskDetailService;
    @Autowired
    private WareOrderTaskService wareOrderTaskService;
    @Autowired
    private OrderFeignService orderFeignService;
    @Autowired
    private WareSkuService wareSkuService;

    /**
     * 【解锁库存】
     * 1、订单存在：一定存在库存工作单
     * ===>1.1 订单已支付（根据订单状态判断）：消费消息，无需其他处理
     * ===>1.2 订单未支付（根据订单状态判断）：消费消息，解锁库存
     * 2、订单不存在：不一定存在库存工作单
     * ===>2.1 存在库存工作单：由于其他服务导致的订单事务回滚：消费消息，解锁库存
     * ===>2.2 没有库存工作单：由于锁定库存导致的订单事务回：消费消息，无需处理
     */
    @RabbitHandler()
    public void handlerStockLockedRelease(WareTaskTo wareTaskTo, Message message, Channel channel) throws IOException {
        log.info("收到订单取消信息.....");
        // 查询库存工作单
        try {
            WareOrderTaskEntity taskEntity = wareOrderTaskService.getById(wareTaskTo.getId());
            if (taskEntity != null) { //存在库存工作单：判断是否存在订单
                // 判断订单是否存在
                OrderTo order = orderFeignService.getStatusByOrderSn(taskEntity.getOrderSn());
                if (order == null) { // 不存在，需要解锁库存（引用非库存服务导致的事务回滚）
                    for (WareOrderTaskDetailEntity task : wareOrderTaskDetailService.listByTaskId(wareTaskTo.getId())) {
                        wareSkuService.unlockStockBySkuIdAndWareId(task.getSkuId(), task.getWareId(), task.getSkuNum());
                    }
                } else {    // 存在，判断订单的状态
                    if (order.getStatus() == 4) {   // 取消支付：直接解锁库存
                        for (WareOrderTaskDetailEntity task : wareOrderTaskDetailService.listByTaskId(order.getId())) {
                            wareSkuService.unlockStockBySkuIdAndWareId(task.getSkuId(), task.getWareId(), task.getSkuNum());
                        }
                    }
                }
            }
            // 最终都需要消费消息
            channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
        } catch (Exception e) {
            log.error("处理消息出现异常：", e);
            // 处理消息过程中如果出现异常，决绝消息，并让消息回队列
            channel.basicReject(message.getMessageProperties().getDeliveryTag(), true);
        }
    }

    /**
     * 【解锁库存】
     * 处理由于订单超时产生的库存解锁信息
     */
    @RabbitHandler
    public void handlerOrderRelease(String orderSn, Message message, Channel channel) throws IOException {
        log.info("收到订单超时消息，订单号：{}", orderSn);
        try {
            // 根据orderSn查询库存工作单
            WareOrderTaskEntity wareOrderTaskEntity = wareOrderTaskService.getByOrderSn(orderSn);
            if (wareOrderTaskEntity != null) {
                // 根据库存工作单id查询工作单详情，解锁库存
                List<WareOrderTaskDetailEntity> orderTaskDetailList = wareOrderTaskDetailService.listByTaskId(wareOrderTaskEntity.getId());
                for (WareOrderTaskDetailEntity wareOrderTaskDetailEntity : orderTaskDetailList) {
                    // 乐观锁更新订单数据
                    Integer res = wareOrderTaskDetailService.updateLockStatusToUnlock(wareOrderTaskDetailEntity.getId());
                    if (res == 1) {
                        // 更新成功直接解锁库存
                        wareSkuService.unlockStockBySkuIdAndWareId(wareOrderTaskDetailEntity.getSkuId(),
                                wareOrderTaskDetailEntity.getWareId(),
                                wareOrderTaskDetailEntity.getSkuNum());
                    }
                }
            }
            // 如果上面的步骤执行成功，直接消费消息
            channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
        } catch (Exception e) {
            // 在处理消息过程中无论出现什么异常都需要拒绝消费消息，将消息重新回队列
            log.error("处理订单超时消息出现异常，回滚消息！", e);
            channel.basicReject(message.getMessageProperties().getDeliveryTag(), true);
        }

    }

}

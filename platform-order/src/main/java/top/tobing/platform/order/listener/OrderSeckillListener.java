package top.tobing.platform.order.listener;

import com.rabbitmq.client.Channel;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.annotation.RabbitHandler;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import top.tobing.common.to.mq.SeckillOrderTo;
import top.tobing.platform.order.service.OrderItemService;
import top.tobing.platform.order.service.OrderService;

import java.io.IOException;

/**
 * @Author tobing
 * @Date 2021/5/3 11:23
 * @Description
 */
@Slf4j
@Component
@RabbitListener(queues = "order.seckill.order.queue")
public class OrderSeckillListener {

    @Autowired
    private OrderService orderService;

    @RabbitHandler
    public void listener(SeckillOrderTo seckillOrderTo, Message message, Channel channel) throws IOException {
        System.out.println("收到订单秒杀消息，订单号为：" + seckillOrderTo.getOrderSn());
        // TODO 创建订单信息、订单项信息
        try {
            orderService.saveSeckillOrder(seckillOrderTo);
            // 消息确认
            channel.basicAck(message.getMessageProperties().getDeliveryTag(), false);
        } catch (Exception e) {
            log.error("创建秒杀订单出错，拒绝消息！");
            channel.basicReject(message.getMessageProperties().getDeliveryTag(), true);
        }
    }
}

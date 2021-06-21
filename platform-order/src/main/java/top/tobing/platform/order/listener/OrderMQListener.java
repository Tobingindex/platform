package top.tobing.platform.order.listener;

import com.rabbitmq.client.Channel;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.annotation.RabbitHandler;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import top.tobing.platform.order.entity.OrderEntity;
import top.tobing.platform.order.service.OrderService;

import java.io.IOException;

/**
 * @Author tobing
 * @Date 2021/4/29 17:43
 * @Description 订单释放消息处理
 */
@Component
@RabbitListener(queues = "order.release.order.queue")
public class OrderMQListener {

    @Autowired
    private OrderService orderService;
    @Autowired
    private RabbitTemplate rabbitTemplate;

    @RabbitHandler
    public void listener(String orderSn, Message message, Channel channel) throws IOException {
        System.out.println("收到释放订单的消息，订单号为：" + orderSn);
        // 乐观锁更新订单状态
        Integer res = orderService.updateOrderStatusToOverdue(orderSn);
        // 同时先解锁库存队列发送解锁消息
        if (res == 1) { // 保证订单的状态成功被为别取消
            rabbitTemplate.convertAndSend("order-event-exchange", "order.release.other", orderSn);
        }
        // 手动确认，禁止批量确认
        long deliveryTag = message.getMessageProperties().getDeliveryTag();
        channel.basicAck(deliveryTag, false);
    }

}

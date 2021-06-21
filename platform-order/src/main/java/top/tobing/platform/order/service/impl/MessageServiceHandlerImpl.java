package top.tobing.platform.order.service.impl;

import com.rabbitmq.client.Channel;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.annotation.RabbitHandler;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Service;
import top.tobing.platform.order.entity.OrderEntity;
import top.tobing.platform.order.entity.OrderItemEntity;

import java.io.IOException;

/**
 * @Author tobing
 * @Date 2021/4/22 18:20
 * @Description 消息接收服务
 */
@Service
@RabbitListener(queues = {"hello-java-queue"})
public class MessageServiceHandlerImpl {

    // 自动接收内容为OrderItemEntity的消息
    @RabbitHandler()
    public void recMsg(Message message, OrderItemEntity orderItemEntity, Channel channel) {
        // 消费消息
        System.out.println("message:" + message);
        System.out.println("orderItem:" + orderItemEntity);
        // 确认消息
        try {
            long deliveryTag = message.getMessageProperties().getDeliveryTag();
            // 对每个消息一一确认，不采用批量模式
            channel.basicAck(deliveryTag, false);
        } catch (IOException e) {
            // 网络中断等问题
            e.printStackTrace();
        }
    }

    // 自动接收内容为OrderEntity的消息
    @RabbitHandler()
    public void recMsg(Message message, OrderEntity orderEntity, Channel channel) {
        // 消费消息
        System.out.println("message:" + message);
        System.out.println("order:" + orderEntity);
        // 确认消息
        try {
            long deliveryTag = message.getMessageProperties().getDeliveryTag();
            // 对每个消息一一确认，不采用批量模式
            channel.basicAck(deliveryTag, false);
        } catch (IOException e) {
            // 网络中断等问题
            e.printStackTrace();
        }
    }
}

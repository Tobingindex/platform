package top.tobing.platform.order.service.impl;

import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Service;
import top.tobing.platform.order.entity.OrderItemEntity;

import java.nio.channels.Channel;

/**
 * @Author tobing
 * @Date 2021/4/22 18:20
 * @Description 消息接收服务
 */
@Service
public class MessageServiceImpl {

    /**
     * queues：声明需要监听的所有队列
     * 参数可以取以下类型
     * 1、Message：原始消息详情
     * 2、Channel：当前传输数据的管道
     * 3、Object：发送消息时指定的对象类型，可以在接收的时候自动注入到该对象中，如OrderItemEntity
     * 采用这种方式监听消息，可以有多个人消费，但是一个消息只能被消费一次（一旦消息被消费，就会从MQ中删除）。
     * 采用这种方式监听消息，方法运行结束，可以接受下一个消息
     */
    // @RabbitListener(queues = {"hello-java-queue"})
    public void recMsg(Message message, OrderItemEntity orderItemEntity) {
        System.out.println("message:" + message);
        System.out.println("orderItem:" + orderItemEntity);
    }
}

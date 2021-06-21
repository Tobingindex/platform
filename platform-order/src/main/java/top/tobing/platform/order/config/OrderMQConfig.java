package top.tobing.platform.order.config;

import com.rabbitmq.client.Channel;
import org.springframework.amqp.core.*;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import top.tobing.platform.order.entity.OrderEntity;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * @Author tobing
 * @Date 2021/4/26 16:34
 * @Description
 */
@Configuration
public class OrderMQConfig {

    // 监听订单释放
    // @RabbitListener(queues = "order.release.order.queue")
    public void listener(OrderEntity orderEntity, Message message, Channel channel) throws IOException {
        System.out.println("收到释放订单的消息，订单号为：" + orderEntity.getOrderSn());
        long deliveryTag = message.getMessageProperties().getDeliveryTag();
        // 手动确认，禁止批量确认
        channel.basicAck(deliveryTag, false);
    }


    // 延时队列 ： order.delay.queue
    // 监听队列 ： order.release.order.queue
    // 交换机：order-event-exchange
    // 绑定关系： order.delay.queue ==> order.create.order
    // 绑定关系： order.release.order.queue ==> order.release.order

    /**
     * 【延时队列】
     * 消息发送到此队列，不会被消费者消费，该队列中的消息会在添加到度列之后指定ttl失效
     * 失效的消息会以「x-dead-letter-routing-key」的routing-key发送到「x-dead-letter-exchange」指定的交换机
     */
    @Bean
    public Queue orderDelayQueue() {
        Map<String, Object> map = new HashMap<>();
        map.put("x-dead-letter-exchange", "order-event-exchange");
        map.put("x-dead-letter-routing-key", "order.release.order");
        map.put("x-message-ttl", 60000);
        return new Queue("order.delay.queue", true, false, false, map);
    }

    /**
     * 【处理队列】
     * 有客户端监听的队列，延时队列失效的消息会通过路由键来到此队列
     * 客户端收到之后会对失效的消息进行处理
     */
    @Bean
    public Queue orderReleaseOrderQueue() {
        return new Queue("order.release.order.queue",
                true, false, false, null);
    }

    /**
     * 【交换机】
     * 基于定于的交换机。有两方面功能：
     * ①将延时消息转发个延时队列
     * ②将超时信息转发个处理队列
     */
    @Bean
    public Exchange orderEventExchange() {
        return new TopicExchange("order-event-exchange",
                true,
                false,
                null);
    }

    /**
     * 【绑定关系】
     * 将交换机与延时队列绑定
     */
    @Bean
    public Binding orderCreateOrderBinding() {
        return new Binding("order.delay.queue",
                Binding.DestinationType.QUEUE,
                "order-event-exchange",
                "order.create.order",
                null);
    }

    /**
     * 【绑定关系】
     * 将交换机与处理队列绑定
     */
    @Bean
    public Binding orderReleaseOrderBinding() {
        return new Binding("order.release.order.queue",
                Binding.DestinationType.QUEUE,
                "order-event-exchange",
                "order.release.order",
                null);
    }

    /**
     * 【绑定关系】
     * 将交换机与解锁库存队列解锁
     */
    @Bean
    public Binding orderStockReleaseBinding() {
        return new Binding("stock.release.stock.queue",
                Binding.DestinationType.QUEUE,
                "order-event-exchange",
                "order.release.other.#",
                null);
    }


    /**
     * 【秒杀处理队列】
     */
    @Bean
    public Queue orderSeckillOrderQueue() {
        return new Queue("order.seckill.order.queue",
                true, false, false, null);
    }

    /**
     * 【绑定关系】
     * 绑定订单秒杀与订单路由
     */
    @Bean
    public Binding orderSeckillOrderBinding() {
        return new Binding("order.seckill.order.queue",
                Binding.DestinationType.QUEUE,
                "order-event-exchange",
                "ordre.seckill.order",
                null);
    }


}

package top.tobing.platform.ware.config;

import org.springframework.amqp.core.*;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.HashMap;
import java.util.Map;

/**
 * @Author tobing
 * @Date 2021/4/27 16:19
 * @Description
 */
@Configuration
public class WareMQConfig {

    // 用于方便创建下面的主键，采用Bean方式创建的时候需要连上一次MQ
//    @RabbitListener(queues = "stock.release.stock.queue")
//    public void listener(Message message) {
//
//    }

    /**
     * 库存服务交换机
     * Exchange：stock-event-exchange
     * TopicExchange(String name, boolean durable, boolean autoDelete, Map<String, Object> arguments)
     */
    @Bean
    public Exchange stockEventExchange() {
        return new TopicExchange("stock-event-exchange", true, false, null);
    }

    /**
     * 解锁库存队列
     * Queue：stock.release.stock.queue
     */
    @Bean
    public Queue stockReleaseStockQueue() {
        return new Queue("stock.release.stock.queue", true, false, false, null);
    }

    /**
     * 库存延时队列【为了演示方便采用2min】
     * Queue：stock.delay.queue 50min
     * Queue(String name, boolean durable, boolean exclusive, boolean autoDelete, Map<String, Object> arguments)
     */
    @Bean
    public Queue stockDelayQueue() {
        Map<String, Object> map = new HashMap<>();
        map.put("x-dead-letter-exchange", "stock-event-exchange");
        map.put("x-dead-letter-routing-key", "stock.release");
        map.put("x-message-ttl", 120000);
        return new Queue("stock.delay.queue", true, false, false, map);
    }

    /**
     * Exchange与延时队列的绑定关系
     * Binding(String destination, Binding.DestinationType destinationType, String exchange, String routingKey, java.util.Map<String, Object> arguments)
     */
    @Bean
    public Binding stockLockedExchange() {
        return new Binding("stock.delay.queue",
                Binding.DestinationType.QUEUE,
                "stock-event-exchange",
                "stock.locked",
                null);
    }


    /**
     * 释放队列与Exchange绑定
     */
    @Bean
    public Binding stockReleaseExchange() {
        return new Binding("stock.release.stock.queue",
                Binding.DestinationType.QUEUE,
                "stock-event-exchange",
                "stock.release.#",
                null);
    }


    // Binding：stock.locked stock.delay.queue==>Exchange
    // Binding：stock.release.# stock.release.stock.queue==>Exchange

}

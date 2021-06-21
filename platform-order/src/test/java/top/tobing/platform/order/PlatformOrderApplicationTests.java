package top.tobing.platform.order;

import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.amqp.core.AmqpAdmin;
import org.springframework.amqp.core.Binding;
import org.springframework.amqp.core.DirectExchange;
import org.springframework.amqp.core.Queue;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import top.tobing.platform.order.entity.OrderEntity;
import top.tobing.platform.order.entity.OrderItemEntity;

import java.util.UUID;

@Slf4j
@SpringBootTest
class PlatformOrderApplicationTests {

    /**
     * 测试AmqpAdmin
     */
    @Autowired
    private AmqpAdmin amqpAdmin;

    // 测试创建Exchange
    // @Test
    void testCreateExchange() {
        /**
         * public DirectExchange(String name,           // 队列名称
         *                       boolean durable,       // 是否持久化
         *                       boolean autoDelete,    // 是否自动删除
         *                       @Nullable java.util.Map<String, Object> arguments)
         */
        DirectExchange directExchange = new DirectExchange("hello-java-exchange", true, false);
        amqpAdmin.declareExchange(directExchange);
        log.info("Exchange[{}]创建成功！", "hello-java-exchange");
    }

    // 测试创建Queue
    // @Test
    void testCreateQueue() {
        /**
         * public Queue(@NotNull String name,   // 名称
         *              boolean durable,        // 是否持久化
         *              boolean exclusive,      // 是否排他
         *              boolean autoDelete,     // 是否自动删除
         *              @Nullable @Nullable java.util.Map<String, Object> arguments)
         */
        Queue queue = new Queue("hello-java-queue", true, false, false);
        amqpAdmin.declareQueue(queue);
        log.info("Queue[{}]创建成功！", "hello-java-queue");
    }

    // 测试绑定
    // @Test
    void testCreateBind() {
        /** 将Exchange与destination(queue/exchange)绑定
         * public Binding(String destination,                       // 目的地址
         *                Binding.DestinationType destinationType,  // 目的类型
         *                String exchange,  // 要绑定的交换机
         *                String routingKey,// 路由键
         *                @Nullable @Nullable java.util.Map<String, Object> arguments)
         */
        Binding binding = new Binding("hello-java-queue",
                Binding.DestinationType.QUEUE,
                "hello-java-exchange",
                "", null);
        amqpAdmin.declareBinding(binding);
        log.info("Banding[{}]创建成功！", "banding");
    }

    /**
     * 测试RabbitTemplate
     */
    @Autowired
    private RabbitTemplate rabbitTemplate;

    // 测试发送消息
    // @Test
    void testSendMsg() {
        OrderItemEntity orderItemEntity = new OrderItemEntity();
        orderItemEntity.setOrderSn(UUID.randomUUID().toString());
        orderItemEntity.setGiftGrowth(100);
        // 如果发送的是对象，默认情况先会使用JDK的序列化器来序列化，这时就需要将该类实现Serializable接口
        // 但一般情况下也可以注入一个json转换器来以json方式转换进而实现序列化【推荐使用】
        // 完交换器(hello-java-exchange)发送消息(orderItemEntity)
        rabbitTemplate.convertAndSend("hello-java-exchange", "", orderItemEntity);
        log.info("发送消息");
    }
}

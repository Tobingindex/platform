# RabbitMQ 实现延时队列

对于未支付的订单，超过一定时间之后，系统自动取消订单并释放占有物品(解锁库存)。

常见的解决方案有，通过Spring的schedule定时任务轮询数据库。但是这种方式消耗系统内存，增加数据库压力，最主要还是存在较大的时间误差。

> Spring 的 schedule的缺点：假设一个任务在定时开始的1min之后才到的，到下一个30min时，定时任务仅仅29min，不符合过期时间，只能等到第2个30min，即60min才会被处理，即该任务等待了59min才被处理，与要求30min相差太多。

![image-20210426171420290](https://tobing-markdown.oss-cn-shenzhen.aliyuncs.com/image-20210426171420290.png)

而使用RabbitMQ的消息TTL以及死信Exchange结合可以避免Spring 的 schedule的缺点，接下来接受一下RabbitMQ的一些概念。

## 1、消息的TTL

TTL，Time To Live，消息的存活时间。

RabbitMQ可以对**队列**和**消息**分布设置TTL。

+ 对队列设置就是队列没有消费者连着的保留时间，也可以对一个单独的消息做单独设置，超过这个时间，可以认为这个消息死了，称之为**死信**。
+ 如果队列设置了，消息也设置了，那么取最小的。所以一个消息如果被路由到不同的队列中，这个消息死亡时间有可能不同。
+ 消息的TTL是实现延时任务的关键，可以同设置消息的`expiration`或`x-message-ttl`属性来设置时间，两种效果一样。

## 2、死信Exchange

Dead Letter Exchange，死信路由，一个消息如果满足以下条件，会进入死信路由：

+ 一个信息个Consumer拒收，并且reject方法的参数里request是false。也就是说不会被再次放在队列里面，被其他消费者使用。
+ 一个消息的TTL到了，消息过期了。
+ 队列的长度限制满了，排在前面的消息会被丢弃或放到死信路由。

DLE(Dead Letter Exchange)其实就是一种普通的路由，创建的方式和其它路由并无两样。

只是在某一个设置了DLE队列的队列中如果有消息过期了，会自动触发消息的转发，发送到DLE中。

**我们既可以控制消息在一段时间后变成死信，有可以控制变成死信的消息被路由到某一个指定的交换机，结合二者可以实现延时队列。**

## 3、延时队列实现

### 3.1 方式1

![delayqueueimpl1](https://tobing-markdown.oss-cn-shenzhen.aliyuncs.com/delayqueueimpl1.jpg)

### 3.2 方式2

![delayqueueimpl2](https://tobing-markdown.oss-cn-shenzhen.aliyuncs.com/delayqueueimpl2.jpg)

## 4、延时队列的简单演示

基于一些RabbitMQ，我们采用选用方式1来实现我们项目中的业务。

【业务需求】

订单生成，1min之后检查是否支付。

> RabbitMQ的结构图

![delayqueueimplinplatform](https://tobing-markdown.oss-cn-shenzhen.aliyuncs.com/delayqueueimplinplatform.jpg)

> 代码实现：创建对应的Exchange、Queue、Binding。在SpringBoot只要我们将Exchange、Queue、Binding以Bean的方式注入到容器中，SpringBoot就会帮我们自定创建指定的实体。

```java
@Configuration
public class OrderMQConfig {

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
}
```

> 监听延时消息

```java
// 监听订单释放
@RabbitListener(queues = "order.release.order.queue")
public void listener(OrderEntity orderEntity, Message message, Channel channel) throws IOException {
    System.out.println("收到释放订单的消息，订单号为：" + orderEntity.getOrderSn());
    long deliveryTag = message.getMessageProperties().getDeliveryTag();
    // 手动确认，禁止批量确认
    channel.basicAck(deliveryTag, false);
}
```

> 发送消息

```java
@Autowired
private RabbitTemplate rabbitTemplate;

@ResponseBody
@GetMapping("/test/order")
public String testSendMsg() {
    OrderEntity orderEntity = new OrderEntity();
    orderEntity.setOrderSn(UUID.randomUUID().toString());
    rabbitTemplate.convertAndSend("order-event-exchange", "order.create.order", orderEntity);
    return "ok";
}
```


# SpringBoot整合各种技术

## 1、整合 Rabbitmq

### 使用

1、引入starter

```xml
<!--amqp-->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-amqp</artifactId>
</dependency>
```

2、开启Rabbitmq使用

```java
@EnableRabbit
@SpringBootApplication
public class PlatformOrderApplication {
}
```

3、配置配置信息

```properties
# rabbitmq
spring.rabbitmq.host=121.196.163.151
spring.rabbitmq.username=guest
spring.rabbitmq.password=xxxxx
```

4、使用注解监听消息【2种方式】

> 方式1：方法/类上使用@RabbitListener注解

```java
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
    @RabbitListener(queues = {"hello-java-queue"})
    public void recMsg(Message message, OrderItemEntity orderItemEntity, Channel channel) {
        System.out.println("message:" + message);
        System.out.println("orderItem:" + orderItemEntity);
    }
}
```

> 方式2：类使用@RabbitListener，方法使用@RabbitHandler
>
> @RabbitListener指定监听的队列
>
> @RabbitHandler自适应读取消息

```java
@Service
@RabbitListener(queues = {"hello-java-queue"})	
public class MessageServiceHandlerImpl {

    // 自动接收内容为OrderItemEntity的消息
    @RabbitHandler()
    public void recMsg(Message message, OrderItemEntity orderItemEntity) {
        System.out.println("message:" + message);
        System.out.println("orderItem:" + orderItemEntity);
    }

    // 自动接收内容为OrderEntity的消息
    @RabbitHandler()
    public void recMsg(Message message, OrderEntity orderEntity) {
        System.out.println("message:" + message);
        System.out.println("order:" + orderEntity);
    }
}
```

### 原理

1、添加`spring-boot-starter-amqp`会引入`RabbitAutoConfiguration`；

2、该自动配置类往容器中引入了CachingConnectionFactory、RabbitTemplateConfigurer、RabbitTemplate、AmqpAdmin、RabbitMessagingTemplate等Bean；

3、同时该配置类还会从`RabbitProperties`中获取某些自定义配置信息，前缀为spring.rabbitmq；

4、正是我们在配置文件中配置的内容。

> 图1：RabbitAutoConfiguration，通过RabbitProperties引入用户自定义的配置信息

![image-20210422171309577](https://tobing-markdown.oss-cn-shenzhen.aliyuncs.com/image-20210422171309577.png)

> 图2：RabbitProperties，配置了一下默认了配置，同时用配置文件中spring.rabbitmq的前缀绑定

![image-20210422171459221](https://tobing-markdown.oss-cn-shenzhen.aliyuncs.com/image-20210422171459221.png)

> 图3：RabbitAutoConfiguration还注入了常用的Bean

![image-20210422171532919](https://tobing-markdown.oss-cn-shenzhen.aliyuncs.com/image-20210422171532919.png)

### 测试

```java
@Slf4j
@SpringBootTest
class PlatformOrderApplicationTests {

    /**
     * 测试AmqpAdmin
     */
    @Autowired
    private AmqpAdmin amqpAdmin;

    // 测试创建Exchange
    @Test
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
    @Test
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
    @Test
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
    @Test
    void testSendMsg() {
        OrderItemEntity orderItemEntity = new OrderItemEntity();
        orderItemEntity.setOrderSn(UUID.randomUUID().toString());
        orderItemEntity.setGiftGrowth(100);
        // 如果发送的是对象，默认情况先会使用JDK的序列化器来序列化，这时就需要将该类实现Serializable接口
        // 但一般情况下也可以注入一个json转换器来替换原生的转换器以json方式转换进而实现序列化【推荐使用】
        // 往交换器(hello-java-exchange)发送消息(orderItemEntity)
        rabbitTemplate.convertAndSend("hello-java-exchange", "", orderItemEntity);
        log.info("发送消息");
    }
}
```

### Rabbitmq消息确认机制

在某些场景中，需要保证消息要可靠的抵到接收方。为了保证消息不丢失，可靠抵达，可以使用事务消息，但是性能会比没有开启事务下降大于250倍。因此引入了确认机制来保证消息的可靠性。

![image-20210422203556100](https://tobing-markdown.oss-cn-shenzhen.aliyuncs.com/image-20210422203556100.png)

在发送方到接收方的过程中，有三个阶段可能出现消息的丢失，分别是：

+ 生产者到服务器阶段：网络等问题

+ 路由器到队列阶段：错误的队列名称等

+ 队列到消费者阶段：网络等问题

RabbitMQ在这三个阶段分别引入了三种确认回调：

+ ConfirmCallback：生产者到服务器的确认回调
+ ReturnCallback：服务器的Exchange到Queue的确认回调
+ ack确认：Queue中的消息被客户端消费的确认回调

#### ConfirmCallback开启【服务端确认】

消息只有在被broker接收到之后就会执行confirmCallback，如果是cluster模式，需要所有broker收到之后才会调用confirmCallback。

confirmCallback的回调只能确认消息被broker接受，不能保证消息在接下来是否会被正确接受。

**SpringBoot中使用前需要开启：**

```properties
# client ==> server
spring.rabbitmq.publisher-confirms=true
```

**同时要为rabbitTemplate进行配置：**

```java
// 自定义确认回调
rabbitTemplate.setConfirmCallback(new RabbitTemplate.ConfirmCallback() {
    /**
     * 消息抵到服务器的确认回调
     * @param correlationData 当前消息的唯一关联数据（消息的唯一id）
     * @param ack   消息是否成功抵到
     * @param cause 失败的原因
     */
    @Override
    public void confirm(CorrelationData correlationData, boolean ack, String cause) {
        log.info("【确认回调】：消息唯一标识：{}, 消息是否确认：{}, 消息失败原因：{}", correlationData.toString(), ack, cause);
    }
});
```

#### ReturnCallback开启【服务端确认】

confirm模式下只能保证消息到达broker，不能保证消息准确投递到目标的queue中。

而ReturnCallback可以感知没有正确投递到queue中的消息，主要就可以记录下错误的信息，按照一定策略纠错。

**SpringBoot中使用前需要开启：**

```properties
# exchange ==> queue
spring.rabbitmq.publisher-returns=true
spring.rabbitmq.template.mandatory=true
```

**同时对rabbitTemplate进行配置：**

```java
// 自定义消息抵达Queue的确认回调
rabbitTemplate.setReturnCallback(new RabbitTemplate.ReturnCallback() {
    /**
     * 消息如果没有投递到指定的队列，就会触发这个失败回调
     * @param message 失败消息的详细信息
     * @param replyCode 回复状态码
     * @param replyText 回复文本内容
     * @param exchange 消息所在交换机
     * @param routingKey 消息发送的routeKey
     */
    @Override
    public void returnedMessage(Message message, int replyCode, String replyText, String exchange, String routingKey) {
        log.info("【队列失败投递】失败消息的详细信息：{}，回复状态码：{}， 回复文本内容：{}， 消息所在交换机：{}， 消息发送的routeKey：{}",
                message.toString(), replyCode, replyText, exchange, routingKey);
    }
});
```

#### ACK确认开启【消费端确认】

ReturnCallback能够确认客户端发送的消息成功到达Queue，但是Queue的消息是否正常被消费者消费，则需要「ACK消息确认机制」来实现。

与前两个确认机制不同，ACK确认是在消费端的确认。默认情况下，消费端是自动确认，只要消费端接收到，客户端户为自动确认，服务器会移除这个消息。

在默认情况下，ACK确认机制会存在一个问题，即：消费端一下子接收到很多的消息，自动将这些消息ack。但在处理消息的过程中，只要部分消息处理成功，然后发送宕机，这时就会发送消息丢失。

为了解决上面的问题，需要将ACK确认机制设置为「手动确认模式」。即只要客户端明确对某个消息进行了确认，才能够回复ACK。如果客户端没有明确ACK，则消息一直处于unacked状态，这是即使消费端发生宕机，消息不会丢失，而是变回Ready状态，保存在RabbitMQ中。

**SpringBoot开启ACK的手动确认：**

```properties
# queue ==> consumer
spring.rabbitmq.listener.simple.acknowledge-mode=manual
```

**客户端消费消息的时候要对消息进行确认：**

```java
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
```

当我们采用了对每个消息确认的方式，这样如果发生了宕机，可以实现让为实际消费的消息仍然会从unacked变回到Ready状态。可以在服务重启的时候，再次消费，当然我们也有可能在执行完逻辑之后再执行确认，这时发送宕机可能会导致重复消费的问题，这时就可以采用不投递会服务器来保证不重复消费。

**Channel主要还有以下几个方法可以用来对消息进行确认/不确认：**

```java
// 用于否定确认，可以指定broker是否丢弃此消息，可以批量
public abstract void basicNack(long deliveryTag,	// 消息标识
                               boolean multiple,	// 是否丢弃	
                               boolean requeue);	// 是否重新回到queue中

// 用于否定确认，可以指定broker是否丢弃此消息，但不可以批量
public abstract void basicReject(long deliveryTag,	// 消息标识
                                 boolean requeue);	// 是否重新回到queue中

// 用于肯定确认，broker将会异常这个消息
public abstract void basicAck(long deliveryTag,
                              boolean multiple);
```

一般情况下，开启手动ack模式：

消息处理成功，basicAck，接受下一条消息，之前的从broker移除；

消息处理失败，basicNack/basicReject，重新发送给其他人处理，或者容错不处理不再投递给别人。



## 2、整合 ElasticSearch

1、引入依赖

```xml
<!--引入elasticsearch-->
<dependency>
    <groupId>org.elasticsearch.client</groupId>
    <artifactId>elasticsearch-rest-high-level-client</artifactId>
</dependency>
```

2、配置文件

```java
public class PlatformElasticSearchConfig {
    public static final RequestOptions COMMON_OPTIONS;
    static {
        RequestOptions.Builder builder = RequestOptions.DEFAULT.toBuilder();
//        builder.addHeader("Authorization", "Bearer " + TOKEN);
//        builder.setHttpAsyncResponseConsumerFactory(
//                new HttpAsyncResponseConsumerFactory
//                        .HeapBufferedResponseConsumerFactory(30 * 1024 * 1024 * 1024));
        COMMON_OPTIONS = builder.build();
    }

    @Bean
    public RestHighLevelClient restHighLevelClient() {
        RestHighLevelClient client = new RestHighLevelClient(
                RestClient.builder(
                        new HttpHost("localhost", 9200, "http")));
        return client;
    }
}
```

3、开启使用

将RestHighLevelClient注入容器即可使用，无需开启使用注解。

## 3、整合 Scheduling

[QuartZ中文文档](https://www.w3cschool.cn/quartz_doc/quartz_doc-1xbu2clr.html)

[QuartZ官方文档](http://www.quartz-scheduler.org/documentation/)

[corn表达式生成](https://cron.qqe2.com/)

```java
/**
 * @Author tobing
 * @Date 2021/5/1 11:37
 * @Description 任务调度延时程序，生产环境下不开启使用
 * 【定时任务】
 * 1、@EnableScheduling 开启定时任务使用
 * 2、@Scheduled 开启一个定时
 * 3、自动配置类：TaskSchedulingAutoConfiguration
 * 【异步任务】
 * 1、@EnableAsync 开启任务的异步执行功能
 * 2、@Async 该任务异步执行
 * 3、自动配置类：TaskExecutionAutoConfiguration
 */
@Slf4j
@Component
@EnableAsync
@EnableScheduling
public class HelloSchedule {

    /**
     * Spring的定时任务cron表达式与Quartz的cron表达式并不完全相同，不同主要如下：
     * 1、Spring中有6位组成，分别是（秒 分 时 日 月 周），不允许第7位的年；
     * 2、在对「周」的表示上，Quartz的1-7表示是一周中的第几天(星期天开始)，Spring的1-7表示的是星期一到星期天；
     * <p>
     * 需要注意的是，Spring定时任务的使用不应该是阻塞的（默认阻塞），下面是几种采用非阻塞的方式：
     * 1、让业务任务以异步方式执行，自己提交到线程池；
     * 2、支持定时任务线程池，配置TaskSchedulingAutoConfiguration设置，设置线程池大小；
     * 3、让定时任务异步执行，开启异步任务；
     */
    @Async
    @Scheduled(cron = "*/5 * * * * *")
    public void hello() {
        log.info("hello");
    }
}
```

## 4、整合 Sentinel

**Sentinel，英 [ˈsentɪnl]   美 [ˈsentɪnl]  ，哨兵。**

1. 引入sentinel starter

   ```xml
   <!--SpringCloud Alibaba Sentinel-->
   <dependency>
       <groupId>com.alibaba.cloud</groupId>
       <artifactId>spring-cloud-alibaba-sentinel</artifactId>
   </dependency>
   ```

   

2. 引入actuator

   ```xml
   <!--actuator-->
   <dependency>
       <groupId>org.springframework.boot</groupId>
       <artifactId>spring-boot-starter-actuator</artifactId>
   </dependency>
   ```

   

3. 下载sentinel控制台

   + [官方仓库](https://github.com/alibaba/Sentinel/wiki/%E4%BB%8B%E7%BB%8D)

   + [官方文档](https://sentinelguard.io/zh-cn/docs/quick-start.html)

4. 配置Sentinel的地址信息

   ```properties
   # sentinel
   spring.cloud.sentinel.transport.port=8719
   spring.cloud.sentinel.transport.dashboard=localhost:8080
   # actuator
   management.endpoints.web.exposure.include=*
   # 允许发现feign的远程调用链路
   feign.sentinel.enabled=true
   ```

   

5. 配置响应信息

   ```java
   /**
    * @Author tobing
    * @Date 2021/5/3 16:36
    * @Description 自定义Sentinel异常处理
    */
   @Component
   public class SentinelExceptionHandler implements BlockExceptionHandler {
       @Override
       public void handle(HttpServletRequest request, HttpServletResponse response, BlockException e) throws Exception {
           R error = R.error(BziCodeEnum.TOO_MANY_REQUEST.getCode(), BziCodeEnum.TOO_MANY_REQUEST.getMsg());
           response.setCharacterEncoding("UTF-8");
           response.setContentType("application/json");
           response.getWriter().write(JSON.toJSONString(error));
       }
   }
   ```

   

6. 配置保护feign的远程调用

   1. 调用方的熔断保护：开启`feign.sentinel.enable=true`
   2. 调用方手动指定远程服务的降级策略。远程服务被降级处理。触发我们的熔断回调方法
   3. 超大流量的时候，需要牺牲一些远程服务。在服务的提供方（远程服务）指定降级策略。

7. 为feign指定异常返回

   https://github.com/alibaba/spring-cloud-alibaba/wiki/Sentinel#feign-%E6%94%AF%E6%8C%81

   ```java
   ////////////////////////////////////为feign接口指定fallback处理类////////////////////////////////////
   @FeignClient(value = "platform-coupon", fallback = CouponFeignServiceFallback.class)
   public interface CouponFeignService {
   
       /**
        * 保存积分信息
        */
       @PostMapping("coupon/spubounds/save")
       R saveSpuBounds(@RequestBody SpuBoundsTo spuBoundsTo);
   
       /**
        * 保存满减、优惠信息
        */
       @PostMapping("coupon/skufullreduction/save/full")
       R saveSkuFullReduction(@RequestBody SkuFullReductionTo skuFullReductionTo);
   }
   
   ////////////////////////////////////实现feign接口指定熔断响应////////////////////////////////////
   @Slf4j
   public class CouponFeignServiceFallback implements CouponFeignService {
       @Override
       public R saveSpuBounds(SpuBoundsTo spuBoundsTo) {
           log.error("远程服务调用异常，现进行熔断处理!!!");
           return R.error(BziCodeEnum.TOO_MANY_REQUEST.getCode(), BziCodeEnum.TOO_MANY_REQUEST.getMsg());
       }
   
       @Override
       public R saveSkuFullReduction(SkuFullReductionTo skuFullReductionTo) {
           log.error("远程服务调用异常，现进行熔断处理!!!");
           return R.error(BziCodeEnum.TOO_MANY_REQUEST.getCode(), BziCodeEnum.TOO_MANY_REQUEST.getMsg());
       }
   }
   ```

   














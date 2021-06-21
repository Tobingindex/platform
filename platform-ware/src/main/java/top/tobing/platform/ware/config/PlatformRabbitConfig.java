package top.tobing.platform.ware.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.core.Message;
import org.springframework.amqp.rabbit.connection.CorrelationData;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.amqp.support.converter.Jackson2JsonMessageConverter;
import org.springframework.amqp.support.converter.MessageConverter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.annotation.PostConstruct;

/**
 * @Author tobing
 * @Date 2021/4/22 18:10
 * @Description Rabbit相关配置类
 */
@Slf4j
@Configuration
public class PlatformRabbitConfig {

    @Autowired
    private RabbitTemplate rabbitTemplate;

    /**
     * 使用Jackson转换器替换原生的转换器
     */
    @Bean
    public MessageConverter messageConverter() {
        return new Jackson2JsonMessageConverter();
    }


//    @PostConstruct
//    public void initRabbitTemplate() {
//
//        // 自定义确认回调
//        // 【注意】：在Spring2.x之后将该配置设置为废弃的，因此在这里也无效果
//        rabbitTemplate.setConfirmCallback(new RabbitTemplate.ConfirmCallback() {
//            /**
//             * 消息抵到服务器的确认回调
//             * @param correlationData 当前消息的唯一关联数据（消息的唯一id）
//             * @param ack   消息是否成功抵到
//             * @param cause 失败的原因
//             */
//            @Override
//            public void confirm(CorrelationData correlationData, boolean ack, String cause) {
//                log.info("【确认回调】：消息唯一标识：{}, 消息是否确认：{}, 消息失败原因：{}", correlationData.toString(), ack, cause);
//            }
//        });
//
//        // 自定义消息抵达Queue的确认回调
//        rabbitTemplate.setReturnCallback(new RabbitTemplate.ReturnCallback() {
//            /**
//             * 消息如果没有投递到指定的队列，就会触发这个失败回调
//             * @param message 失败消息的详细信息
//             * @param replyCode 回复状态码
//             * @param replyText 回复文本内容
//             * @param exchange 消息所在交换机
//             * @param routingKey 消息发送的routeKey
//             */
//            @Override
//            public void returnedMessage(Message message, int replyCode, String replyText, String exchange, String routingKey) {
//                log.info("【队列失败投递】失败消息的详细信息：{}，回复状态码：{}， 回复文本内容：{}， 消息所在交换机：{}， 消息发送的routeKey：{}",
//                        message.toString(), replyCode, replyText, exchange, routingKey);
//            }
//        });
//    }
}

package top.tobing.platform.order.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import top.tobing.platform.order.entity.OrderEntity;
import top.tobing.platform.order.entity.OrderItemEntity;

import java.util.UUID;

/**
 * @Author tobing
 * @Date 2021/4/22 18:33
 * @Description
 */
@Slf4j
@RestController
public class MsgController {

    @Autowired
    private RabbitTemplate rabbitTemplate;

    @GetMapping("/sendMsg")
    public String sendMsg() {
        for (int i = 0; i < 10; i++) {
            if (i % 2 == 0) {
                OrderItemEntity orderItemEntity = new OrderItemEntity();
                orderItemEntity.setOrderSn(UUID.randomUUID().toString());
                orderItemEntity.setGiftGrowth(100);
                rabbitTemplate.convertAndSend("hello-java-exchange", "", orderItemEntity);
                log.info("发送消息:orderItemEntity");
            } else {
                OrderEntity orderEntity = new OrderEntity();
                orderEntity.setOrderSn(UUID.randomUUID().toString());
                rabbitTemplate.convertAndSend("hello-java-exchange", "", orderEntity);
                log.info("发送消息:orderEntity");
            }
        }
        return "ok";
    }
}

package top.tobing.platform.order.web;

import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import top.tobing.platform.order.entity.OrderEntity;

import java.util.UUID;

/**
 * @Author tobing
 * @Date 2021/4/23 8:51
 * @Description
 */
@Controller
public class IndexController {

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

    @GetMapping("confirm.html")
    public String confirmPage() {
        return "confirm";
    }

    @GetMapping("detail.html")
    public String detailPage() {
        return "detail";
    }



    @GetMapping("pay.html")
    public String payPage() {
        return "pay";
    }


}

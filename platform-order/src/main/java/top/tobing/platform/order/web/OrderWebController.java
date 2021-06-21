package top.tobing.platform.order.web;

import com.alipay.api.AlipayApiException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import top.tobing.platform.order.config.AlipayTemplate;
import top.tobing.platform.order.exception.NoStockException;
import top.tobing.platform.order.service.OrderService;
import top.tobing.platform.order.vo.*;

import java.util.List;
import java.util.concurrent.ExecutionException;

/**
 * @Author tobing
 * @Date 2021/4/23 20:38
 * @Description Order Controller
 */
@Controller
public class OrderWebController {

    @Autowired
    private OrderService orderService;
    @Autowired
    private AlipayTemplate alipayTemplate;

    // 去支付
    @GetMapping("/toTrade")
    public String toTrade(Model model) throws ExecutionException, InterruptedException {
        OrderConfirmVo orderConfirmVo = orderService.toTrade();
        model.addAttribute("orderConfirm", orderConfirmVo);
        return "confirm";
    }

    // 提交订单
    @PostMapping("/submitOrder")
    public String submitOrder(OrderSubmitVo orderSubmitVo, Model model, RedirectAttributes redirectAttributes) {
        OrderSubmitRespVo respVo = null;
        try {
            respVo = orderService.submitOrder(orderSubmitVo);
        } catch (NoStockException e) {
            respVo = new OrderSubmitRespVo();
            respVo.setCode(3);
        }
        if (respVo.getCode() == 0) {
            // 提交成功，跳转到支付页
            model.addAttribute("respVo", respVo);
            return "pay";
        } else {
            String msg = "";
            if (respVo.getCode() == 1) {
                msg = "令牌验证失败";
            } else if (respVo.getCode() == 2) {
                msg = "验价失败";
            } else if (respVo.getCode() == 3) {
                msg = "库存锁定失败！";
            }
            redirectAttributes.addFlashAttribute("msg", msg);
            // 提交失败，直接重新跳转到表达确认页
            return "redirect:http://order.platform.com/toTrade";
        }
    }

    @ResponseBody
    @GetMapping(value = "/payOrder", produces = "text/html")
    public String payOrder(@RequestParam("orderSn") String orderSn) throws AlipayApiException {
        System.out.println("订单号：" + orderSn);
        // 封装支付需要的数据
        PayVo payVo = orderService.getOrderPay(orderSn);
        String pay = alipayTemplate.pay(payVo);
        // System.out.println(pay);
        return pay;
    }

    @GetMapping("list.html")
    public String listPage(Model model) {
        List<OrderRespVo> respVoList = orderService.getOrderDetailList();
        model.addAttribute("orderList", respVoList);
        return "list";
    }

}

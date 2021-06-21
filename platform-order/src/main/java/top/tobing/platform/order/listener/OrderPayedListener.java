package top.tobing.platform.order.listener;

import com.alipay.api.AlipayApiException;
import com.alipay.api.internal.util.AlipaySignature;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import top.tobing.platform.order.config.AlipayTemplate;
import top.tobing.platform.order.service.OrderService;
import top.tobing.platform.order.vo.PayAsyncVo;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * @Author tobing
 * @Date 2021/5/1 9:09
 * @Description 监听订单支付
 */
@Slf4j
@RestController
public class OrderPayedListener {

    @Autowired
    private AlipayTemplate alipayTemplate;
    @Autowired
    private OrderService orderService;


    /**
     * 订单支付成功异步回调函数
     */
    @PostMapping("/payed/notify")
    public String payedNotify(PayAsyncVo payVo, HttpServletRequest request) throws AlipayApiException {
        log.info("订单支付成功，执行回调函数！！");
        if (verifySignature(request)) {
            return orderService.updateOrderStatusByAlipay(payVo);
        }
        return "error";
    }

    /**
     * 验证异步回调请求签名信息
     * https://opendocs.alipay.com/open/54/106370#JAVA%20%E6%9C%8D%E5%8A%A1%E7%AB%AF%E9%AA%8C%E8%AF%81%E5%BC%82%E6%AD%A5%E9%80%9A%E7%9F%A5%E4%BF%A1%E6%81%AF%E5%8F%82%E6%95%B0%E7%A4%BA%E4%BE%8B
     */
    private boolean verifySignature(HttpServletRequest request) throws AlipayApiException {
        //获取支付宝POST过来反馈信息 
        Map<String, String> params = new HashMap<String, String>();
        Map requestParams = request.getParameterMap();
        for (Iterator iter = requestParams.keySet().iterator(); iter.hasNext(); ) {
            String name = (String) iter.next();
            String[] values = (String[]) requestParams.get(name);
            String valueStr = "";
            for (int i = 0; i < values.length; i++) {
                valueStr = (i == values.length - 1) ? valueStr + values[i]
                        : valueStr + values[i] + ",";
            }
            //乱码解决，这段代码在出现乱码时使用。 
            //valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8"); 
            params.put(name, valueStr);
        }
        //切记alipaypublickey是支付宝的公钥，请去open.alipay.com对应应用下查看。 
        //boolean AlipaySignature.rsaCheckV1(Map<String, String> params, String publicKey, String charset, String sign_type) 
        return AlipaySignature.rsaCheckV1(params, alipayTemplate.getAlipay_public_key(), alipayTemplate.getCharset(), "RSA2");
    }


}

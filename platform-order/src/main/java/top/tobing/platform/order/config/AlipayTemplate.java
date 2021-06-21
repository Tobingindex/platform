package top.tobing.platform.order.config;

import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.request.AlipayTradePagePayRequest;
import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;
import top.tobing.platform.order.vo.PayVo;

/**
 * @Author tobing
 * @Date 2021/4/30 11:24
 * @Description 支付宝支付测试工具
 */

@ConfigurationProperties(prefix = "alipay")
@Component
@Data
public class AlipayTemplate {

    //在支付宝创建的应用的id
    private String app_id = "2016092200568607";

    // 商户私钥，您的PKCS8格式RSA2私钥
    private String merchant_private_key = "MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCqL21yAGpTm1vMgkrPMko7uccZHsivESzfWTbJaJpQbg//01oDgFnyDb5Esv33DsDS90JAVarrexQncOLl5UKg/zLUPVWbJtNsWWQYjp/J/0lhpN617M/8KNAh0fKTvaoeJ3mB85ltir6jiyUKski+0WvDuoDMl3w5ghQlxqwGFhwCeJ2LTFuahKeKplwvfhVIsIHlVFUQjH07BJeTSyC8TfTpvVEx/0lD1TZsGO0EnBJREiQsMt22lCKKHCmwB+mfCGZfJJ1rs7z90KdBde48ytvcakojwyAK7rGCKNs6/0A66OQqr/ggooo0cgqQd7OemndN9d4mvpZvWA3VViKPAgMBAAECggEANZRS97ZLw2DBKQTIOq1Rk7YsiasYcY2NvA+hYQ2ur63HGbrXtwx8xOkwwv47WMHrUUAJOqn98r9AHB69QLXKIVfXD9zzi7JQk+cczWJxyi22U6iNeWdCH9hVlqA7p+npmi7BYXlpD4TD+kc/dTumDXVvYSLhlAgJUy2x3CbNV+iwj2A9l3kCWQepPulqvSQKIctYxa/4+Vj+Mfbkv6RskfESRRuyvS2kx4PISDFC0IG7RBe4TUSZxQq7zFmwjdr/qKN2h8ka7RqvikJcdCsbXD/a/A4LZWQCOy290WKYsVjXBwx6PvHPeVo/u9w0WB/VbMdsadK6+Ihg+0ZNGwt3cQKBgQDXj2dEPTny973wll+N0oxicvKp6Xd8fcopnQ1RqnfWBOytsbeSPlOeYbtGk7tjiMPGqe/Bd37lqfPyK81K2yUV9CQ4ZGR8EijFCawb3REB67AE6nobGXev/X7vd+n4OLNJ0IClSDNJ9OzavaDYHeP8LIlCBITHu/pE/WPLPrIqtwKBgQDKHNO43p874desCoPBUOlrZUz0eHjyUIEk8Pg+kfJ+XQjPu/ZQJ/ZvOhZEUH+lB+d8IWI6iybybukCaSI0jy/06UYVZcSgE09Uv6YOOH1+1I6+7PZoGJU3XHWD1zJkQbED9BKLceoxyRM167g39vkjt3A4jzGgcfJEuDNomaLO6QKBgFoSsSsBjoppXTQAEdOYTFMDB0VaqjQZ9/TljGA4pDSJAEEgRr3UT2qaGgBG0QGpb20/K1EjVqIvHyFtji4eXmPLDauGv7pceC7FeOZ3vJiZ3IZhWD6kqK+gdH8qE1lGkBxjBK6L+eqIbsSEgoZsDw0bqwssCjPP56cWXrHZ8+cHAoGBAJpjdt/LPvuxQtxqk8bCFewxz50Xwdvn3x7m69pwBjq8upRk0nzcagUA7C13CGp6JTvPDIgH79JVIqzyvmxDzLBa2WxS9uYImhr04tYOFN8jY3845+kQjjth52q0oguvmpaYhOn8NJefL4uK6oflot7Dq3eo+pHDOPuBcdO/OHyxAoGBAKV3WEOqqaK3NE72hT6DHdLjVD/bXny13onYdn8q3J8O4BnvvjsGC1lPWomWMYiv/RN99DOZ9pZv8DmBHjA00KA6C0lHj7vYxmKFwmcWfktXIM9MXjxyum7BdaKYT7qdAwPETsgQZ1vXb3wFVcMApAopaT8gw5OZ7gOfY2aCyaHq";
    // 支付宝公钥,查看地址：https://openhome.alipay.com/platform/keyManage.htm 对应APPID下的支付宝公钥。
    private String alipay_public_key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0GI1oQtHuLvvhVMse1HAe/GzA8djc06u8+sBmDjYL4vR1kVtkSzxdTZ2fAbFPw7y8FlvDCraI6LIni8h84BE/D24y3IbUPDfzR2kXg5P9nyjHmsldyqzv86uCAbW2b501qtw2Xj9Xx/tphuDjcCmd6BBjVSiS1U1htJK3Mmkdvuj+9c/XgzBSfrQ6PHnLCS6sacBeZDHTh3HxGKRHIKvxVfITYFO9BeZYuF+g5fR0afPebuxJeIQWk2ny2u35oeIx7T7o+LOs9hummwDJ6oMA5BJZ0OqbwhOGfnOznEIfyzBzCgDtcmR223cl2U9oJoy1ccqvnAeED7YeCYQKvfz5wIDAQAB";
    // 服务器[异步通知]页面路径  需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
    // 支付宝会悄悄的给我们发送一个请求，告诉我们支付成功的信息
    private String notify_url;

    // 页面跳转同步通知页面路径 需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
    //同步通知，支付成功，一般跳转到成功页
    private String return_url;

    // 签名方式
    private String sign_type = "RSA2";

    // 字符编码格式
    private String charset = "utf-8";

    // 支付宝网关； https://openapi.alipaydev.com/gateway.do
    private String gatewayUrl = "https://openapi.alipaydev.com/gateway.do";

    public String pay(PayVo vo) throws AlipayApiException {

        //AlipayClient alipayClient = new DefaultAlipayClient(AlipayTemplate.gatewayUrl, AlipayTemplate.app_id, AlipayTemplate.merchant_private_key, "json", AlipayTemplate.charset, AlipayTemplate.alipay_public_key, AlipayTemplate.sign_type);
        //1、根据支付宝的配置生成一个支付客户端
        AlipayClient alipayClient = new DefaultAlipayClient(gatewayUrl,
                app_id, merchant_private_key, "json",
                charset, alipay_public_key, sign_type);

        //2、创建一个支付请求 //设置请求参数
        AlipayTradePagePayRequest alipayRequest = new AlipayTradePagePayRequest();
        alipayRequest.setReturnUrl(return_url);
        alipayRequest.setNotifyUrl(notify_url);

        //商户订单号，商户网站订单系统中唯一订单号，必填
        String out_trade_no = vo.getOut_trade_no();
        //付款金额，必填
        String total_amount = vo.getTotal_amount();
        //订单名称，必填
        String subject = vo.getSubject();
        //商品描述，可空
        String body = vo.getBody();

        alipayRequest.setBizContent("{\"out_trade_no\":\"" + out_trade_no + "\","
                + "\"total_amount\":\"" + total_amount + "\","
                + "\"subject\":\"" + subject + "\","
                + "\"body\":\"" + body + "\","
                + "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");

        String result = alipayClient.pageExecute(alipayRequest).getBody();

        //会收到支付宝的响应，响应的是一个页面，只要浏览器显示这个页面，就会自动来到支付宝的收银台页面
        System.out.println("支付宝的响应：" + result);

        return result;

    }
}

package top.tobing.platformthirypart.config.impl;

import com.aliyun.dysmsapi20170525.Client;
import org.springframework.boot.context.properties.ConfigurationProperties;

import com.aliyun.dysmsapi20170525.models.*;
import com.aliyun.teaopenapi.models.*;
import org.springframework.stereotype.Component;
import top.tobing.platformthirypart.config.SmsConfig;

/**
 * @Author tobing
 * @Date 2021/4/15 18:14
 * @Description
 */
@Component
@ConfigurationProperties(prefix = "spring.alicloud.sms")
public class AliSmsConfig implements SmsConfig {


    // 访问key
    private String accessKeyId = "LTAI5tEnyAcc4bV4EMWDsswY";
    // 访问密码
    private String accessKeySecret = "hoP5gRCTyI7Hlz9IQRvMxCFoD60QRV";
    // 服务地址
    private String endpoint = "dysmsapi.aliyuncs.com";
    // 短信签名名称
    private String signName;
    // 短信模板ID
    private String templateCode;


    /**
     * @param phoneNumber 电话号码
     * @param code        验证码
     */
    @Override
    public void sendSms(String phoneNumber, String code) throws Exception {
        // 配置初始化：秘钥、服务器host
        Config config = new Config()
                .setAccessKeyId(accessKeyId)
                .setAccessKeySecret(accessKeySecret);
        config.endpoint = endpoint;
        // 配置Client：签名、模板id、电话号码、验证码内容
        Client client = new Client(config);
        SendSmsRequest sendSmsRequest = new SendSmsRequest();
        sendSmsRequest.setSignName(signName);
        sendSmsRequest.setTemplateCode(templateCode);
        sendSmsRequest.setPhoneNumbers(phoneNumber);
        sendSmsRequest.setTemplateParam(code);
        // 发送短信
        client.sendSms(sendSmsRequest);
    }
}
package top.tobing.platformthirypart.config;

/**
 * @Author tobing
 * @Date 2021/4/16 14:03
 * @Description SMS Configuration Interface
 */
public interface SmsConfig {

    /**
     * @param phoneNumber 手机号码
     * @param code        验证码
     */
    public void sendSms(String phoneNumber, String code) throws Exception;
}

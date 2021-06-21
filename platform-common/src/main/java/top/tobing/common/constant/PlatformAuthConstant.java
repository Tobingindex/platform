package top.tobing.common.constant;


/**
 * @Author tobing
 * @Date 2021/4/15 20:04
 * @Description Platform-auth 常量
 * platform-auth 服务相关常量
 */
public class PlatformAuthConstant {
    /**
     * SMS 缓存前缀
     */
    public static final String SMS_CODE_CACHE_PREFIX = "sms:code:";
    /**
     * 登录用户名称
     */
    public static final String LOGIN_USER = "loginUser";
    /**
     * SMS 过期时间
     */
    public static final int SMS_CODE_TIMEOUT = 60000;
    /**
     * 认证服务域名
     */
    public static final String PLATFORM_AUTH_DOMAIN = "http://auth.platform.com";
}

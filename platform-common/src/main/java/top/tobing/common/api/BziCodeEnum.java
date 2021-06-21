package top.tobing.common.api;

/**
 * @Author tobing
 * @Date 2021/4/16 16:05
 * @Description 通用业务状态码
 */
public enum BziCodeEnum {

    /**
     * 统一业务状态码:500XXX
     * 200:请求成功
     * 500000：platform
     * 5001XX：platform_auth
     * 5002XX：platform_coupon
     * 5003XX：platform_gateway
     * 5004XX：platform_member
     * 5005XX：platform_product
     * 5006XX：platform_search
     * 5007XX：platform_thirypart
     * 5008XX：platform_ware
     * 5009XX：platform_cart
     * 5010XX：platform_order
     * 5011XX：platform_seckill
     */

    // 通用错误码
    SUCCESS(200, "success"),
    SERVER_ERROR(500000, "服务端异常"),
    BINDING_ERROR(500001, "参数校验异常：%"),
    TOO_MANY_REQUEST(500002, "请求太频繁，请稍后重试!"),

    // 认证服务 5001XX
    PHONE_EXIST_EXCEPTION(500101, "手机号已经存在!"),
    USERNAME_EXIST_EXCEPTION(500102, "用户名已经存在!"),
    PHONE_ILLEGAL_EXCEPTION(500103, "手机号不合法!"),
    INVALID_ACCOUNT_PASSWORD_EXCEPTION(500104, "账号或密码错误!"),
    AUTH_SMS_FREQUENTLY(500105, "验证码发送太频繁!"),

    // 第三方服务 507XX
    THIRD_PART_ERROR(500700, "第三方服务调用异常!"),
    THIRD_PART_SEND_SMS_ERROR(500701, "第三方服务验证码发送错误！");


    private Integer code;
    private String msg;


    BziCodeEnum(Integer code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public Integer getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }

    @Override
    public String toString() {
        return "BziCodeEnum{" +
                "code=" + code +
                ", msg='" + msg + '\'' +
                '}';
    }
}

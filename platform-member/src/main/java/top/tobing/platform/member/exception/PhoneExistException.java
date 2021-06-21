package top.tobing.platform.member.exception;

/**
 * @Author tobing
 * @Date 2021/4/16 15:49
 * @Description
 */
public class PhoneExistException extends RuntimeException{
    public PhoneExistException() {
        super("注册的手机号已经存在！");
    }
}

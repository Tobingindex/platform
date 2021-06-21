package top.tobing.platform.member.exception;

/**
 * @Author tobing
 * @Date 2021/4/16 15:48
 * @Description
 */
public class UserExistException extends RuntimeException {
    public UserExistException() {
        super("注册的用户名已经存在！");
    }
}

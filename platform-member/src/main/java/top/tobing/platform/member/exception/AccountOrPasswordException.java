package top.tobing.platform.member.exception;

/**
 * @Author tobing
 * @Date 2021/4/16 21:49
 * @Description
 */
public class AccountOrPasswordException extends RuntimeException {
    public AccountOrPasswordException() {
        super("用户号或账号密码错误！");
    }
}

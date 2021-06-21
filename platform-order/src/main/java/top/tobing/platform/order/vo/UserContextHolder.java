package top.tobing.platform.order.vo;

import top.tobing.common.to.MemberRespVo;

/**
 * @Author tobing
 * @Date 2021/6/18 22:37
 * @Description Tool class for saving user information.
 */
public class UserContextHolder {

    private static ThreadLocal<MemberRespVo> memberRespVoContext = new ThreadLocal<>();

    // Set the user information if it not null.
    public static void setCurrentUser(MemberRespVo memberRespVo) {
        // ThreadLocal is thread-local variable, therefore it hasn't concurrent problem.
        // Each thread call the threadLocal.get is get different result.
        if (memberRespVoContext.get() == null) {
            memberRespVoContext.set(memberRespVo);
        }
    }

    // Get current user information.
    public static MemberRespVo getCurrentUser() {
        return memberRespVoContext.get();
    }

    // Remove current user information from ThreadLocal.
    public static void removeCurrentUser() {
        memberRespVoContext.remove();
    }
}

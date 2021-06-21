package top.tobing.platform.order.interceptor;

import org.springframework.util.AntPathMatcher;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import top.tobing.common.constant.PlatformAuthConstant;
import top.tobing.common.to.MemberRespVo;
import top.tobing.platform.order.vo.UserContextHolder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @Author tobing
 * @Date 2021/4/23 21:14
 * @Description
 */
public class LoginUserInterceptor implements HandlerInterceptor {

    public static ThreadLocal<MemberRespVo> threadLocal = new ThreadLocal<>();

    /**
     * 前置处理
     * 对未登录的用户：跳转到登录页
     * 对于登录的用户：取出Session中的用户信息放到ThreadLocal中
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        // 放行查询订单状态的信息
        String uri = request.getRequestURI();
        AntPathMatcher antPathMatcher = new AntPathMatcher();
        boolean matchStatus = antPathMatcher.match("/order/order/status/**", uri);
        boolean matchPayed = antPathMatcher.match("/payed/**", uri);
        if (matchStatus || matchPayed) {
            return true;
        }

        MemberRespVo memberRespVo = (MemberRespVo) request.getSession().getAttribute(PlatformAuthConstant.LOGIN_USER);
        if (memberRespVo == null) {
            // 未登录，跳转到登录页
            response.sendRedirect("http://auth.platform.com/login.html");
            return false;
        } else {
            UserContextHolder.setCurrentUser(memberRespVo);
            threadLocal.set(memberRespVo);
            return true;
        }
    }

    /**
     * 后置处理，释放ThreadLocal中的对象
     */
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        // threadLocal.remove();
    }


    /**
     * Remove ther user infomation in ThreadLocal when complete of request processing and view rendering.
     * Why not in postHandle ?
     * https://stackoverflow.com/questions/37358426/remove-threadlocal-object-within-a-spring-mvc-website
     * The postHandle method looks like a good place, but afterCompletion is better because it's called
     * even when the handler fails to process the request correctly (aka an exception occurred).
     */
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        UserContextHolder.removeCurrentUser();
        threadLocal.remove();
    }
}

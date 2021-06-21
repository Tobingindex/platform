package top.tobing.platform.seckill.interceptor;

import org.springframework.util.AntPathMatcher;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import top.tobing.common.constant.PlatformAuthConstant;
import top.tobing.common.to.MemberRespVo;

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

        // 对秒杀接口进行登录校验
        String uri = request.getRequestURI();
        AntPathMatcher antPathMatcher = new AntPathMatcher();
        boolean match = antPathMatcher.match("/kill", uri);
        if (match) {
            MemberRespVo memberRespVo = (MemberRespVo) request.getSession().getAttribute(PlatformAuthConstant.LOGIN_USER);
            if (memberRespVo == null) {
                response.sendRedirect("http://auth.platform.com/login.html");
                return false;
            } else {
                threadLocal.set(memberRespVo);
                return true;
            }
        }
        return true;
    }

    /**
     * 后置处理，释放ThreadLocal中的对象
     */
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        threadLocal.remove();
    }
}

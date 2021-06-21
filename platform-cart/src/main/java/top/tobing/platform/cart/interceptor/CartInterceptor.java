package top.tobing.platform.cart.interceptor;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import top.tobing.common.constant.PlatformAuthConstant;
import top.tobing.common.constant.PlatformCartConstant;
import top.tobing.common.constant.PlatformConstant;
import top.tobing.common.to.MemberRespVo;
import top.tobing.platform.cart.vo.UserInfoTo;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.UUID;

/**
 * @Author tobing
 * @Date 2021/4/19 17:22
 * @Description 购物车拦截器
 * 用来拦截每个访问购物车接口的请求，确保每个请求都具有用户信息 {@link top.tobing.platform.cart.vo.UserInfoTo}
 */
@Slf4j
@Component
public class CartInterceptor implements HandlerInterceptor {


    /**
     * 通过ThreadLocal来保存一个请求内的用户信息
     */
    public static final ThreadLocal<UserInfoTo> threadLocal = new ThreadLocal<>();

    /**
     * 前置处理：为访问购物车接口的请求添加用户信息
     * 1、对于没有登录的用户，创建临时用户；
     * 2、对于已经添加的用户，获取userId并创建用户标识(userKey)
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 用户信息
        UserInfoTo userInfoTo = new UserInfoTo();
        // 通过Session获取用户的登录信息
        HttpSession session = request.getSession();
        MemberRespVo memberRespVo = (MemberRespVo) session.getAttribute(PlatformAuthConstant.LOGIN_USER);
        // 判断用户是否已经登录
        if (memberRespVo != null) {
            userInfoTo.setUserId(memberRespVo.getId());
            log.info("{}，成功登录！", memberRespVo.getId());
        }
        // 遍历Cookies获取用户身份标识（userKey）
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) { // 判断是否携带用户身份标识user-key，如果有添加上
                if (PlatformCartConstant.TEMP_USER_COOKIE_NAME.equals(cookie.getName())) {
                    userInfoTo.setUserKey(cookie.getValue());
                }
            }
        }
        // 对于即没有user-key又没有userId的用户，即时第一次访问的用户，创建临时身份标识
        if (StringUtils.isEmpty(userInfoTo.getUserId()) && StringUtils.isEmpty(userInfoTo.getUserKey())) {
            String uuid = UUID.randomUUID().toString();
            userInfoTo.setIsTemp(true);
            userInfoTo.setUserKey(uuid);
        }
        // 将用户信息放到线程中
        threadLocal.set(userInfoTo);
        return true;
    }

    /**
     * 后置处理：添加用户身份标识Cookie：user-key
     */
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        UserInfoTo userInfoTo = threadLocal.get();
        // 对于临时用户持续延长Cookie过期时间
        if (userInfoTo.getIsTemp()) {
            Cookie cookie = new Cookie(PlatformCartConstant.TEMP_USER_COOKIE_NAME, userInfoTo.getUserKey());
            cookie.setDomain(PlatformConstant.PLATFORM_DOMAIN);
            cookie.setMaxAge(PlatformCartConstant.TEMP_USER_COOKIE_TIMEOUT); // 设置过期时间为一个月
            response.addCookie(cookie);
        }
        // 手动释放数据
        threadLocal.remove();
    }
}

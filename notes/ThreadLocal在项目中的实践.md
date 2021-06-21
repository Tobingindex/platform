# ThreadLocal在项目中的实践

ThreadLocal，线程内部变量。

当使用ThreadLocal维护变量时，ThreadLocal为每个使用该变量的线程提供独立的变量副本，所以每一个线程都可以独立地改变自己的副本，而不会影响其它线程所对应的副本。从线程的角度看，目标变量就像是线程的本地变量，这也是类名中“Local”所要表达的意思。

## 业务需求

对于Platform平台的购物车服务，要实现**临时购物车**和**登录购物车**的功能。

**对于临时购物车**，是为了方便未登录的用户可以快捷添加商品到购物车。临时用户可以在不登录的情况下将商品添加到购物车中，即时关闭浏览器，在下次访问的时候依旧可以查看到之前添加的内容。

对于登录购物车，就是在登录的用户的购物车，可以直接通过用户信息查询。

因此这个功能实现的关键就是要保存的临时用户的信息，这边采用的方案就是：**在服务端的Redis中保存购物车的数据库，在客户端浏览器Cookie保存临时身份标识user-key来关联服务端的信息。**

为了方便实现这一功能，我们考虑定义一个拦截器，对于每个访问购物车访问的请求进行拦截。

**在前置处理中**，先通过SpringSession获取用户登录信息，在通过request获取Cookie中的user-key，将信息保存起来。

对于没有登录的用户，无法获取用户信息，而且如果是第一次登录页不会携带user-key，这是就需要生成一个user-key作为用户标识。

当以上流程执行之后，会将用户信息封装到一个对象中，并将其保存在ThreadLocal中，这样本次请求的所有执行都可以这些数据。

**在后置处理中**，对于未登录的用户，对其用户标识user-key自动续期。并且将用户信息从ThreadLocal中移除。

## 代码实现

> DIY Interceptor

```java
package top.tobing.platform.cart.interceptor;

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
@Component
public class CartInterceptor implements HandlerInterceptor {


    /**
     * 通过ThreadLocal来保存一个请求内的用户信息
     */
    ThreadLocal<UserInfoTo> threadLocal = new ThreadLocal<>();

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
        MemberRespVo memberRespVo = (MemberRespVo) session.getAttribute(AuthConstant.LOGIN_USER);
        // 判断用户是否已经登录
        if (memberRespVo != null) {
            userInfoTo.setUserId(memberRespVo.getId());
        }
        // 遍历Cookies获取用户身份标识（userKey）
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) { // 判断是否携带用户身份标识user-key，如果有添加上
                if (CartConstant.TEMP_USER_COOKIE_NAME.equals(cookie.getName())) {
                    userInfoTo.setUserKey(cookie.getValue());
                }
            }
        }
        // 对于即没有user-key又没有userId的用户，即时第一次访问的用户，创建临时身份标识
        if (StringUtils.isEmpty(userInfoTo.getUserId()) && StringUtils.isEmpty(userInfoTo.getUserId())) {
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
            Cookie cookie = new Cookie(CartConstant.TEMP_USER_COOKIE_NAME, userInfoTo.getUserKey());
            cookie.setDomain(PlatformConstant.PLATFORM_DOMAIN);
            cookie.setMaxAge(CartConstant.TEMP_USER_COOKIE_TIMEOUT); // 设置过期时间为一个月
            response.addCookie(cookie);
        }
        // 手动释放数据
        threadLocal.remove();
    }
}
```

> Controller中通过ThreadLocal获取用户数据

```java
@Controller
public class CartController {

    @GetMapping("/success.html")
    public String success() {
        // 通过ThreadLocal获取线程内变量
        UserInfoTo userInfoTo = CartInterceptor.threadLocal.get();
        System.out.println(userInfoTo);
        return "success";
    }
}
```

> 访问接口的输出

```bash
UserInfoTo(userId=null, userKey=4dda098a-b742-47d0-9d0d-ef5714f3e629, isTemp=true)
```






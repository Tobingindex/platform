package top.tobing.platform.order.config;

import feign.RequestInterceptor;
import feign.RequestTemplate;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;

/**
 * @Author tobing
 * @Date 2021/4/23 22:07
 * @Description 自定义Feign的请求拦截器
 * 【问题来源】
 * 默认情况下，使用OpenFeign只是简单地将URL封装为一个请求（headers为null），接着就通过这个请求调用给定的接口。
 * 试想以下这种场景，如果需要调用的接口要携带上Cookie等一些数据，这时候该如果使用OpenFeign调用呢？
 * 【解决办法】
 * OpenFeign支持从当前Spring容器取出一个RequestInterceptor，每个OpenFeign调用都会经过该拦截器。
 * 可以考虑将RequestInterceptor注入Spring容器中，实现在每次请求激光管拦截器的时候将为每个请求添加上请求头。
 * 如下
 */
@Configuration
public class FeignConfig {
    @Bean
    public RequestInterceptor requestInterceptor() {
        return new RequestInterceptor() {
            @Override
            public void apply(RequestTemplate template) {
                // 1、获取到进入该请求的上下文保持器
                ServletRequestAttributes requestAttributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
                if (requestAttributes != null) {
                    // 2、从中获取Request对象
                    HttpServletRequest request = requestAttributes.getRequest();
                    // 3、从请求头中获取Cookie
                    String cookies = request.getHeader("Cookie");
                    // 4、将Cookie放到Feign的远程调用的请求中
                    template.header("Cookie", cookies);
                }
            }
        };
    }
}

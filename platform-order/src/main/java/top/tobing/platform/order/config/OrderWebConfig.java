package top.tobing.platform.order.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import top.tobing.platform.order.interceptor.LoginUserInterceptor;

/**
 * @Author tobing
 * @Date 2021/4/23 21:23
 * @Description
 */
@Configuration
public class OrderWebConfig implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new LoginUserInterceptor());
    }
}

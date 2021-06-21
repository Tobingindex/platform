package top.tobing.platform.cart.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import top.tobing.platform.cart.interceptor.CartInterceptor;

/**
 * @Author tobing
 * @Date 2021/4/19 17:58
 * @Description
 */
@Configuration
public class CartConfig implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new CartInterceptor());
    }
}

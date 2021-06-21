package top.tobing.platform.seckill.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import top.tobing.platform.seckill.interceptor.LoginUserInterceptor;

/**
 * @Author tobing
 * @Date 2021/5/2 22:12
 * @Description
 */
@Configuration
public class SeckillWebConfig implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new LoginUserInterceptor());
    }
}

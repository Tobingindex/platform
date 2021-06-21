package top.tobing.platform.auth.conf;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * @Author tobing
 * @Date 2021/4/15 16:48
 * @Description
 */
@Configuration
public class AuthWebMvcConfig implements WebMvcConfigurer {

    /**
     * This is useful in cases where there is no need for custom controller logic
     * -- e.g.
     * render a home page, perform simple site URL redirects, return a 404 status
     * with HTML content, a 204 with no content, and more.
     * 【总结】就是避免在Controller写太多路径跳转的空方法
     */
    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
//        registry.addViewController("/login1.html").setViewName("login1");
//        registry.addViewController("/register1.html").setViewName("register1");
        registry.addViewController("/register.html").setViewName("register");
    }
}

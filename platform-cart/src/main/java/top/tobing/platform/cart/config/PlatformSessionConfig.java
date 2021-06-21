package top.tobing.platform.cart.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.serializer.GenericJackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.RedisSerializer;
import org.springframework.session.web.http.CookieSerializer;
import org.springframework.session.web.http.DefaultCookieSerializer;
import top.tobing.common.constant.PlatformConstant;

/**
 * @Author tobing
 * @Date 2021/4/17 19:04
 * @Description
 */
@Configuration
public class PlatformSessionConfig {

    // 设置Session在Redis场景下的序列话方式为json
    @Bean
    public RedisSerializer<Object> springSessionDefaultRedisSerializer() {
        return new GenericJackson2JsonRedisSerializer();
    }

    @Bean
    public CookieSerializer cookieSerializer() {
        DefaultCookieSerializer serializer = new DefaultCookieSerializer();
        // 设置Cookie名称
        serializer.setCookieName("PLATFORM_SESSION");
        // 设置Cookie的作用域名
        serializer.setDomainName(PlatformConstant.PLATFORM_DOMAIN);
        return serializer;
    }
}

package top.tobing.platform.seckill.config;

import org.redisson.Redisson;
import org.redisson.api.RedissonClient;
import org.redisson.config.Config;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * @Author tobing
 * @Date 2021/4/10 22:13
 * @Description
 */
@Configuration
public class RedissonConfig {


    /**
     * 给容器中注入RedissonClient
     */
    @Bean
    public RedissonClient redissonClient() {
        // 设置单节点配置
        Config config = new Config();
        config.useSingleServer().setAddress("redis://127.0.0.1:6379");
        // 根据配置文件创建RedissonClient
        return Redisson.create(config);
    }

}

package top.tobing.platform.product.config;

import org.springframework.boot.autoconfigure.cache.CacheProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.cache.RedisCacheConfiguration;
import org.springframework.data.redis.serializer.GenericJackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.RedisSerializationContext;
import org.springframework.data.redis.serializer.StringRedisSerializer;

/**
 * @Author tobing
 * @Date 2021/4/11 12:01
 * @Description 缓存配置类
 * 【缓存常用注解】
 * @Cacheable: Triggers cache population.触发将数据保存到缓存中
 * @CacheEvict: Triggers cache eviction. 触发缓存的失效
 * @CachePut: Updates the cache without interfering with the method execution.
 * @Caching: Regroups multiple cache operations to be applied on a method.
 * @CacheConfig: Shares some common cache-related settings at class-level.
 * 【SpringCache不足】
 * 1、读模式
 *      缓存穿透：查询一个null数据，如果缓存中不做保存，这些请求将全部打到数据库中。解决：缓存空数据
 *      缓存击穿：大并发的请求同时查询一个正好过期的数据。解决：加锁，@Cacheable(sync=true)
 *      缓存雪崩：大量的key同时过期，大量并发同时打到数据库中。
 * 2、写模式(缓存与数据库一致性)
 *      读写加锁。
 *      引入Canal、感知到MySQL的更新去更新Redis
 *      读多写多，直接到数据库中查询即可
 * 3、总结
 *      常规数据（读多写少，即时性和一致性要求不高的数据），完全可以使用Spring-Cache
 */
// 允许使用缓存
@EnableCaching
@Configuration
@EnableConfigurationProperties(CacheProperties.class)
public class PlatformCacheConfig {

    /**
     * 将自定义的Redis缓存配置注入到容器中
     *
     * @param cacheProperties 拿到容器中的CacheProperties，获取redis的配置文件信息
     * @return RedisCacheConfiguration
     */
    @Bean
    RedisCacheConfiguration redisCacheConfiguration(CacheProperties cacheProperties) {
        // 从默认配置上进行修改
        RedisCacheConfiguration config = RedisCacheConfiguration.defaultCacheConfig();
        // 修改key的序列化器
        config = config.serializeKeysWith(RedisSerializationContext.SerializationPair.fromSerializer(new StringRedisSerializer()));
        // 修改value的序列化器，默认采用JDK序列化方式，不利于异构系统，改为Json方式
        config = config.serializeValuesWith(RedisSerializationContext.SerializationPair.fromSerializer(new GenericJackson2JsonRedisSerializer()));
        // 通过CacheProperties获取RedisProperties
        CacheProperties.Redis redisProperties = cacheProperties.getRedis();
        // 尝试从配置文件中获取「ttl」
        if (redisProperties.getTimeToLive() != null) {
            config = config.entryTtl(redisProperties.getTimeToLive());
        }
        // 尝试从配置文件中获取「key前缀」
        if (redisProperties.getKeyPrefix() != null) {
            config = config.prefixCacheNameWith(redisProperties.getKeyPrefix());
        }
        // 尝试从配置文件中获取「isCacheNullValues」
        if (!redisProperties.isCacheNullValues()) {
            config = config.disableCachingNullValues();
        }
        // 尝试从配置文件中获取 「isUseKeyPrefix」
        if (!redisProperties.isUseKeyPrefix()) {
            config = config.disableKeyPrefix();
        }
        return config;
    }

}

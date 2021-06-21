package top.tobing.platform.auth;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.session.data.redis.config.annotation.web.http.EnableRedisHttpSession;


/**
 * 【SpringSession的核心原理】
 * 1、使用SpringSession需要添加@EnableRedisHttpSession，这个注解帮我们引入了RedisHttpSessionConfiguration
 * 2、在RedisHttpSessionConfiguration类中，往Spring容器放了：
 *      RedisIndexedSessionRepository（本类中注入）：主要用于对Redis中的session就行增删改查
 *      SessionRepositoryFilter（父类中注入）：实现Filter，作用是过滤器，每个请求都会经过这个类
 * 3、对于SessionRepositoryFilter，在构造函数中会获取容器中的RedisIndexedSessionRepository；
 * 4、在SessionRepositoryFilter的doFilterInternal中，是对每个请求的实现逻辑过滤操作
 *
 * 【Filter补充】
 * Filter能够在一个request到达servlet之前预处理request，也可以在response离开servlet时处理response，可以实现：
 * 1. 在servlet被调用之前截获；
 * 2. 在servlet被调用之前检查servlet request;
 * 3. 根据需要修改request头和request数据；
 * 4. 根据需要修改response头和response数据；
 * 5. 在servlet被调用之后截获.
 */
@EnableRedisHttpSession
@EnableFeignClients
@SpringBootApplication
public class PlatformAuthApplication {

    public static void main(String[] args) {
        SpringApplication.run(PlatformAuthApplication.class, args);
    }

}

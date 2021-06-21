package top.tobing.platform.order.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.concurrent.Executors;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/**
 * @Author tobing
 * @Date 2021/4/15 12:39
 * @Description
 */
@Configuration
public class ThreadPoolConfig {

    @Bean
    public ThreadPoolExecutor threadPoolExecutor() {
        return new ThreadPoolExecutor(20,   // 核心线程数
                100,                    // 最大线程数
                10,                             // 存活时间
                TimeUnit.SECONDS,                           // 单位
                new LinkedBlockingQueue(2000),      // 阻塞队列
                Executors.defaultThreadFactory(),           // 线程工厂
                new ThreadPoolExecutor.AbortPolicy());      // 拒绝策略
    }

}

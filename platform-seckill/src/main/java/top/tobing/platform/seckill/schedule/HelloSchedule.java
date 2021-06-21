package top.tobing.platform.seckill.schedule;

import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**
 * @Author tobing
 * @Date 2021/5/1 11:37
 * @Description 任务调度延时程序，生产环境下不开启使用
 * 【定时任务】
 * 1、@EnableScheduling 开启定时任务使用
 * 2、@Scheduled 开启一个定时
 * 3、自动配置类：TaskSchedulingAutoConfiguration
 * 【异步任务】
 * 1、@EnableAsync 开启任务的异步执行功能
 * 2、@Async 该任务异步执行
 * 3、自动配置类：TaskExecutionAutoConfiguration
 * 【cron表达式生成】
 * https://cron.qqe2.com/
 */
@Slf4j
@Component
@EnableAsync
@EnableScheduling
public class HelloSchedule {

    /**
     * Spring的定时任务cron表达式与Quartz的cron表达式并不完全相同，不同主要如下：
     * 1、Spring中有6位组成，分别是（秒 分 时 日 月 周），不允许第7位的年；
     * 2、在对「周」的表示上，Quartz的1-7表示是一周中的第几天(星期天开始)，Spring的1-7表示的是星期一到星期天；
     * <p>
     * 需要注意的是，Spring定时任务的使用不应该是阻塞的（默认阻塞），下面是几种采用非阻塞的方式：
     * 1、让业务任务以异步方式执行，自己提交到线程池；
     * 2、支持定时任务线程池，配置TaskSchedulingAutoConfiguration设置，设置线程池大小；
     * 3、让定时任务异步执行，开启异步任务；
     */
    //@Async
    //@Scheduled(cron = "*/5 * * * * *")
    public void hello() {
        log.info("hello");
    }
}

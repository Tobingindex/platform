package top.tobing.platform.seckill.schedule;

import lombok.extern.slf4j.Slf4j;
import org.redisson.api.RLock;
import org.redisson.api.RedissonClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import top.tobing.platform.seckill.service.SeckillService;

/**
 * @Author tobing
 * @Date 2021/5/2 9:43
 * @Description 定时调度器
 */
@Slf4j
@Component
@EnableAsync
@EnableScheduling
public class SeckillSchedule {

    @Autowired
    private SeckillService seckillService;
    @Autowired
    private RedissonClient redissonClient;

    private final String UP_LOCK = "seckill:up:lock";

    /**
     * 上架最近3天参与秒杀的商品
     * 测试期间没5秒执行一次
     */
    @Async
    @Scheduled(cron = "*/10 * * * * *")
    public void upRecently3DaySeckill() {
        log.info("上架秒杀商品信息...");
        // 使用分布式锁保证数据不会被重复提交
        RLock lock = redissonClient.getLock(UP_LOCK);
        lock.lock();
        try {
            seckillService.upRecently3DaySeckill();
        } finally {
            lock.unlock();
        }
    }

}

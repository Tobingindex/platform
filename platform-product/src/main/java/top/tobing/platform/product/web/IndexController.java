package top.tobing.platform.product.web;

import org.redisson.api.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import top.tobing.platform.product.entity.BannerEntity;
import top.tobing.platform.product.entity.CategoryEntity;
import top.tobing.platform.product.service.BannerService;
import top.tobing.platform.product.service.CategoryService;
import top.tobing.platform.product.vo.Catalog2Vo;

import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * @Author tobing
 * @Date 2021/4/9 18:28
 * @Description
 */
@Controller
@RequestMapping
public class IndexController {

    public static final String INDEX_CONTROLLER_LOCK = "INDEX_CONTROLLER_LOCK";
    public static final String INDEX_CONTROLLER_READ_WRITE_LOCK = "INDEX_CONTROLLER_READ_WRITE_LOCK";
    public static final String INDEX_CONTROLLER_SEMAPHORE_LOCK = "INDEX_CONTROLLER_READ_WRITE_LOCK";
    public static final String INDEX_CONTROLLER_COUNT_DOWN_LATCH_LOCK = "INDEX_CONTROLLER_COUNT_DOWN_LATCH_LOCK";

    @Autowired
    private CategoryService categoryService;
    @Autowired
    private BannerService bannerService;
    @Autowired
    private RedissonClient redissonClient;
    @Autowired
    private StringRedisTemplate redisTemplate;

    @GetMapping({"/", "/index.html"})
    public String index(Model model) {
        List<CategoryEntity> categoryEntityList = categoryService.getLevel1Categories();
        List<BannerEntity> bannerEntityList = bannerService.listIndexBanner();
        model.addAttribute("categoryList", categoryEntityList);
        model.addAttribute("bannerList", bannerEntityList);
        return "index";
    }

    @ResponseBody
    @GetMapping("/index/catalog.json")
    public Map<String, List<Catalog2Vo>> getCatalogJson() {
        Map<String, List<Catalog2Vo>> categoryJson = categoryService.getCatalogJsonWithRedissonLock();
        return categoryJson;
    }


    @ResponseBody
    @GetMapping("/hello")
    public String hello() {
        /**
         * 【Redisson的特性】
         * 1、Redisson加锁的时候回阻塞在lock()方法。
         * 2、Redisson默认加锁时间是30s，如果业务时间很长，将会自动续期，即如果业务还在执行将会自动更新30s，不用担心因业务时间长，而导致锁被删除。
         * 3、Redisson采用过期时间+看门狗的方式来实现长业务适应，同时也允许在执行过程中出现异常，能够自动超时返回（因为出现异常，则不续期，超时自动返回）
         * 4、需要注意的是，锁的自动续期时间是30/3=10s，即每10秒续期一次。
         * 5、此处之外，我们指定自动接收时间，来创建锁，这时候的锁就不会带有看门狗机制，过期就会失效。
         */
        System.out.println("hello");
        RLock lock = redissonClient.getLock(INDEX_CONTROLLER_LOCK);
        lock.lock();
        try {
            System.out.println("开始执行逻辑");
            Thread.sleep(10000);
            System.out.println("执行逻辑完毕");
        } catch (Exception e) {
        } finally {
            lock.unlock();
        }
        return "hello";
    }

    /**
     * Redisson还支持读写锁，读写锁可以实现「写排他、读共享」，能够保证每次读到最新的数据
     * 先读后读：相当于无锁，并发读
     * 先读后写：读完才能写
     * 先写后读：写完才能读
     * 写写：肯定互斥
     */

    @ResponseBody
    @GetMapping("/write")
    public String write() {
        RReadWriteLock readWriteLock = redissonClient.getReadWriteLock(INDEX_CONTROLLER_READ_WRITE_LOCK);
        RLock rLock = readWriteLock.writeLock();
        rLock.lock();
        String str = "";
        try {
            System.out.println("获取写锁成功");
            Thread.sleep(10000);
            str = UUID.randomUUID().toString();
            redisTemplate.opsForValue().set("rw_str", str);
            System.out.println("写锁执行完毕");
        } catch (Exception e) {

        } finally {
            rLock.unlock();
        }
        return str;
    }

    @ResponseBody
    @GetMapping("/read")
    public String read() {
        RReadWriteLock readWriteLock = redissonClient.getReadWriteLock(INDEX_CONTROLLER_READ_WRITE_LOCK);
        RLock rLock = readWriteLock.readLock();
        rLock.lock();
        String str = "";
        try {
            System.out.println("获取读锁成功");
            Thread.sleep(10000);
            str = UUID.randomUUID().toString();
            redisTemplate.opsForValue().get("rw_str");
            System.out.println("读锁执行完毕");
        } catch (Exception e) {
        } finally {
            rLock.unlock();
        }
        return str;
    }


    @ResponseBody
    @GetMapping("/put")
    public String put() {
        RSemaphore semaphore = redissonClient.getSemaphore(INDEX_CONTROLLER_SEMAPHORE_LOCK);
        semaphore.release();
        return "释放锁成功";
    }

    @ResponseBody
    @GetMapping("/get")
    public String get() {
        RSemaphore semaphore = redissonClient.getSemaphore(INDEX_CONTROLLER_SEMAPHORE_LOCK);
        try {
            semaphore.acquire();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        return "获取锁成功";
    }

    @ResponseBody
    @GetMapping("/finish")
    public String finish() {
        RCountDownLatch countDownLatch = redissonClient.getCountDownLatch(INDEX_CONTROLLER_COUNT_DOWN_LATCH_LOCK);
        countDownLatch.trySetCount(7);
        try {
            countDownLatch.await();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        return "七颗龙珠召唤完毕，出来吧，神龙！";
    }

    @ResponseBody
    @GetMapping("/collect/{id}")
    public String finish(@PathVariable("id") Long id) {
        RCountDownLatch countDownLatch = redissonClient.getCountDownLatch(INDEX_CONTROLLER_COUNT_DOWN_LATCH_LOCK);
        countDownLatch.countDown();
        return id + "星龙珠找到啦！";
    }
}

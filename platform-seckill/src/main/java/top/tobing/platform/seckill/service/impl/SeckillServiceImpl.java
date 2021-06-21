package top.tobing.platform.seckill.service.impl;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.toolkit.IdWorker;
import org.redisson.api.RSemaphore;
import org.redisson.api.RedissonClient;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.BoundHashOperations;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;
import top.tobing.common.to.MemberRespVo;
import top.tobing.common.to.mq.SeckillOrderTo;
import top.tobing.platform.seckill.feign.CouponFeignService;
import top.tobing.platform.seckill.feign.ProductFeignService;
import top.tobing.platform.seckill.interceptor.LoginUserInterceptor;
import top.tobing.platform.seckill.service.SeckillService;
import top.tobing.platform.seckill.vo.RedisSkuInfoVo;
import top.tobing.platform.seckill.vo.SeckillSessionWithSkusVo;
import top.tobing.platform.seckill.vo.SeckillSkuRelationVo;
import top.tobing.platform.seckill.vo.SkuInfoVo;

import java.time.LocalDateTime;
import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

/**
 * @Author tobing
 * @Date 2021/5/2 9:48
 * @Description
 */
@Service
public class SeckillServiceImpl implements SeckillService {

    @Autowired
    private CouponFeignService couponFeignService;
    @Autowired
    private ProductFeignService productFeignService;
    @Autowired
    private StringRedisTemplate stringRedisTemplate;
    @Autowired
    private RedissonClient redissonClient;
    @Autowired
    private RabbitTemplate rabbitTemplate;

    public static final String SECKILL_SESSION_PREFIX = "seckill:session:";
    public static final String SECKILL_SKU_PREFIX = "seckill:skus:";
    // 防重处理
    public static final String SECKILL_IDEMPOTENCY_SESSION = "seckill:idempotency:session:session";
    public static final String SECKILL_IDEMPOTENCY_SKU = "seckill:idempotency:session:sku";
    // 信号量
    public static final String SECKILL_SEMAPHORE = "seckill:stock:";

    @Override
    public void upRecently3DaySeckill() {
        // 1、获取最近三天的活动相关信息
        List<SeckillSessionWithSkusVo> sessionList = couponFeignService.recently3DaySession();
        // 2、保存秒杀活动信息
        saveSessionInfos(sessionList);
        // 3、保存秒杀活动关联的商品信息
        saveSessionSkuInfos(sessionList);


    }

    @Override
    public List<RedisSkuInfoVo> getCurrentSeckillSkus() {
        long currentTime = System.currentTimeMillis();
        Set<String> keys = stringRedisTemplate.keys(SECKILL_SESSION_PREFIX + "*");
        for (String key : keys) {
            // 获取符合当前时间的秒杀场次
            String replace = key.replace(SECKILL_SESSION_PREFIX, "");
            String[] strings = replace.split("_");
            long startTime = Long.parseLong(strings[1]);
            long endTime = Long.parseLong(strings[2]);
            // 根据场次查询出对应的参与本次秒杀活动的商品信息
            if (currentTime >= startTime && startTime <= endTime) {
                List<String> skuIds = stringRedisTemplate.opsForList().range(key, -100, +100);
                BoundHashOperations<String, String, String> hashOps = stringRedisTemplate.boundHashOps(SECKILL_SKU_PREFIX);
                List<String> jsons = hashOps.multiGet(skuIds);
                if (jsons != null) {
                    List<RedisSkuInfoVo> resList = jsons.stream().map(item -> {
                        RedisSkuInfoVo redisSkuInfoVo = JSON.parseObject(item, RedisSkuInfoVo.class);
                        return redisSkuInfoVo;
                    }).collect(Collectors.toList());
                    return resList;
                }
            }

        }
        return null;
    }

    @Override
    public RedisSkuInfoVo getSeckillSkuBySkuId(Long skuId) {
        BoundHashOperations<String, String, String> hashOperations = stringRedisTemplate.boundHashOps(SECKILL_SKU_PREFIX);
        Set<String> keys = hashOperations.keys();
        String regx = "\\d_" + skuId;
        if (keys != null) {
            List<RedisSkuInfoVo> resList = keys.stream().filter(item -> {   // 过滤掉不是当前商品的信息
                return Pattern.matches(regx, item);
            }).map(item -> {            // 将当前商品信息封装为RedisSkuInfoVo
                String json = hashOperations.get(item);
                RedisSkuInfoVo redisSkuInfoVo = JSON.parseObject(json, RedisSkuInfoVo.class);
                long currentTime = System.currentTimeMillis();
                // 判断当前活动是否已经开始
                if (currentTime < redisSkuInfoVo.getStartTime() || currentTime > redisSkuInfoVo.getEndTime()) {
                    redisSkuInfoVo.setRandomCode(null);
                }
                return redisSkuInfoVo;
            }).sorted(Comparator.comparingLong(RedisSkuInfoVo::getStartTime)).collect(Collectors.toList()); // 根据创建日期排序，获取最近活动
            if (resList.size() != 0) {
                return resList.get(0);
            }
        }
        return null;
    }

    // 商品秒杀
    @Override
    public String kill(String killId, String key, Integer num) {
        // 查询对应的商品信息 killId
        BoundHashOperations<String, String, String> hashOps = stringRedisTemplate.boundHashOps(SECKILL_SKU_PREFIX);
        String json = hashOps.get(killId);
        if (!StringUtils.isEmpty(json)) {
            RedisSkuInfoVo skuInfoVo = JSON.parseObject(json, RedisSkuInfoVo.class);
            // 校验时间合法性
            long current = System.currentTimeMillis();
            Long startTime = skuInfoVo.getStartTime();
            Long endTime = skuInfoVo.getEndTime();
            if (current >= startTime && current <= endTime) {
                // 校验随机码
                if (skuInfoVo.getRandomCode().equals(key)) {
                    // 校验购物数量是否合法
                    if (skuInfoVo.getSeckillCount().intValue() > num) {
                        // 校验是否重复购买 userId_skuId_promotionId
                        MemberRespVo memberRespVo = LoginUserInterceptor.threadLocal.get();
                        String join = String.join("_", memberRespVo.getId().toString(), skuInfoVo.getSkuId().toString(), skuInfoVo.getPromotionId().toString());
                        if (stringRedisTemplate.opsForValue().setIfAbsent(join, "")) {
                            // 使用Semaphore实现控制
                            RSemaphore semaphore = redissonClient.getSemaphore(SECKILL_SEMAPHORE + key);
                            // 非阻塞方式尝试获取信号量，获取到则使用Idwork直接生成orderSn
                            boolean isSuccess = semaphore.tryAcquire(num);
                            if (isSuccess) {
                                String orderSn = IdWorker.getTimeId();
                                // 发送消息创建订单
                                SeckillOrderTo seckillOrderTo = new SeckillOrderTo();
                                seckillOrderTo.setOrderSn(orderSn);
                                seckillOrderTo.setMemberId(memberRespVo.getId());
                                seckillOrderTo.setSeckillPrice(skuInfoVo.getSeckillPrice());
                                seckillOrderTo.setNum(skuInfoVo.getSeckillCount().intValue());
                                seckillOrderTo.setPromotionId(skuInfoVo.getPromotionId());
                                seckillOrderTo.setSkuId(skuInfoVo.getSkuId());
                                rabbitTemplate.convertAndSend("order-event-exchange", "order.seckill.order", skuInfoVo);
                                return orderSn;
                            }
                        }
                    }
                }
            }
        }
        return null;
    }

    /**
     * 缓存秒杀的活动信息
     * key：sessionId_startTime_endTime 活动Id_活动开始时间_活动结束时间
     * value:sessionId_skuIds 参与活动的skuId
     */
    private void saveSessionInfos(List<SeckillSessionWithSkusVo> sessionList) {
        if (!CollectionUtils.isEmpty(sessionList)) {
            for (SeckillSessionWithSkusVo session : sessionList) {
                // 接口幂等性处理，对于同一个活动不重复上架
                String k = SECKILL_IDEMPOTENCY_SESSION + session.getId();
                if (!stringRedisTemplate.opsForValue().setIfAbsent(k, "")) {
                    continue;
                }
                // 构造 key
                Long sessionId = session.getId();
                Long startTime = session.getStartTime().getTime();
                Long endTime = session.getEndTime().getTime();
                String key = SECKILL_SESSION_PREFIX + String.join("_", sessionId.toString(), startTime.toString(), endTime.toString());
                //  保证接口幂等性
                if (!stringRedisTemplate.hasKey(key)) {
                    // 缓存信息
                    List<String> skuIds = session.getRelations().stream().map(item -> item.getSkuId().toString()).collect(Collectors.toList());
                    stringRedisTemplate.opsForList().leftPushAll(key, skuIds);
                }
            }
        }
    }

    /**
     * 缓存参与秒杀活动的商品信息
     * key: sessionId_skuId 商品的skuId
     * value: skuInfoDetail  商品的详情
     */
    private void saveSessionSkuInfos(List<SeckillSessionWithSkusVo> sessionList) {
        if (!CollectionUtils.isEmpty(sessionList)) {
            // 提取参与秒杀活动的所有skuId
            Set<Long> skuIdSet = new HashSet<>();
            for (SeckillSessionWithSkusVo session : sessionList) {
                List<Long> skuIdList = session.getRelations().stream().map(SeckillSkuRelationVo::getSkuId).collect(Collectors.toList());
                skuIdSet.addAll(skuIdList);
            }

            // 通过skuId批量查询对一个对应的详情信息，并将其转换为Map(Id,SkuInfo)便于下面封装
            List<SkuInfoVo> skuInfoVos = productFeignService.listBySkuId(new ArrayList<>(skuIdSet));
            Map<Long, SkuInfoVo> map = skuInfoVos.stream().collect(Collectors.toMap(SkuInfoVo::getSkuId, value -> value));

            // 封装skuInfo信息
            for (SeckillSessionWithSkusVo session : sessionList) {
                // 接口幂等性处理，对于同一个活动不重复上架
                String k = SECKILL_IDEMPOTENCY_SKU + session.getId();
                if (!stringRedisTemplate.opsForValue().setIfAbsent(k, "")) {
                    continue;
                }
                // 获取hashOps
                BoundHashOperations<String, Object, Object> hashOps = stringRedisTemplate.boundHashOps(SECKILL_SKU_PREFIX);
                for (SeckillSkuRelationVo relation : session.getRelations()) {
                    RedisSkuInfoVo redisSkuInfoVo = new RedisSkuInfoVo();
                    // 设置商品基本信息
                    BeanUtils.copyProperties(relation, redisSkuInfoVo);
                    redisSkuInfoVo.setSkuInfoVo(map.get(relation.getSkuId()));
                    // 设置商品活动时间
                    redisSkuInfoVo.setStartTime(session.getStartTime().getTime());
                    redisSkuInfoVo.setEndTime(session.getEndTime().getTime());
                    // 设置商品随机码
                    String token = UUID.randomUUID().toString().replace("-", "");
                    redisSkuInfoVo.setRandomCode(token);
                    // 设置分布式信号量
                    RSemaphore semaphore = redissonClient.getSemaphore(SECKILL_SEMAPHORE + token);
                    semaphore.trySetPermits(relation.getSeckillCount().intValue());

                    // 保存
                    String jsonString = JSON.toJSONString(redisSkuInfoVo);
                    String skuKey = new StringBuilder().append(relation.getPromotionId()).append("_").append(relation.getSkuId()).toString();
                    hashOps.put(skuKey, jsonString);
                }
            }
        }
    }
}

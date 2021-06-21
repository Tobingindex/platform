package top.tobing.platform.seckill.service;

import top.tobing.platform.seckill.vo.RedisSkuInfoVo;

import java.util.List;

/**
 * @Author tobing
 * @Date 2021/5/2 9:47
 * @Description
 */
public interface SeckillService {
    void upRecently3DaySeckill();

    /**
     * 获取当前处于秒杀的商品信息
     */
    List<RedisSkuInfoVo> getCurrentSeckillSkus();

    /**
     * 根据skuId查询对应的秒杀活动信息
     */
    RedisSkuInfoVo getSeckillSkuBySkuId(Long skuId);

    /**
     * 商品秒杀
     */
    String kill(String killId, String key, Integer num);
}

package top.tobing.platform.ware.service.impl;

import org.apache.commons.lang.StringUtils;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import top.tobing.common.to.SkuStockSearchVo;
import top.tobing.common.to.mq.WareOrderTaskDetailTo;
import top.tobing.common.to.mq.WareTaskTo;
import top.tobing.common.utils.PageUtils;
import top.tobing.common.utils.Query;

import top.tobing.common.utils.R;
import top.tobing.platform.ware.dao.WareSkuDao;
import top.tobing.platform.ware.entity.WareOrderTaskDetailEntity;
import top.tobing.platform.ware.entity.WareOrderTaskEntity;
import top.tobing.platform.ware.entity.WareSkuEntity;
import top.tobing.platform.ware.exception.NoStockException;
import top.tobing.platform.ware.feign.ProductFeignService;
import top.tobing.platform.ware.service.WareOrderTaskDetailService;
import top.tobing.platform.ware.service.WareOrderTaskService;
import top.tobing.platform.ware.service.WareSkuService;
import top.tobing.platform.ware.vo.OrderItemStockLockVo;
import top.tobing.platform.ware.vo.SkuWareHasStock;


@Service("wareSkuService")
public class WareSkuServiceImpl extends ServiceImpl<WareSkuDao, WareSkuEntity> implements WareSkuService {

    @Autowired
    private WareSkuDao wareSkuDao;
    @Autowired
    private ProductFeignService productFeignService;
    @Autowired
    private WareOrderTaskDetailService wareOrderTaskDetailService;
    @Autowired
    private WareOrderTaskService wareOrderTaskService;
    @Autowired
    private RabbitTemplate rabbitTemplate;
    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    public static final String ORDERSN_PRE = "ORDERSN:";

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Object skuId = params.get("skuId");
        Object wareId = params.get("wareId");

        // 拼接查询条件
        QueryWrapper<WareSkuEntity> queryWrapper = new QueryWrapper<>();
        if (skuId != null) {
            queryWrapper.and(i -> i.eq("sku_id", skuId));
        }
        if (wareId != null) {
            queryWrapper.and(i -> i.eq("ware_id", wareId));
        }
        IPage<WareSkuEntity> page = this.page(
                new Query<WareSkuEntity>().getPage(params),
                queryWrapper);

        return new PageUtils(page);
    }

    @Override
    public void addStock(Long skuId, Long wareId, Integer skuNum) {
        WareSkuEntity one = this.getOne(new QueryWrapper<WareSkuEntity>().and(i -> i.eq("sku_id", skuId).eq("ware_id", wareId)));
        if (one == null) {
            WareSkuEntity wareSkuEntity = new WareSkuEntity();
            wareSkuEntity.setSkuId(skuId);
            wareSkuEntity.setStock(skuNum);
            wareSkuEntity.setWareId(wareId);
            wareSkuEntity.setStockLocked(0);
            //  查询SKU
            try {
                R r = productFeignService.info(skuId);
                if ("0".equals(r.get("code"))) {
                    Map<String, Object> map = (Map<String, Object>) r.get("info");
                    wareSkuEntity.setSkuName((String) map.get("skuName"));
                }
            } catch (Exception e) {
                log.error("调用商品服务出现异常：{}", e);
            }
            this.save(wareSkuEntity);
        } else {
            wareSkuDao.addStack(skuId, wareId, skuNum);
        }
    }

    @Override
    public List<SkuStockSearchVo> batchSkuStockByIds(List<Long> ids) {
        List<SkuStockSearchVo> collect = ids.stream().map(id -> {
            SkuStockSearchVo skuStockSearchVo = new SkuStockSearchVo();
            Integer stock = this.baseMapper.batchGetSkuStockById(id);
            skuStockSearchVo.setSkuId(id);
            skuStockSearchVo.setStock(stock != null && stock > 0);
            return skuStockSearchVo;
        }).collect(Collectors.toList());
        return collect;
    }

    /**
     * 1）、下单成功，订单过期没有支付被系统自动取消、被用户手动取消，都需解锁库存
     * 2）、下单成功，库存锁定成功，接下来的业务调用失败，导致订单回滚。之前锁定的库存就要解锁
     * 一旦锁定库存，就需要记录每条库存的任务信息，便于异常情况的解锁
     * 【接口幂等性问题-方案1】
     * 此处由于Openfeign的重试机制，容易出现接口不幂等的问题。
     * 此处使用的方案是以orderSn关键字建立唯一索引。
     * 因为一个库存工作单肯定只对应一个订单编号，两者之间是一对一的关系。
     * 如果存在多个orderSn相同，一定是并发插入导致的。
     * 因此通过建立orderSn的唯一索引，只会允许一条数据能够成功插入，
     * 而其他相同的orderSn记录想要插入，会由于orderSn的唯一索引，而插入失败，最终导致事务回滚。
     * 【接口幂等性问题-方案2】
     * 处理唯一索引，还可以将orderSn存放到redis，使用setnx(SET if Not eXists)放入到Redis，
     * 如果存在则直接抛出异常或者返回，确保只能正常插入唯一的orderSn
     * https://www.redis.com.cn/commands/setnx.html
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public Boolean lockSkuStocks(List<OrderItemStockLockVo> stockLockVos) {
        // 不需要锁定库存
        if (stockLockVos == null || stockLockVos.size() == 0) {
            return true;
        }
        System.out.println(Thread.currentThread().getId() + "进来了！！！");
        // 创建库存工作单
        WareOrderTaskEntity wareOrderTaskEntity = new WareOrderTaskEntity();
        String orderSn = stockLockVos.get(0).getOrderSn();
        wareOrderTaskEntity.setOrderSn(orderSn);
        // 方案① 【这里使用唯一索引的方式来保证数据的一致性，如果插入重复的orderSn数据，将会导致抛出异常事务回滚】
        // 方案② 【使用原子性判断redis是否存在订单号】
        Boolean success = stringRedisTemplate.opsForValue().setIfAbsent(ORDERSN_PRE + orderSn, "1");
        if (!success) {
            return true;
        }
        wareOrderTaskService.save(wareOrderTaskEntity);


        // 查询所有还有库存的仓库信息
        List<SkuWareHasStock> stocksState = stockLockVos.stream().map(item -> {
            SkuWareHasStock stock = new SkuWareHasStock();
            stock.setSkuId(item.getSkuId());
            stock.setNum(item.getNum());
            // 查询具有skuId库存的仓库
            List<Long> wareIds = wareSkuDao.listWareBySkuId(item.getSkuId());
            stock.setWareIds(wareIds);
            return stock;
        }).collect(Collectors.toList());
        Boolean isSuccess = true;
        List<WareOrderTaskDetailEntity> detailEntityList = new ArrayList<>();
        // 遍历所有sku，判断是否可以实现锁库存
        for (SkuWareHasStock stock : stocksState) {
            // 任意一个sku无库存，直接返回false
            if (CollectionUtils.isEmpty(stock.getWareIds())) {
                return false;
            }
            boolean flag = false;
            for (Long wareId : stock.getWareIds()) {
                // 根据skuId、wareId、num查询是否存在符合仓库
                Integer count = wareSkuDao.lockSkuStock(stock.getSkuId(), wareId, stock.getNum());
                if (count == 1) {
                    flag = true;
                }
                // 收集订单任务详情表
                WareOrderTaskDetailEntity orderTaskDetailEntity = new WareOrderTaskDetailEntity();
                orderTaskDetailEntity.setSkuId(stock.getSkuId());
                orderTaskDetailEntity.setWareId(wareId);
                orderTaskDetailEntity.setSkuNum(stock.getNum());
                orderTaskDetailEntity.setTaskId(wareOrderTaskEntity.getId());
                // 设置锁定状态为：1-锁定
                orderTaskDetailEntity.setLockStatus(1);
                detailEntityList.add(orderTaskDetailEntity);
            }

            if (!flag) {
                // 如果有任何一个失败，都要抛出异常解锁，便于事务回滚
                throw new NoStockException();
            }
        }
        // 如果没有发现库存，将订单任务保存
        wareOrderTaskDetailService.saveBatch(detailEntityList);
        // 任务单保存完毕，发送消息
//        detailEntityList.stream().filter(item -> item.getId() != null).collect(Collectors.toList()).forEach(item -> {
//            WareTaskTo wareTaskTo = new WareTaskTo();
//            wareTaskTo.setId(item.getTaskId());
//            WareOrderTaskDetailTo wareOrderTaskDetailTo = new WareOrderTaskDetailTo();
//            BeanUtils.copyProperties(item, wareOrderTaskDetailTo);
//            wareTaskTo.setDetail(wareOrderTaskDetailTo);
//        });
        WareTaskTo wareTaskTo = new WareTaskTo();
        wareTaskTo.setId(wareOrderTaskEntity.getId());
        rabbitTemplate.convertAndSend("stock-event-exchange", "stock.locked", wareTaskTo);
        return true;
    }

    @Override
    public void unlockStockBySkuIdAndWareId(Long skuId, Long wareId, Integer skuNum) {
        this.baseMapper.unlockStockBySkuIdAndWareId(skuId, wareId, skuNum);
    }


}
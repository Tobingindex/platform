package top.tobing.platform.order.service.impl;

import com.baomidou.mybatisplus.core.toolkit.IdWorker;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.script.DefaultRedisScript;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.*;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.stream.Collectors;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import top.tobing.common.api.BziCodeEnum;
import top.tobing.common.api.Result;
import top.tobing.common.constant.LuaScript;
import top.tobing.common.constant.PlatformOrderConstant;
import top.tobing.common.to.MemberRespVo;
import top.tobing.common.to.SkuStockSearchVo;
import top.tobing.common.to.mq.SeckillOrderTo;
import top.tobing.common.utils.PageUtils;
import top.tobing.common.utils.Query;

import top.tobing.common.utils.R;
import top.tobing.platform.order.dao.OrderDao;
import top.tobing.platform.order.entity.OrderEntity;
import top.tobing.platform.order.entity.OrderItemEntity;
import top.tobing.platform.order.entity.PaymentInfoEntity;
import top.tobing.platform.order.enume.OrderStatusEnum;
import top.tobing.platform.order.exception.NoStockException;
import top.tobing.platform.order.feign.CartFeignService;
import top.tobing.platform.order.feign.MemberFeignService;
import top.tobing.platform.order.feign.ProductFeignService;
import top.tobing.platform.order.feign.WareFeignService;
import top.tobing.platform.order.interceptor.LoginUserInterceptor;
import top.tobing.platform.order.service.OrderItemService;
import top.tobing.platform.order.service.OrderService;
import top.tobing.platform.order.service.PaymentInfoService;
import top.tobing.platform.order.to.OrderCreateTo;
import top.tobing.platform.order.vo.*;

@Slf4j
@Service("orderService")
public class OrderServiceImpl extends ServiceImpl<OrderDao, OrderEntity> implements OrderService {

    private ThreadLocal<OrderSubmitVo> submitVoThreadLocal = new ThreadLocal<>();

    @Autowired
    private OrderService orderService;
    @Autowired
    private OrderItemService orderItemService;
    @Autowired
    private MemberFeignService memberFeignService;
    @Autowired
    private CartFeignService cartFeignService;
    @Autowired
    private WareFeignService wareFeignService;
    @Autowired
    private ProductFeignService productFeignService;
    @Autowired
    private ThreadPoolExecutor poolExecutor;
    @Autowired
    private StringRedisTemplate redisTemplate;
    @Autowired
    private RabbitTemplate rabbitTemplate;
    @Autowired
    private PaymentInfoService paymentInfoService;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<OrderEntity> page = this.page(
                new Query<OrderEntity>().getPage(params),
                new QueryWrapper<OrderEntity>()
        );

        return new PageUtils(page);
    }

    @Override
    public OrderConfirmVo toTrade() throws ExecutionException, InterruptedException {
        OrderConfirmVo confirmVo = new OrderConfirmVo();
        MemberRespVo memberRespVo = UserContextHolder.getCurrentUser();
        // MemberRespVo memberRespVo = LoginUserInterceptor.threadLocal.get();
        // 注意将本次请求的上下文对象，设置给每个异步编排中的线程，因为RequestContextHolder内部通过ThreadLocal来保存数据
        // 异步化如果不进行处理那么在Feign的拦截器将拿不到数据
         RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();

        CompletableFuture<Void> getAddress = CompletableFuture.runAsync(() -> {
            // 注意异步编排无法使用ThreadLocal中的变量，可以将信息取出来放到
             RequestContextHolder.setRequestAttributes(requestAttributes);
            // 1、查询所有的收货地址【用户服务】
            List<MemberAddressVo> address = memberFeignService.addressList(memberRespVo.getId());
            confirmVo.setAddressList(address);
        }, poolExecutor);

        CompletableFuture<Void> getItems = CompletableFuture.supplyAsync(() -> {
            // 注意异步编排无法使用ThreadLocal中的变量，可以将信息取出来放到
             RequestContextHolder.setRequestAttributes(requestAttributes);
            // 2、查询购物车选中的商品【购物车服务】
            Result<List<OrderItemVo>> cartResult = cartFeignService.listOwnCheckItem();
            if (BziCodeEnum.SUCCESS.getCode() != cartResult.getCode()) {
                throw new RuntimeException("远程查询数据出错！");
            }
            confirmVo.setItemVoList(cartResult.getData());
            return cartResult.getData();
        }, poolExecutor).thenAcceptAsync((items) -> {
            // 3、查询远程是否存在库存【库存服务】
            List<Long> skuIds = items.stream().map(OrderItemVo::getSkuId).collect(Collectors.toList());
            List<SkuStockSearchVo> stockStatus = wareFeignService.batchSkuStock(skuIds);
            if (stockStatus != null) {
                Map<Long, Boolean> map = stockStatus.stream().collect(Collectors.toMap(SkuStockSearchVo::getSkuId, SkuStockSearchVo::getStock));
                confirmVo.setHasStockMap(map);
            }
        }, poolExecutor);


        // 4、查询用户优惠信息【用户服务】
        Integer integration = memberRespVo.getIntegration();
        confirmVo.setIntegration(integration);

        // 5、生成防重令牌，分别保存在Redis与返回页面，这样就可以在页面提交的时候直接校验（保证接口幂等性）
        String orderToken = UUID.randomUUID().toString().replace("-", "");
        confirmVo.setOrderToken(orderToken);
        redisTemplate.opsForValue().set(PlatformOrderConstant.USER_ORDER_TOKEN_PREFIX + memberRespVo.getId(), orderToken);

        CompletableFuture.allOf(getAddress, getItems).get();

        return confirmVo;
    }

    //    @GlobalTransactional
    @Transactional
    @Override
    public OrderSubmitRespVo submitOrder(OrderSubmitVo orderSubmitVo) {
        OrderSubmitRespVo respVo = new OrderSubmitRespVo();
        submitVoThreadLocal.set(orderSubmitVo);
        MemberRespVo memberRespVo = LoginUserInterceptor.threadLocal.get();
        respVo.setCode(0);
        // 1、验证令牌
        /* 反例，非原子性对比
        String submitToken = orderSubmitVo.getOrderToken();
        String redisToken = redisTemplate.opsForValue().get(OrderConstant.USER_ORDER_TOKEN_PREFIX + memberRespVo.getId());
        if (submitToken != null && submitToken.equals(redisToken)) {
        } */
        // 正例子，使用Lua脚本，原子性对比
        String script = LuaScript.REDIS_ATOMIC_COMPARE_AND_DELETE;
        String submitToken = orderSubmitVo.getOrderToken();
        Long result = redisTemplate.execute(new DefaultRedisScript<Long>(script, Long.class),
                Arrays.asList(PlatformOrderConstant.USER_ORDER_TOKEN_PREFIX + memberRespVo.getId()), submitToken);
        if (result == null || result.equals(0L)) {
            // 令牌验证失败
            respVo.setCode(4);
            return respVo;
        } else {
            // 临牌验证成功：创建订单、验价
            OrderCreateTo orderCreateTo = createOrder();
            BigDecimal payAmount = orderCreateTo.getOrder().getPayAmount();
            BigDecimal submitAmount = orderSubmitVo.getPayPrice();
            if (payAmount.subtract(submitAmount).doubleValue() < 0.01) {
                // 保存订单
                saveOrder(orderCreateTo);
                // 锁库存：skuId、skuName、skuLocked
                List<OrderItemStockLockVo> stockList = orderCreateTo.getOrderItems().stream().map(item -> {
                    OrderItemStockLockVo lockVo = new OrderItemStockLockVo();
                    lockVo.setOrderSn(item.getOrderSn());
                    lockVo.setSkuId(item.getSkuId());
                    lockVo.setName(item.getSkuName());
                    lockVo.setNum(item.getSkuQuantity());
                    return lockVo;
                }).collect(Collectors.toList());
                // 接口幂等性处理
                log.info("即将发送锁库存");
                R r = null;
                try {
                    r = wareFeignService.lockSkuStocks(stockList);
                } catch (Exception e) {
                    log.error("远程调用出现异常");
                }
                if (r != null && !r.get("code").equals(0)) {
                    // 抛出异常，便于回滚
                    throw new NoStockException();
                }
                // 订单超时自动处理：发送消息到延时队列，超时自动删除订单
                // String exchange, String routingKey, Message message
                respVo.setOrderEntity(orderCreateTo.getOrder());
                rabbitTemplate.convertAndSend("order-event-exchange", "order.create.order", orderCreateTo.getOrder().getOrderSn());
                // 手动抛出异常，用于测试
                // int i = 1 / 0;
            } else {
                respVo.setCode(2);
                return respVo;
            }
        }
        return respVo;
    }

    @Override
    public OrderEntity getStatusByOrderSn(String orderSn) {
        return this.getOne(new QueryWrapper<OrderEntity>().eq("order_sn", orderSn));
    }

    @Override
    public Integer updateOrderStatusToOverdue(String orderSn) {
        return this.baseMapper.updateOrderStatusToOverdue(orderSn);
    }

    @Override
    public PayVo getOrderPay(String orderSn) {
        PayVo payVo = new PayVo();
        OrderEntity orderEntity = orderService.getOne(new QueryWrapper<OrderEntity>().eq("order_sn", orderSn));
        BigDecimal bigDecimal = orderEntity.getPayAmount().setScale(2, BigDecimal.ROUND_UP);

        payVo.setOut_trade_no(orderSn); // 订单编号
        payVo.setSubject("订单名称【测试】");  // 订单名称
        payVo.setTotal_amount(bigDecimal.toString());   // 订单金额，保留两位小数
        payVo.setBody("无描述【测试】");
        return payVo;
    }

    @Override
    public List<OrderRespVo> getOrderDetailList() {
        MemberRespVo memberRespVo = LoginUserInterceptor.threadLocal.get();
        Long id = memberRespVo.getId();
        List<OrderEntity> orderEntityList = this.list(new QueryWrapper<OrderEntity>().eq("member_id", id).orderByDesc("id"));
        if (orderEntityList != null) {
            List<OrderRespVo> respVoList = orderEntityList.stream().map(item -> {
                OrderRespVo respVo = new OrderRespVo();
                BeanUtils.copyProperties(item, respVo);
                // 查询订单项
                List<OrderItemEntity> orderItemEntityList = orderItemService.list(new QueryWrapper<OrderItemEntity>().eq("order_sn", item.getOrderSn()));
                respVo.setItems(orderItemEntityList);
                return respVo;
            }).collect(Collectors.toList());
            return respVoList;
        }
        return null;
    }

    /**
     * 保证接口幂等性
     * 采用唯一索引的方式限定，orderSn和支付宝流水号
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public String updateOrderStatusByAlipay(PayAsyncVo payVo) {
        // 保存订单支付信息`oms_payment_info`
        PaymentInfoEntity paymentInfoEntity = new PaymentInfoEntity();
        paymentInfoEntity.setOrderSn(payVo.getOut_trade_no());
        paymentInfoEntity.setAlipayTradeNo(payVo.getTrade_no());
        paymentInfoEntity.setTotalAmount(new BigDecimal(payVo.getTotal_amount()));
        paymentInfoEntity.setSubject(payVo.getSubject());
        paymentInfoEntity.setPaymentStatus(payVo.getTrade_status());
        paymentInfoEntity.setCreateTime(payVo.getGmt_create());
        paymentInfoEntity.setCallbackTime(new Date());
        paymentInfoService.save(paymentInfoEntity);

        // 判断订单的支付状态
        if ("TRADE_FINISHED".equals(payVo.getTrade_status()) || "TRADE_SUCCESS".equals(payVo.getTrade_status())) {
            // 更新订单
            this.baseMapper.updateOrderStatusByOrderSn(payVo.getOut_trade_no(), PlatformOrderConstant.OrderStatus.FOR_THE_SEND.getCode());
        }
        return "success";
    }

    @Override
    public void saveSeckillOrder(SeckillOrderTo seckillOrderTo) {
        // 处理订单信息
        OrderEntity orderEntity = new OrderEntity();
        orderEntity.setMemberId(seckillOrderTo.getMemberId());
        orderEntity.setOrderSn(seckillOrderTo.getOrderSn());
        orderEntity.setCreateTime(new Date());
        // TODO 远程查询运费信息
        orderEntity.setPayAmount(seckillOrderTo.getSeckillPrice());
        orderEntity.setFreightAmount(new BigDecimal("0.0"));
        orderEntity.setPayAmount(orderEntity.getPayAmount().add(orderEntity.getFreightAmount()));

        orderEntity.setStatus(PlatformOrderConstant.OrderStatus.FOR_THE_PAYMENT.getCode());

        // TODO 后继

        // 处理订单项信息
    }

    // 保存订单内容
    private void saveOrder(OrderCreateTo orderCreateTo) {
        // 保存订单
        OrderEntity order = orderCreateTo.getOrder();
        save(order);
        // 批量保存订单项
        List<OrderItemEntity> orderItems = orderCreateTo.getOrderItems();
        orderItemService.saveBatch(orderItems);
    }

    /**
     * 构造订单项
     */
    private OrderCreateTo createOrder() {
        OrderCreateTo orderCreateTo = new OrderCreateTo();
        // 1、生成订单号，Idwork生成
        String orderSn = IdWorker.getTimeId();
        // 2、创建订单
        OrderEntity orderEntity = buildOrder(orderSn);
        orderCreateTo.setOrder(orderEntity);
        // 3、获取订单项
        List<OrderItemEntity> orderItemVoList = buildOrderItems(orderSn);
        orderCreateTo.setOrderItems(orderItemVoList);
        // 4、计算价格、积分信息
        computeTotal(orderEntity, orderItemVoList);

        return orderCreateTo;
    }

    // 计算总价、总积分等信息
    private void computeTotal(OrderEntity orderEntity, List<OrderItemEntity> orderItemVoList) {
        // 订单总额
        BigDecimal total = new BigDecimal("0.0");
        // 优惠券抵扣总金额
        BigDecimal coupon = new BigDecimal("0.0");
        // 积分抵扣总金额
        BigDecimal integration = new BigDecimal("0.0");
        // 促销优化总金额（促销价、满减、阶梯价）
        BigDecimal promotion = new BigDecimal("0.0");
        // 总成长积分
        BigDecimal gift = new BigDecimal("0.0");
        // 总成长值
        BigDecimal growth = new BigDecimal("0.0");
        // 计算汇总
        for (OrderItemEntity orderItemEntity : orderItemVoList) {
            total = total.add(orderItemEntity.getRealAmount());
            coupon = coupon.add(orderItemEntity.getCouponAmount());
            integration = integration.add(orderItemEntity.getIntegrationAmount());
            promotion = promotion.add(orderItemEntity.getPromotionAmount());
            gift = gift.add(new BigDecimal(orderItemEntity.getGiftGrowth()));
            growth = growth.add(new BigDecimal(orderItemEntity.getGiftIntegration()));
        }
        // 商品总价
        orderEntity.setTotalAmount(total);
        // 应付价格
        orderEntity.setPayAmount(total.add(orderEntity.getFreightAmount()));
        orderEntity.setPromotionAmount(promotion);
        orderEntity.setIntegrationAmount(integration);
        orderEntity.setCouponAmount(coupon);
        // 积分信息
        orderEntity.setIntegration(integration.intValue());
        orderEntity.setGrowth(growth.intValue());
    }

    // 构造订单项信息
    private List<OrderItemEntity> buildOrderItems(String orderSn) {
        // 从购物车获取选中的购物项
        Result< List<OrderItemVo>> cartResult = cartFeignService.listOwnCheckItem();
        List<OrderItemVo> orderItemVoList = cartResult.getData();
        if (orderItemVoList != null && !orderItemVoList.isEmpty()) {
            List<OrderItemEntity> collect = orderItemVoList.stream().map(item -> {
                OrderItemEntity itemEntity = toOrderItem(item);
                itemEntity.setOrderSn(orderSn);
                return itemEntity;
            }).collect(Collectors.toList());
            return collect;
        }
        return null;
    }

    // 将购物车项（OrderItemVo）封装为 订单项（OrderItemEntity）
    private OrderItemEntity toOrderItem(OrderItemVo item) {
        OrderItemEntity orderItemEntity = new OrderItemEntity();
        // SPU信息 ==> 远程查询
        SpuInfoVo spuInfoVo = productFeignService.getBySkuId(item.getSkuId());
        orderItemEntity.setSpuId(spuInfoVo.getId());
        orderItemEntity.setSpuName(spuInfoVo.getSpuName());
        orderItemEntity.setSpuBrand(spuInfoVo.getBrandId().toString());
        orderItemEntity.setCategoryId(spuInfoVo.getCatalogId());
        // sku信息
        orderItemEntity.setSkuId(item.getSkuId());
        orderItemEntity.setSkuName(item.getTitle());
        orderItemEntity.setSkuPic(item.getImage());
        orderItemEntity.setSkuPrice(item.getPrice());
        orderItemEntity.setSkuQuantity(item.getCount());
        String attrStr = String.join(";", item.getSkuAttr());
        orderItemEntity.setSkuAttrsVals(attrStr);
        // 积分信息 ==> 简单处理
        orderItemEntity.setGiftGrowth(item.getPrice().multiply(new BigDecimal(orderItemEntity.getSkuQuantity())).intValue());
        orderItemEntity.setGiftIntegration(item.getPrice().multiply(new BigDecimal(orderItemEntity.getSkuQuantity())).intValue());
        // 订单项价格
        orderItemEntity.setPromotionAmount(new BigDecimal(0.0));    //
        orderItemEntity.setCouponAmount(new BigDecimal(0.0));
        orderItemEntity.setIntegrationAmount(new BigDecimal(0.0));
        // 计算实际价格
        BigDecimal original = orderItemEntity.getSkuPrice().
                multiply(new BigDecimal(orderItemEntity.getSkuQuantity()));
        BigDecimal realPrice = original.subtract(orderItemEntity.getPromotionAmount())
                .subtract(orderItemEntity.getCouponAmount())
                .subtract(orderItemEntity.getIntegrationAmount());
        orderItemEntity.setRealAmount(realPrice);

        return orderItemEntity;
    }

    // 构造订单部分信息
    private OrderEntity buildOrder(String orderSn) {
        OrderEntity orderEntity = new OrderEntity();
        MemberRespVo memberRespVo = LoginUserInterceptor.threadLocal.get();
        OrderSubmitVo orderSubmitVo = submitVoThreadLocal.get();

        // 设置通用信息
        orderEntity.setOrderSn(orderSn);        // 订单号
        orderEntity.setCreateTime(new Date());  // 创建时间
        orderEntity.setModifyTime(new Date());  // 修改时间
        orderEntity.setStatus(OrderStatusEnum.CREATE_NEW.getCode());    // 订单状态
        orderEntity.setPayType(1);              // 支付方式
        orderEntity.setSourceType(1);           // 订单来源
        orderEntity.setAutoConfirmDay(7);       // 自动确认收货时间
        orderEntity.setConfirmStatus(0);        // 确认状态
        orderEntity.setDeleteStatus(0);         // 删除状态

        // 查询运费
        FareVo fareVo = wareFeignService.farejson(orderSubmitVo.getAddrId());
        orderEntity.setFreightAmount(fareVo.getFare());
        // 设置用户信息
        orderEntity.setMemberId(memberRespVo.getId());
        orderEntity.setMemberUsername(memberRespVo.getUsername());

        // 设置地址信息
        MemberAddressVo memberAddressVo = fareVo.getAddress();
        orderEntity.setReceiverName(memberAddressVo.getName());
        orderEntity.setReceiverPhone(memberAddressVo.getPhone());
        orderEntity.setReceiverPostCode(memberAddressVo.getPostCode());
        orderEntity.setReceiverProvince(memberAddressVo.getProvince());
        orderEntity.setReceiverCity(memberAddressVo.getCity());
        orderEntity.setReceiverRegion(memberAddressVo.getRegion());
        orderEntity.setReceiverDetailAddress(memberAddressVo.getDetailAddress());

        return orderEntity;
    }

}
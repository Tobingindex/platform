package top.tobing.platform.cart.service.impl;

import com.alibaba.fastjson.JSON;
import org.apache.catalina.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.BoundHashOperations;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;
import top.tobing.common.api.BziCodeEnum;
import top.tobing.common.api.Result;
import top.tobing.platform.cart.feign.ProductFeignService;
import top.tobing.platform.cart.interceptor.CartInterceptor;
import top.tobing.platform.cart.service.CartService;
import top.tobing.platform.cart.vo.Cart;
import top.tobing.platform.cart.vo.CartItem;
import top.tobing.platform.cart.vo.SkuInfoTo;
import top.tobing.platform.cart.vo.UserInfoTo;

import java.math.BigDecimal;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.stream.Collectors;

/**
 * @Author tobing
 * @Date 2021/4/20 10:33
 * @Description
 */
@Service
public class CartServiceImpl implements CartService {

    private static final String CART_PREFIX = "platform:cart:";

    @Autowired
    private StringRedisTemplate redisTemplate;
    @Autowired
    private ProductFeignService productFeignService;

    /**
     * 添加指定的商品{skuId}到购物车
     * 1、获取用户的购物车操作对象
     * 2、封装购物车项
     * 2.1、远程查询商品信息
     * 2.2、远程查询属性信息
     * 3、将购物车项放到Redis中保存，并返回显示。
     * 「使用异步编排提高查询效率」
     */
    @Override
    public CartItem addToCart(Long skuId, Integer num) throws ExecutionException, InterruptedException {
        // 获取操作当前Redis中指定key的hash操作
        BoundHashOperations<String, Object, Object> cartHashOps = getCartHashOps();
        String cartItemJson = (String) cartHashOps.get(skuId.toString());
        if (cartItemJson == null) {  // 新增购物车
            // 封装购物车项
            CartItem cartItem = new CartItem();
            // 1、远程查询商品信息
            CompletableFuture<Void> getSkuInfo = CompletableFuture.runAsync(() -> {
                SkuInfoTo skuInfoTo = productFeignService.detail(skuId);
                cartItem.setCheck(true);
                cartItem.setCount(num);
                cartItem.setImage(skuInfoTo.getSkuDefaultImg());
                cartItem.setPrice(skuInfoTo.getPrice());
                cartItem.setSkuId(skuId);
                cartItem.setTitle(skuInfoTo.getSkuSubtitle());
            });
            // 2、远程查询属性信息
            CompletableFuture<Void> getAttrList = CompletableFuture.runAsync(() -> {
                List<String> skuSaleList = productFeignService.getSkuSaleList(skuId);
                cartItem.setSkuAttr(skuSaleList);
            });
            CompletableFuture.allOf(getSkuInfo, getAttrList).get();

            // 3、将封装好的CartItem转换为JSON保存
            String cartJson = JSON.toJSONString(cartItem);
            cartHashOps.put(skuId.toString(), cartJson);
            return cartItem;
        }

        CartItem cartItem = JSON.parseObject(cartItemJson, CartItem.class);
        cartItem.setCount(cartItem.getCount() + num);
        cartHashOps.put(skuId.toString(), JSON.toJSONString(cartItem));
        return cartItem;
    }

    @Override
    public CartItem getCartItemBySkuId(Long skuId) {
        BoundHashOperations<String, Object, Object> cartHashOps = getCartHashOps();
        String itemJson = (String) cartHashOps.get(skuId.toString());
        CartItem cartItem = JSON.parseObject(itemJson, CartItem.class);
        return cartItem;
    }

    @Override
    public Cart getCartList() {
        UserInfoTo userInfoTo = CartInterceptor.threadLocal.get();
        Cart cart = new Cart();

        if (userInfoTo.getUserId() != null) {
            // 合并临时用户与登录用户购物车
            List<CartItem> cartItemList = getCartItemList(CART_PREFIX + userInfoTo.getUserKey());
            if (cartItemList != null && cartItemList.size() != 0) {
                // 将每一项添加到登录用户key的购物车中
                for (CartItem cartItem : cartItemList) {
                    try {
                        addToCart(cartItem.getSkuId(), cartItem.getCount());
                    } catch (ExecutionException e) {
                        e.printStackTrace();
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
                // 添加完毕，清空临时账号的购物车信息
                clearCart(CART_PREFIX + userInfoTo.getUserKey());
            }
            // 查询合并后的结果，返回
            cart.setItems(getCartItemList(CART_PREFIX + userInfoTo.getUserId()));
        } else {
            // 直接查询临时用户购物车
            String key = CART_PREFIX + userInfoTo.getUserKey();
            cart.setItems(getCartItemList(key));
        }
        return cart;
    }

    /**
     * 根据key获取购物车项
     */
    private List<CartItem> getCartItemList(String key) {
        BoundHashOperations<String, Object, Object> operations = redisTemplate.boundHashOps(key);
        List<Object> itemStrs = operations.values();
        if (itemStrs != null && itemStrs.size() != 0) {
            List<CartItem> collect = itemStrs.stream().map(item -> {
                String str = (String) item;
                return JSON.parseObject(str, CartItem.class);
            }).collect(Collectors.toList());
            return collect;
        }
        return null;
    }

    /**
     * Returns the operations performed on hash values bound to the given key.
     * 返回代表了指定key的hash操作对象。
     */
    private BoundHashOperations<String, Object, Object> getCartHashOps() {
        // 临时用户则采用user-key、登录用户则采用userId
        UserInfoTo userInfoTo = CartInterceptor.threadLocal.get();
        String key = "";
        if (userInfoTo.getUserId() != null) {
            key = CART_PREFIX + userInfoTo.getUserId().toString();
        } else {
            key = CART_PREFIX + userInfoTo.getUserKey();
        }
        return redisTemplate.boundHashOps(key);
    }

    // 清空购物车
    @Override
    public void clearCart(String key) {
        redisTemplate.delete(key);
    }

    @Override
    public void checkItem(String skuId, Integer checked) {
        BoundHashOperations<String, Object, Object> operations = getCartHashOps();
        String json = (String) operations.get(skuId);
        CartItem cartItem = JSON.parseObject(json, CartItem.class);
        cartItem.setCheck(checked == 1);
        String newJson = JSON.toJSONString(cartItem);
        operations.put(skuId, newJson);
    }

    @Override
    public void changItemCount(String skuId, Integer num) {
        BoundHashOperations<String, Object, Object> operations = getCartHashOps();
        String json = (String) operations.get(skuId);
        CartItem cartItem = JSON.parseObject(json, CartItem.class);
        cartItem.setCount(num);
        String newJson = JSON.toJSONString(cartItem);
        operations.put(skuId, newJson);
    }

    @Override
    public void deleteItem(String skuId) {
        BoundHashOperations<String, Object, Object> operations = getCartHashOps();
        operations.delete(skuId);
    }

    @Override
    public Result<List<CartItem>> listOwnCheckItem() {
        UserInfoTo userInfoTo = CartInterceptor.threadLocal.get();
        if (userInfoTo.getUserId() == null) {
            // 缺少用户信息
            return Result.error(BziCodeEnum.CART_UNAUTH_USER.getCode(), BziCodeEnum.CART_UNAUTH_USER.getMsg());
        }
        List<CartItem> cartItemList = getCartItemList(CART_PREFIX + userInfoTo.getUserId());
        if (cartItemList != null) {
            List<CartItem> collect = cartItemList.stream().filter(CartItem::getCheck).collect(Collectors.toList());
            for (CartItem cartItem : collect) {
                // 调用远程查询每个商品项的价格【每次都要查询最新的价格】
                BigDecimal bigDecimal = productFeignService.priceBySkuId(cartItem.getSkuId());
                cartItem.setPrice(bigDecimal);
            }
            return Result.ok(collect);
        }
        return Result.ok(null);
    }
}

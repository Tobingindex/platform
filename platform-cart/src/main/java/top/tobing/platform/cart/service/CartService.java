package top.tobing.platform.cart.service;

import top.tobing.platform.cart.vo.Cart;
import top.tobing.platform.cart.vo.CartItem;

import java.util.List;
import java.util.concurrent.ExecutionException;

/**
 * @Author tobing
 * @Date 2021/4/20 10:33
 * @Description
 */
public interface CartService {
    /**
     * 添加商品到购物车
     */
    CartItem addToCart(Long skuId, Integer num) throws ExecutionException, InterruptedException;

    /**
     * 根据skuId查询购物车项
     */
    CartItem getCartItemBySkuId(Long skuId);

    /**
     * 获取购物车信息
     */
    Cart getCartList();

    /**
     * 清空购物车
     */
    void clearCart(String key);

    /**
     * 修改商品先的选中状态
     */
    void checkItem(String skuId, Integer checked);

    /**
     * 修改商品项的数量
     */
    void changItemCount(String skuId, Integer num);

    /**
     * 删除指定商品项
     *
     * @param skuId
     */
    void deleteItem(String skuId);

    /**
     * 查询登录用户选中购物车项
     * 用户通过ThreadLocal获取
     */
    List<CartItem> listOwnCheckItem();
}

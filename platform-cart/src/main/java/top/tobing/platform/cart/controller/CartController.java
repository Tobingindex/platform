package top.tobing.platform.cart.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import top.tobing.common.api.Result;
import top.tobing.platform.cart.interceptor.CartInterceptor;
import top.tobing.platform.cart.service.CartService;
import top.tobing.platform.cart.vo.Cart;
import top.tobing.platform.cart.vo.CartItem;
import top.tobing.platform.cart.vo.UserInfoTo;

import java.util.List;
import java.util.concurrent.ExecutionException;

/**
 * @Author tobing
 * @Date 2021/4/19 16:35
 * @Description
 */
@Controller
public class CartController {

    @Autowired
    private CartService cartService;


    @GetMapping("/success.html")
    public String success() {
        // 通过ThreadLocal获取线程内变量
        UserInfoTo userInfoTo = CartInterceptor.threadLocal.get();
        System.out.println(userInfoTo);
        return "success";
    }

//    @GetMapping({"/", "cartList.html"})
//    public String cartList() {
//        return "cartList";
//    }

    // 添加商品到购物车
    @GetMapping("/addToCart")
    public String addToCart(@RequestParam("skuId") Long skuId,
                            @RequestParam("num") Integer num,
                            RedirectAttributes redirectAttributes) throws ExecutionException, InterruptedException {
        CartItem cartItem = cartService.addToCart(skuId, num);
        redirectAttributes.addAttribute("skuId", skuId);
        return "redirect:http://cart.platform.com/addToCartSuccess.html";
    }

    // 跳转到指定的成功页面
    @GetMapping("/addToCartSuccess.html")
    public String addToCartSuccessPage(@RequestParam("skuId") Long skuId, Model model) {
        // 重新根据skuId查询购物车项数据
        CartItem cartItem = cartService.getCartItemBySkuId(skuId);
        model.addAttribute(cartItem);
        return "success";
    }

    // 查询购物车
    @GetMapping("/cartList.html")
    public String getCartList(Model model) {
        Cart cart = cartService.getCartList();
        model.addAttribute(cart);
        return "cartList";
    }

    // 修改商品项的选中状态
    @GetMapping("/checkItem")
    public String checkItem(@RequestParam("skuId") String skuId,
                            @RequestParam("checked") Integer checked) {
        cartService.checkItem(skuId, checked);
        return "redirect:http://cart.platform.com/cartList.html";
    }

    // 修改商品项的数量
    @GetMapping("countItem")
    public String changItemCount(@RequestParam("skuId") String skuId,
                                 @RequestParam("num") Integer num) {
        cartService.changItemCount(skuId, num);
        return "redirect:http://cart.platform.com/cartList.html";
    }

    // 删除指定的商品项
    @GetMapping("deleteItem")
    public String deleteItem(@RequestParam("skuId") String skuId) {
        cartService.deleteItem(skuId);
        return "redirect:http://cart.platform.com/cartList.html";
    }

    // 查询登录用户选中的购物项【远程调用】
    @ResponseBody
    @GetMapping("listOwnCheckItem")
    public Result<List<CartItem>> listOwnCheckItem() {
        return cartService.listOwnCheckItem();
    }


}


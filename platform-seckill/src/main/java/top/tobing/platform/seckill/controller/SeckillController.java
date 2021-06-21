package top.tobing.platform.seckill.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import top.tobing.common.utils.R;
import top.tobing.platform.seckill.service.SeckillService;
import top.tobing.platform.seckill.vo.RedisSkuInfoVo;

import java.util.List;

/**
 * @Author tobing
 * @Date 2021/5/2 19:05
 * @Description
 */
@Controller
public class SeckillController {

    @Autowired
    private SeckillService seckillService;

    /**
     * 获取当前秒杀活动的商品信息
     */
    @ResponseBody
    @GetMapping("/currentSeckillSkus")
    public R getCurrentSeckillSkus() {
        List<RedisSkuInfoVo> skus = seckillService.getCurrentSeckillSkus();
        return R.ok().put("data", skus);
    }

    /**
     * 根据skuId查询对应的秒杀信息
     */
    @ResponseBody
    @GetMapping("/getSeckillSkuBySkuId/{skuId}")
    public RedisSkuInfoVo getSeckillSkuBySkuId(@PathVariable("skuId") Long skuId) {
        return seckillService.getSeckillSkuBySkuId(skuId);
    }

    /**
     * 商品秒杀
     */
    @GetMapping("/kill")
    public String kill(@RequestParam("killId") String killId,
                       @RequestParam("key") String key,
                       @RequestParam("num") Integer num,
                       Model model) {
        String orderSn = seckillService.kill(killId, key, num);
        model.addAttribute("orderSn", orderSn);
        return "success";
    }
}

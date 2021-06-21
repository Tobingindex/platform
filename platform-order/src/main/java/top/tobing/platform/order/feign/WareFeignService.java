package top.tobing.platform.order.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import top.tobing.common.to.SkuStockSearchVo;
import top.tobing.common.utils.R;
import top.tobing.platform.order.vo.FareVo;
import top.tobing.platform.order.vo.OrderItemStockLockVo;

import java.util.List;

/**
 * @Author tobing
 * @Date 2021/4/24 10:31
 * @Description
 */
@FeignClient("platform-ware")
public interface WareFeignService {


    /**
     * 根据addrId查询收货信息【地址+运费】
     */
    @GetMapping("/ware/wareinfo/farejson")
    public FareVo farejson(@RequestParam("addrId") Long addrId);

    /**
     * 远程批量查询skuId的库存状态
     */
    @RequestMapping("/ware/waresku/batch")
    public List<SkuStockSearchVo> batchSkuStock(@RequestBody List<Long> ids);


    /**
     * 锁库存
     */
    @GetMapping("/ware/waresku/lockSkuStocks")
    public R lockSkuStocks(@RequestBody List<OrderItemStockLockVo> stockLockVos);
}

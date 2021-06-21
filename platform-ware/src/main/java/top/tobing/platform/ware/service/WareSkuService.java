package top.tobing.platform.ware.service;

import com.baomidou.mybatisplus.extension.service.IService;
import top.tobing.common.to.SkuStockSearchVo;
import top.tobing.common.utils.PageUtils;
import top.tobing.platform.ware.entity.WareSkuEntity;
import top.tobing.platform.ware.vo.OrderItemStockLockVo;
import top.tobing.platform.ware.vo.PurchaseDoneItemVo;

import java.util.List;
import java.util.Map;

/**
 * 商品库存
 *
 * @author tobing
 * @email tobing6379@gmail.com
 * @date 2021-03-29 22:27:14
 */
public interface WareSkuService extends IService<WareSkuEntity> {

    PageUtils queryPage(Map<String, Object> params);

    void addStock(Long skuId, Long wareId, Integer skuNum);

    /**
     * 批量查询sku的库存信息
     */
    List<SkuStockSearchVo> batchSkuStockByIds(List<Long> ids);

    /**
     * 尝试锁库存
     */
    Boolean lockSkuStocks(List<OrderItemStockLockVo> stockLockVos);

    /**
     * 根据skuId和wareId更新skuNum
     */
    void unlockStockBySkuIdAndWareId(Long skuId, Long wareId, Integer skuNum);
}


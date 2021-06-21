package top.tobing.platform.product.service;

import com.baomidou.mybatisplus.extension.service.IService;
import top.tobing.common.utils.PageUtils;
import top.tobing.platform.product.entity.SkuInfoEntity;
import top.tobing.platform.product.vo.SkuItemVo;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

/**
 * sku信息
 *
 * @author tobing
 * @email 652916578@qq.com
 * @date 2021-02-02 21:09:57
 */
public interface SkuInfoService extends IService<SkuInfoEntity> {

    PageUtils queryPage(Map<String, Object> params);

    void saveSkuInfoBase(SkuInfoEntity skuInfoEntity);

    SkuItemVo item(Long skuId);

    List<String> getSkuSaleListBySkuId(Long skuId);

    /**
     * 根据skuId查询商品的价格
     */
    BigDecimal priceBySkuId(Long skuId);

    /**
     * 根据skuId批量查询sku列表
     */
    List<SkuInfoEntity> listBySkuId(List<Long> skuIds);
}


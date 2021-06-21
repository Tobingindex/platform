package top.tobing.platform.coupon.service;

import com.baomidou.mybatisplus.extension.service.IService;
import top.tobing.common.to.SkuFullReductionTo;
import top.tobing.common.utils.PageUtils;
import top.tobing.platform.coupon.entity.SkuFullReductionEntity;

import java.util.Map;

/**
 * 商品满减信息
 *
 * @author tobing
 * @email tobing6379@gmail.com
 * @date 2021-03-09 16:09:33
 */
public interface SkuFullReductionService extends IService<SkuFullReductionEntity> {

    PageUtils queryPage(Map<String, Object> params);

    void saveSkuFullReduction(SkuFullReductionTo skuFullReductionTo);
}


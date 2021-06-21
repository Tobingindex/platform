package top.tobing.platform.product.service;

import com.baomidou.mybatisplus.extension.service.IService;
import top.tobing.common.utils.PageUtils;
import top.tobing.platform.product.entity.SpuInfoEntity;
import top.tobing.platform.product.vo.SpuSaveVo;

import java.util.Map;

/**
 * spu信息
 *
 * @author tobing
 * @email 652916578@qq.com
 * @date 2021-02-02 21:09:57
 */
public interface SpuInfoService extends IService<SpuInfoEntity> {

    PageUtils queryPage(Map<String, Object> params);

    /**
     * 保存SpuSaveVo的所有信息
     */
    void saveSpuSaveVo(SpuSaveVo spuSaveVo);

    /**
     * 商品上架
     */
    void up(Long spuId);

    /**
     * 通过sku查询对应spu信息
     */
    SpuInfoEntity getBySkuId(Long skuId);
}


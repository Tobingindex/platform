package top.tobing.platform.product.vo;

import lombok.Data;
import top.tobing.platform.product.entity.SkuImagesEntity;
import top.tobing.platform.product.entity.SkuInfoEntity;
import top.tobing.platform.product.entity.SpuInfoDescEntity;
import top.tobing.platform.product.entity.SpuInfoEntity;

import java.util.List;

/**
 * @Author tobing
 * @Date 2021/4/14 21:21
 * @Description SKU详情VO
 */
@Data
public class SkuItemVo {
    // sku基本信息
    private SkuInfoEntity skuInfoEntity;
    // 是否有库存
    private Boolean hashStock = true;
    // sku所属spu的介绍信息
    private SpuInfoDescEntity spuInfoDescEntity;
    // sku的图片信息
    private List<SkuImagesEntity> skuImagesEntityList;
    // sku销售属性组合
    private List<SkuItemSaleAttrVo> saleAttrVoList;
    // spu规格参数组合
    private List<SpuItemAttrGroupVo> attrGroupVoList;
    // 商品秒杀信息
    private SkuSeckillVo skuSeckillVo;

}

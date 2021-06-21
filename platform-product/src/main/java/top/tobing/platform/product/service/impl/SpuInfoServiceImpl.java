package top.tobing.platform.product.service.impl;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.transaction.annotation.Transactional;
import top.tobing.common.constant.PlatformProductConstant;
import top.tobing.common.to.SkuFullReductionTo;
import top.tobing.common.to.SkuStockSearchVo;
import top.tobing.common.to.SpuBoundsTo;
import top.tobing.common.to.es.Attrs;
import top.tobing.common.to.es.ProductEsTo;
import top.tobing.common.utils.PageUtils;
import top.tobing.common.utils.Query;

import top.tobing.common.utils.R;
import top.tobing.platform.product.dao.SpuInfoDao;
import top.tobing.platform.product.entity.*;
import top.tobing.platform.product.feign.CouponFeignService;
import top.tobing.platform.product.feign.SearchFeignService;
import top.tobing.platform.product.feign.WareFeignService;
import top.tobing.platform.product.service.*;
import top.tobing.platform.product.vo.*;

@Slf4j
@Service("spuInfoService")
public class SpuInfoServiceImpl extends ServiceImpl<SpuInfoDao, SpuInfoEntity> implements SpuInfoService {

    @Autowired
    private SpuInfoDescService spuInfoDescService;
    @Autowired
    private SpuImagesService spuImagesService;
    @Autowired
    private SkuInfoService skuInfoService;
    @Autowired
    private SkuImagesService skuImagesService;
    @Autowired
    private SkuSaleAttrValueService skuSaleAttrValueService;
    @Autowired
    private CouponFeignService couponFeignService;
    @Autowired
    private BrandService brandService;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private WareFeignService wareFeignService;
    @Autowired
    private AttrService attrService;
    @Autowired
    private ProductAttrValueService productAttrValueService;
    @Autowired
    private SpuInfoService spuInfoService;
    @Autowired
    private SearchFeignService searchFeignService;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        QueryWrapper<SpuInfoEntity> queryWrapper = new QueryWrapper<>();
        // 拼接查询条件
        String key = (String) params.get("key");
        Object catelogId = params.get("catelogId");
        Object brandId = params.get("brandId");
        Object status = params.get("status");
        if (key != null && key.length() > 0) {
            queryWrapper.like("spu_name", key).or().like("spu_description", key);
        }
        if (catelogId != null && !"0".equals(catelogId)) {
            queryWrapper.and(i -> i.eq("catalog_id", catelogId));
        }
        if (brandId != null && !"0".equals(brandId)) {
            queryWrapper.and(i -> i.eq("brand_id", brandId));
        }
        if (status != null) {
            queryWrapper.and(i -> i.eq("publish_status", status));
        }
        IPage<SpuInfoEntity> page = this.page(
                new Query<SpuInfoEntity>().getPage(params), queryWrapper);
        return new PageUtils(page);
    }

    /**
     * 保存SpuSaveVo全部信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveSpuSaveVo(SpuSaveVo spuSaveVo) {
        //1、保存SPU基本信息 pms_spu_info
        SpuInfoEntity spuInfoEntity = new SpuInfoEntity();
        BeanUtils.copyProperties(spuSaveVo, spuInfoEntity);
        spuInfoEntity.setCreateTime(new Date());
        spuInfoEntity.setUpdateTime(new Date());
        this.baseMapper.insert(spuInfoEntity);
        log.info("保存基本信息：{}", spuInfoEntity);

        //2、保存SPU详细信息 pms_spu_info_desc
        List<String> decript = spuSaveVo.getDecript();
        if (decript != null) {
            String desc = String.join(",", decript);
            SpuInfoDescEntity spuInfoDescEntity = new SpuInfoDescEntity();
            spuInfoDescEntity.setSpuId(spuInfoEntity.getId());
            spuInfoDescEntity.setDecript(desc);
            spuInfoDescService.save(spuInfoDescEntity);
            log.info("保存SPU详细信息：{}", spuInfoDescEntity);
        }

        //3、保存SPU图片信息 pms_spu_images
        List<Images> images = spuSaveVo.getImages();
        if (images != null && images.size() > 0) {
            List<SpuImagesEntity> spuImagesEntityList = images.stream().map(item -> {
                SpuImagesEntity imagesEntity = new SpuImagesEntity();
                imagesEntity.setSpuId(spuInfoEntity.getId());
                imagesEntity.setImgName("");
                imagesEntity.setImgUrl(item.getImgUrl());
                imagesEntity.setDefaultImg(item.getDefaultImg());
                imagesEntity.setImgSort(1);
                return imagesEntity;
            }).collect(Collectors.toList());
            spuImagesService.saveBatch(spuImagesEntityList);
            log.info("保存图片信息：{}", spuImagesEntityList);
        }

        //4. 保存商品的属性信息 pms_product_attr_value
        List<BaseAttrs> baseAttrs = spuSaveVo.getBaseAttrs();
        if (baseAttrs != null && baseAttrs.size() != 0) {
            List<ProductAttrValueEntity> collect = baseAttrs.stream().map(item -> {
                ProductAttrValueEntity productAttrValueEntity = new ProductAttrValueEntity();
                productAttrValueEntity.setSpuId(spuInfoEntity.getId());
                productAttrValueEntity.setAttrId(item.getAttrId());
                AttrEntity attrEntity = attrService.getById(item.getAttrId());
                productAttrValueEntity.setAttrName(attrEntity.getAttrName());
                productAttrValueEntity.setAttrValue(item.getAttrValues());
                productAttrValueEntity.setQuickShow(item.getShowDesc());
                return productAttrValueEntity;
            }).collect(Collectors.toList());
            productAttrValueService.saveBatch(collect);
            log.info("保存商品属性信息：{}", collect);
        }


        //5、保存SPU成长信息 sms_spu_bounds【跨服务】
        Bounds bounds = spuSaveVo.getBounds();
        if (bounds != null) {
            SpuBoundsTo spuBoundsTo = new SpuBoundsTo();
            spuBoundsTo.setSpuId(spuInfoEntity.getId());
            spuBoundsTo.setBuyBounds(bounds.getBuyBounds());
            spuBoundsTo.setGrowBounds(bounds.getGrowBounds());
            R r = couponFeignService.saveSpuBounds(spuBoundsTo);
            if ((Integer) r.get("code") != 0) {
                throw new IllegalArgumentException();
            }
            log.info("保存积分信息：{}", spuBoundsTo);
        }


        //6、保存SKU详细信息 pms_sku_info/pms_sku_images
        List<Skus> skus = spuSaveVo.getSkus();
        if (skus != null && skus.size() != 0) {
            for (Skus item : skus) {// 获取默认图片
                String defaultImage = "";
                if (item.getImages() != null && item.getImages().size() != 0) {
                    for (Images image : item.getImages()) {
                        if (image.getDefaultImg() == 1) {
                            defaultImage = image.getImgUrl();
                        }
                    }
                }
                SkuInfoEntity skuInfoEntity = new SkuInfoEntity();
                BeanUtils.copyProperties(item, skuInfoEntity);
                skuInfoEntity.setBrandId(spuSaveVo.getBrandId());
                skuInfoEntity.setCatalogId(spuSaveVo.getCatalogId());
                skuInfoEntity.setSaleCount(0L);
                skuInfoEntity.setSkuDefaultImg(defaultImage);
                // 保存SKU基础信息
                skuInfoService.saveSkuInfoBase(skuInfoEntity);
                log.info("保存SKU基本信息：{}", skuInfoEntity);
                Long skuId = skuInfoEntity.getSkuId();

                List<Attr> attrList = item.getAttr();
                List<SkuSaleAttrValueEntity> skuSaleAttrValueEntityList = attrList.stream().map(attr -> {
                    SkuSaleAttrValueEntity skuSaleAttrValueEntity = new SkuSaleAttrValueEntity();
                    skuSaleAttrValueEntity.setSkuId(skuId);
                    skuSaleAttrValueEntity.setAttrName(attr.getAttrName());
                    skuSaleAttrValueEntity.setAttrValue(attr.getAttrValue());
                    skuSaleAttrValueEntity.setAttrId(attr.getAttrId());
                    return skuSaleAttrValueEntity;
                }).collect(Collectors.toList());
                // 保存SKU销售属性
                skuSaleAttrValueService.saveBatch(skuSaleAttrValueEntityList);
                log.info("保存商品销售属性信息：{}", skuSaleAttrValueEntityList);

                List<SkuImagesEntity> skuImagesEntityList = item.getImages().stream().filter(i -> {
                    return i.getImgUrl() != null && i.getImgUrl().length() > 0; // 过滤空白图片
                }).map(img -> {
                    SkuImagesEntity skuImagesEntity = new SkuImagesEntity();
                    skuImagesEntity.setImgUrl(img.getImgUrl());
                    skuImagesEntity.setDefaultImg(img.getDefaultImg());
                    skuImagesEntity.setSkuId(skuId);
                    return skuImagesEntity;
                }).collect(Collectors.toList());
                // 保存SKU图片信息
                skuImagesService.saveBatch(skuImagesEntityList);
                log.info("保存商品图片信息：{}", skuImagesEntityList);


                SkuFullReductionTo skuFullReductionTo = new SkuFullReductionTo();
                BeanUtils.copyProperties(item, skuFullReductionTo);
                // 保存满减、优惠信息 TODO 没有满减为0，或者
                R r = couponFeignService.saveSkuFullReduction(skuFullReductionTo);
                if ((Integer) r.get("code") != 0) {
                    throw new IllegalArgumentException();
                }
                log.info("保存满减信息：{}", skuFullReductionTo);
            }
        }
    }

    /**
     * 商品上架
     * 1、查询SPU全部信息、SKU下的信息，将其封装到ES实体类中
     * 2、使用ElasticSearch-Client将数据保存到ElasticSearch
     * 3、更新SPU的状态信息
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void up(Long spuId) {
        // 1、查询SPU信息
        SpuInfoEntity spuInfoEntity = getById(spuId);
        // 2、查询品牌、分类信息
        CategoryEntity categoryEntity = categoryService.getById(spuInfoEntity.getCatalogId());
        BrandEntity brandEntity = brandService.getById(spuInfoEntity.getBrandId());
        // 3、查询SKU信息
        List<SkuInfoEntity> skuInfoEntityList = skuInfoService.list(new QueryWrapper<SkuInfoEntity>().eq("spu_id", spuId));
        // 4、查询属性信息【商品的销售属性】
        List<ProductAttrValueEntity> spuAttrValue = productAttrValueService.list(new QueryWrapper<ProductAttrValueEntity>().eq("spu_id", spuId));
        List<Attrs> spuSearchAttrs = null;
        if (spuAttrValue != null && spuAttrValue.size() != 0) {
            // 4.1）、获取属性的所有的id
            List<Long> attrIds = spuAttrValue.stream().map(ProductAttrValueEntity::getAttrId).collect(Collectors.toList());
            // 4.2）、将查询出的商品属性放到数据库查询看是否是属于检索字段
            List<Long> attrEntityList = attrService.getSearchAttrByIds(attrIds);
            // 4.3)、将检索字段封装为Set，便于下面查询使用【Set可以提高查询效率】
            Set<Long> attrIdSet = new HashSet<>(attrEntityList);
            // 4.4）、借助Set查询出可以过滤出可以用于查询的属性信息
            spuSearchAttrs = spuAttrValue.stream().filter(item -> attrIdSet.contains(item.getAttrId())).map(item -> {
                Attrs attrs = new Attrs();
                attrs.setAttrId(item.getAttrId());
                attrs.setAttrName(item.getAttrName());
                attrs.setAttrValue(item.getAttrValue());
                return attrs;
            }).collect(Collectors.toList());
        }

        // 5、远程调用库存服务查询是否有库存【由于库存服务需要调用远程的服务，如果每个sku遍历依次去查询的话，效率很低，因此把总的sku拿到批量查询备用】
        List<Long> ids = skuInfoEntityList.stream().map(SkuInfoEntity::getSkuId).collect(Collectors.toList());
        List<SkuStockSearchVo> stockSearchVos = wareFeignService.batchSkuStock(ids);
        Map<Long, Boolean> map = new HashMap<>();
        if (stockSearchVos != null && !stockSearchVos.isEmpty()) {
            for (SkuStockSearchVo stockSearchVo : stockSearchVos) {
                map.put(stockSearchVo.getSkuId(), stockSearchVo.getStock());
            }
        }

        // 6、封装ES实体信息
        List<Attrs> finalSpuSearchAttrs = spuSearchAttrs;
        List<ProductEsTo> collect = skuInfoEntityList.stream().map(item -> {
            ProductEsTo productEsTo = new ProductEsTo();
            // 设置基础信息
            productEsTo.setSpuId(spuId);
            productEsTo.setSkuId(item.getSkuId());
            productEsTo.setSkuImg(item.getSkuDefaultImg());
            productEsTo.setSkuPrice(item.getPrice());
            productEsTo.setSkuTitle(item.getSkuTitle());
            productEsTo.setSaleCount(item.getSaleCount());
            productEsTo.setBrandId(item.getBrandId());
            productEsTo.setBrandName(brandEntity == null ? "" : brandEntity.getName());
            productEsTo.setBrandImg(brandEntity == null ? "" : brandEntity.getLogo());
            productEsTo.setCatalogId(item.getCatalogId());
            productEsTo.setCatalogName(categoryEntity == null ? "" : categoryEntity.getName());
            productEsTo.setHotScore(0L);
            // 设置库存
            productEsTo.setHasStock(map.get(item.getSkuId()) != null && map.get(item.getSkuId()));
            // 设置属性
            productEsTo.setAttrs(finalSpuSearchAttrs);
            return productEsTo;
        }).collect(Collectors.toList());
        log.info("封装到ES中的信息：{}", collect);
        // 7、调用Search服务保存到ES中
        R esResult = searchFeignService.saveProductESTo(collect);
        if (esResult.get("code").equals(0)) {
            // 8、更新商品的状态信息
            SpuInfoEntity newState = new SpuInfoEntity();
            newState.setId(spuId);
            newState.setUpdateTime(new Date());
            newState.setPublishStatus(PlatformProductConstant.ProductAvailabilityStatus.ON_SHELF.getCode());
            baseMapper.updateStatusById(newState);
        }

    }

    @Override
    public SpuInfoEntity getBySkuId(Long skuId) {
        SkuInfoEntity skuInfoEntity = skuInfoService.getById(skuId);
        return spuInfoService.getById(skuInfoEntity.getSpuId());
    }

}
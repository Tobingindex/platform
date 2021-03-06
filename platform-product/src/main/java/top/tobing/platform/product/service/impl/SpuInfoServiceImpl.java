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
        // ??????????????????
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
     * ??????SpuSaveVo????????????
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveSpuSaveVo(SpuSaveVo spuSaveVo) {
        //1?????????SPU???????????? pms_spu_info
        SpuInfoEntity spuInfoEntity = new SpuInfoEntity();
        BeanUtils.copyProperties(spuSaveVo, spuInfoEntity);
        spuInfoEntity.setCreateTime(new Date());
        spuInfoEntity.setUpdateTime(new Date());
        this.baseMapper.insert(spuInfoEntity);
        log.info("?????????????????????{}", spuInfoEntity);

        //2?????????SPU???????????? pms_spu_info_desc
        List<String> decript = spuSaveVo.getDecript();
        if (decript != null) {
            String desc = String.join(",", decript);
            SpuInfoDescEntity spuInfoDescEntity = new SpuInfoDescEntity();
            spuInfoDescEntity.setSpuId(spuInfoEntity.getId());
            spuInfoDescEntity.setDecript(desc);
            spuInfoDescService.save(spuInfoDescEntity);
            log.info("??????SPU???????????????{}", spuInfoDescEntity);
        }

        //3?????????SPU???????????? pms_spu_images
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
            log.info("?????????????????????{}", spuImagesEntityList);
        }

        //4. ??????????????????????????? pms_product_attr_value
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
            log.info("???????????????????????????{}", collect);
        }


        //5?????????SPU???????????? sms_spu_bounds???????????????
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
            log.info("?????????????????????{}", spuBoundsTo);
        }


        //6?????????SKU???????????? pms_sku_info/pms_sku_images
        List<Skus> skus = spuSaveVo.getSkus();
        if (skus != null && skus.size() != 0) {
            for (Skus item : skus) {// ??????????????????
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
                // ??????SKU????????????
                skuInfoService.saveSkuInfoBase(skuInfoEntity);
                log.info("??????SKU???????????????{}", skuInfoEntity);
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
                // ??????SKU????????????
                skuSaleAttrValueService.saveBatch(skuSaleAttrValueEntityList);
                log.info("?????????????????????????????????{}", skuSaleAttrValueEntityList);

                List<SkuImagesEntity> skuImagesEntityList = item.getImages().stream().filter(i -> {
                    return i.getImgUrl() != null && i.getImgUrl().length() > 0; // ??????????????????
                }).map(img -> {
                    SkuImagesEntity skuImagesEntity = new SkuImagesEntity();
                    skuImagesEntity.setImgUrl(img.getImgUrl());
                    skuImagesEntity.setDefaultImg(img.getDefaultImg());
                    skuImagesEntity.setSkuId(skuId);
                    return skuImagesEntity;
                }).collect(Collectors.toList());
                // ??????SKU????????????
                skuImagesService.saveBatch(skuImagesEntityList);
                log.info("???????????????????????????{}", skuImagesEntityList);


                SkuFullReductionTo skuFullReductionTo = new SkuFullReductionTo();
                BeanUtils.copyProperties(item, skuFullReductionTo);
                // ??????????????????????????? TODO ???????????????0?????????
                R r = couponFeignService.saveSkuFullReduction(skuFullReductionTo);
                if ((Integer) r.get("code") != 0) {
                    throw new IllegalArgumentException();
                }
                log.info("?????????????????????{}", skuFullReductionTo);
            }
        }
    }

    /**
     * ????????????
     * 1?????????SPU???????????????SKU??????????????????????????????ES????????????
     * 2?????????ElasticSearch-Client??????????????????ElasticSearch
     * 3?????????SPU???????????????
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void up(Long spuId) {
        // 1?????????SPU??????
        SpuInfoEntity spuInfoEntity = getById(spuId);
        // 2??????????????????????????????
        CategoryEntity categoryEntity = categoryService.getById(spuInfoEntity.getCatalogId());
        BrandEntity brandEntity = brandService.getById(spuInfoEntity.getBrandId());
        // 3?????????SKU??????
        List<SkuInfoEntity> skuInfoEntityList = skuInfoService.list(new QueryWrapper<SkuInfoEntity>().eq("spu_id", spuId));
        // 4????????????????????????????????????????????????
        List<ProductAttrValueEntity> spuAttrValue = productAttrValueService.list(new QueryWrapper<ProductAttrValueEntity>().eq("spu_id", spuId));
        List<Attrs> spuSearchAttrs = null;
        if (spuAttrValue != null && spuAttrValue.size() != 0) {
            // 4.1??????????????????????????????id
            List<Long> attrIds = spuAttrValue.stream().map(ProductAttrValueEntity::getAttrId).collect(Collectors.toList());
            // 4.2????????????????????????????????????????????????????????????????????????????????????
            List<Long> attrEntityList = attrService.getSearchAttrByIds(attrIds);
            // 4.3)???????????????????????????Set??????????????????????????????Set???????????????????????????
            Set<Long> attrIdSet = new HashSet<>(attrEntityList);
            // 4.4????????????Set?????????????????????????????????????????????????????????
            spuSearchAttrs = spuAttrValue.stream().filter(item -> attrIdSet.contains(item.getAttrId())).map(item -> {
                Attrs attrs = new Attrs();
                attrs.setAttrId(item.getAttrId());
                attrs.setAttrName(item.getAttrName());
                attrs.setAttrValue(item.getAttrValue());
                return attrs;
            }).collect(Collectors.toList());
        }

        // 5???????????????????????????????????????????????????????????????????????????????????????????????????????????????sku????????????????????????????????????????????????????????????sku???????????????????????????
        List<Long> ids = skuInfoEntityList.stream().map(SkuInfoEntity::getSkuId).collect(Collectors.toList());
        List<SkuStockSearchVo> stockSearchVos = wareFeignService.batchSkuStock(ids);
        Map<Long, Boolean> map = new HashMap<>();
        if (stockSearchVos != null && !stockSearchVos.isEmpty()) {
            for (SkuStockSearchVo stockSearchVo : stockSearchVos) {
                map.put(stockSearchVo.getSkuId(), stockSearchVo.getStock());
            }
        }

        // 6?????????ES????????????
        List<Attrs> finalSpuSearchAttrs = spuSearchAttrs;
        List<ProductEsTo> collect = skuInfoEntityList.stream().map(item -> {
            ProductEsTo productEsTo = new ProductEsTo();
            // ??????????????????
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
            // ????????????
            productEsTo.setHasStock(map.get(item.getSkuId()) != null && map.get(item.getSkuId()));
            // ????????????
            productEsTo.setAttrs(finalSpuSearchAttrs);
            return productEsTo;
        }).collect(Collectors.toList());
        log.info("?????????ES???????????????{}", collect);
        // 7?????????Search???????????????ES???
        R esResult = searchFeignService.saveProductESTo(collect);
        if (esResult.get("code").equals(0)) {
            // 8??????????????????????????????
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
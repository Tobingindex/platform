package top.tobing.platform.product.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ThreadPoolExecutor;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import top.tobing.common.utils.PageUtils;
import top.tobing.common.utils.Query;

import top.tobing.platform.product.dao.SkuInfoDao;
import top.tobing.platform.product.entity.SkuImagesEntity;
import top.tobing.platform.product.entity.SkuInfoEntity;
import top.tobing.platform.product.entity.SpuInfoDescEntity;
import top.tobing.platform.product.feign.SeckillFeignService;
import top.tobing.platform.product.service.*;
import top.tobing.platform.product.vo.SkuItemSaleAttrVo;
import top.tobing.platform.product.vo.SkuItemVo;
import top.tobing.platform.product.vo.SkuSeckillVo;
import top.tobing.platform.product.vo.SpuItemAttrGroupVo;


@Service("skuInfoService")
public class SkuInfoServiceImpl extends ServiceImpl<SkuInfoDao, SkuInfoEntity> implements SkuInfoService {

    @Autowired
    private SpuInfoDescService spuInfoDescService;
    @Autowired
    private SkuImagesService skuImagesService;
    @Autowired
    private AttrGroupService attrGroupService;
    @Autowired
    private SkuSaleAttrValueService skuSaleAttrValueService;
    @Autowired
    private SeckillFeignService seckillFeignService;
    @Autowired
    private ThreadPoolExecutor threadPoolExecutor;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        String key = (String) params.get("key");
        String catelogId = (String) params.get("catelogId");
        String brandId = (String) params.get("brandId");
        String min = (String) params.get("min");
        String max = (String) params.get("max");
        // 拼接查询条件
        QueryWrapper<SkuInfoEntity> queryWrapper = new QueryWrapper<>();
        if (key != null && key.length() > 0) {
            queryWrapper.and(i -> i.like("sku_name", key)
                    .or().like("sku_desc", key)
                    .or().like("sku_title", key)
                    .or().like("sku_subtitle", key));
        }
        if (!"0".equals(catelogId)) {
            queryWrapper.and(i -> i.eq("catalog_id", catelogId));
        }
        if (!"0".equals(brandId)) {
            queryWrapper.and(i -> i.eq("brand_id", brandId));
        }
        if (min != null && !"0".equals(min)) {
            try {
                BigDecimal minDec = new BigDecimal(min);
                queryWrapper.and(i -> i.le("price", min));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (max != null && !"0".equals(max)) {
            try {
                BigDecimal minDec = new BigDecimal(max);
                queryWrapper.and(i -> i.le("price", max));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        IPage<SkuInfoEntity> page = this.page(
                new Query<SkuInfoEntity>().getPage(params),
                queryWrapper);

        return new PageUtils(page);
    }

    @Override
    public void saveSkuInfoBase(SkuInfoEntity skuInfoEntity) {
        this.baseMapper.insert(skuInfoEntity);
    }


    @Override
    public SkuItemVo item(Long skuId) {
        SkuItemVo skuItemVo = new SkuItemVo();

        // 异步编排
        // 1-->2、1-->4、1-->5
        // 1-->3
        CompletableFuture<SkuInfoEntity> skuInfoFuture = CompletableFuture.supplyAsync(() -> {
            // 1、sku基本信息 pms_sku_info
            SkuInfoEntity skuInfoEntity = getById(skuId);
            skuItemVo.setSkuInfoEntity(skuInfoEntity);
            return skuInfoEntity;
        }, threadPoolExecutor);

        CompletableFuture<Void> spuInfoDescEntityFuture = skuInfoFuture.thenAcceptAsync((spuInfo) -> {
            // 2、sku所属spu的介绍信息 pms_spu_info_desc
            SpuInfoDescEntity spuInfoDescEntity = spuInfoDescService.getById(spuInfo.getSpuId());
            skuItemVo.setSpuInfoDescEntity(spuInfoDescEntity);
        }, threadPoolExecutor);

        // 3、sku的图片信息 pms_sku_images
        CompletableFuture<List<SkuImagesEntity>> skuImageFuture = CompletableFuture.supplyAsync(() -> {
            List<SkuImagesEntity> skuImagesEntityList =
                    skuImagesService.list(new QueryWrapper<SkuImagesEntity>().eq("sku_id", skuId));
            skuItemVo.setSkuImagesEntityList(skuImagesEntityList);
            return skuImagesEntityList;
        }, threadPoolExecutor);

        // 4、sku销售属性组合
        CompletableFuture<Void> skuItemSaleAttrVoListFuture = skuInfoFuture.thenAcceptAsync((spuInfo) -> {
            List<SkuItemSaleAttrVo> skuItemSaleAttrVoList = skuSaleAttrValueService.getSaleAttrBySpuId(spuInfo.getSpuId());
            skuItemVo.setSaleAttrVoList(skuItemSaleAttrVoList);

        }, threadPoolExecutor);
        // 5、spu规格参数组合
        CompletableFuture<Void> spuItemAttrGroupVoListFuture = skuInfoFuture.thenAcceptAsync((spuInfo) -> {
            List<SpuItemAttrGroupVo> spuItemAttrGroupVoList =
                    attrGroupService.getAttrGroupWithAttrByCatalogIdAndSpuId(spuInfo.getCatalogId(), spuInfo.getSpuId());
            skuItemVo.setAttrGroupVoList(spuItemAttrGroupVoList);
        }, threadPoolExecutor);

        // 6、查询商品的秒杀信息
        CompletableFuture<Void> getSkuSeckillInfo = CompletableFuture.runAsync(() -> {
            SkuSeckillVo skuSeckillVo = seckillFeignService.getSeckillSkuBySkuId(skuId);
            skuItemVo.setSkuSeckillVo(skuSeckillVo);
        }, threadPoolExecutor);

        try {
            CompletableFuture.allOf(spuInfoDescEntityFuture, skuImageFuture, skuItemSaleAttrVoListFuture, spuItemAttrGroupVoListFuture, getSkuSeckillInfo).get();
        } catch (InterruptedException | ExecutionException e) {
            log.error("异步编排查询出现异常：", e);
        }
        return skuItemVo;

    }

    @Override
    public List<String> getSkuSaleListBySkuId(Long skuId) {
        SkuInfoDao skuInfoDao = this.baseMapper;
        return skuInfoDao.getSkuSaleListBySkuId(skuId);
    }

    @Override
    public BigDecimal priceBySkuId(Long skuId) {
        SkuInfoEntity skuInfoEntity = getById(skuId);
        return skuInfoEntity.getPrice();
    }

    @Override
    public List<SkuInfoEntity> listBySkuId(List<Long> skuIds) {
        Collection<SkuInfoEntity> skuInfoEntities = this.listByIds(skuIds);
        return new ArrayList<>(skuInfoEntities);
    }


}
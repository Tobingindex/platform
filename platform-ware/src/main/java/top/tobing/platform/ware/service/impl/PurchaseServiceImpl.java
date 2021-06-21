package top.tobing.platform.ware.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.transaction.annotation.Transactional;
import top.tobing.common.constant.PlatformWareConstant;
import top.tobing.common.utils.PageUtils;
import top.tobing.common.utils.Query;

import top.tobing.common.utils.R;
import top.tobing.platform.ware.dao.PurchaseDao;
import top.tobing.platform.ware.entity.PurchaseDetailEntity;
import top.tobing.platform.ware.entity.PurchaseEntity;
import top.tobing.platform.ware.service.PurchaseDetailService;
import top.tobing.platform.ware.service.PurchaseService;
import top.tobing.platform.ware.service.WareSkuService;
import top.tobing.platform.ware.vo.MergeVo;
import top.tobing.platform.ware.vo.PurchaseDoneItemVo;
import top.tobing.platform.ware.vo.PurchaseDoneVo;


@Service("purchaseService")
public class PurchaseServiceImpl extends ServiceImpl<PurchaseDao, PurchaseEntity> implements PurchaseService {

    @Autowired
    private PurchaseDetailService purchaseDetailService;
    @Autowired
    private WareSkuService wareSkuService;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<PurchaseEntity> page = this.page(
                new Query<PurchaseEntity>().getPage(params),
                new QueryWrapper<PurchaseEntity>()
        );

        return new PageUtils(page);
    }

    @Override
    public PageUtils queryPageUnreceiveList(Map<String, Object> params) {
        QueryWrapper<PurchaseEntity> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("status", PlatformWareConstant.PurchaseDetailStatus.NEW).or().eq("status", PlatformWareConstant.PurchaseDetailStatus.ASSINGED);
        IPage<PurchaseEntity> page = this.page(
                new Query<PurchaseEntity>().getPage(params), queryWrapper);
        return new PageUtils(page);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public R merge(MergeVo mergeVo) {
        // 不存在采购单，创建采购单
        if (mergeVo.getPurchaseId() == null) {
            PurchaseEntity purchaseEntity = new PurchaseEntity();
            purchaseEntity.setCreateTime(new Date());
            purchaseEntity.setUpdateTime(new Date());
            purchaseEntity.setStatus(PlatformWareConstant.PurchaseStatus.NEW.getCode());
            this.save(purchaseEntity);
            mergeVo.setPurchaseId(purchaseEntity.getId());
        }
        Collection<PurchaseDetailEntity> purchaseDetailEntities = purchaseDetailService.listByIds(mergeVo.getItems());

        purchaseDetailEntities.forEach(item -> {
            item.setPurchaseId(mergeVo.getPurchaseId());
            item.setStatus(PlatformWareConstant.PurchaseDetailStatus.ASSINGED.getCode());
        });

        purchaseDetailService.updateBatchById(purchaseDetailEntities);

        return R.ok();
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public R received(List<Long> ids) {
        // 1、更新采购单状态
        Collection<PurchaseEntity> purchaseEntities = this.listByIds(ids);
        List<PurchaseEntity> collect = purchaseEntities.stream().filter(item -> {  // 过滤状态不合法采购单
            return PlatformWareConstant.PurchaseStatus.ASSINGED.getCode().equals(item.getStatus())
                    || PlatformWareConstant.PurchaseStatus.NEW.getCode().equals(item.getStatus());
        }).map(item -> {
            item.setStatus(PlatformWareConstant.PurchaseStatus.RECEIVED.getCode()); // 更新状态
            return item;
        }).collect(Collectors.toList());
        this.updateBatchById(collect);


        // 2、更新采购需求状态
        collect.forEach(item -> {
            // 获取采购需求
            List<PurchaseDetailEntity> detailEntities = purchaseDetailService.listByPurchaseId(item.getId());
            //更新采购需求状态
            List<PurchaseDetailEntity> purchaseDetailEntityList = detailEntities.stream().map(entity -> {
                PurchaseDetailEntity newEntity = new PurchaseDetailEntity();
                newEntity.setId(entity.getId());
                newEntity.setStatus(PlatformWareConstant.PurchaseDetailStatus.PURCHASING.getCode());
                return newEntity;
            }).collect(Collectors.toList());
            if (purchaseDetailEntityList != null && purchaseDetailEntityList.size() != 0) {
                purchaseDetailService.updateBatchById(purchaseDetailEntityList);
            }

        });

        return R.ok();
    }

    @Transactional
    @Override
    public R done(PurchaseDoneVo purchaseDoneVo) {
        // 1、判断采购单状态是否合法
        Long purchaseEntityId = purchaseDoneVo.getId();
        PurchaseEntity purchaseEntity = this.getById(purchaseEntityId);
        if (purchaseEntity == null || !(PlatformWareConstant.PurchaseStatus.RECEIVED.getCode().equals(purchaseEntity.getStatus()))) {
            return R.error("采购单状态异常");
        }
        boolean isFinish = true;
        // 2、更新库存
        for (PurchaseDoneItemVo item : purchaseDoneVo.getItems()) {
            Long detailId = item.getItemId();
            PurchaseDetailEntity entity = purchaseDetailService.getById(detailId);
            if (item.getStatus() == 4) {    // 无采购的情况
                isFinish = false;
                entity.setStatus(PlatformWareConstant.PurchaseDetailStatus.FAILURE.getCode());
            } else if (item.getStatus() == 3) { // 采购成功 ==> 添加库存
                wareSkuService.addStock(entity.getSkuId(), entity.getWareId(), entity.getSkuNum());
                entity.setStatus(PlatformWareConstant.PurchaseDetailStatus.FINISH.getCode());
            }
            // 更新采购需求
            PurchaseDetailEntity purchaseDetailEntity = new PurchaseDetailEntity();
            purchaseDetailEntity.setId(entity.getId());
            purchaseDetailEntity.setStatus(PlatformWareConstant.PurchaseDetailStatus.FINISH.getCode());
            purchaseDetailService.updateById(purchaseDetailEntity);
        }
        // 3、更新采购状态
        purchaseEntity.setStatus(isFinish ? PlatformWareConstant.PurchaseStatus.FINISH.getCode() : PlatformWareConstant.PurchaseStatus.EXCEPTION.getCode());
        purchaseEntity.setUpdateTime(new Date());
        this.updateById(purchaseEntity);
        return R.ok();
    }

}
package top.tobing.platform.ware.service.impl;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import top.tobing.common.utils.PageUtils;
import top.tobing.common.utils.Query;

import top.tobing.platform.ware.dao.PurchaseDetailDao;
import top.tobing.platform.ware.entity.PurchaseDetailEntity;
import top.tobing.platform.ware.service.PurchaseDetailService;


@Service("purchaseDetailService")
public class PurchaseDetailServiceImpl extends ServiceImpl<PurchaseDetailDao, PurchaseDetailEntity> implements PurchaseDetailService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Object key = params.get("key");
        Object status = params.get("status");
        Object wareId = params.get("wareId");
        QueryWrapper<PurchaseDetailEntity> queryWrapper = new QueryWrapper<>();
        // 拼接查询条件
        if (key != null) {
            queryWrapper.and(i -> i.like("purchase_id", key).or().like("sku_id", key).or().like("ware_id", key));
        }
        if (status != null) {
            queryWrapper.and(i -> i.eq("status", status));
        }
        if (wareId != null) {
            queryWrapper.and(i -> i.eq("ware_id", wareId));
        }
        IPage<PurchaseDetailEntity> page = this.page(
                new Query<PurchaseDetailEntity>().getPage(params),
                queryWrapper);

        return new PageUtils(page);
    }

    @Override
    public List<PurchaseDetailEntity> listByPurchaseId(long purchaseId) {
        return this.list(new QueryWrapper<PurchaseDetailEntity>().eq("purchase_id", purchaseId));
    }


}
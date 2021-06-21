package top.tobing.platform.coupon.service.impl;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.util.StringUtils;
import top.tobing.common.utils.PageUtils;
import top.tobing.common.utils.Query;

import top.tobing.platform.coupon.dao.SeckillSkuRelationDao;
import top.tobing.platform.coupon.entity.SeckillSkuRelationEntity;
import top.tobing.platform.coupon.service.SeckillSkuRelationService;


@Service("seckillSkuRelationService")
public class SeckillSkuRelationServiceImpl extends ServiceImpl<SeckillSkuRelationDao, SeckillSkuRelationEntity> implements SeckillSkuRelationService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        QueryWrapper<SeckillSkuRelationEntity> queryWrapper = new QueryWrapper<>();
        String promotionSessionId = (String) params.get("promotionSessionId");
        if (!StringUtils.isEmpty(promotionSessionId)) {
            queryWrapper.eq("promotion_session_id", promotionSessionId);
        }
        Object key = params.get("key");
        if (key != null) {
            queryWrapper.and(item -> item.like("promotion_id", key)
                    .or().like("promotion_session_id", key)
                    .or().like("seckill_count", key)
                    .or().like("seckill_limit", key)
                    .or().like("seckill_price", key));
        }
        IPage<SeckillSkuRelationEntity> page = this.page(
                new Query<SeckillSkuRelationEntity>().getPage(params),
                queryWrapper
        );

        return new PageUtils(page);
    }

    @Override
    public List<SeckillSkuRelationEntity> listByPromotionSessionId(Long id) {
        return this.list(new QueryWrapper<SeckillSkuRelationEntity>().eq("promotion_session_id", id));
    }

}
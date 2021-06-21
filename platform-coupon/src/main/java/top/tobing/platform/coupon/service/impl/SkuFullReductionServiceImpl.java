package top.tobing.platform.coupon.service.impl;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.transaction.annotation.Transactional;
import top.tobing.common.to.MemberPrice;
import top.tobing.common.to.SkuFullReductionTo;
import top.tobing.common.utils.PageUtils;
import top.tobing.common.utils.Query;

import top.tobing.platform.coupon.dao.SkuFullReductionDao;
import top.tobing.platform.coupon.entity.MemberPriceEntity;
import top.tobing.platform.coupon.entity.SkuFullReductionEntity;
import top.tobing.platform.coupon.entity.SkuLadderEntity;
import top.tobing.platform.coupon.service.MemberPriceService;
import top.tobing.platform.coupon.service.SkuFullReductionService;


@Service("skuFullReductionService")
public class SkuFullReductionServiceImpl extends ServiceImpl<SkuFullReductionDao, SkuFullReductionEntity> implements SkuFullReductionService {

    @Autowired
    private MemberPriceService memberPriceService;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<SkuFullReductionEntity> page = this.page(
                new Query<SkuFullReductionEntity>().getPage(params),
                new QueryWrapper<SkuFullReductionEntity>()
        );

        return new PageUtils(page);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveSkuFullReduction(SkuFullReductionTo skuFullReductionTo) {
        // 保存满减信息
        SkuFullReductionEntity skuFullReductionEntity = new SkuFullReductionEntity();
        BeanUtils.copyProperties(skuFullReductionTo, skuFullReductionEntity);
        // 保存折扣信息
        SkuLadderEntity skuLadderEntity = new SkuLadderEntity();
        BeanUtils.copyProperties(skuFullReductionTo, skuLadderEntity);

        // 保存会员优惠信息
        BigDecimal zero = new BigDecimal("0");
        List<MemberPrice> memberPrice = skuFullReductionTo.getMemberPrice();
        if (memberPrice != null && memberPrice.size() != 0) {
            List<MemberPriceEntity> memberPriceEntityList = memberPrice.stream().filter(item -> {
                return (zero.compareTo(item.getPrice()) != 0);
            }).map(member -> {
                MemberPriceEntity memberPriceEntity = new MemberPriceEntity();
                memberPriceEntity.setMemberLevelId(member.getId());
                memberPriceEntity.setMemberLevelName(member.getName());
                memberPriceEntity.setMemberPrice(member.getPrice());
                return memberPriceEntity;
            }).collect(Collectors.toList());
            memberPriceService.saveBatch(memberPriceEntityList);
        }
    }

}
package top.tobing.platform.coupon.service.impl;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.util.CollectionUtils;
import top.tobing.common.utils.PageUtils;
import top.tobing.common.utils.Query;

import top.tobing.platform.coupon.dao.SeckillSessionDao;
import top.tobing.platform.coupon.entity.SeckillSessionEntity;
import top.tobing.platform.coupon.entity.SeckillSkuRelationEntity;
import top.tobing.platform.coupon.service.SeckillSessionService;
import top.tobing.platform.coupon.service.SeckillSkuRelationService;
import top.tobing.platform.coupon.vo.SeckillSessionWithSkusVo;


@Service("seckillSessionService")
public class SeckillSessionServiceImpl extends ServiceImpl<SeckillSessionDao, SeckillSessionEntity> implements SeckillSessionService {

    @Autowired
    private SeckillSkuRelationService skuRelationService;


    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        QueryWrapper<SeckillSessionEntity> queryWrapper = new QueryWrapper<>();
        Object key = params.get("key");
        if (key != null) {
            queryWrapper.like("name", key);
        }
        IPage<SeckillSessionEntity> page = this.page(
                new Query<SeckillSessionEntity>().getPage(params),
                queryWrapper
        );

        return new PageUtils(page);
    }

    @Override
    public List<SeckillSessionWithSkusVo> recently3DaySession() {
        String start = getRecently3DayMin();
        String end = getRecently3DayMax();
        List<SeckillSessionEntity> sessionEntityList =
                this.list(new QueryWrapper<SeckillSessionEntity>().between("start_time", start, end));
        if (!CollectionUtils.isEmpty(sessionEntityList)) {
            List<SeckillSessionWithSkusVo> res = sessionEntityList.stream().map(session -> {
                // 封装活动信息
                SeckillSessionWithSkusVo sessionWithSkusVo = new SeckillSessionWithSkusVo();
                BeanUtils.copyProperties(session, sessionWithSkusVo);
                // 封装商品信息
                List<SeckillSkuRelationEntity> relationEntityList = skuRelationService.listByPromotionSessionId(session.getId());
                sessionWithSkusVo.setRelations(relationEntityList);
                return sessionWithSkusVo;
            }).collect(Collectors.toList());
            return res;
        }
        return null;
    }

    // 获取最近三天的最小时间点
    private String getRecently3DayMin() {
        LocalDate date = LocalDate.now();
        LocalTime time = LocalTime.MIN;
        return LocalDateTime.of(date, time).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }

    // 获取最近三天的最大时间点
    private String getRecently3DayMax() {
        LocalDate date = LocalDate.now().plusDays(2L);
        LocalTime time = LocalTime.MAX;
        return LocalDateTime.of(date, time).format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }

}
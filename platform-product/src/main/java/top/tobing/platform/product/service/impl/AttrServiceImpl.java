package top.tobing.platform.product.service.impl;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.transaction.annotation.Transactional;
import top.tobing.common.utils.PageUtils;
import top.tobing.common.utils.Query;

import top.tobing.platform.product.dao.AttrDao;
import top.tobing.platform.product.entity.AttrAttrgroupRelationEntity;
import top.tobing.platform.product.entity.AttrEntity;
import top.tobing.platform.product.entity.AttrGroupEntity;
import top.tobing.platform.product.service.AttrAttrgroupRelationService;
import top.tobing.platform.product.service.AttrService;
import top.tobing.platform.product.service.CategoryService;
import top.tobing.platform.product.vo.AtrrReqVo;
import top.tobing.platform.product.vo.AttrGroupComplexRespVo;
import top.tobing.platform.product.vo.AttrRespVo;


@Service("attrService")
public class AttrServiceImpl extends ServiceImpl<AttrDao, AttrEntity> implements AttrService {

    @Autowired
    private AttrAttrgroupRelationService attrAttrgroupRelationService;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private AttrService attrService;


    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        String key = (String) params.get("key");
        IPage<AttrEntity> page = this.page(
                new Query<AttrEntity>().getPage(params),
                new QueryWrapper<AttrEntity>().eq("attr_id", key).or().like("attr_name", key)
        );
        return new PageUtils(page);
    }

    @Override
    public PageUtils querySalePage(Map<String, Object> params, Long catelogId) {
        String key =  params.get("key") != null ? (String) params.get("key") : "";
        QueryWrapper<AttrEntity> queryWrapper = null;
        // ????????????
        if (catelogId != 0) {
            queryWrapper = new QueryWrapper<AttrEntity>()
                    .or(i -> i.eq("attr_id", key).or().like("attr_name", key))
                    .and(i -> i.eq("catelog_id", catelogId).eq("attr_type", 0));
        } else {
            // ????????????
            queryWrapper = new QueryWrapper<AttrEntity>()
                    .or(i -> i.eq("attr_id", key).or().like("attr_name", key))
                    .and(i -> i.eq("attr_type", 0));
        }
        IPage<AttrEntity> page = this.page(new Query<AttrEntity>().getPage(params), queryWrapper);
        return new PageUtils(page);
    }

    @Override
    public PageUtils queryBasePage(Map<String, Object> params, Long catelogId) {
        String key = (String) params.get("key");
        QueryWrapper<AttrEntity> queryWrapper = null;
        // ????????????
        if (catelogId != 0) {
            queryWrapper = new QueryWrapper<AttrEntity>()
                    .or(i -> i.eq("attr_id", key).or().like("attr_name", key))
                    .and(i -> i.eq("catelog_id", catelogId).eq("attr_type", 1));
        } else {
            // ????????????
            queryWrapper = new QueryWrapper<AttrEntity>()
                    .or(i -> i.eq("attr_id", key).or().like("attr_name", key))
                    .and(i -> i.eq("attr_type", 1));
        }

        IPage<AttrEntity> page = this.page(new Query<AttrEntity>().getPage(params), queryWrapper);
        return new PageUtils(page);
    }

    @Override
    public AttrRespVo getDetailById(Long attrId) {
        AttrEntity attrEntity = this.getById(attrId);
        AttrRespVo res = new AttrRespVo();
        BeanUtils.copyProperties(attrEntity, res);
        // ????????????????????????
        Long[] path = categoryService.path(res.getCatelogId());
        res.setCatelogPath(path);
        // ????????????id
        AttrAttrgroupRelationEntity relationEntity = attrAttrgroupRelationService.getOne(new QueryWrapper<AttrAttrgroupRelationEntity>().eq("attr_id", attrId));
        if (relationEntity != null) {
            res.setAttrGroupId(relationEntity.getAttrGroupId());
        }
        return res;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateDetailById(AtrrReqVo attr) {
        // ??????????????????
        // ???????????????????????????
        attrAttrgroupRelationService.deleteByAttrId(attr.getAttrId());
        // ????????????????????????
        AttrAttrgroupRelationEntity attrAttrgroupRelationEntity = new AttrAttrgroupRelationEntity();
        attrAttrgroupRelationEntity.setAttrGroupId(attr.getAttrGroupId());
        attrAttrgroupRelationEntity.setAttrId(attr.getAttrId());
        attrAttrgroupRelationService.save(attrAttrgroupRelationEntity);
        // ??????????????????
        AttrEntity attrEntity = new AttrEntity();
        BeanUtils.copyProperties(attr, attrEntity);
        this.updateById(attrEntity);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void saveDetail(AttrRespVo attr) {
        // ??????????????????????????????????????????
        AttrEntity attrEntity = new AttrEntity();
        BeanUtils.copyProperties(attr, attrEntity);
        this.save(attrEntity);
        // ????????????????????????
        AttrAttrgroupRelationEntity attrAttrgroupRelationEntity = new AttrAttrgroupRelationEntity();
        attrAttrgroupRelationEntity.setAttrGroupId(attr.getAttrGroupId());
        attrAttrgroupRelationEntity.setAttrId(attrEntity.getAttrId());
        attrAttrgroupRelationService.save(attrAttrgroupRelationEntity);
    }

    @Override
    public List<AttrEntity> attrRelation(Map<String, Object> params, Long attrgroupId) {
        // ????????????????????????????????????id
        List<AttrAttrgroupRelationEntity> attrAttrGroupList = attrAttrgroupRelationService
                .list(new QueryWrapper<AttrAttrgroupRelationEntity>()
                        .eq("attr_group_id", attrgroupId));
        List<Long> attrIds = attrAttrGroupList.stream().map(attrAttrGroup -> attrAttrGroup.getAttrId()).collect(Collectors.toList());
        // ??????id???????????????????????????
        List<AttrEntity> list = attrService.listByIds(attrIds).stream().collect(Collectors.toList());
        return list;
    }

    @Override
    public PageUtils noattrRelation(Map<String, Object> params, Long attrgroupId) {
        String key = (String) params.get("key");
        // ????????????????????????????????????id
        List<AttrAttrgroupRelationEntity> attrAttrGroupList = attrAttrgroupRelationService
                .list(new QueryWrapper<AttrAttrgroupRelationEntity>()
                        .eq("attr_group_id", attrgroupId));
        // ????????????id???key????????????
        List<Long> attrIds = attrAttrGroupList.stream().map(attrAttrGroup -> attrAttrGroup.getAttrId()).collect(Collectors.toList());
        IPage<AttrEntity> page = this.page(new Query<AttrEntity>().getPage(params), new QueryWrapper<AttrEntity>().or(i -> i.notIn("attr_id", attrIds)).and(i -> i.like("attr_name", key)));
        return new PageUtils(page);
    }

    @Override
    public List<Long> getSearchAttrByIds(List<Long> attrIds) {
        return baseMapper.getSearchAttrByIds(attrIds);
    }
}
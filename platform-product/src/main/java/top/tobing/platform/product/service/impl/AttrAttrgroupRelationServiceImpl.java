package top.tobing.platform.product.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.transaction.annotation.Transactional;
import top.tobing.common.utils.PageUtils;
import top.tobing.common.utils.Query;

import top.tobing.platform.product.dao.AttrAttrgroupRelationDao;
import top.tobing.platform.product.dao.AttrGroupDao;
import top.tobing.platform.product.entity.AttrAttrgroupRelationEntity;
import top.tobing.platform.product.service.AttrAttrgroupRelationService;


@Service("attrAttrgroupRelationService")
public class AttrAttrgroupRelationServiceImpl extends ServiceImpl<AttrAttrgroupRelationDao, AttrAttrgroupRelationEntity> implements AttrAttrgroupRelationService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<AttrAttrgroupRelationEntity> page = this.page(
                new Query<AttrAttrgroupRelationEntity>().getPage(params),
                new QueryWrapper<AttrAttrgroupRelationEntity>()
        );

        return new PageUtils(page);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteByAttrId(Long attrId) {
        this.baseMapper.delete(new QueryWrapper<AttrAttrgroupRelationEntity>().eq("attr_id", attrId));
    }

    @Override
    public void deleteBatch(List<AttrAttrgroupRelationEntity> mapping) {
        for (AttrAttrgroupRelationEntity relationEntity : mapping) {
            this.baseMapper.delete(new QueryWrapper<AttrAttrgroupRelationEntity>()
                    .eq("attr_group_id", relationEntity.getAttrGroupId())
                    .eq("attr_id", relationEntity.getAttrId()));
        }
    }


}
package top.tobing.platform.product.service.impl;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.AbstractList;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.function.Consumer;
import java.util.stream.Collectors;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import top.tobing.common.utils.PageUtils;
import top.tobing.common.utils.Query;

import top.tobing.platform.product.dao.AttrGroupDao;
import top.tobing.platform.product.entity.AttrAttrgroupRelationEntity;
import top.tobing.platform.product.entity.AttrEntity;
import top.tobing.platform.product.entity.AttrGroupEntity;
import top.tobing.platform.product.service.AttrAttrgroupRelationService;
import top.tobing.platform.product.service.AttrGroupService;
import top.tobing.platform.product.service.AttrService;
import top.tobing.platform.product.service.CategoryService;
import top.tobing.platform.product.vo.AttrGroupComplexRespVo;
import top.tobing.platform.product.vo.AttrGroupRespVo;
import top.tobing.platform.product.vo.SpuItemAttrGroupVo;


@Service("attrGroupService")
public class AttrGroupServiceImpl extends ServiceImpl<AttrGroupDao, AttrGroupEntity> implements AttrGroupService {


    @Autowired
    private CategoryService categoryService;

    @Autowired
    private AttrService attrService;

    @Autowired
    private AttrAttrgroupRelationService attrAttrgroupRelationService;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<AttrGroupEntity> page = this.page(
                new Query<AttrGroupEntity>().getPage(params),
                new QueryWrapper<AttrGroupEntity>()
        );

        return new PageUtils(page);
    }

    @Override
    public PageUtils queryPage(Map<String, Object> params, Long categoryId) {
        String key = params.get("key") == null ? "" : (String) params.get("key");
        QueryWrapper<AttrGroupEntity> wrapper = new QueryWrapper<AttrGroupEntity>()
                .or(i -> i.eq("attr_group_id", key).or()
                        .like("attr_group_name", key).or()
                        .like("descript", key));
        // 分类id为0时，查询所有
        if (categoryId == 0) {
            IPage<AttrGroupEntity> page = this.page(
                    new Query<AttrGroupEntity>().getPage(params),
                    wrapper
            );
            return new PageUtils(page);
        } else { // 否则根据categoryId 查询
            IPage<AttrGroupEntity> page = this.page(
                    new Query<AttrGroupEntity>().getPage(params),
                    wrapper.and(i -> i.eq("catelog_id", categoryId))
            );
            Long[] path = categoryService.path(categoryId);

            return new PageUtils(page);
        }

    }

    @Override
    public AttrGroupRespVo getDetailById(Long attrGroupId) {
        AttrGroupEntity entity = getById(attrGroupId);
        AttrGroupRespVo attrGroupRespVo = new AttrGroupRespVo();
        BeanUtils.copyProperties(entity, attrGroupRespVo);
        Long[] path = categoryService.path(entity.getCatelogId());
        attrGroupRespVo.setCatelogPath(path);
        return attrGroupRespVo;
    }

    @Override
    public List<AttrGroupComplexRespVo> getAttrDetailsByCategoryId(Long catelogId) {
        // 根据分类id获取熟悉组
        List<AttrGroupEntity> attrGroupEntityList =
                list(new QueryWrapper<AttrGroupEntity>().eq("catelog_id", catelogId));
        List<AttrGroupComplexRespVo> res = attrGroupEntityList.stream().map(item -> {
            AttrGroupComplexRespVo complexRespVo = new AttrGroupComplexRespVo();
            BeanUtils.copyProperties(item, complexRespVo);
            return complexRespVo;
        }).collect(Collectors.toList());

        // 遍历属性组获取其属性
        res.forEach(item -> {
            Long attrGroupId = item.getAttrGroupId();
            //  根据id查询分组信息
            List<Long> attrIds = attrAttrgroupRelationService
                    .list(new QueryWrapper<AttrAttrgroupRelationEntity>().eq("attr_group_id", attrGroupId))
                    .stream().map(AttrAttrgroupRelationEntity::getAttrId).collect(Collectors.toList());
            if (attrIds != null && !attrIds.isEmpty()) {
                List<AttrEntity> attrEntityList = attrService.listByIds(attrIds).stream().collect(Collectors.toList());
                item.setAttrs(attrEntityList);
            } else {
                item.setAttrs(new ArrayList<AttrEntity>());
            }
        });

        return res;
    }

    @Override
    public List<SpuItemAttrGroupVo> getAttrGroupWithAttrByCatalogIdAndSpuId(Long catalogId, Long spuId) {
        return this.baseMapper.getAttrGroupWithAttrByCatalogIdAndSpuId(catalogId, spuId);
    }


}
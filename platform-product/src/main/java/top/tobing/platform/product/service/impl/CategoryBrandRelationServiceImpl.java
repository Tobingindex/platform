package top.tobing.platform.product.service.impl;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.transaction.annotation.Transactional;
import top.tobing.common.utils.PageUtils;
import top.tobing.common.utils.Query;

import top.tobing.platform.product.dao.CategoryBrandRelationDao;
import top.tobing.platform.product.entity.BrandEntity;
import top.tobing.platform.product.entity.CategoryBrandRelationEntity;
import top.tobing.platform.product.entity.CategoryEntity;
import top.tobing.platform.product.service.BrandService;
import top.tobing.platform.product.service.CategoryBrandRelationService;
import top.tobing.platform.product.service.CategoryService;
import top.tobing.platform.product.vo.BrandRespVo;
import top.tobing.platform.product.vo.CategoryRespVo;


@Service("categoryBrandRelationService")
public class CategoryBrandRelationServiceImpl extends ServiceImpl<CategoryBrandRelationDao, CategoryBrandRelationEntity> implements CategoryBrandRelationService {

    @Autowired
    private CategoryService categoryService;
    @Autowired
    private BrandService brandService;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<CategoryBrandRelationEntity> page = this.page(
                new Query<CategoryBrandRelationEntity>().getPage(params),
                new QueryWrapper<CategoryBrandRelationEntity>()
        );

        return new PageUtils(page);
    }

    @Override
    public List<CategoryBrandRelationEntity> catelogList(Long brandId) {
        List<CategoryBrandRelationEntity> categories = this.list(new QueryWrapper<CategoryBrandRelationEntity>().eq("brand_id", brandId));
        return categories;
    }

    /**
     * 对于冗余字段，在保存时需要单独去查询对应的名称
     * 对于冗余字段，在更新时需要去单独更新维护
     *
     * @param categoryBrandRelation 分类品牌映射信息
     */
    @Override
    @Transactional
    public void saveDetail(CategoryBrandRelationEntity categoryBrandRelation) {
        // 获取分类名称、品牌名称用于保存冗余字段
        Long brandId = categoryBrandRelation.getBrandId();
        Long catelogId = categoryBrandRelation.getCatelogId();
        CategoryEntity categoryEntity = categoryService.getById(catelogId);
        BrandEntity brandEntity = brandService.getById(brandId);

        categoryBrandRelation.setBrandName(brandEntity.getName());
        categoryBrandRelation.setCatelogName(categoryEntity.getName());
        this.save(categoryBrandRelation);
    }

    @Override
    public List<BrandRespVo> getBrandListByCategoryId(Long categoryId) {
        // 获取分类下的关联信息
        List<CategoryBrandRelationEntity> categoryBrandRelationEntityList =
                list(new QueryWrapper<CategoryBrandRelationEntity>().eq("catelog_id", categoryId));
        // 提取品牌信息
        List<BrandRespVo> res = categoryBrandRelationEntityList.stream().map(item -> {
            BrandRespVo entity = new BrandRespVo();
            entity.setBrandId(item.getBrandId());
            entity.setBrandName(item.getBrandName());
            return entity;
        }).collect(Collectors.toList());
        return res;
    }


}
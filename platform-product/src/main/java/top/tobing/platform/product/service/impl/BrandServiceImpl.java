package top.tobing.platform.product.service.impl;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.transaction.annotation.Transactional;
import top.tobing.common.utils.PageUtils;
import top.tobing.common.utils.Query;

import top.tobing.platform.product.dao.BrandDao;
import top.tobing.platform.product.dao.CategoryBrandRelationDao;
import top.tobing.platform.product.entity.BrandEntity;
import top.tobing.platform.product.service.BrandService;
import top.tobing.platform.product.vo.BrandReqVo;


@Service("brandService")
public class BrandServiceImpl extends ServiceImpl<BrandDao, BrandEntity> implements BrandService {

    @Autowired
    private CategoryBrandRelationDao categoryBrandRelationDao;


    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        String key = (String) params.get("key");
        IPage<BrandEntity> page = this.page(
                new Query<BrandEntity>().getPage(params),
                new QueryWrapper<BrandEntity>().eq("brand_id", key)
                        .or().like("name", key)
                        .or().like("descript", key)
        );
        return new PageUtils(page);
    }

    @Override
    public void updateStatusById(BrandReqVo brand) {
        BrandEntity brandEntity = new BrandEntity();
        BeanUtils.copyProperties(brand, brandEntity);
        this.update(brandEntity, new QueryWrapper<BrandEntity>().eq("brand_id", brand.getBrandId()));
    }

    @Override
    @Transactional
    public void updateCascade(BrandEntity brand) {
        this.updateById(brand);
        categoryBrandRelationDao.updateByrandNameByBrandId(brand.getBrandId(), brand.getName());
    }

}
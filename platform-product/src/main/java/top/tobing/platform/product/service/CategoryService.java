package top.tobing.platform.product.service;

import com.baomidou.mybatisplus.extension.service.IService;
import top.tobing.common.utils.PageUtils;
import top.tobing.platform.product.entity.CategoryEntity;
import top.tobing.platform.product.vo.Catalog2Vo;

import java.util.List;
import java.util.Map;

/**
 * 商品三级分类
 *
 * @author tobing
 * @email 652916578@qq.com
 * @date 2021-02-02 21:09:57
 */
public interface CategoryService extends IService<CategoryEntity> {

    PageUtils queryPage(Map<String, Object> params);

    List<CategoryEntity> queryListByTree();


    /**
     * 根据分类id查询三级分类的完整路径
     *
     * @param catelogId
     * @return
     */
    Long[] path(Long catelogId);

    /**
     * 级联更新冗余字段
     *
     * @param category
     */
    void updateCascade(CategoryEntity category);

    /**
     * 获取第一级分类
     */
    List<CategoryEntity> getLevel1Categories();

    /**
     * 获取二级、三级分类信息
     */
    Map<String, List<Catalog2Vo>> getCatalogJsonWithRedissonLock();
}


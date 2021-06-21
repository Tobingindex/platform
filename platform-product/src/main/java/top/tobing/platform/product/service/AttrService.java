package top.tobing.platform.product.service;

import com.baomidou.mybatisplus.extension.service.IService;
import top.tobing.common.utils.PageUtils;
import top.tobing.platform.product.entity.AttrEntity;
import top.tobing.platform.product.vo.AtrrReqVo;
import top.tobing.platform.product.vo.AttrGroupComplexRespVo;
import top.tobing.platform.product.vo.AttrRespVo;

import java.util.List;
import java.util.Map;

/**
 * 商品属性
 *
 * @author tobing
 * @email 652916578@qq.com
 * @date 2021-02-02 21:09:57
 */
public interface AttrService extends IService<AttrEntity> {

    PageUtils queryPage(Map<String, Object> params);


    /**
     * 分页查询销售属性
     *
     * @param params
     * @param catelogId
     * @return
     */
    PageUtils querySalePage(Map<String, Object> params, Long catelogId);

    /**
     * 分页查询基础属性
     *
     * @param params
     * @param catelogId
     * @return
     */
    PageUtils queryBasePage(Map<String, Object> params, Long catelogId);

    /**
     * 根据属性id查询属性详情
     *
     * @param attrId 属性id
     * @return 属性详情
     */
    AttrRespVo getDetailById(Long attrId);

    /**
     * 根据属性id更新属性
     *
     * @param attr
     */
    void updateDetailById(AtrrReqVo attr);

    /**
     * 保存属性信息
     *
     * @param attr 属性
     */
    void saveDetail(AttrRespVo attr);

    List<AttrEntity> attrRelation(Map<String, Object> params, Long attrgroupId);

    PageUtils noattrRelation(Map<String, Object> params, Long attrgroupId);


    /**
     * 查询出ids属性中为搜索信息的属性
     */
    List<Long> getSearchAttrByIds(List<Long> attrIds);
}


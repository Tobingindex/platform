package top.tobing.platform.product.service;

import com.baomidou.mybatisplus.extension.service.IService;
import top.tobing.common.utils.PageUtils;
import top.tobing.platform.product.entity.BrandEntity;
import top.tobing.platform.product.vo.BrandReqVo;

import java.util.Map;

/**
 * 品牌
 *
 * @author tobing
 * @email 652916578@qq.com
 * @date 2021-02-02 21:09:57
 */
public interface BrandService extends IService<BrandEntity> {

    PageUtils queryPage(Map<String, Object> params);



    void updateStatusById(BrandReqVo brand);

    /**
     * 级联更新，更新冗余字段
     * @param brand
     */
    void updateCascade(BrandEntity brand);
}


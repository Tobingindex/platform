package top.tobing.platform.product.service;

import com.baomidou.mybatisplus.extension.service.IService;
import top.tobing.common.utils.PageUtils;
import top.tobing.platform.product.entity.BannerEntity;

import java.util.List;
import java.util.Map;

/**
 * 商品-广告表
 *
 * @author tobing
 * @email 652916578@qq.com
 * @date 2021-02-02 21:09:57
 */
public interface BannerService extends IService<BannerEntity> {

    PageUtils queryPage(Map<String, Object> params);

    /**
     * 查询首页广告列表
     */
    List<BannerEntity> listIndexBanner();
}


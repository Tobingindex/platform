package top.tobing.platform.ware.service;

import com.baomidou.mybatisplus.extension.service.IService;
import top.tobing.common.utils.PageUtils;
import top.tobing.common.utils.R;
import top.tobing.platform.ware.entity.PurchaseEntity;
import top.tobing.platform.ware.vo.MergeVo;
import top.tobing.platform.ware.vo.PurchaseDoneVo;

import java.util.List;
import java.util.Map;

/**
 * 采购信息
 *
 * @author tobing
 * @email tobing6379@gmail.com
 * @date 2021-03-29 22:27:14
 */
public interface PurchaseService extends IService<PurchaseEntity> {

    PageUtils queryPage(Map<String, Object> params);

    PageUtils queryPageUnreceiveList(Map<String, Object> params);

    R merge(MergeVo mergeVo);

    R received(List<Long> ids);

    R done(PurchaseDoneVo purchaseDoneVo);
}


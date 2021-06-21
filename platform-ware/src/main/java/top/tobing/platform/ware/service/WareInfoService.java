package top.tobing.platform.ware.service;

import com.baomidou.mybatisplus.extension.service.IService;
import top.tobing.common.utils.PageUtils;
import top.tobing.platform.ware.entity.WareInfoEntity;
import top.tobing.platform.ware.vo.FareVo;

import java.util.Map;

/**
 * 仓库信息
 *
 * @author tobing
 * @email tobing6379@gmail.com
 * @date 2021-03-29 22:27:14
 */
public interface WareInfoService extends IService<WareInfoEntity> {

    PageUtils queryPage(Map<String, Object> params);

    /**
     * 根据用户地址运算运费信息
     */
    FareVo fareByAddrId(Long addrId);
}


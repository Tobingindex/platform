package top.tobing.platform.ware.service.impl;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import top.tobing.common.utils.PageUtils;
import top.tobing.common.utils.Query;

import top.tobing.platform.ware.dao.WareOrderTaskDetailDao;
import top.tobing.platform.ware.entity.WareOrderTaskDetailEntity;
import top.tobing.platform.ware.service.WareOrderTaskDetailService;


@Service("wareOrderTaskDetailService")
public class WareOrderTaskDetailServiceImpl extends ServiceImpl<WareOrderTaskDetailDao, WareOrderTaskDetailEntity> implements WareOrderTaskDetailService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<WareOrderTaskDetailEntity> page = this.page(
                new Query<WareOrderTaskDetailEntity>().getPage(params),
                new QueryWrapper<WareOrderTaskDetailEntity>()
        );

        return new PageUtils(page);
    }

    @Override
    public List<WareOrderTaskDetailEntity> listByTaskId(Long taskId) {
        return list(new QueryWrapper<WareOrderTaskDetailEntity>().eq("task_id", taskId));
    }

    @Override
    public Integer updateLockStatusToUnlock(Long id) {
        return this.baseMapper.updateLockStatusToUnlock(id);
    }

}
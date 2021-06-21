package top.tobing.platform.member.service;

import com.baomidou.mybatisplus.extension.service.IService;
import top.tobing.common.utils.PageUtils;
import top.tobing.platform.member.entity.IntegrationChangeHistoryEntity;

import java.util.Map;

/**
 * 积分变化历史记录
 *
 * @author tobing
 * @email tobing6379@gmail.com
 * @date 2021-03-07 21:14:09
 */
public interface IntegrationChangeHistoryService extends IService<IntegrationChangeHistoryEntity> {

    PageUtils queryPage(Map<String, Object> params);
}


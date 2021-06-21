package top.tobing.platform.member.service;

import com.baomidou.mybatisplus.extension.service.IService;
import top.tobing.common.to.MemberRespVo;
import top.tobing.common.utils.PageUtils;
import top.tobing.platform.member.entity.MemberEntity;
import top.tobing.platform.member.vo.MemberLoginVo;
import top.tobing.platform.member.vo.MemberRegisterVo;

import java.util.Map;

/**
 * 会员
 *
 * @author tobing
 * @email tobing6379@gmail.com
 * @date 2021-03-07 21:14:09
 */
public interface MemberService extends IService<MemberEntity> {

    PageUtils queryPage(Map<String, Object> params);

    /**
     * 会员注册
     */
    void register(MemberRegisterVo memberRegisterVo) throws Exception;

    /**
     * 会员登录
     */
    MemberRespVo login(MemberLoginVo memberLoginVo);
}


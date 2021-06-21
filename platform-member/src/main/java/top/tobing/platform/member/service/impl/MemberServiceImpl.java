package top.tobing.platform.member.service.impl;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.Map;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.transaction.annotation.Transactional;
import top.tobing.common.to.MemberRespVo;
import top.tobing.common.utils.PageUtils;
import top.tobing.common.utils.Query;

import top.tobing.platform.member.dao.MemberDao;
import top.tobing.platform.member.entity.MemberEntity;
import top.tobing.platform.member.exception.AccountOrPasswordException;
import top.tobing.platform.member.exception.PhoneExistException;
import top.tobing.platform.member.exception.UserExistException;
import top.tobing.platform.member.service.MemberLevelService;
import top.tobing.platform.member.service.MemberService;
import top.tobing.platform.member.vo.MemberLoginVo;
import top.tobing.platform.member.vo.MemberRegisterVo;


@Service("memberService")
public class MemberServiceImpl extends ServiceImpl<MemberDao, MemberEntity> implements MemberService {


    @Autowired
    private MemberLevelService memberLevelService;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<MemberEntity> page = this.page(
                new Query<MemberEntity>().getPage(params),
                new QueryWrapper<MemberEntity>()
        );

        return new PageUtils(page);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void register(MemberRegisterVo memberRegisterVo) throws Exception {
        MemberDao memberDao = this.baseMapper;
        // 判断用户名、手机号合法性
        int usernameFlag = checkUsernameUnique(memberRegisterVo.getUsername());
        if (usernameFlag > 0) {
            throw new UserExistException();
        }
        int phoneFlag = checkPhoneUnique(memberRegisterVo.getPhone());
        if (phoneFlag > 0) {
            throw new PhoneExistException();
        }
        // 保存数据
        MemberEntity memberEntity = new MemberEntity();
        memberEntity.setCreateTime(new Date());
        memberEntity.setMobile(memberRegisterVo.getPhone());
        memberEntity.setUsername(memberRegisterVo.getUsername());
        // 对明文密码进行加密
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        String encodePassword = passwordEncoder.encode(memberRegisterVo.getPassword());
        memberEntity.setPassword(encodePassword);
        // 查询默认会员等级
        Long defaultLevelId = memberLevelService.getDefaultLevelId();
        memberEntity.setLevelId(defaultLevelId);

        // 保存数据库
        memberDao.insert(memberEntity);
    }

    @Override
    public MemberRespVo login(MemberLoginVo memberLoginVo) {
        // 根据手机号或用户名查询用户
        MemberDao memberDao = this.baseMapper;
        MemberEntity memberEntity = memberDao.selectOne(new QueryWrapper<MemberEntity>()
                .eq("mobile", memberLoginVo.getAccount()).or()
                .eq("username", memberLoginVo.getAccount()));
        if (memberEntity == null) {
            throw new AccountOrPasswordException();
        }
        // 对比原文与密文
        String passwordDB = memberEntity.getPassword();
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        if (!passwordEncoder.matches(memberLoginVo.getPassword(), passwordDB)) {
            throw new AccountOrPasswordException();
        }
        MemberRespVo memberRespVo = new MemberRespVo();
        BeanUtils.copyProperties(memberEntity, memberRespVo);
        return memberRespVo;
    }

    private int checkPhoneUnique(String phone) {
        return this.count(new QueryWrapper<MemberEntity>().eq("mobile", phone));
    }

    private int checkUsernameUnique(String username) {
        return this.count(new QueryWrapper<MemberEntity>().eq("username", username));
    }

}
package top.tobing.platform.ware.service.impl;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Map;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import top.tobing.common.utils.PageUtils;
import top.tobing.common.utils.Query;

import top.tobing.platform.ware.dao.WareInfoDao;
import top.tobing.platform.ware.entity.WareInfoEntity;
import top.tobing.platform.ware.feign.MemberFeignService;
import top.tobing.platform.ware.service.WareInfoService;
import top.tobing.platform.ware.vo.FareVo;
import top.tobing.platform.ware.vo.MemberAddressVo;


@Service("wareInfoService")
public class WareInfoServiceImpl extends ServiceImpl<WareInfoDao, WareInfoEntity> implements WareInfoService {

    @Autowired
    private MemberFeignService memberFeignService;

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        String key = (String) params.get("key");
        QueryWrapper<WareInfoEntity> queryWrapper = new QueryWrapper<>();
        if (!StringUtils.isEmpty(key)) {
            queryWrapper.or().like("name", key).or().like("address", key).or().like("areacode", key);
        }
        // 拼接查询条件
        IPage<WareInfoEntity> page = this.page(
                new Query<WareInfoEntity>().getPage(params),
                queryWrapper
        );

        return new PageUtils(page);
    }

    @Override
    public FareVo fareByAddrId(Long addrId) {
        FareVo fareVo = new FareVo();

        // 查询用户地址信息
        MemberAddressVo memberAddressVo = memberFeignService.getById(addrId);
        fareVo.setAddress(memberAddressVo);
        // 计算运费
//        int fare = (int) (System.currentTimeMillis() % 100);
        int fare = 9;
        fareVo.setFare(new BigDecimal(fare));
        return fareVo;
    }

}
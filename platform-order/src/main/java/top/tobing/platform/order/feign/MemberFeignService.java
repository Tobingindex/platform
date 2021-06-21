package top.tobing.platform.order.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import top.tobing.platform.order.vo.MemberAddressVo;

import java.util.List;

/**
 * @Author tobing
 * @Date 2021/4/23 21:11
 * @Description
 */
@FeignClient("platform-member")
public interface MemberFeignService {
    /**
     * 查询用户的收货地址列表
     */
    @GetMapping("/member/memberreceiveaddress/address/{userId}")
    public List<MemberAddressVo> addressList(@PathVariable("userId") Long userId);

    /**
     * 根据地址id查询地址详细信息
     */
    @GetMapping("/member/memberreceiveaddress/addrinfo/{addrId}")
    public MemberAddressVo getById(@PathVariable("addrId") Long addrId);
}

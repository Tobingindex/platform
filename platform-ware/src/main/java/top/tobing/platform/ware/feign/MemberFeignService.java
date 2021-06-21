package top.tobing.platform.ware.feign;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import top.tobing.platform.ware.vo.MemberAddressVo;

/**
 * @Author tobing
 * @Date 2021/4/24 11:50
 * @Description
 */
@FeignClient("platform-member")
public interface MemberFeignService {
    /**
     * 根据addrId查询
     */
    @GetMapping("/member/memberreceiveaddress/addrinfo/{addrId}")
    public MemberAddressVo getById(@PathVariable("addrId") Long addrId);
}

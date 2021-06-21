package top.tobing.platform.member.controller;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import top.tobing.platform.member.entity.MemberReceiveAddressEntity;
import top.tobing.platform.member.service.MemberReceiveAddressService;
import top.tobing.common.utils.PageUtils;
import top.tobing.common.utils.R;


/**
 * 会员收货地址
 *
 * @author tobing
 * @email tobing6379@gmail.com
 * @date 2021-03-07 21:14:08
 */
@RestController
@RequestMapping("member/memberreceiveaddress")
public class MemberReceiveAddressController {
    @Autowired
    private MemberReceiveAddressService memberReceiveAddressService;

    /**
     * 根据addrId查询【远程调用】
     */
    @GetMapping("/addrinfo/{addrId}")
    public MemberReceiveAddressEntity getById(@PathVariable("addrId") Long addrId) {
        return memberReceiveAddressService.addressListByAddrId(addrId);
    }

    /**
     * 查询用户的收货地址列表【远程调用】
     */
    @GetMapping("/address/{userId}")
    public List<MemberReceiveAddressEntity> addressList(@PathVariable("userId") Long userId) {
        return memberReceiveAddressService.addressListByUserId(userId);
    }


    /**
     * 列表
     */
    @RequestMapping("/list")
    //@RequiresPermissions("member:memberreceiveaddress:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = memberReceiveAddressService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    //@RequiresPermissions("member:memberreceiveaddress:info")
    public R info(@PathVariable("id") Long id) {
        MemberReceiveAddressEntity memberReceiveAddress = memberReceiveAddressService.getById(id);

        return R.ok().put("memberReceiveAddress", memberReceiveAddress);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    //@RequiresPermissions("member:memberreceiveaddress:save")
    public R save(@RequestBody MemberReceiveAddressEntity memberReceiveAddress) {
        memberReceiveAddressService.save(memberReceiveAddress);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    //@RequiresPermissions("member:memberreceiveaddress:update")
    public R update(@RequestBody MemberReceiveAddressEntity memberReceiveAddress) {
        memberReceiveAddressService.updateById(memberReceiveAddress);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    //@RequiresPermissions("member:memberreceiveaddress:delete")
    public R delete(@RequestBody Long[] ids) {
        memberReceiveAddressService.removeByIds(Arrays.asList(ids));

        return R.ok();
    }

}

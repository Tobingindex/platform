package top.tobing.platform.ware.controller;

import java.util.Arrays;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import top.tobing.platform.ware.entity.WareInfoEntity;
import top.tobing.platform.ware.service.WareInfoService;
import top.tobing.common.utils.PageUtils;
import top.tobing.common.utils.R;
import top.tobing.platform.ware.vo.FareVo;


/**
 * 仓库信息
 *
 * @author tobing
 * @email tobing6379@gmail.com
 * @date 2021-03-29 22:27:14
 */
@RestController
@RequestMapping("ware/wareinfo")
public class WareInfoController {
    @Autowired
    private WareInfoService wareInfoService;


    /**
     * 根据addrId查询收货信息【地址+运费】
     */
    @GetMapping("/farejson")
    public FareVo farejson(@RequestParam("addrId") Long addrId) {
        FareVo fareVo = wareInfoService.fareByAddrId(addrId);
        return fareVo;
    }


    /**
     * 查询指定地址的运费信息
     */
    @GetMapping("/fare")
    public R fare(@RequestParam("addrId") Long addrId) {
        FareVo fareVo = wareInfoService.fareByAddrId(addrId);
        return R.ok().put("data", fareVo);
    }


    /**
     * 列表
     */
    @RequestMapping("/list")
    //@RequiresPermissions("ware:wareinfo:list")
    public R list(@RequestParam Map<String, Object> params) {
        PageUtils page = wareInfoService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    //@RequiresPermissions("ware:wareinfo:info")
    public R info(@PathVariable("id") Long id) {
        WareInfoEntity wareInfo = wareInfoService.getById(id);

        return R.ok().put("wareInfo", wareInfo);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    //@RequiresPermissions("ware:wareinfo:save")
    public R save(@RequestBody WareInfoEntity wareInfo) {
        wareInfoService.save(wareInfo);

        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    //@RequiresPermissions("ware:wareinfo:update")
    public R update(@RequestBody WareInfoEntity wareInfo) {
        wareInfoService.updateById(wareInfo);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    //@RequiresPermissions("ware:wareinfo:delete")
    public R delete(@RequestBody Long[] ids) {
        wareInfoService.removeByIds(Arrays.asList(ids));

        return R.ok();
    }

}

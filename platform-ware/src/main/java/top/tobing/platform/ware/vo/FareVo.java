package top.tobing.platform.ware.vo;

import lombok.Data;

import java.math.BigDecimal;

/**
 * @Author tobing
 * @Date 2021/4/24 11:44
 * @Description 运费相关信息
 */
@Data
public class FareVo {
    // 用户地址信息
    private MemberAddressVo address;
    // 运费
    private BigDecimal fare;
}

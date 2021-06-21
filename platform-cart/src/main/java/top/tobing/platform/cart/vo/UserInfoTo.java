package top.tobing.platform.cart.vo;

import lombok.Data;
import lombok.ToString;

/**
 * @Author tobing
 * @Date 2021/4/19 17:20
 * @Description 用来保存用户的登录信息
 */
@ToString
@Data
public class UserInfoTo {
    // 对应数据库的用户记录
    private Long userId;
    // 浏览器的用户身份标识
    private String userKey;
    // 临时标识
    private Boolean isTemp = false;
}

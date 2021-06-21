package top.tobing.platform.auth.vo;

import lombok.Data;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotEmpty;

/**
 * @Author tobing
 * @Date 2021/4/16 21:42
 * @Description
 */
@Data
public class UserLoginVo {
    @NotEmpty(message = "用户名必须填写")
    @Length(min = 6, max = 18, message = "用户名必须是6-18个字符")
    private String account;

    @NotEmpty(message = "密码必须填写")
    @Length(min = 6, max = 18, message = "密码必须是6-18个字符")
    private String password;
}

package top.tobing.platform.auth.vo;


import lombok.Data;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;

/**
 * @Author tobing
 * @Date 2021/4/15 21:15
 * @Description User Register View Object
 * Use JSR303 Validation
 */
@Data
public class UserRegisterVo {

    @NotEmpty(message = "用户名必须填写")
    @Length(min = 6, max = 18, message = "用户名必须是6-18个字符")
    private String username;

    @NotEmpty(message = "用户名必须填写")
    @Length(min = 6, max = 18, message = "密码必须是6-18个字符")
    private String password;

    @NotEmpty(message = "电话号码必须填写")
    @Pattern(regexp = "^(13[0-9]|14[5|7]|15[0|1|2|3|4|5|6|7|8|9]|18[0|1|2|3|5|6|7|8|9])\\d{8}$", message = "手机格式不正确")
    private String phone;

    @NotEmpty(message = "验证码不能为空")
    private String code;
}

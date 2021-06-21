package top.tobing.common.to;

import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.util.Date;

/**
 * @Author tobing
 * @Date 2021/4/17 17:14
 * @Description
 */
@Data
public class MemberRespVo {
    private Long id;
    private String username;
    private String nickname;
    private String header;
    private Integer integration;
}

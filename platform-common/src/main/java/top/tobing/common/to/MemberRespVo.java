package top.tobing.common.to;

import lombok.Data;


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

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getHeader() {
        return header;
    }

    public void setHeader(String header) {
        this.header = header;
    }

    public Integer getIntegration() {
        return integration;
    }

    public void setIntegration(Integer integration) {
        this.integration = integration;
    }
}

package top.tobing.common.to.mq;

import lombok.Data;

/**
 * @Author tobing
 * @Date 2021/4/27 17:53
 * @Description
 */
@Data
public class WareTaskTo {
    // 工作单id
    private Long id;
    // 工作单详情列表
    private WareOrderTaskDetailTo detail;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public WareOrderTaskDetailTo getDetail() {
        return detail;
    }

    public void setDetail(WareOrderTaskDetailTo detail) {
        this.detail = detail;
    }
}

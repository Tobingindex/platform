package top.tobing.platform.coupon.vo;


import lombok.Data;
import top.tobing.platform.coupon.entity.SeckillSkuRelationEntity;

import java.util.Date;
import java.util.List;

/**
 * @Author tobing
 * @Date 2021/5/2 9:52
 * @Description
 */
@Data
public class SeckillSessionWithSkusVo {
    private Long id;
    private String name;
    private Date startTime;
    private Date endTime;
    private Integer status;
    private Date createTime;
    private List<SeckillSkuRelationEntity> relations;
}

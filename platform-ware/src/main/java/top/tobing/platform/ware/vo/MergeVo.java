package top.tobing.platform.ware.vo;

import lombok.Data;

import java.util.List;

/**
 * @Author tobing
 * @Date 2021/3/30 11:52
 * @Description 合并采购单需求Vo
 */
@Data
public class MergeVo {
    private Long purchaseId;
    private List<Long> items;
}

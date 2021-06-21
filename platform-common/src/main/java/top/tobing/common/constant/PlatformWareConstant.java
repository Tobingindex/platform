package top.tobing.common.constant;

/**
 * @Author tobing
 * @Date 2021/3/30 11:41
 * @Description Platform-ware 常量
 */
public class PlatformWareConstant {

    public enum PurchaseStatus {
        NEW(0, "新建"), ASSINGED(1, "已分配"),
        RECEIVED(2, "已领取"), FINISH(3, "已完成"),
        EXCEPTION(4, "有异常");
        private Integer code;
        private String msg;

        PurchaseStatus(Integer code, String msg) {
            this.code = code;
            this.msg = msg;
        }

        public Integer getCode() {
            return code;
        }

        public String getMsg() {
            return msg;
        }
    }

    // 采购需求状态
    public enum PurchaseDetailStatus {
        // 状态[0新建，1已分配，2正在采购，3已完成，4采购失败]
        NEW(0, "新建"), ASSINGED(1, "已分配"),
        PURCHASING(2, "正在采购"), FINISH(3, "已完成"),
        FAILURE(4, "采购失败");
        private Integer code;
        private String msg;

        PurchaseDetailStatus(Integer code, String msg) {
            this.code = code;
            this.msg = msg;
        }


        public Integer getCode() {
            return code;
        }

        public String getMsg() {
            return msg;
        }
    }
}

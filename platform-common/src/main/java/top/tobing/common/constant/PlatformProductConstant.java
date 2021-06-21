package top.tobing.common.constant;

/**
 * @Author tobing
 * @Date 2021/4/3 22:04
 * @Description Platform-product 常量
 */
public class PlatformProductConstant {
    // 上架状态[0 - 下架，1 - 上架]
    public enum ProductAvailabilityStatus {
        ON_SHELF(1, "上架"),
        OFF_SHELF(0, "下架");
        private Integer code;
        private String msg;

        ProductAvailabilityStatus(Integer code, String msg) {
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

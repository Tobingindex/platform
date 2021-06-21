package top.tobing.common.constant;

/**
 * @Author tobing
 * @Date 2021/4/24 16:50
 * @Description Platform-order 常量
 */
public class PlatformOrderConstant {
    public static final String USER_ORDER_TOKEN_PREFIX = "platform:order:token:";

    /**
     * 订单状态
     * 0->待付款；1->待发货；2->已发货；3->已完成；4->已关闭；5->无效订单
     */
    public enum OrderStatus {
        FOR_THE_PAYMENT(0, "待付款"),
        FOR_THE_SEND(1, "待发货"),
        SHIPPED(2, "已发货"),
        FINISHED(3, "已完成"),
        CLOSED(4, "已关闭"),
        INVALID(5, "无效订单");

        private Integer code;
        private String msg;

        OrderStatus(Integer code, String msg) {
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

    /**
     * 支付方式
     */
    public enum PayType {
        ALIPAY(1, "支付宝"),
        WECHAT_PAY(2, "微信支付"),
        UNIONPAY(3, "银联支付"),
        CASH_ON_DELIVERY(4, "货到付款");

        private Integer code;
        private String msg;

        PayType(Integer code, String msg) {
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

    /**
     * 发票类型
     */
    public enum BillType {
        NONE(0, "不开发牌"),
        E_INVOICE(1, "电子发牌"),
        PAPER_INVOICE(2, "纸质发票");

        private Integer code;
        private String msg;

        BillType(Integer code, String msg) {
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

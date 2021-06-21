package top.tobing.common.api;

/**
 * @Author tobing
 * @Date 2021/5/4 12:42
 * @Description 通用的返回结果
 * 本项目中主要用远程调用的结果返回，使用人人开源提供的R在数据传输的时候并不方便
 */
public class Result<T> {
    /**
     * 状态码
     */
    private int code;
    /**
     * 提示信息
     */
    private String msg;
    /**
     * 数据封装
     */
    private T data;

    public Result() {
    }

    public Result(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public Result(int code, String msg, T data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
    }

    public static <T> Result<T> ok() {
        return new Result<T>(BziCodeEnum.SUCCESS.getCode(), BziCodeEnum.SUCCESS.getMsg());
    }

    public static <T> Result<T> ok(T data) {
        return new Result<T>(BziCodeEnum.SUCCESS.getCode(), BziCodeEnum.SUCCESS.getMsg(), data);
    }

    public static <T> Result<T> error() {
        return new Result<T>(BziCodeEnum.SERVER_ERROR.getCode(), BziCodeEnum.SERVER_ERROR.getMsg());
    }

    public static <T> Result<T> error(int code, String msg) {
        return new Result<T>(code, msg);
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    @Override
    public String toString() {
        return "Result{" +
                "code=" + code +
                ", msg='" + msg + '\'' +
                ", data=" + data +
                '}';
    }
}

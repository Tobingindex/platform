package top.tobing.platform.ware.exception;

/**
 * @Author tobing
 * @Date 2021/4/24 22:19
 * @Description 无库存异常
 */
public class NoStockException extends RuntimeException{
    public NoStockException() {
        super("锁定库存失败！");
    }
}

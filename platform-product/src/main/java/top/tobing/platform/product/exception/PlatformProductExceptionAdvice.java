package top.tobing.platform.product.exception;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import top.tobing.common.api.BziCodeEnum;
import top.tobing.common.utils.R;

/**
 * @Author tobing
 * @Date 2021/2/4 17:40
 * @Description 统一处理商品模块异常
 */
@Slf4j
// 处理controller下的异常
@RestControllerAdvice(basePackages = "top.tobing.platform.product.controller")
public class PlatformProductExceptionAdvice {

    // 捕获处理所有未捕获的异常
    @ExceptionHandler(value = Throwable.class)
    public R handleException(Throwable throwable) {
        log.error("错误：", throwable);
        return R.error(BziCodeEnum.SERVER_ERROR.getCode(), BziCodeEnum.SERVER_ERROR.getMsg());
    }
}

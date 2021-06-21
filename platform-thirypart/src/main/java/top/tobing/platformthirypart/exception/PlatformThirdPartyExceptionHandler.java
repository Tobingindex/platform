package top.tobing.platformthirypart.exception;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import top.tobing.common.api.BziCodeEnum;
import top.tobing.common.utils.R;

/**
 * @Author tobing
 * @Date 2021/1/27 14:37
 * @Description
 */
@RestControllerAdvice
@Slf4j
public class PlatformThirdPartyExceptionHandler {

    @ExceptionHandler(value = Exception.class)
    public R allExceptionHandler(Exception e) {
        log.error("发送异常：{}，异常类型：{}，堆栈信息为：{}", e.getMessage(), e.getClass(), e.getStackTrace());
        return R.error(BziCodeEnum.THIRD_PART_ERROR.getCode(), BziCodeEnum.THIRD_PART_ERROR.getMsg()).put("data", e.getCause());
    }

}

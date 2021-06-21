package top.tobing.common.exception;

import top.tobing.common.api.BziCodeEnum;

/**
 * @Author tobing
 * @Date 2021/5/4 12:58
 * @Description 全局异常
 */
public class GlobalException extends RuntimeException {

    private BziCodeEnum codeEnum;

    public GlobalException(BziCodeEnum codeEnum) {
        super(codeEnum.toString());
        this.codeEnum = codeEnum;
    }

    public BziCodeEnum getCodeEnum() {
        return codeEnum;
    }
}

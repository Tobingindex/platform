package top.tobing.common.valid.validator;

import top.tobing.common.valid.anno.OrderNumber;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;

/**
 * @Author tobing
 * @Date 2021/5/8 15:00
 * @Description
 */
public class OrderNumberConstraintValidator implements ConstraintValidator<OrderNumber, String> {
    @Override
    public void initialize(OrderNumber constraintAnnotation) {
        // 不用处理
    }

    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        // 单纯判断传递进来的订单号是否是以tobing开头
        if (value != null) {
            return value.startsWith("tobing");
        }
        return false;
    }
}

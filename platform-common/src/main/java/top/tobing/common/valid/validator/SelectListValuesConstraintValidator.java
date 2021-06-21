package top.tobing.common.valid.validator;

import top.tobing.common.valid.anno.SelectListValues;

import javax.validation.ConstraintValidator;
import javax.validation.ConstraintValidatorContext;
import java.util.HashSet;
import java.util.Set;

/**
 * @Author tobing
 * @Date 2020/12/15 17:57
 * @Description 参数校验器
 * 与{@link SelectListValues}绑定
 */
public class SelectListValuesConstraintValidator implements ConstraintValidator<SelectListValues, Integer> {

    Set<Integer> values = new HashSet<>();

    @Override
    public void initialize(SelectListValues constraintAnnotation) {
        // 获取注解中传入的values信息
        int[] inputs = constraintAnnotation.values();
        // 遍历values信息，放到set中
        for (int value : inputs) {
            values.add(value);
        }
    }

    @Override
    public boolean isValid(Integer integer, ConstraintValidatorContext constraintValidatorContext) {
        // 当用户传进来的值符合给定的值才允许通过（return true）
        return values.contains(integer);
    }
}

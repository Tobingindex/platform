package top.tobing.common.valid.anno;

import top.tobing.common.valid.validator.SelectListValuesConstraintValidator;

import javax.validation.Constraint;
import javax.validation.Payload;
import java.lang.annotation.*;

/**
 * @Author tobing
 * @Date 2020/12/15 17:53
 * @Description 可选列表注解
 * 自动注解，使用{@link SelectListValuesConstraintValidator}校验器约束
 * 只有符合values中定义的值，才会校验通过
 */
@Target({ElementType.METHOD, ElementType.FIELD, ElementType.ANNOTATION_TYPE, ElementType.CONSTRUCTOR, ElementType.PARAMETER, ElementType.TYPE_USE})
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Constraint(
        validatedBy = {SelectListValuesConstraintValidator.class}
)
public @interface SelectListValues {

    /**
     * The message element value is used to create the error message.
     */
    String message() default "参数不匹配";

    /**
     * a groups element that specifies the processing groups with which the constraint declaration is associated
     */
    Class<?>[] groups() default {};

    /**
     * specifies the payload with which the the constraint declaration is associated
     */
    Class<? extends Payload>[] payload() default {};

    /**
     * 值在values中的才允许通过
     */
    int[] values() default {};

}

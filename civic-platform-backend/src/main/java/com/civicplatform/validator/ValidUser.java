package com.civicplatform.validator;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;

import java.lang.annotation.*;

@Documented
@Constraint(validatedBy = UserValidator.class)
@Target({ElementType.TYPE, ElementType.ANNOTATION_TYPE})
@Retention(RetentionPolicy.RUNTIME)
public @interface ValidUser {
    String message() default "Invalid user data";
    Class<?>[] groups() default {};
    Class<? extends Payload>[] payload() default {};
}

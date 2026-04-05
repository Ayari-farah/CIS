package com.civicplatform.validator;

import com.civicplatform.dto.request.UserRequest;
import com.civicplatform.enums.UserType;
import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

public class UserValidator implements ConstraintValidator<ValidUser, UserRequest> {

    @Override
    public void initialize(ValidUser constraintAnnotation) {
        ConstraintValidator.super.initialize(constraintAnnotation);
    }

    @Override
    public boolean isValid(UserRequest userRequest, ConstraintValidatorContext context) {
        boolean isValid = true;

        if (userRequest.getUserType() == UserType.AMBASSADOR) {
            if (userRequest.getBadge() == null) {
                context.disableDefaultConstraintViolation();
                context.buildConstraintViolationWithTemplate("Badge is required for AMBASSADOR users")
                       .addPropertyNode("badge")
                       .addConstraintViolation();
                isValid = false;
            }
        }

        if (userRequest.getUserType() == UserType.DONOR) {
            if (userRequest.getAssociationName() == null || userRequest.getAssociationName().trim().isEmpty()) {
                context.disableDefaultConstraintViolation();
                context.buildConstraintViolationWithTemplate("Association name is required for DONOR users")
                       .addPropertyNode("associationName")
                       .addConstraintViolation();
                isValid = false;
            }
        }

        if (userRequest.getUserType() == UserType.CITIZEN) {
            if (userRequest.getFirstName() == null || userRequest.getFirstName().trim().isEmpty()) {
                context.disableDefaultConstraintViolation();
                context.buildConstraintViolationWithTemplate("First name is required for CITIZEN users")
                       .addPropertyNode("firstName")
                       .addConstraintViolation();
                isValid = false;
            }
            if (userRequest.getLastName() == null || userRequest.getLastName().trim().isEmpty()) {
                context.disableDefaultConstraintViolation();
                context.buildConstraintViolationWithTemplate("Last name is required for CITIZEN users")
                       .addPropertyNode("lastName")
                       .addConstraintViolation();
                isValid = false;
            }
        }

        if (userRequest.getUserType() == UserType.PARTICIPANT) {
            if (userRequest.getPoints() == null) {
                context.disableDefaultConstraintViolation();
                context.buildConstraintViolationWithTemplate("Points is required for PARTICIPANT users")
                       .addPropertyNode("points")
                       .addConstraintViolation();
                isValid = false;
            } else if (userRequest.getPoints() < 0) {
                context.disableDefaultConstraintViolation();
                context.buildConstraintViolationWithTemplate("Points must be greater than or equal to 0")
                       .addPropertyNode("points")
                       .addConstraintViolation();
                isValid = false;
            }
        }

        return isValid;
    }
}

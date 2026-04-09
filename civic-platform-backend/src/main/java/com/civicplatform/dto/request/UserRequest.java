package com.civicplatform.dto.request;

import com.civicplatform.enums.Badge;
import com.civicplatform.enums.UserType;
import com.civicplatform.validator.ValidUser;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ValidUser
public class UserRequest {
    
    @NotBlank(message = "Username is required")
    @Size(min = 3, max = 50, message = "Username must be between 3 and 50 characters")
    private String userName;
    
    @NotBlank(message = "Email is required")
    @Email(message = "Email should be valid")
    private String email;
    
    @NotBlank(message = "Password is required")
    @Size(min = 6, message = "Password must be at least 6 characters")
    private String password;
    
    @NotNull(message = "User type is required")
    private UserType userType;
    
    // AMBASSADOR fields
    private Badge badge;
    
    // DONOR fields
    private String companyName;
    private String associationName;
    private String contactName;
    private String contactEmail;
    private String address;
    
    // CITIZEN fields
    private String firstName;
    private String lastName;
    private String phone;
    private String birthDate;
    
    // PARTICIPANT fields
    private Integer points;
}

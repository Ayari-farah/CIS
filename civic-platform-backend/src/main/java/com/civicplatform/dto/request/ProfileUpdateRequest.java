package com.civicplatform.dto.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProfileUpdateRequest {
    
    // Profile fields - all optional for partial updates
    private String firstName;
    private String lastName;
    private String phone;
    private String address;
    private String birthDate;
    
    // DONOR fields
    private String companyName;
    private String associationName;
    private String contactName;
    
    @Email(message = "Contact email should be valid")
    private String contactEmail;
}

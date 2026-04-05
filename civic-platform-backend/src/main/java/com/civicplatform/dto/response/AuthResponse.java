package com.civicplatform.dto.response;

import com.civicplatform.enums.Role;
import com.civicplatform.enums.UserType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AuthResponse {
    
    private String token;
    private String refreshToken;
    private String userType;
    private String role;
    private Long userId;
    private String userName;
    private String email;
}

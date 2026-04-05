package com.civicplatform.service;

import com.civicplatform.dto.request.LoginRequest;
import com.civicplatform.dto.request.RefreshTokenRequest;
import com.civicplatform.dto.request.UserRequest;
import com.civicplatform.dto.response.AuthResponse;

public interface AuthService {
    AuthResponse register(UserRequest userRequest);
    AuthResponse login(LoginRequest loginRequest);
    AuthResponse refreshToken(RefreshTokenRequest refreshTokenRequest);
    void logout(String refreshToken);
}

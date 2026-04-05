package com.civicplatform.service.impl;

import com.civicplatform.dto.request.LoginRequest;
import com.civicplatform.dto.request.RefreshTokenRequest;
import com.civicplatform.dto.request.UserRequest;
import com.civicplatform.dto.response.AuthResponse;
import com.civicplatform.entity.RefreshToken;
import com.civicplatform.entity.User;
import com.civicplatform.mapper.UserMapper;
import com.civicplatform.repository.RefreshTokenRepository;
import com.civicplatform.repository.UserRepository;
import com.civicplatform.security.JwtService;
import com.civicplatform.service.AuthService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class AuthServiceImpl implements AuthService {

    private final UserRepository userRepository;
    private final RefreshTokenRepository refreshTokenRepository;
    private final UserMapper userMapper;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private final AuthenticationManager authenticationManager;

    @Override
    @Transactional
    public AuthResponse register(UserRequest userRequest) {
        // Check if user already exists
        if (userRepository.existsByEmail(userRequest.getEmail())) {
            throw new RuntimeException("Email already exists");
        }
        if (userRepository.existsByUserName(userRequest.getUserName())) {
            throw new RuntimeException("Username already exists");
        }

        // Create new user
        User user = userMapper.toEntityForCreate(userRequest);
        user.setPassword(passwordEncoder.encode(userRequest.getPassword()));

        user = userRepository.save(user);

        // Generate tokens
        String accessToken = jwtService.generateAccessToken(user);
        String refreshToken = generateRefreshToken(user);

        return AuthResponse.builder()
                .token(accessToken)
                .refreshToken(refreshToken)
                .userType(user.getUserType().name())
                .role(user.getRole().name())
                .userId(user.getId())
                .userName(user.getUserName())
                .email(user.getEmail())
                .build();
    }

    @Override
    @Transactional
    public AuthResponse login(LoginRequest loginRequest) {
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        loginRequest.getEmail(),
                        loginRequest.getPassword()
                )
        );

        UserDetails userDetails = (UserDetails) authentication.getPrincipal();
        User user = userRepository.findByEmail(userDetails.getUsername())
                .orElseThrow(() -> new RuntimeException("User not found"));

        // Generate tokens
        String accessToken = jwtService.generateAccessToken(userDetails);
        String refreshToken = generateRefreshToken(user);

        return AuthResponse.builder()
                .token(accessToken)
                .refreshToken(refreshToken)
                .userType(user.getUserType().name())
                .role(user.getRole().name())
                .userId(user.getId())
                .userName(user.getUserName())
                .email(user.getEmail())
                .build();
    }

    @Override
    @Transactional
    public AuthResponse refreshToken(RefreshTokenRequest refreshTokenRequest) {
        String refreshToken = refreshTokenRequest.getRefreshToken();
        
        RefreshToken tokenEntity = refreshTokenRepository.findByToken(refreshToken)
                .orElseThrow(() -> new RuntimeException("Invalid refresh token"));

        if (tokenEntity.isExpired()) {
            refreshTokenRepository.delete(tokenEntity);
            throw new RuntimeException("Refresh token expired");
        }

        User user = tokenEntity.getUser();
        UserDetails userDetails = org.springframework.security.core.userdetails.User.builder()
                .username(user.getEmail())
                .password(user.getPassword())
                .authorities("ROLE_" + user.getRole().name())
                .build();

        // Generate new access token
        String newAccessToken = jwtService.generateAccessToken(userDetails);

        return AuthResponse.builder()
                .token(newAccessToken)
                .refreshToken(refreshToken)
                .userType(user.getUserType().name())
                .role(user.getRole().name())
                .userId(user.getId())
                .userName(user.getUserName())
                .email(user.getEmail())
                .build();
    }

    @Override
    @Transactional
    public void logout(String refreshToken) {
        refreshTokenRepository.findByToken(refreshToken)
                .ifPresent(refreshTokenRepository::delete);
    }

    private String generateRefreshToken(User user) {
        String token = UUID.randomUUID().toString();
        LocalDateTime expiryDate = LocalDateTime.now().plusDays(7); // 7 days

        RefreshToken refreshToken = RefreshToken.builder()
                .token(token)
                .user(user)
                .expiryDate(expiryDate)
                .build();

        refreshTokenRepository.save(refreshToken);
        return token;
    }
}

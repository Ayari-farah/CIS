package com.civicplatform.service;

import com.civicplatform.dto.request.ProfileUpdateRequest;
import com.civicplatform.dto.request.UserRequest;
import com.civicplatform.dto.response.UserResponse;
import com.civicplatform.enums.UserType;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface UserService {
    UserResponse createUser(UserRequest userRequest);
    UserResponse getUserById(Long id);
    UserResponse getUserByEmail(String email);
    List<UserResponse> getAllUsers();
    List<UserResponse> getUsersByType(UserType userType);
    UserResponse updateUser(Long id, UserRequest userRequest);
    UserResponse updateProfile(Long id, ProfileUpdateRequest request);
    UserResponse uploadProfilePicture(Long id, MultipartFile file);
    void deleteUser(Long id);
    void promoteToAmbassador(Long userId);
    long countUsersByType(UserType userType);
}

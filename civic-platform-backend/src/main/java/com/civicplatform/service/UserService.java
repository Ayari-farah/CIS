package com.civicplatform.service;

import com.civicplatform.dto.request.UserRequest;
import com.civicplatform.dto.response.UserResponse;
import com.civicplatform.enums.UserType;

import java.util.List;

public interface UserService {
    UserResponse createUser(UserRequest userRequest);
    UserResponse getUserById(Long id);
    UserResponse getUserByEmail(String email);
    List<UserResponse> getAllUsers();
    List<UserResponse> getUsersByType(UserType userType);
    UserResponse updateUser(Long id, UserRequest userRequest);
    void deleteUser(Long id);
    void promoteToAmbassador(Long userId);
    long countUsersByType(UserType userType);
}

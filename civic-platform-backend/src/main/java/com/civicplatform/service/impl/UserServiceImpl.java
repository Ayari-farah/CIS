package com.civicplatform.service.impl;

import com.civicplatform.dto.request.UserRequest;
import com.civicplatform.dto.response.UserResponse;
import com.civicplatform.entity.User;
import com.civicplatform.enums.Badge;
import com.civicplatform.enums.UserType;
import com.civicplatform.mapper.UserMapper;
import com.civicplatform.repository.EventParticipantRepository;
import com.civicplatform.repository.UserRepository;
import com.civicplatform.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;
    private final UserMapper userMapper;
    private final EventParticipantRepository eventParticipantRepository;

    @Override
    @Transactional
    public UserResponse createUser(UserRequest userRequest) {
        User user = userMapper.toEntity(userRequest);
        user = userRepository.save(user);
        return userMapper.toResponse(user);
    }

    @Override
    public UserResponse getUserById(Long id) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("User not found with id: " + id));
        return userMapper.toResponse(user);
    }

    @Override
    public UserResponse getUserByEmail(String email) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("User not found with email: " + email));
        return userMapper.toResponse(user);
    }

    @Override
    public List<UserResponse> getAllUsers() {
        List<User> users = userRepository.findAll();
        return users.stream()
                .map(userMapper::toResponse)
                .collect(Collectors.toList());
    }

    @Override
    public List<UserResponse> getUsersByType(UserType userType) {
        List<User> users = userRepository.findByUserType(userType);
        return users.stream()
                .map(userMapper::toResponse)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public UserResponse updateUser(Long id, UserRequest userRequest) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("User not found with id: " + id));
        
        userMapper.updateEntity(userRequest, user);
        user = userRepository.save(user);
        return userMapper.toResponse(user);
    }

    @Override
    @Transactional
    public void deleteUser(Long id) {
        if (!userRepository.existsById(id)) {
            throw new RuntimeException("User not found with id: " + id);
        }
        userRepository.deleteById(id);
    }

    @Override
    @Transactional
    public void promoteToAmbassador(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("User not found with id: " + userId));

        if (user.getUserType() != UserType.CITIZEN) {
            throw new RuntimeException("Only CITIZEN users can be promoted to AMBASSADOR");
        }

        long completedEventsCount = eventParticipantRepository.countCompletedEventsByUser(userId);
        if (completedEventsCount < 3) {
            throw new RuntimeException("User must have completed at least 3 events to be promoted to AMBASSADOR");
        }

        user.setUserType(UserType.AMBASSADOR);
        user.setBadge(Badge.COEUR);
        user.setAwardedDate(LocalDate.now());

        userRepository.save(user);
        
        log.info("User {} has been promoted to AMBASSADOR with badge COEUR", user.getEmail());
        
        // TODO: Send congratulatory email
    }

    @Override
    public long countUsersByType(UserType userType) {
        return userRepository.countByUserType(userType);
    }
}

package com.civicplatform.mapper;

import com.civicplatform.dto.request.UserRequest;
import com.civicplatform.dto.response.UserResponse;
import com.civicplatform.entity.User;
import com.civicplatform.enums.Role;
import org.mapstruct.AfterMapping;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.Named;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@Mapper(componentModel = "spring")
public interface UserMapper {

    UserResponse toResponse(User user);
    
    User toEntity(UserRequest userRequest);
    
    void updateEntity(UserRequest userRequest, @MappingTarget User user);
    
    @Mapping(target = "password", ignore = true)
    @Mapping(target = "id", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "comments", ignore = true)
    @Mapping(target = "likes", ignore = true)
    @Mapping(target = "campaigns", ignore = true)
    @Mapping(target = "eventParticipations", ignore = true)
    @Mapping(target = "projectFundings", ignore = true)
    @Mapping(target = "campaignVotes", ignore = true)
    @Mapping(target = "refreshTokens", ignore = true)
    @Mapping(target = "badge", ignore = true)
    @Mapping(target = "points", ignore = true)
    @Mapping(target = "role", ignore = true)
    User toEntityForCreate(UserRequest userRequest);
    
    @AfterMapping
    default void setDefaults(@MappingTarget User user) {
        if (user.getPoints() == null) {
            user.setPoints(0);
        }
        if (user.getRole() == null) {
            user.setRole(Role.USER);
        }
    }
    
    @Named("stringToLocalDate")
    default LocalDate stringToLocalDate(String date) {
        if (date == null || date.trim().isEmpty()) {
            return null;
        }
        return LocalDate.parse(date, DateTimeFormatter.ISO_LOCAL_DATE);
    }
}

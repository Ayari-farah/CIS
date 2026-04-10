package com.civicplatform.mapper;

import com.civicplatform.dto.request.UserRequest;
import com.civicplatform.dto.response.UserResponse;
import com.civicplatform.entity.User;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.Named;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@Mapper(componentModel = "spring")
public interface UserMapper {

    @Mapping(target = "hasProfilePicture", expression = "java(user.getProfilePictureExtension() != null && !user.getProfilePictureExtension().isBlank())")
    UserResponse toResponse(User user);

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
    @Mapping(target = "admin", ignore = true)
    @Mapping(target = "profilePictureExtension", ignore = true)
    User toEntity(UserRequest userRequest);

    @Mapping(target = "profilePictureExtension", ignore = true)
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
    @Mapping(target = "admin", ignore = true)
    @Mapping(target = "profilePictureExtension", ignore = true)
    User toEntityForCreate(UserRequest userRequest);

    @Named("stringToLocalDate")
    default LocalDate stringToLocalDate(String date) {
        if (date == null || date.trim().isEmpty()) {
            return null;
        }
        return LocalDate.parse(date, DateTimeFormatter.ISO_LOCAL_DATE);
    }
}

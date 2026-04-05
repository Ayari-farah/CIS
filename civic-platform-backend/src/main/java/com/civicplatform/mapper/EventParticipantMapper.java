package com.civicplatform.mapper;

import com.civicplatform.dto.response.EventParticipantResponse;
import com.civicplatform.entity.EventParticipant;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

import java.util.List;

@Mapper(componentModel = "spring")
public interface EventParticipantMapper {

    @Mapping(target = "eventTitle", source = "event.title")
    @Mapping(target = "userName", source = "user.userName")
    @Mapping(target = "userEmail", source = "user.email")
    EventParticipantResponse toResponse(EventParticipant eventParticipant);
    
    List<EventParticipantResponse> toResponseList(List<EventParticipant> eventParticipants);
}

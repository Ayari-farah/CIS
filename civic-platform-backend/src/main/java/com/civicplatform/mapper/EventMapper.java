package com.civicplatform.mapper;

import com.civicplatform.dto.request.EventRequest;
import com.civicplatform.dto.response.EventResponse;
import com.civicplatform.entity.Event;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.Named;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Mapper(componentModel = "spring", uses = {EventParticipantMapper.class})
public interface EventMapper {

    @Mapping(target = "organizerName", source = "organizerId", qualifiedByName = "getOrganizerName")
    @Mapping(target = "participants", source = "participants")
    EventResponse toResponse(Event event);
    
    List<EventResponse> toResponseList(List<Event> events);
    
    @Mapping(target = "id", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "currentParticipants", ignore = true)
    @Mapping(target = "status", ignore = true)
    @Mapping(target = "participants", ignore = true)
    @Mapping(target = "date", source = "date", qualifiedByName = "stringToLocalDateTime")
    Event toEntity(EventRequest eventRequest);
    
    void updateEntity(EventRequest eventRequest, @MappingTarget Event event);
    
    @Named("stringToLocalDateTime")
    default LocalDateTime stringToLocalDateTime(String dateTime) {
        if (dateTime == null || dateTime.trim().isEmpty()) {
            return null;
        }
        return LocalDateTime.parse(dateTime, DateTimeFormatter.ISO_LOCAL_DATE_TIME);
    }
    
    @Named("getOrganizerName")
    default String getOrganizerName(Long organizerId) {
        // This would typically require a service call
        return "Organizer " + organizerId;
    }
}

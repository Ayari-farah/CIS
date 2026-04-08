package com.civicplatform.dto.response;

import com.civicplatform.enums.ParticipantStatus;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class EventParticipantResponse {
    
    private Long id;
    private LocalDateTime registeredAt;
    private LocalDateTime checkedInAt;
    private ParticipantStatus status;
    private Long eventId;
    private String eventTitle;
    private LocalDateTime eventDate;
    private String eventLocation;
    private Long userId;
    private String userName;
    private String userEmail;
}

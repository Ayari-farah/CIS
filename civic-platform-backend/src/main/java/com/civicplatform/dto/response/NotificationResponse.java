package com.civicplatform.dto.response;

import com.civicplatform.enums.NotificationType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class NotificationResponse {
    private Long id;
    private String title;
    private String body;
    private NotificationType type;
    private LocalDateTime readAt;
    private String linkUrl;
    private LocalDateTime createdAt;
}

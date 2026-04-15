package com.civicplatform.service;

import com.civicplatform.dto.response.NotificationResponse;
import com.civicplatform.enums.NotificationType;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface NotificationService {

    Page<NotificationResponse> listForUser(Long userId, Pageable pageable);

    long unreadCount(Long userId);

    void markRead(Long notificationId, Long userId);

    void markAllRead(Long userId);

    /**
     * Creates a notification for {@code recipientUserId}, unless it equals {@code actorUserId}
     * (skip self-notifications).
     */
    void notifyUnlessSameUser(
            Long recipientUserId,
            Long actorUserId,
            NotificationType type,
            String title,
            String body,
            String linkUrl
    );

    /** Resolves username to a user id; no-op if unknown. */
    void notifyByUserNameUnless(
            String recipientUserName,
            Long actorUserId,
            NotificationType type,
            String title,
            String body,
            String linkUrl
    );
}

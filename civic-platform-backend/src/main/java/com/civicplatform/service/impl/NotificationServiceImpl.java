package com.civicplatform.service.impl;

import com.civicplatform.dto.response.NotificationResponse;
import com.civicplatform.entity.Notification;
import com.civicplatform.enums.NotificationType;
import com.civicplatform.repository.NotificationRepository;
import com.civicplatform.repository.UserRepository;
import com.civicplatform.service.NotificationService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;

@Service
@RequiredArgsConstructor
public class NotificationServiceImpl implements NotificationService {

    private final NotificationRepository notificationRepository;
    private final UserRepository userRepository;

    @Override
    @Transactional(readOnly = true)
    public Page<NotificationResponse> listForUser(Long userId, Pageable pageable) {
        return notificationRepository.findByUserIdOrderByCreatedAtDesc(userId, pageable)
                .map(this::toResponse);
    }

    @Override
    @Transactional(readOnly = true)
    public long unreadCount(Long userId) {
        return notificationRepository.countByUserIdAndReadAtIsNull(userId);
    }

    @Override
    @Transactional
    public void markRead(Long notificationId, Long userId) {
        Notification n = notificationRepository.findById(notificationId)
                .orElseThrow(() -> new RuntimeException("Notification not found"));
        if (!n.getUser().getId().equals(userId)) {
            throw new RuntimeException("Forbidden");
        }
        if (n.getReadAt() == null) {
            n.setReadAt(LocalDateTime.now());
            notificationRepository.save(n);
        }
    }

    @Override
    @Transactional
    public void markAllRead(Long userId) {
        notificationRepository.markAllReadForUser(userId, LocalDateTime.now());
    }

    @Override
    @Transactional
    public void notifyUnlessSameUser(
            Long recipientUserId,
            Long actorUserId,
            NotificationType type,
            String title,
            String body,
            String linkUrl) {
        if (recipientUserId == null) {
            return;
        }
        if (actorUserId != null && recipientUserId.equals(actorUserId)) {
            return;
        }
        Notification n = Notification.builder()
                .user(userRepository.getReferenceById(recipientUserId))
                .title(title)
                .body(body)
                .type(type != null ? type : NotificationType.INFO)
                .linkUrl(linkUrl)
                .build();
        notificationRepository.save(n);
    }

    @Override
    @Transactional
    public void notifyByUserNameUnless(
            String recipientUserName,
            Long actorUserId,
            NotificationType type,
            String title,
            String body,
            String linkUrl) {
        if (recipientUserName == null || recipientUserName.isBlank()) {
            return;
        }
        userRepository.findByUserName(recipientUserName.trim())
                .ifPresent(u -> notifyUnlessSameUser(u.getId(), actorUserId, type, title, body, linkUrl));
    }

    private NotificationResponse toResponse(Notification n) {
        return NotificationResponse.builder()
                .id(n.getId())
                .title(n.getTitle())
                .body(n.getBody())
                .type(n.getType())
                .readAt(n.getReadAt())
                .linkUrl(n.getLinkUrl())
                .createdAt(n.getCreatedAt())
                .build();
    }
}

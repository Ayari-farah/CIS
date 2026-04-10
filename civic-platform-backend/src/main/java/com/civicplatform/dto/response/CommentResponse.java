package com.civicplatform.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CommentResponse {
    
    private Long id;
    private String content;
    private LocalDateTime createdAt;
    private Long authorId;
    private String authorName;
    private String authorEmail;
    private Long postId;
    private List<MediaAttachmentDto> attachments;
}

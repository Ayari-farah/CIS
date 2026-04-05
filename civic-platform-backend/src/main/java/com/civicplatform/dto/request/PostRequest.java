package com.civicplatform.dto.request;

import com.civicplatform.enums.PostType;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PostRequest {
    
    @NotBlank(message = "Content is required")
    private String content;
    
    @NotNull(message = "Post type is required")
    private PostType type;
    
    private Long campaignId;
}

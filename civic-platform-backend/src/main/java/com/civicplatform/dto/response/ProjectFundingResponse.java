package com.civicplatform.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProjectFundingResponse {
    
    private Long id;
    private BigDecimal amount;
    private LocalDateTime fundDate;
    private String paymentMethod;
    private Long projectId;
    private String projectTitle;
    private Long userId;
    private String userName;
    private String userEmail;
}

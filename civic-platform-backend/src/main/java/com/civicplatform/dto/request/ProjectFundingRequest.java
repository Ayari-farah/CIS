package com.civicplatform.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProjectFundingRequest {
    
    @NotNull(message = "Project ID is required")
    private Long projectId;
    
    @NotNull(message = "Amount is required")
    private BigDecimal amount;
    
    private String paymentMethod;
}

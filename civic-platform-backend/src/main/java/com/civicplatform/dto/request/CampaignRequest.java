package com.civicplatform.dto.request;

import com.civicplatform.enums.CampaignType;
import jakarta.validation.constraints.NotBlank;
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
public class CampaignRequest {
    
    @NotBlank(message = "Name is required")
    private String name;
    
    private BigDecimal neededAmount;
    
    @NotNull(message = "Campaign type is required")
    private CampaignType type;
    
    private String description;
    
    private String startDate;
    
    private String endDate;
    
    private Integer goalKg;
    
    private Integer goalMeals;
    
    private BigDecimal goalAmount;
    
    private String hashtag;
}

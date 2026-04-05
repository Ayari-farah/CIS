package com.civicplatform.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ImpactMetricsResponse {
    
    private Long id;
    private LocalDate metricDate;
    private Integer totalDonationsKg;
    private Integer totalMealsEquivalent;
    private BigDecimal totalCo2SavedKg;
    private Integer totalPeopleHelped;
    private Integer activeAssociations;
    private Integer activeDonors;
    private Integer activeVolunteers;
    private String region;
    private LocalDateTime createdAt;
}

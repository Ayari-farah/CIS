package com.civicplatform.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "impact_metrics")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EntityListeners(AuditingEntityListener.class)
public class ImpactMetrics {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "metric_date", nullable = false, unique = true)
    private LocalDate metricDate;
    
    @Column(name = "total_donations_kg", nullable = false)
    private Integer totalDonationsKg = 0;
    
    @Column(name = "total_meals_equivalent", nullable = false)
    private Integer totalMealsEquivalent = 0;
    
    @Column(name = "total_co2_saved_kg", precision = 15, scale = 2)
    private BigDecimal totalCo2SavedKg = BigDecimal.ZERO;
    
    @Column(name = "total_people_helped", nullable = false)
    private Integer totalPeopleHelped = 0;
    
    @Column(name = "active_associations", nullable = false)
    private Integer activeAssociations = 0;
    
    @Column(name = "active_donors", nullable = false)
    private Integer activeDonors = 0;
    
    @Column(name = "active_volunteers", nullable = false)
    private Integer activeVolunteers = 0;
    
    private String region;
    
    @CreatedDate
    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;
    
    // Helper methods for calculations
    public void calculateFromCampaigns(Integer totalKg) {
        this.totalDonationsKg = totalKg;
        this.totalMealsEquivalent = totalKg * 3; // 1 kg = 3 meals
        this.totalCo2SavedKg = BigDecimal.valueOf(totalKg * 2.5); // 1 kg food = 2.5 kg CO2
        this.totalPeopleHelped = totalKg / 10; // Assume 1 person helped per 10kg
    }
}

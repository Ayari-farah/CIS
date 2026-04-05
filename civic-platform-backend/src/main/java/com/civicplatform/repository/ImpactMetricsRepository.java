package com.civicplatform.repository;

import com.civicplatform.entity.ImpactMetrics;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface ImpactMetricsRepository extends JpaRepository<ImpactMetrics, Long> {
    
    Optional<ImpactMetrics> findByMetricDate(LocalDate metricDate);
    
    List<ImpactMetrics> findByMetricDateBetweenOrderByMetricDate(LocalDate startDate, LocalDate endDate);
    
    @Query("SELECT im FROM ImpactMetrics im WHERE im.metricDate >= :startDate ORDER BY im.metricDate DESC")
    List<ImpactMetrics> findMetricsSince(LocalDate startDate);
    
    @Query("SELECT SUM(im.totalDonationsKg) FROM ImpactMetrics im WHERE im.metricDate >= :startDate")
    Integer sumTotalDonationsSince(LocalDate startDate);
    
    @Query("SELECT SUM(im.totalMealsEquivalent) FROM ImpactMetrics im WHERE im.metricDate >= :startDate")
    Integer sumTotalMealsSince(LocalDate startDate);
}

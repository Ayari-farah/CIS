package com.civicplatform.service;

import com.civicplatform.dto.response.ImpactMetricsResponse;

import java.time.LocalDate;
import java.util.List;

public interface ImpactMetricsService {
    ImpactMetricsResponse getMetricsByDate(LocalDate date);
    List<ImpactMetricsResponse> getMetricsBetweenDates(LocalDate startDate, LocalDate endDate);
    List<ImpactMetricsResponse> getDailyMetrics();
    List<ImpactMetricsResponse> getMonthlyMetrics();
    List<ImpactMetricsResponse> getYearlyMetrics();
    void calculateAndSaveDailyMetrics();
}

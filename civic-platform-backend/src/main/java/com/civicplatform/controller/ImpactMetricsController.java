package com.civicplatform.controller;

import com.civicplatform.dto.response.ImpactMetricsResponse;
import com.civicplatform.service.ImpactMetricsService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/metrics")
@RequiredArgsConstructor
@Tag(name = "Impact Metrics", description = "Impact metrics management APIs")
public class ImpactMetricsController {

    private final ImpactMetricsService impactMetricsService;

    @Operation(summary = "Get metrics by date")
    @GetMapping("/date/{date}")
    public ResponseEntity<ImpactMetricsResponse> getMetricsByDate(@PathVariable @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date) {
        ImpactMetricsResponse response = impactMetricsService.getMetricsByDate(date);
        return ResponseEntity.ok(response);
    }

    @Operation(summary = "Get metrics between dates")
    @GetMapping("/range")
    public ResponseEntity<List<ImpactMetricsResponse>> getMetricsBetweenDates(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate) {
        List<ImpactMetricsResponse> response = impactMetricsService.getMetricsBetweenDates(startDate, endDate);
        return ResponseEntity.ok(response);
    }

    @Operation(summary = "Get daily metrics")
    @GetMapping("/daily")
    public ResponseEntity<List<ImpactMetricsResponse>> getDailyMetrics() {
        List<ImpactMetricsResponse> response = impactMetricsService.getDailyMetrics();
        return ResponseEntity.ok(response);
    }

    @Operation(summary = "Get monthly metrics")
    @GetMapping("/monthly")
    public ResponseEntity<List<ImpactMetricsResponse>> getMonthlyMetrics() {
        List<ImpactMetricsResponse> response = impactMetricsService.getMonthlyMetrics();
        return ResponseEntity.ok(response);
    }

    @Operation(summary = "Get yearly metrics")
    @GetMapping("/yearly")
    public ResponseEntity<List<ImpactMetricsResponse>> getYearlyMetrics() {
        List<ImpactMetricsResponse> response = impactMetricsService.getYearlyMetrics();
        return ResponseEntity.ok(response);
    }

    @Operation(summary = "Recalculate metrics manually")
    @PostMapping("/recalculate")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<Void> calculateAndSaveDailyMetrics() {
        impactMetricsService.calculateAndSaveDailyMetrics();
        return ResponseEntity.ok().build();
    }
}

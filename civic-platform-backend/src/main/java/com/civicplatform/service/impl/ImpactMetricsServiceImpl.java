package com.civicplatform.service.impl;

import com.civicplatform.dto.response.ImpactMetricsResponse;
import com.civicplatform.entity.ImpactMetrics;
import com.civicplatform.enums.CampaignStatus;
import com.civicplatform.enums.UserType;
import com.civicplatform.mapper.ImpactMetricsMapper;
import com.civicplatform.repository.CampaignRepository;
import com.civicplatform.repository.ImpactMetricsRepository;
import com.civicplatform.repository.UserRepository;
import com.civicplatform.service.ImpactMetricsService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.YearMonth;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class ImpactMetricsServiceImpl implements ImpactMetricsService {

    private final ImpactMetricsRepository impactMetricsRepository;
    private final UserRepository userRepository;
    private final CampaignRepository campaignRepository;
    private final ImpactMetricsMapper impactMetricsMapper;

    @Override
    public ImpactMetricsResponse getMetricsByDate(LocalDate date) {
        ImpactMetrics metrics = impactMetricsRepository.findByMetricDate(date)
                .orElseThrow(() -> new RuntimeException("No metrics found for date: " + date));
        return impactMetricsMapper.toResponse(metrics);
    }

    @Override
    public List<ImpactMetricsResponse> getMetricsBetweenDates(LocalDate startDate, LocalDate endDate) {
        List<ImpactMetrics> metrics = impactMetricsRepository.findByMetricDateBetweenOrderByMetricDate(startDate, endDate);
        return metrics.stream()
                .map(impactMetricsMapper::toResponse)
                .collect(Collectors.toList());
    }

    @Override
    public List<ImpactMetricsResponse> getDailyMetrics() {
        LocalDate startDate = LocalDate.now().minusDays(30);
        List<ImpactMetrics> metrics = impactMetricsRepository.findByMetricDateBetweenOrderByMetricDate(startDate, LocalDate.now());
        return metrics.stream()
                .map(impactMetricsMapper::toResponse)
                .collect(Collectors.toList());
    }

    @Override
    public List<ImpactMetricsResponse> getMonthlyMetrics() {
        LocalDate startDate = LocalDate.now().minusMonths(12);
        List<ImpactMetrics> metrics = impactMetricsRepository.findByMetricDateBetweenOrderByMetricDate(startDate, LocalDate.now());
        return metrics.stream()
                .map(impactMetricsMapper::toResponse)
                .collect(Collectors.toList());
    }

    @Override
    public List<ImpactMetricsResponse> getYearlyMetrics() {
        LocalDate startDate = LocalDate.now().minusYears(5);
        List<ImpactMetrics> metrics = impactMetricsRepository.findByMetricDateBetweenOrderByMetricDate(startDate, LocalDate.now());
        return metrics.stream()
                .map(impactMetricsMapper::toResponse)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    @Scheduled(cron = "0 0 0 * * ?") // Run every day at midnight
    public void calculateAndSaveDailyMetrics() {
        LocalDate today = LocalDate.now();
        
        // Check if metrics already exist for today
        if (impactMetricsRepository.findByMetricDate(today).isPresent()) {
            log.info("Metrics already exist for today: {}", today);
            return;
        }

        // Calculate metrics
        Integer totalDonationsKg = calculateTotalDonations();
        Integer totalMealsEquivalent = totalDonationsKg * 3;
        BigDecimal totalCo2SavedKg = BigDecimal.valueOf(totalDonationsKg * 2.5);
        Integer totalPeopleHelped = totalDonationsKg / 10;
        
        Integer activeAssociations = (int) userRepository.countByUserType(UserType.DONOR);
        Integer activeDonors = activeAssociations;
        Integer activeVolunteers = (int) userRepository.countByUserType(UserType.PARTICIPANT);

        ImpactMetrics metrics = ImpactMetrics.builder()
                .metricDate(today)
                .totalDonationsKg(totalDonationsKg)
                .totalMealsEquivalent(totalMealsEquivalent)
                .totalCo2SavedKg(totalCo2SavedKg)
                .totalPeopleHelped(totalPeopleHelped)
                .activeAssociations(activeAssociations)
                .activeDonors(activeDonors)
                .activeVolunteers(activeVolunteers)
                .region("Global")
                .build();

        impactMetricsRepository.save(metrics);
        log.info("Daily impact metrics calculated and saved for: {}", today);
    }

    private Integer calculateTotalDonations() {
        // Sum up currentKg from all active and completed campaigns
        List<com.civicplatform.entity.Campaign> campaigns = campaignRepository.findByStatus(CampaignStatus.ACTIVE);
        campaigns.addAll(campaignRepository.findByStatus(CampaignStatus.COMPLETED));
        
        return campaigns.stream()
                .mapToInt(campaign -> campaign.getCurrentKg() != null ? campaign.getCurrentKg() : 0)
                .sum();
    }
}

package com.civicplatform.service.impl;

import com.civicplatform.dto.response.DashboardStatsResponse;
import com.civicplatform.enums.CampaignStatus;
import com.civicplatform.enums.UserType;
import com.civicplatform.entity.ImpactMetrics;
import com.civicplatform.repository.CampaignRepository;
import com.civicplatform.repository.EventRepository;
import com.civicplatform.repository.ImpactMetricsRepository;
import com.civicplatform.repository.ProjectFundingRepository;
import com.civicplatform.repository.ProjectRepository;
import com.civicplatform.repository.UserRepository;
import com.civicplatform.service.DashboardService;
import com.civicplatform.service.MlServiceClient;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class DashboardServiceImpl implements DashboardService {

    private final UserRepository userRepository;
    private final CampaignRepository campaignRepository;
    private final ProjectRepository projectRepository;
    private final ProjectFundingRepository projectFundingRepository;
    private final EventRepository eventRepository;
    private final ImpactMetricsRepository impactMetricsRepository;
    private final MlServiceClient mlServiceClient;

    @Override
    public DashboardStatsResponse getDashboardStats() {
        // User statistics
        Map<String, Long> totalUsersByType = new HashMap<>();
        totalUsersByType.put("AMBASSADOR", userRepository.countByUserType(UserType.AMBASSADOR));
        totalUsersByType.put("DONOR", userRepository.countByUserType(UserType.DONOR));
        totalUsersByType.put("CITIZEN", userRepository.countByUserType(UserType.CITIZEN));
        totalUsersByType.put("PARTICIPANT", userRepository.countByUserType(UserType.PARTICIPANT));

        // Campaign statistics
        Map<String, Long> totalCampaignsByStatus = new HashMap<>();
        totalCampaignsByStatus.put("DRAFT", campaignRepository.countByStatus(CampaignStatus.DRAFT));
        totalCampaignsByStatus.put("ACTIVE", campaignRepository.countByStatus(CampaignStatus.ACTIVE));
        totalCampaignsByStatus.put("COMPLETED", campaignRepository.countByStatus(CampaignStatus.COMPLETED));
        totalCampaignsByStatus.put("CANCELLED", campaignRepository.countByStatus(CampaignStatus.CANCELLED));

        // Project statistics — total funding = sum of all rows in project_funding (donations), not only COMPLETED projects
        Long totalProjects = projectRepository.count();
        BigDecimal totalFundingAmount = projectFundingRepository.sumAllFundingAmounts();
        if (totalFundingAmount == null) {
            totalFundingAmount = BigDecimal.ZERO;
        }

        Long totalEvents = eventRepository.count();

        BigDecimal totalCo2Saved = BigDecimal.ZERO;
        Integer totalMealsDistributed = 0;
        String mostActiveRegion = null;
        Optional<ImpactMetrics> latestImpact = impactMetricsRepository.findFirstByOrderByMetricDateDesc();
        if (latestImpact.isPresent()) {
            ImpactMetrics im = latestImpact.get();
            if (im.getTotalCo2SavedKg() != null) {
                totalCo2Saved = im.getTotalCo2SavedKg();
            }
            if (im.getTotalMealsEquivalent() != null) {
                totalMealsDistributed = im.getTotalMealsEquivalent();
            }
            if (im.getRegion() != null && !im.getRegion().isBlank()) {
                mostActiveRegion = im.getRegion().trim();
            }
        }
        Long activeVolunteers = userRepository.countByUserType(UserType.PARTICIPANT);
        Long activeDonors = userRepository.countByUserType(UserType.DONOR);
        Long activeAssociations = userRepository.countByUserType(UserType.DONOR);

        boolean mlOk = mlServiceClient.isHealthy();

        return DashboardStatsResponse.builder()
                .totalUsersByType(totalUsersByType)
                .totalCampaignsByStatus(totalCampaignsByStatus)
                .totalFundingAmount(totalFundingAmount)
                .totalCo2Saved(totalCo2Saved)
                .totalMealsDistributed(totalMealsDistributed)
                .mostActiveRegion(mostActiveRegion)
                .totalProjects(totalProjects)
                .totalEvents(totalEvents)
                .activeVolunteers(activeVolunteers)
                .activeDonors(activeDonors)
                .activeAssociations(activeAssociations)
                .mlServiceStatus(mlOk ? "online" : "offline")
                .build();
    }
}

package com.civicplatform.service;

import com.civicplatform.entity.Campaign;
import com.civicplatform.entity.Project;

import java.io.ByteArrayOutputStream;

public interface PdfService {
    ByteArrayOutputStream generateCampaignReport(Campaign campaign);
    ByteArrayOutputStream generateProjectReport(Project project);
    ByteArrayOutputStream generateMetricsReport();
}

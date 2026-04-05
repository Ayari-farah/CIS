package com.civicplatform.service;

import java.util.Map;

public interface EmailService {
    void sendRegistrationEmail(String to, String userName);
    void sendCampaignLaunchEmail(String to, String campaignName);
    void sendProjectFundingEmail(String to, String projectName, String amount);
    void sendEventRegistrationEmail(String to, String eventTitle);
    void sendAmbassadorPromotionEmail(String to, String userName);
    void sendEmailWithTemplate(String to, String subject, String templateName, Map<String, Object> variables);
}

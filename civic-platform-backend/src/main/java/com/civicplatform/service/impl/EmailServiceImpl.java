package com.civicplatform.service.impl;

import com.civicplatform.service.EmailService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.Context;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
public class EmailServiceImpl implements EmailService {

    private final JavaMailSender mailSender;
    private final TemplateEngine templateEngine;

    @Override
    public void sendRegistrationEmail(String to, String userName) {
        String subject = "Welcome to Civic Platform!";
        String templateName = "email/registration";
        
        Map<String, Object> variables = Map.of(
            "userName", userName,
            "platformName", "Civic Platform"
        );
        
        sendEmailWithTemplate(to, subject, templateName, variables);
    }

    @Override
    public void sendCampaignLaunchEmail(String to, String campaignName) {
        String subject = "New Campaign Launched: " + campaignName;
        String templateName = "email/campaign-launch";
        
        Map<String, Object> variables = Map.of(
            "campaignName", campaignName,
            "platformName", "Civic Platform"
        );
        
        sendEmailWithTemplate(to, subject, templateName, variables);
    }

    @Override
    public void sendProjectFundingEmail(String to, String projectName, String amount) {
        String subject = "Project Funded: " + projectName;
        String templateName = "email/project-funding";
        
        Map<String, Object> variables = Map.of(
            "projectName", projectName,
            "amount", amount,
            "platformName", "Civic Platform"
        );
        
        sendEmailWithTemplate(to, subject, templateName, variables);
    }

    @Override
    public void sendEventRegistrationEmail(String to, String eventTitle) {
        String subject = "Event Registration Confirmed: " + eventTitle;
        String templateName = "email/event-registration";
        
        Map<String, Object> variables = Map.of(
            "eventTitle", eventTitle,
            "platformName", "Civic Platform"
        );
        
        sendEmailWithTemplate(to, subject, templateName, variables);
    }

    @Override
    public void sendAmbassadorPromotionEmail(String to, String userName) {
        String subject = "Congratulations! You've been promoted to Ambassador!";
        String templateName = "email/ambassador-promotion";
        
        Map<String, Object> variables = Map.of(
            "userName", userName,
            "badge", "COEUR",
            "platformName", "Civic Platform"
        );
        
        sendEmailWithTemplate(to, subject, templateName, variables);
    }

    @Override
    public void sendEmailWithTemplate(String to, String subject, String templateName, Map<String, Object> variables) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            
            helper.setTo(to);
            helper.setSubject(subject);
            
            Context context = new Context();
            context.setVariables(variables);
            
            String htmlContent = templateEngine.process(templateName, context);
            helper.setText(htmlContent, true);
            
            mailSender.send(message);
            log.info("Email sent successfully to {} with subject: {}", to, subject);
            
        } catch (MessagingException e) {
            log.error("Failed to send email to {} with subject: {}", to, subject, e);
            throw new RuntimeException("Failed to send email", e);
        }
    }

    public void sendSimpleEmail(String to, String subject, String text) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(to);
            message.setSubject(subject);
            message.setText(text);
            
            mailSender.send(message);
            log.info("Simple email sent successfully to {} with subject: {}", to, subject);
            
        } catch (Exception e) {
            log.error("Failed to send simple email to {} with subject: {}", to, subject, e);
            throw new RuntimeException("Failed to send email", e);
        }
    }
}

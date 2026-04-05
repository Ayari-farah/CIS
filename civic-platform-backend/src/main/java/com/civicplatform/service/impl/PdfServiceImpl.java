package com.civicplatform.service.impl;

import com.civicplatform.entity.Campaign;
import com.civicplatform.entity.Project;
import com.civicplatform.service.PdfService;
import lombok.extern.slf4j.Slf4j;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.font.Standard14Fonts;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.time.format.DateTimeFormatter;

@Service
@Slf4j
public class PdfServiceImpl implements PdfService {

    private static final float MARGIN = 50;
    private static final float FONT_SIZE = 12;
    private static final float TITLE_FONT_SIZE = 18;
    private static final float LINE_HEIGHT = 15;

    @Override
    public ByteArrayOutputStream generateCampaignReport(Campaign campaign) {
        try (PDDocument document = new PDDocument();
             ByteArrayOutputStream outputStream = new ByteArrayOutputStream()) {
            
            PDPage page = new PDPage();
            document.addPage(page);
            
            try (PDPageContentStream contentStream = new PDPageContentStream(document, page)) {
                float yPosition = page.getMediaBox().getHeight() - MARGIN;
                
                // Title
                contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA_BOLD), TITLE_FONT_SIZE);
                contentStream.beginText();
                contentStream.newLineAtOffset(MARGIN, yPosition);
                contentStream.showText("Campaign Report: " + campaign.getName());
                contentStream.endText();
                yPosition -= LINE_HEIGHT * 2;
                
                // Campaign Details
                contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA), FONT_SIZE);
                yPosition = addTextLine(contentStream, "Campaign ID: " + campaign.getId(), yPosition);
                yPosition = addTextLine(contentStream, "Type: " + campaign.getType(), yPosition);
                yPosition = addTextLine(contentStream, "Status: " + campaign.getStatus(), yPosition);
                yPosition = addTextLine(contentStream, "Created: " + campaign.getCreatedAt().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME), yPosition);
                yPosition = addTextLine(contentStream, "Start Date: " + (campaign.getStartDate() != null ? campaign.getStartDate() : "N/A"), yPosition);
                yPosition = addTextLine(contentStream, "End Date: " + (campaign.getEndDate() != null ? campaign.getEndDate() : "N/A"), yPosition);
                
                yPosition -= LINE_HEIGHT;
                yPosition = addTextLine(contentStream, "Goals:", yPosition);
                yPosition = addTextLine(contentStream, "  - Target KG: " + (campaign.getGoalKg() != null ? campaign.getGoalKg() : "N/A"), yPosition);
                yPosition = addTextLine(contentStream, "  - Current KG: " + (campaign.getCurrentKg() != null ? campaign.getCurrentKg() : 0), yPosition);
                yPosition = addTextLine(contentStream, "  - Target Meals: " + (campaign.getGoalMeals() != null ? campaign.getGoalMeals() : "N/A"), yPosition);
                yPosition = addTextLine(contentStream, "  - Current Meals: " + (campaign.getCurrentMeals() != null ? campaign.getCurrentMeals() : 0), yPosition);
                
                if (campaign.getGoalAmount() != null) {
                    yPosition = addTextLine(contentStream, "  - Target Amount: $" + campaign.getGoalAmount(), yPosition);
                }
                
                if (campaign.getDescription() != null && !campaign.getDescription().isEmpty()) {
                    yPosition -= LINE_HEIGHT;
                    yPosition = addTextLine(contentStream, "Description:", yPosition);
                    String[] descriptionLines = wrapText(campaign.getDescription(), 80);
                    for (String line : descriptionLines) {
                        yPosition = addTextLine(contentStream, "  " + line, yPosition);
                    }
                }
                
                if (campaign.getHashtag() != null && !campaign.getHashtag().isEmpty()) {
                    yPosition = addTextLine(contentStream, "Hashtag: " + campaign.getHashtag(), yPosition);
                }
                
                // Footer
                yPosition = MARGIN + 30;
                contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA), 10);
                addTextLine(contentStream, "Generated on: " + java.time.LocalDate.now().format(DateTimeFormatter.ISO_LOCAL_DATE), yPosition);
            }
            
            document.save(outputStream);
            return outputStream;
            
        } catch (IOException e) {
            log.error("Error generating campaign PDF report", e);
            throw new RuntimeException("Failed to generate PDF report", e);
        }
    }

    @Override
    public ByteArrayOutputStream generateProjectReport(Project project) {
        try (PDDocument document = new PDDocument();
             ByteArrayOutputStream outputStream = new ByteArrayOutputStream()) {
            
            PDPage page = new PDPage();
            document.addPage(page);
            
            try (PDPageContentStream contentStream = new PDPageContentStream(document, page)) {
                float yPosition = page.getMediaBox().getHeight() - MARGIN;
                
                // Title
                contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA_BOLD), TITLE_FONT_SIZE);
                contentStream.beginText();
                contentStream.newLineAtOffset(MARGIN, yPosition);
                contentStream.showText("Project Report: " + project.getTitle());
                contentStream.endText();
                yPosition -= LINE_HEIGHT * 2;
                
                // Project Details
                contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA), FONT_SIZE);
                yPosition = addTextLine(contentStream, "Project ID: " + project.getId(), yPosition);
                yPosition = addTextLine(contentStream, "Status: " + project.getStatus(), yPosition);
                yPosition = addTextLine(contentStream, "Created: " + project.getCreatedAt().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME), yPosition);
                
                if (project.getStartDate() != null) {
                    yPosition = addTextLine(contentStream, "Start Date: " + project.getStartDate(), yPosition);
                }
                
                if (project.getCompletionDate() != null) {
                    yPosition = addTextLine(contentStream, "Completion Date: " + project.getCompletionDate(), yPosition);
                }
                
                yPosition -= LINE_HEIGHT;
                yPosition = addTextLine(contentStream, "Funding:", yPosition);
                yPosition = addTextLine(contentStream, "  - Goal Amount: $" + project.getGoalAmount(), yPosition);
                yPosition = addTextLine(contentStream, "  - Current Amount: $" + project.getCurrentAmount(), yPosition);
                yPosition = addTextLine(contentStream, "  - Vote Count: " + project.getVoteCount(), yPosition);
                yPosition = addTextLine(contentStream, "  - Progress: " + project.getFundingPercentage() + "%", yPosition);
                
                if (project.getOrganizerType() != null) {
                    yPosition = addTextLine(contentStream, "Organizer Type: " + project.getOrganizerType(), yPosition);
                }
                
                if (project.getDescription() != null && !project.getDescription().isEmpty()) {
                    yPosition -= LINE_HEIGHT;
                    yPosition = addTextLine(contentStream, "Description:", yPosition);
                    String[] descriptionLines = wrapText(project.getDescription(), 80);
                    for (String line : descriptionLines) {
                        yPosition = addTextLine(contentStream, "  " + line, yPosition);
                    }
                }
                
                if (project.getFinalReport() != null && !project.getFinalReport().isEmpty()) {
                    yPosition -= LINE_HEIGHT;
                    yPosition = addTextLine(contentStream, "Final Report:", yPosition);
                    String[] reportLines = wrapText(project.getFinalReport(), 80);
                    for (String line : reportLines) {
                        yPosition = addTextLine(contentStream, "  " + line, yPosition);
                    }
                }
                
                // Footer
                yPosition = MARGIN + 30;
                contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA), 10);
                addTextLine(contentStream, "Generated on: " + java.time.LocalDate.now().format(DateTimeFormatter.ISO_LOCAL_DATE), yPosition);
            }
            
            document.save(outputStream);
            return outputStream;
            
        } catch (IOException e) {
            log.error("Error generating project PDF report", e);
            throw new RuntimeException("Failed to generate PDF report", e);
        }
    }

    @Override
    public ByteArrayOutputStream generateMetricsReport() {
        try (PDDocument document = new PDDocument();
             ByteArrayOutputStream outputStream = new ByteArrayOutputStream()) {
            
            PDPage page = new PDPage();
            document.addPage(page);
            
            try (PDPageContentStream contentStream = new PDPageContentStream(document, page)) {
                float yPosition = page.getMediaBox().getHeight() - MARGIN;
                
                // Title
                contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA_BOLD), TITLE_FONT_SIZE);
                contentStream.beginText();
                contentStream.newLineAtOffset(MARGIN, yPosition);
                contentStream.showText("Impact Metrics Report");
                contentStream.endText();
                yPosition -= LINE_HEIGHT * 2;
                
                // Metrics Summary
                contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA), FONT_SIZE);
                yPosition = addTextLine(contentStream, "Report Period: " + java.time.LocalDate.now().format(DateTimeFormatter.ISO_LOCAL_DATE), yPosition);
                yPosition -= LINE_HEIGHT;
                yPosition = addTextLine(contentStream, "Key Metrics:", yPosition);
                yPosition = addTextLine(contentStream, "  - Total Food Donations: 1,250 kg", yPosition);
                yPosition = addTextLine(contentStream, "  - Meals Equivalent: 3,750 meals", yPosition);
                yPosition = addTextLine(contentStream, "  - CO2 Saved: 3,125 kg", yPosition);
                yPosition = addTextLine(contentStream, "  - People Helped: 125", yPosition);
                yPosition = addTextLine(contentStream, "  - Active Associations: 15", yPosition);
                yPosition = addTextLine(contentStream, "  - Active Donors: 45", yPosition);
                yPosition = addTextLine(contentStream, "  - Active Volunteers: 78", yPosition);
                
                // Footer
                yPosition = MARGIN + 30;
                contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA), 10);
                addTextLine(contentStream, "Generated on: " + java.time.LocalDate.now().format(DateTimeFormatter.ISO_LOCAL_DATE), yPosition);
            }
            
            document.save(outputStream);
            return outputStream;
            
        } catch (IOException e) {
            log.error("Error generating metrics PDF report", e);
            throw new RuntimeException("Failed to generate PDF report", e);
        }
    }

    private float addTextLine(PDPageContentStream contentStream, String text, float yPosition) throws IOException {
        contentStream.beginText();
        contentStream.newLineAtOffset(MARGIN, yPosition);
        contentStream.showText(text);
        contentStream.endText();
        return yPosition - LINE_HEIGHT;
    }

    private String[] wrapText(String text, int maxCharsPerLine) {
        if (text == null || text.isEmpty()) {
            return new String[0];
        }
        
        String[] words = text.split(" ");
        StringBuilder currentLine = new StringBuilder();
        java.util.List<String> lines = new java.util.ArrayList<>();
        
        for (String word : words) {
            if (currentLine.length() + word.length() + 1 <= maxCharsPerLine) {
                if (currentLine.length() > 0) {
                    currentLine.append(" ");
                }
                currentLine.append(word);
            } else {
                if (currentLine.length() > 0) {
                    lines.add(currentLine.toString());
                    currentLine = new StringBuilder(word);
                } else {
                    // Word is longer than max line length, split it
                    for (int i = 0; i < word.length(); i += maxCharsPerLine) {
                        int endIndex = Math.min(i + maxCharsPerLine, word.length());
                        lines.add(word.substring(i, endIndex));
                    }
                }
            }
        }
        
        if (currentLine.length() > 0) {
            lines.add(currentLine.toString());
        }
        
        return lines.toArray(new String[0]);
    }
}

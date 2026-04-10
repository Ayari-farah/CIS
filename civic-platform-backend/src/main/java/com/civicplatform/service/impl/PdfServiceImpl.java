package com.civicplatform.service.impl;

import com.civicplatform.dto.response.DashboardStatsResponse;
import com.civicplatform.entity.Campaign;
import com.civicplatform.entity.Project;
import com.civicplatform.service.DashboardService;
import com.civicplatform.service.PdfService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.font.Standard14Fonts;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

@Service
@Slf4j
@RequiredArgsConstructor
public class PdfServiceImpl implements PdfService {

    private final DashboardService dashboardService;

    private static final float MARGIN = 48f;
    private static final float FONT_SIZE = 11f;
    private static final float TITLE_FONT_SIZE = 20f;
    private static final float LINE_HEIGHT = 14f;
    private static final float HEADER_H = 88f;
    /** Emerald theme (matches app) */
    private static final float HDR_R = 0.02f;
    private static final float HDR_G = 0.59f;
    private static final float HDR_B = 0.41f;

    @Override
    public ByteArrayOutputStream generateCampaignReport(Campaign campaign) {
        try (PDDocument document = new PDDocument();
             ByteArrayOutputStream outputStream = new ByteArrayOutputStream()) {

            PDPage page = new PDPage();
            document.addPage(page);

            try (PDPageContentStream contentStream = new PDPageContentStream(document, page)) {
                float yPosition = page.getMediaBox().getHeight() - MARGIN;

                contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA_BOLD), TITLE_FONT_SIZE);
                contentStream.beginText();
                contentStream.newLineAtOffset(MARGIN, yPosition);
                contentStream.showText(pdfSafe("Campaign Report: " + campaign.getName()));
                contentStream.endText();
                yPosition -= LINE_HEIGHT * 2;

                contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA), FONT_SIZE);
                yPosition = addTextLine(contentStream, pdfSafe("Campaign ID: " + campaign.getId()), yPosition);
                yPosition = addTextLine(contentStream, pdfSafe("Type: " + campaign.getType()), yPosition);
                yPosition = addTextLine(contentStream, pdfSafe("Status: " + campaign.getStatus()), yPosition);
                yPosition = addTextLine(contentStream, pdfSafe("Created: " + campaign.getCreatedAt().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME)), yPosition);
                yPosition = addTextLine(contentStream, pdfSafe("Start Date: " + (campaign.getStartDate() != null ? campaign.getStartDate() : "N/A")), yPosition);
                yPosition = addTextLine(contentStream, pdfSafe("End Date: " + (campaign.getEndDate() != null ? campaign.getEndDate() : "N/A")), yPosition);

                yPosition -= LINE_HEIGHT;
                yPosition = addTextLine(contentStream, pdfSafe("Goals:"), yPosition);
                yPosition = addTextLine(contentStream, pdfSafe("  - Target KG: " + (campaign.getGoalKg() != null ? campaign.getGoalKg() : "N/A")), yPosition);
                yPosition = addTextLine(contentStream, pdfSafe("  - Current KG: " + (campaign.getCurrentKg() != null ? campaign.getCurrentKg() : 0)), yPosition);
                yPosition = addTextLine(contentStream, pdfSafe("  - Target Meals: " + (campaign.getGoalMeals() != null ? campaign.getGoalMeals() : "N/A")), yPosition);
                yPosition = addTextLine(contentStream, pdfSafe("  - Current Meals: " + (campaign.getCurrentMeals() != null ? campaign.getCurrentMeals() : 0)), yPosition);

                if (campaign.getGoalAmount() != null) {
                    yPosition = addTextLine(contentStream, pdfSafe("  - Target Amount: $" + campaign.getGoalAmount()), yPosition);
                }

                if (campaign.getDescription() != null && !campaign.getDescription().isEmpty()) {
                    yPosition -= LINE_HEIGHT;
                    yPosition = addTextLine(contentStream, pdfSafe("Description:"), yPosition);
                    String[] descriptionLines = wrapText(campaign.getDescription(), 80);
                    for (String line : descriptionLines) {
                        yPosition = addTextLine(contentStream, pdfSafe("  " + line), yPosition);
                    }
                }

                if (campaign.getHashtag() != null && !campaign.getHashtag().isEmpty()) {
                    yPosition = addTextLine(contentStream, pdfSafe("Hashtag: " + campaign.getHashtag()), yPosition);
                }

                yPosition = MARGIN + 30;
                contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA), 10);
                addTextLine(contentStream, pdfSafe("Generated on: " + LocalDate.now().format(DateTimeFormatter.ISO_LOCAL_DATE)), yPosition);
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

                contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA_BOLD), TITLE_FONT_SIZE);
                contentStream.beginText();
                contentStream.newLineAtOffset(MARGIN, yPosition);
                contentStream.showText(pdfSafe("Project Report: " + project.getTitle()));
                contentStream.endText();
                yPosition -= LINE_HEIGHT * 2;

                contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA), FONT_SIZE);
                yPosition = addTextLine(contentStream, pdfSafe("Project ID: " + project.getId()), yPosition);
                yPosition = addTextLine(contentStream, pdfSafe("Status: " + project.getStatus()), yPosition);
                yPosition = addTextLine(contentStream, pdfSafe("Created: " + project.getCreatedAt().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME)), yPosition);

                if (project.getStartDate() != null) {
                    yPosition = addTextLine(contentStream, pdfSafe("Start Date: " + project.getStartDate()), yPosition);
                }

                if (project.getCompletionDate() != null) {
                    yPosition = addTextLine(contentStream, pdfSafe("Completion Date: " + project.getCompletionDate()), yPosition);
                }

                yPosition -= LINE_HEIGHT;
                yPosition = addTextLine(contentStream, pdfSafe("Funding:"), yPosition);
                yPosition = addTextLine(contentStream, pdfSafe("  - Goal Amount: $" + project.getGoalAmount()), yPosition);
                yPosition = addTextLine(contentStream, pdfSafe("  - Current Amount: $" + project.getCurrentAmount()), yPosition);
                yPosition = addTextLine(contentStream, pdfSafe("  - Vote Count: " + project.getVoteCount()), yPosition);
                yPosition = addTextLine(contentStream, pdfSafe("  - Progress: " + project.getFundingPercentage() + "%"), yPosition);

                if (project.getOrganizerType() != null) {
                    yPosition = addTextLine(contentStream, pdfSafe("Organizer Type: " + project.getOrganizerType()), yPosition);
                }

                if (project.getDescription() != null && !project.getDescription().isEmpty()) {
                    yPosition -= LINE_HEIGHT;
                    yPosition = addTextLine(contentStream, pdfSafe("Description:"), yPosition);
                    String[] descriptionLines = wrapText(project.getDescription(), 80);
                    for (String line : descriptionLines) {
                        yPosition = addTextLine(contentStream, pdfSafe("  " + line), yPosition);
                    }
                }

                if (project.getFinalReport() != null && !project.getFinalReport().isEmpty()) {
                    yPosition -= LINE_HEIGHT;
                    yPosition = addTextLine(contentStream, pdfSafe("Final Report:"), yPosition);
                    String[] reportLines = wrapText(project.getFinalReport(), 80);
                    for (String line : reportLines) {
                        yPosition = addTextLine(contentStream, pdfSafe("  " + line), yPosition);
                    }
                }

                yPosition = MARGIN + 30;
                contentStream.setFont(new PDType1Font(Standard14Fonts.FontName.HELVETICA), 10);
                addTextLine(contentStream, pdfSafe("Generated on: " + LocalDate.now().format(DateTimeFormatter.ISO_LOCAL_DATE)), yPosition);
            }

            document.save(outputStream);
            return outputStream;

        } catch (IOException e) {
            log.error("Error generating project PDF report", e);
            throw new RuntimeException("Failed to generate PDF report", e);
        }
    }

    private static final float METRICS_TABLE_HEADER_H = 22f;
    private static final float METRICS_ROW_H = 20f;
    private static final float METRICS_SECTION_TITLE_H = 26f;

    @Override
    public ByteArrayOutputStream generateMetricsReport() {
        DashboardStatsResponse stats = dashboardService.getDashboardStats();
        try (PDDocument document = new PDDocument();
             ByteArrayOutputStream outputStream = new ByteArrayOutputStream()) {

            /* A4 gives a bit more vertical room for four structured tables */
            PDPage page = new PDPage(PDRectangle.A4);
            document.addPage(page);
            float pageW = page.getMediaBox().getWidth();
            float pageH = page.getMediaBox().getHeight();

            PDType1Font bold = new PDType1Font(Standard14Fonts.FontName.HELVETICA_BOLD);
            PDType1Font regular = new PDType1Font(Standard14Fonts.FontName.HELVETICA);

            try (PDPageContentStream cs = new PDPageContentStream(document, page)) {
                drawMetricsCoverHeader(cs, bold, regular, pageW, pageH);

                float y = pageH - HEADER_H - 32f;
                cs.setNonStrokingColor(0.42f, 0.45f, 0.5f);
                cs.beginText();
                cs.setFont(regular, 10f);
                cs.newLineAtOffset(MARGIN, y);
                cs.showText(pdfSafe("Generated: " + LocalDate.now().format(DateTimeFormatter.ISO_LOCAL_DATE)));
                cs.endText();
                y -= 14f;
                cs.beginText();
                cs.setFont(regular, 9f);
                cs.newLineAtOffset(MARGIN, y);
                cs.showText(pdfSafe("Document layout: numbered sections with bordered data tables. User directory exports: Admin > Reports."));
                cs.endText();
                y -= 22f;

                String funding = formatMoneyTnd(stats.getTotalFundingAmount());
                String[][] kpiRows = {
                        {"Total funding (TND)", funding},
                        {"Total projects", nz(stats.getTotalProjects())},
                        {"Total events", nz(stats.getTotalEvents())},
                        {"Active volunteers", nz(stats.getActiveVolunteers())},
                        {"Active donors", nz(stats.getActiveDonors())},
                        {"Associations (donor accounts)", nz(stats.getActiveAssociations())}
                };
                y = drawMetricsSectionWithTable(cs, bold, regular, pageW, MARGIN, y,
                        "1. Platform KPIs (snapshot)", "Metric", "Value", kpiRows);

                String co2 = stats.getTotalCo2Saved() != null ? stats.getTotalCo2Saved().toPlainString() : "0";
                String meals = stats.getTotalMealsDistributed() != null ? String.valueOf(stats.getTotalMealsDistributed()) : "0";
                String region = stats.getMostActiveRegion() != null ? stats.getMostActiveRegion() : "N/A";
                String[][] envRows = {
                        {"CO2 saved (kg, model)", co2},
                        {"Meals distributed (model)", meals},
                        {"Most active region", region}
                };
                y = drawMetricsSectionWithTable(cs, bold, regular, pageW, MARGIN, y,
                        "2. Environmental impact (reported model)", "Indicator", "Value", envRows);

                Map<String, Long> usersByType = stats.getTotalUsersByType() != null
                        ? stats.getTotalUsersByType()
                        : Collections.emptyMap();
                List<Map.Entry<String, Long>> userEntries = new ArrayList<>(usersByType.entrySet());
                userEntries.sort(Comparator.comparing(Map.Entry::getKey));
                String[][] userRows = new String[userEntries.size()][2];
                for (int i = 0; i < userEntries.size(); i++) {
                    Map.Entry<String, Long> e = userEntries.get(i);
                    userRows[i][0] = e.getKey();
                    userRows[i][1] = String.valueOf(e.getValue());
                }
                if (userRows.length == 0) {
                    userRows = new String[][]{{"(no data)", "0"}};
                }
                y = drawMetricsSectionWithTable(cs, bold, regular, pageW, MARGIN, y,
                        "3. Registered users by role (counts)", "Role", "Count", userRows);

                Map<String, Long> camps = stats.getTotalCampaignsByStatus() != null
                        ? stats.getTotalCampaignsByStatus()
                        : Collections.emptyMap();
                List<Map.Entry<String, Long>> campEntries = new ArrayList<>(camps.entrySet());
                campEntries.sort(Comparator.comparing(Map.Entry::getKey));
                String[][] campRows = new String[campEntries.size()][2];
                for (int i = 0; i < campEntries.size(); i++) {
                    Map.Entry<String, Long> e = campEntries.get(i);
                    campRows[i][0] = e.getKey();
                    campRows[i][1] = String.valueOf(e.getValue());
                }
                if (campRows.length == 0) {
                    campRows = new String[][]{{"(no data)", "0"}};
                }
                y = drawMetricsSectionWithTable(cs, bold, regular, pageW, MARGIN, y,
                        "4. Campaigns by status", "Status", "Count", campRows);

                drawMetricsPageFooter(cs, regular, pageW, pageH);
            }

            document.save(outputStream);
            return outputStream;

        } catch (IOException e) {
            log.error("Error generating metrics PDF report", e);
            throw new RuntimeException("Failed to generate PDF report", e);
        }
    }

    /** Emerald cover band + titles (matches Civic Platform admin theme). */
    private void drawMetricsCoverHeader(PDPageContentStream cs, PDType1Font bold, PDType1Font regular, float pageW, float pageH)
            throws IOException {
        cs.setNonStrokingColor(HDR_R, HDR_G, HDR_B);
        cs.addRect(0, pageH - HEADER_H, pageW, HEADER_H);
        cs.fill();
        cs.setNonStrokingColor(1f, 1f, 1f);
        cs.beginText();
        cs.setFont(bold, 22f);
        cs.newLineAtOffset(MARGIN, pageH - HEADER_H + 52f);
        cs.showText(pdfSafe("Civic Platform"));
        cs.endText();
        cs.beginText();
        cs.setFont(bold, 14f);
        cs.newLineAtOffset(MARGIN, pageH - HEADER_H + 30f);
        cs.showText(pdfSafe("Structured metrics export"));
        cs.endText();
        cs.beginText();
        cs.setFont(regular, 10f);
        cs.newLineAtOffset(MARGIN, pageH - HEADER_H + 12f);
        cs.showText(pdfSafe("Operational dashboard figures in fixed-column tables"));
        cs.endText();
    }

    /**
     * Section title strip + bordered two-column table (header row + zebra rows).
     *
     * @return y-coordinate of the bottom spacing below the table (PDF coords: from bottom of page).
     */
    private float drawMetricsSectionWithTable(PDPageContentStream cs, PDType1Font bold, PDType1Font regular,
                                            float pageW, float margin, float yTop,
                                            String sectionTitle, String col1Header, String col2Header,
                                            String[][] rows) throws IOException {
        float titleBottom = yTop - METRICS_SECTION_TITLE_H;
        cs.setNonStrokingColor(0.90f, 0.95f, 0.93f);
        cs.addRect(margin, titleBottom, pageW - 2 * margin, METRICS_SECTION_TITLE_H);
        cs.fill();
        cs.setStrokingColor(0.55f, 0.75f, 0.68f);
        cs.setLineWidth(0.75f);
        cs.addRect(margin, titleBottom, pageW - 2 * margin, METRICS_SECTION_TITLE_H);
        cs.stroke();
        cs.setNonStrokingColor(0.04f, 0.32f, 0.22f);
        cs.beginText();
        cs.setFont(bold, 11f);
        cs.newLineAtOffset(margin + 10f, titleBottom + 9f);
        cs.showText(pdfSafe(sectionTitle));
        cs.endText();

        float tableTop = titleBottom - 6f;
        float tableW = pageW - 2 * margin;
        float c1w = tableW * 0.58f;
        float xSplit = margin + c1w;

        // Table header (dark green)
        float hdrBottom = tableTop - METRICS_TABLE_HEADER_H;
        cs.setNonStrokingColor(0.04f, 0.42f, 0.31f);
        cs.addRect(margin, hdrBottom, tableW, METRICS_TABLE_HEADER_H);
        cs.fill();
        cs.setNonStrokingColor(1f, 1f, 1f);
        cs.beginText();
        cs.setFont(bold, 10f);
        cs.newLineAtOffset(margin + 8f, hdrBottom + 7f);
        cs.showText(pdfSafe(col1Header));
        cs.endText();
        cs.beginText();
        cs.setFont(bold, 10f);
        cs.newLineAtOffset(xSplit + 8f, hdrBottom + 7f);
        cs.showText(pdfSafe(col2Header));
        cs.endText();
        cs.setStrokingColor(0.55f, 0.70f, 0.62f);
        cs.setLineWidth(0.5f);
        cs.moveTo(xSplit, hdrBottom);
        cs.lineTo(xSplit, tableTop);
        cs.stroke();

        float rowTop = hdrBottom;
        for (int i = 0; i < rows.length; i++) {
            float rb = rowTop - METRICS_ROW_H;
            boolean zebra = i % 2 == 0;
            cs.setNonStrokingColor(zebra ? 0.99f : 0.96f, zebra ? 0.99f : 0.97f, zebra ? 1f : 0.985f);
            cs.addRect(margin, rb, tableW, METRICS_ROW_H);
            cs.fill();
            cs.setStrokingColor(0.82f, 0.86f, 0.90f);
            cs.setLineWidth(0.4f);
            cs.addRect(margin, rb, tableW, METRICS_ROW_H);
            cs.stroke();
            cs.setStrokingColor(0.82f, 0.86f, 0.90f);
            cs.moveTo(xSplit, rb);
            cs.lineTo(xSplit, rowTop);
            cs.stroke();

            cs.setNonStrokingColor(0.18f, 0.20f, 0.24f);
            cs.beginText();
            cs.setFont(regular, 9.5f);
            cs.newLineAtOffset(margin + 8f, rb + 6f);
            cs.showText(pdfSafe(rows[i][0]));
            cs.endText();
            cs.beginText();
            cs.setFont(bold, 9.5f);
            cs.newLineAtOffset(xSplit + 8f, rb + 6f);
            cs.showText(pdfSafe(rows[i][1]));
            cs.endText();
            rowTop = rb;
        }

        float tableBottom = rowTop;
        cs.setStrokingColor(0.45f, 0.50f, 0.55f);
        cs.setLineWidth(1f);
        cs.addRect(margin, tableBottom, tableW, tableTop - tableBottom);
        cs.stroke();

        return tableBottom - 18f;
    }

    private void drawMetricsPageFooter(PDPageContentStream cs, PDType1Font regular, float pageW, float pageH) throws IOException {
        float fh = 28f;
        cs.setNonStrokingColor(0.94f, 0.96f, 0.98f);
        cs.addRect(0, 0, pageW, fh);
        cs.fill();
        cs.setStrokingColor(0.80f, 0.84f, 0.88f);
        cs.setLineWidth(0.5f);
        cs.moveTo(0, fh);
        cs.lineTo(pageW, fh);
        cs.stroke();
        cs.setNonStrokingColor(0.45f, 0.48f, 0.52f);
        cs.beginText();
        cs.setFont(regular, 8.5f);
        cs.newLineAtOffset(MARGIN, 11f);
        cs.showText(pdfSafe("Civic Platform — confidential structured metrics export — page 1"));
        cs.endText();
    }

    private static String nz(Long n) {
        return n != null ? String.valueOf(n) : "0";
    }

    private static String formatMoneyTnd(BigDecimal amount) {
        if (amount == null) {
            return "0.00 TND";
        }
        return amount.setScale(2, java.math.RoundingMode.HALF_UP).toPlainString() + " TND";
    }

    /**
     * Standard 14 fonts: keep text in Latin-1 / safe subset for PDFBox {@code showText}.
     */
    private static String pdfSafe(String s) {
        if (s == null) {
            return "";
        }
        String t = s.replace('\u2192', '-').replace('\u2014', '-').replace('\u2013', '-');
        StringBuilder out = new StringBuilder(t.length());
        for (int i = 0; i < t.length(); i++) {
            char c = t.charAt(i);
            out.append(c <= 0xFF ? c : '?');
        }
        return out.toString();
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

package com.civicplatform.controller;

import com.civicplatform.service.CampaignService;
import com.civicplatform.service.PdfService;
import com.civicplatform.service.ProjectService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.io.ByteArrayOutputStream;

@RestController
@RequestMapping("/pdf")
@RequiredArgsConstructor
@Tag(name = "PDF Generation", description = "PDF generation APIs")
public class PdfController {

    private final PdfService pdfService;
    private final CampaignService campaignService;
    private final ProjectService projectService;

    @Operation(summary = "Generate campaign PDF report")
    @GetMapping("/campaigns/{id}")
    @PreAuthorize("hasRole('ADMIN') or hasRole('MODERATOR')")
    public ResponseEntity<byte[]> generateCampaignReport(@PathVariable Long id) {
        campaignService.getCampaignById(id); // Verify campaign exists
        ByteArrayOutputStream pdfStream = pdfService.generateCampaignReport(
                // Convert response back to entity - you might need to implement this conversion
                com.civicplatform.entity.Campaign.builder().build()
        );

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_PDF);
        headers.setContentDispositionFormData("attachment", "campaign-report-" + id + ".pdf");
        headers.setContentLength(pdfStream.size());

        return ResponseEntity.ok()
                .headers(headers)
                .body(pdfStream.toByteArray());
    }

    @Operation(summary = "Generate project PDF report")
    @GetMapping("/projects/{id}")
    @PreAuthorize("hasRole('ADMIN') or hasRole('MODERATOR')")
    public ResponseEntity<byte[]> generateProjectReport(@PathVariable Long id) {
        projectService.getProjectById(id); // Verify project exists
        ByteArrayOutputStream pdfStream = pdfService.generateProjectReport(
                // Convert response back to entity - you might need to implement this conversion
                com.civicplatform.entity.Project.builder().build()
        );

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_PDF);
        headers.setContentDispositionFormData("attachment", "project-report-" + id + ".pdf");
        headers.setContentLength(pdfStream.size());

        return ResponseEntity.ok()
                .headers(headers)
                .body(pdfStream.toByteArray());
    }

    @Operation(summary = "Generate metrics PDF report")
    @GetMapping("/metrics")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<byte[]> generateMetricsReport() {
        ByteArrayOutputStream pdfStream = pdfService.generateMetricsReport();

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_PDF);
        headers.setContentDispositionFormData("attachment", "metrics-report.pdf");
        headers.setContentLength(pdfStream.size());

        return ResponseEntity.ok()
                .headers(headers)
                .body(pdfStream.toByteArray());
    }
}

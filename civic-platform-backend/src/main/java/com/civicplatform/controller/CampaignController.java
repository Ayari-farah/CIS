package com.civicplatform.controller;

import com.civicplatform.dto.request.CampaignRequest;
import com.civicplatform.dto.response.CampaignResponse;
import com.civicplatform.enums.CampaignStatus;
import com.civicplatform.service.CampaignService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/campaigns")
@RequiredArgsConstructor
@Tag(name = "Campaign Management", description = "Campaign management APIs")
public class CampaignController {

    private final CampaignService campaignService;

    @Operation(summary = "Create a new campaign")
    @PostMapping
    public ResponseEntity<CampaignResponse> createCampaign(@Valid @RequestBody CampaignRequest campaignRequest, Authentication authentication) {
        Long userId = getUserIdFromAuthentication(authentication);
        CampaignResponse response = campaignService.createCampaign(campaignRequest, userId);
        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }

    @Operation(summary = "Get campaign by ID")
    @GetMapping("/{id}")
    public ResponseEntity<CampaignResponse> getCampaignById(@PathVariable Long id) {
        CampaignResponse response = campaignService.getCampaignById(id);
        return ResponseEntity.ok(response);
    }

    @Operation(summary = "Get all campaigns")
    @GetMapping
    public ResponseEntity<List<CampaignResponse>> getAllCampaigns() {
        List<CampaignResponse> response = campaignService.getAllCampaigns();
        return ResponseEntity.ok(response);
    }

    @Operation(summary = "Get campaigns by status")
    @GetMapping("/status/{status}")
    public ResponseEntity<List<CampaignResponse>> getCampaignsByStatus(@PathVariable CampaignStatus status) {
        List<CampaignResponse> response = campaignService.getCampaignsByStatus(status);
        return ResponseEntity.ok(response);
    }

    @Operation(summary = "Update campaign")
    @PutMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN') or @campaignService.getCampaignById(#id).createdById == authentication.principal.id")
    public ResponseEntity<CampaignResponse> updateCampaign(@PathVariable Long id, @Valid @RequestBody CampaignRequest campaignRequest) {
        CampaignResponse response = campaignService.updateCampaign(id, campaignRequest);
        return ResponseEntity.ok(response);
    }

    @Operation(summary = "Delete campaign")
    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN') or @campaignService.getCampaignById(#id).createdById == authentication.principal.id")
    public ResponseEntity<Void> deleteCampaign(@PathVariable Long id) {
        campaignService.deleteCampaign(id);
        return ResponseEntity.noContent().build();
    }

    @Operation(summary = "Launch campaign")
    @PostMapping("/{id}/launch")
    @PreAuthorize("hasRole('ADMIN') or @campaignService.getCampaignById(#id).createdById == authentication.principal.id")
    public ResponseEntity<CampaignResponse> launchCampaign(@PathVariable Long id) {
        CampaignResponse response = campaignService.launchCampaign(id);
        return ResponseEntity.ok(response);
    }

    @Operation(summary = "Close campaign")
    @PostMapping("/{id}/close")
    @PreAuthorize("hasRole('ADMIN') or @campaignService.getCampaignById(#id).createdById == authentication.principal.id")
    public ResponseEntity<CampaignResponse> closeCampaign(@PathVariable Long id) {
        CampaignResponse response = campaignService.closeCampaign(id);
        return ResponseEntity.ok(response);
    }

    @Operation(summary = "Cancel campaign")
    @PostMapping("/{id}/cancel")
    @PreAuthorize("hasRole('ADMIN') or @campaignService.getCampaignById(#id).createdById == authentication.principal.id")
    public ResponseEntity<CampaignResponse> cancelCampaign(@PathVariable Long id) {
        CampaignResponse response = campaignService.cancelCampaign(id);
        return ResponseEntity.ok(response);
    }

    @Operation(summary = "Vote for campaign")
    @PostMapping("/{id}/vote")
    public ResponseEntity<Void> voteForCampaign(@PathVariable Long id, Authentication authentication) {
        Long userId = getUserIdFromAuthentication(authentication);
        campaignService.voteForCampaign(id, userId);
        return ResponseEntity.ok().build();
    }

    @Operation(summary = "Activate campaigns ready for activation")
    @PostMapping("/activate-ready")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<Void> activateCampaignsReadyForActivation() {
        campaignService.activateCampaignsReadyForActivation();
        return ResponseEntity.ok().build();
    }

    private Long getUserIdFromAuthentication(Authentication authentication) {
        // This is a placeholder - you'll need to implement proper user ID extraction
        // from the authentication object
        return 1L; // Placeholder
    }
}

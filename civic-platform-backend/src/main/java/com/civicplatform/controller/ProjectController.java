package com.civicplatform.controller;

import com.civicplatform.dto.request.ProjectFundingRequest;
import com.civicplatform.dto.request.ProjectRequest;
import com.civicplatform.dto.response.ProjectResponse;
import com.civicplatform.service.ProjectService;
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
@RequestMapping("/projects")
@RequiredArgsConstructor
@Tag(name = "Project Management", description = "Project management APIs")
public class ProjectController {

    private final ProjectService projectService;

    @Operation(summary = "Create a new project")
    @PostMapping
    public ResponseEntity<ProjectResponse> createProject(@Valid @RequestBody ProjectRequest projectRequest, Authentication authentication) {
        Long userId = getUserIdFromAuthentication(authentication);
        ProjectResponse response = projectService.createProject(projectRequest, userId);
        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }

    @Operation(summary = "Get project by ID")
    @GetMapping("/{id}")
    public ResponseEntity<ProjectResponse> getProjectById(@PathVariable Long id) {
        ProjectResponse response = projectService.getProjectById(id);
        return ResponseEntity.ok(response);
    }

    @Operation(summary = "Get all projects")
    @GetMapping
    public ResponseEntity<List<ProjectResponse>> getAllProjects() {
        List<ProjectResponse> response = projectService.getAllProjects();
        return ResponseEntity.ok(response);
    }

    @Operation(summary = "Get projects by status")
    @GetMapping("/status/{status}")
    public ResponseEntity<List<ProjectResponse>> getProjectsByStatus(@PathVariable String status) {
        List<ProjectResponse> response = projectService.getProjectsByStatus(status);
        return ResponseEntity.ok(response);
    }

    @Operation(summary = "Update project")
    @PutMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN') or @projectService.getProjectById(#id).organizerId == authentication.principal.id")
    public ResponseEntity<ProjectResponse> updateProject(@PathVariable Long id, @Valid @RequestBody ProjectRequest projectRequest) {
        ProjectResponse response = projectService.updateProject(id, projectRequest);
        return ResponseEntity.ok(response);
    }

    @Operation(summary = "Delete project")
    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN') or @projectService.getProjectById(#id).organizerId == authentication.principal.id")
    public ResponseEntity<Void> deleteProject(@PathVariable Long id) {
        projectService.deleteProject(id);
        return ResponseEntity.noContent().build();
    }

    @Operation(summary = "Vote for project")
    @PostMapping("/{id}/vote")
    public ResponseEntity<Void> voteForProject(@PathVariable Long id, Authentication authentication) {
        Long userId = getUserIdFromAuthentication(authentication);
        projectService.voteForProject(id, userId);
        return ResponseEntity.ok().build();
    }

    @Operation(summary = "Fund project")
    @PostMapping("/{id}/fund")
    public ResponseEntity<Void> fundProject(@PathVariable Long id, @Valid @RequestBody ProjectFundingRequest fundingRequest, Authentication authentication) {
        Long userId = getUserIdFromAuthentication(authentication);
        fundingRequest.setProjectId(id);
        projectService.fundProject(fundingRequest, userId);
        return ResponseEntity.ok().build();
    }

    @Operation(summary = "Complete project")
    @PostMapping("/{id}/complete")
    @PreAuthorize("hasRole('ADMIN') or @projectService.getProjectById(#id).organizerId == authentication.principal.id")
    public ResponseEntity<ProjectResponse> completeProject(@PathVariable Long id, @RequestParam String finalReport) {
        ProjectResponse response = projectService.completeProject(id, finalReport);
        return ResponseEntity.ok(response);
    }

    private Long getUserIdFromAuthentication(Authentication authentication) {
        // This is a placeholder - you'll need to implement proper user ID extraction
        // from the authentication object
        return 1L; // Placeholder
    }
}

package com.civicplatform.controller;

import com.civicplatform.dto.response.DashboardStatsResponse;
import com.civicplatform.service.DashboardService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/admin")
@RequiredArgsConstructor
@Tag(name = "Admin", description = "Admin management APIs")
public class AdminController {

    private final DashboardService dashboardService;

    @Operation(summary = "Get dashboard statistics")
    @GetMapping("/dashboard")
    public ResponseEntity<DashboardStatsResponse> getDashboardStats() {
        DashboardStatsResponse response = dashboardService.getDashboardStats();
        return ResponseEntity.ok(response);
    }
}

package com.civicplatform.controller;

import com.civicplatform.dto.request.EventRequest;
import com.civicplatform.dto.response.EventResponse;
import com.civicplatform.enums.EventStatus;
import com.civicplatform.service.EventService;
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
@RequestMapping("/events")
@RequiredArgsConstructor
@Tag(name = "Event Management", description = "Event management APIs")
public class EventController {

    private final EventService eventService;

    @Operation(summary = "Create a new event")
    @PostMapping
    public ResponseEntity<EventResponse> createEvent(@Valid @RequestBody EventRequest eventRequest, Authentication authentication) {
        Long userId = getUserIdFromAuthentication(authentication);
        EventResponse response = eventService.createEvent(eventRequest, userId);
        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }

    @Operation(summary = "Get event by ID")
    @GetMapping("/{id}")
    public ResponseEntity<EventResponse> getEventById(@PathVariable Long id) {
        EventResponse response = eventService.getEventById(id);
        return ResponseEntity.ok(response);
    }

    @Operation(summary = "Get all events")
    @GetMapping
    public ResponseEntity<List<EventResponse>> getAllEvents() {
        List<EventResponse> response = eventService.getAllEvents();
        return ResponseEntity.ok(response);
    }

    @Operation(summary = "Get events by status")
    @GetMapping("/status/{status}")
    public ResponseEntity<List<EventResponse>> getEventsByStatus(@PathVariable EventStatus status) {
        List<EventResponse> response = eventService.getEventsByStatus(status);
        return ResponseEntity.ok(response);
    }

    @Operation(summary = "Get events by organizer")
    @GetMapping("/organizer/{organizerId}")
    public ResponseEntity<List<EventResponse>> getEventsByOrganizer(@PathVariable Long organizerId) {
        List<EventResponse> response = eventService.getEventsByOrganizer(organizerId);
        return ResponseEntity.ok(response);
    }

    @Operation(summary = "Get upcoming events")
    @GetMapping("/upcoming")
    public ResponseEntity<List<EventResponse>> getUpcomingEvents() {
        List<EventResponse> response = eventService.getUpcomingEvents();
        return ResponseEntity.ok(response);
    }

    @Operation(summary = "Update event")
    @PutMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN') or @eventService.getEventById(#id).organizerId == authentication.principal.id")
    public ResponseEntity<EventResponse> updateEvent(@PathVariable Long id, @Valid @RequestBody EventRequest eventRequest) {
        EventResponse response = eventService.updateEvent(id, eventRequest);
        return ResponseEntity.ok(response);
    }

    @Operation(summary = "Delete event")
    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN') or @eventService.getEventById(#id).organizerId == authentication.principal.id")
    public ResponseEntity<Void> deleteEvent(@PathVariable Long id) {
        eventService.deleteEvent(id);
        return ResponseEntity.noContent().build();
    }

    @Operation(summary = "Cancel event")
    @PostMapping("/{id}/cancel")
    @PreAuthorize("hasRole('ADMIN') or @eventService.getEventById(#id).organizerId == authentication.principal.id")
    public ResponseEntity<EventResponse> cancelEvent(@PathVariable Long id) {
        EventResponse response = eventService.cancelEvent(id);
        return ResponseEntity.ok(response);
    }

    @Operation(summary = "Register for event")
    @PostMapping("/{id}/register")
    public ResponseEntity<Void> registerForEvent(@PathVariable Long id, Authentication authentication) {
        Long userId = getUserIdFromAuthentication(authentication);
        eventService.registerForEvent(id, userId);
        return ResponseEntity.ok().build();
    }

    @Operation(summary = "Cancel registration")
    @DeleteMapping("/{id}/register")
    public ResponseEntity<Void> cancelRegistration(@PathVariable Long id, Authentication authentication) {
        Long userId = getUserIdFromAuthentication(authentication);
        eventService.cancelRegistration(id, userId);
        return ResponseEntity.ok().build();
    }

    @Operation(summary = "Check in participant")
    @PostMapping("/{id}/checkin")
    @PreAuthorize("hasRole('ADMIN') or @eventService.getEventById(#id).organizerId == authentication.principal.id")
    public ResponseEntity<Void> checkInParticipant(@PathVariable Long id, @RequestParam Long userId) {
        eventService.checkInParticipant(id, userId);
        return ResponseEntity.ok().build();
    }

    private Long getUserIdFromAuthentication(Authentication authentication) {
        // This is a placeholder - you'll need to implement proper user ID extraction
        // from the authentication object
        return 1L; // Placeholder
    }
}

package com.civicplatform.controller;

import com.civicplatform.dto.request.PostRequest;
import com.civicplatform.dto.response.PostResponse;
import com.civicplatform.entity.User;
import com.civicplatform.enums.PostStatus;
import com.civicplatform.repository.UserRepository;
import com.civicplatform.service.PostService;
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
@RequestMapping("/posts")
@RequiredArgsConstructor
@Tag(name = "Post Management", description = "Post management APIs")
public class PostController {

    private final PostService postService;
    private final UserRepository userRepository;

    @Operation(summary = "Create a new post")
    @PostMapping
    public ResponseEntity<PostResponse> createPost(@Valid @RequestBody PostRequest postRequest, Authentication authentication) {
        // Get user ID from authentication (you'll need to implement this logic)
        Long userId = getUserIdFromAuthentication(authentication);
        PostResponse response = postService.createPost(postRequest, userId);
        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }

    @Operation(summary = "Get post by ID")
    @GetMapping("/{id}")
    public ResponseEntity<PostResponse> getPostById(@PathVariable Long id) {
        PostResponse response = postService.getPostById(id);
        return ResponseEntity.ok(response);
    }

    @Operation(summary = "Get all posts")
    @GetMapping
    public ResponseEntity<List<PostResponse>> getAllPosts() {
        List<PostResponse> response = postService.getAllPosts();
        return ResponseEntity.ok(response);
    }

    @Operation(summary = "Get posts by status")
    @GetMapping("/status/{status}")
    public ResponseEntity<List<PostResponse>> getPostsByStatus(@PathVariable PostStatus status) {
        List<PostResponse> response = postService.getPostsByStatus(status);
        return ResponseEntity.ok(response);
    }

    @Operation(summary = "Get posts by campaign")
    @GetMapping("/campaign/{campaignId}")
    public ResponseEntity<List<PostResponse>> getPostsByCampaign(@PathVariable Long campaignId) {
        List<PostResponse> response = postService.getPostsByCampaign(campaignId);
        return ResponseEntity.ok(response);
    }

    @Operation(summary = "Update post")
    @PutMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN') or @postService.getPostById(#id).creator == authentication.name")
    public ResponseEntity<PostResponse> updatePost(@PathVariable Long id, @Valid @RequestBody PostRequest postRequest) {
        PostResponse response = postService.updatePost(id, postRequest);
        return ResponseEntity.ok(response);
    }

    @Operation(summary = "Delete post")
    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN') or @postService.getPostById(#id).creator == authentication.name")
    public ResponseEntity<Void> deletePost(@PathVariable Long id) {
        postService.deletePost(id);
        return ResponseEntity.noContent().build();
    }

    @Operation(summary = "Approve post")
    @PostMapping("/{id}/approve")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<PostResponse> approvePost(@PathVariable Long id) {
        PostResponse response = postService.approvePost(id);
        return ResponseEntity.ok(response);
    }

    @Operation(summary = "Reject post")
    @PostMapping("/{id}/reject")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<PostResponse> rejectPost(@PathVariable Long id) {
        PostResponse response = postService.rejectPost(id);
        return ResponseEntity.ok(response);
    }

    private Long getUserIdFromAuthentication(Authentication authentication) {
        String email = authentication.getName();
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Authenticated user not found"));
        return user.getId();
    }
}

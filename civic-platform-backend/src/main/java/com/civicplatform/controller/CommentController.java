package com.civicplatform.controller;

import com.civicplatform.dto.request.CommentRequest;
import com.civicplatform.dto.response.CommentResponse;
import com.civicplatform.service.CommentService;
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
@RequestMapping("/comments")
@RequiredArgsConstructor
@Tag(name = "Comment Management", description = "Comment management APIs")
public class CommentController {

    private final CommentService commentService;

    @Operation(summary = "Create a new comment")
    @PostMapping
    public ResponseEntity<CommentResponse> createComment(@Valid @RequestBody CommentRequest commentRequest, Authentication authentication) {
        Long userId = getUserIdFromAuthentication(authentication);
        CommentResponse response = commentService.createComment(commentRequest, userId);
        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }

    @Operation(summary = "Get comment by ID")
    @GetMapping("/{id}")
    public ResponseEntity<CommentResponse> getCommentById(@PathVariable Long id) {
        CommentResponse response = commentService.getCommentById(id);
        return ResponseEntity.ok(response);
    }

    @Operation(summary = "Get comments by post")
    @GetMapping("/post/{postId}")
    public ResponseEntity<List<CommentResponse>> getCommentsByPost(@PathVariable Long postId) {
        List<CommentResponse> response = commentService.getCommentsByPost(postId);
        return ResponseEntity.ok(response);
    }

    @Operation(summary = "Get comments by author")
    @GetMapping("/author/{authorId}")
    public ResponseEntity<List<CommentResponse>> getCommentsByAuthor(@PathVariable Long authorId) {
        List<CommentResponse> response = commentService.getCommentsByAuthor(authorId);
        return ResponseEntity.ok(response);
    }

    @Operation(summary = "Update comment")
    @PutMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN') or @commentService.getCommentById(#id).authorEmail == authentication.name")
    public ResponseEntity<CommentResponse> updateComment(@PathVariable Long id, @Valid @RequestBody CommentRequest commentRequest) {
        CommentResponse response = commentService.updateComment(id, commentRequest);
        return ResponseEntity.ok(response);
    }

    @Operation(summary = "Delete comment")
    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN') or @commentService.getCommentById(#id).authorEmail == authentication.name")
    public ResponseEntity<Void> deleteComment(@PathVariable Long id) {
        commentService.deleteComment(id);
        return ResponseEntity.noContent().build();
    }

    private Long getUserIdFromAuthentication(Authentication authentication) {
        // This is a placeholder - you'll need to implement proper user ID extraction
        // from the authentication object
        return 1L; // Placeholder
    }
}

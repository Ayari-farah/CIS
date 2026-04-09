package com.civicplatform.controller;

import com.civicplatform.dto.request.CommentRequest;
import com.civicplatform.dto.response.CommentResponse;
import com.civicplatform.entity.User;
import com.civicplatform.repository.UserRepository;
import com.civicplatform.security.RegularAccountPolicy;
import com.civicplatform.service.CommentService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/comments")
@RequiredArgsConstructor
@Tag(name = "Comment Management", description = "Comment management APIs")
public class CommentController {

    private final CommentService commentService;
    private final UserRepository userRepository;

    @Operation(summary = "Create a new comment")
    @PostMapping
    public ResponseEntity<CommentResponse> createComment(@Valid @RequestBody CommentRequest commentRequest, Authentication authentication) {
        User user = getUserFromAuthentication(authentication);
        RegularAccountPolicy.requireRegularUser(user);
        Long userId = user.getId();
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
    public ResponseEntity<CommentResponse> updateComment(@PathVariable Long id, @Valid @RequestBody CommentRequest commentRequest, Authentication authentication) {
        checkCommentOwnership(id, authentication);
        CommentResponse response = commentService.updateComment(id, commentRequest);
        return ResponseEntity.ok(response);
    }

    @Operation(summary = "Delete comment")
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteComment(@PathVariable Long id, Authentication authentication) {
        checkCommentOwnership(id, authentication);
        commentService.deleteComment(id);
        return ResponseEntity.noContent().build();
    }

    private void checkCommentOwnership(Long commentId, Authentication authentication) {
        User user = userRepository.findByEmail(authentication.getName())
                .orElseThrow(() -> new RuntimeException("Authenticated user not found"));
        RegularAccountPolicy.requireRegularUser(user);
        CommentResponse comment = commentService.getCommentById(commentId);
        if (!authentication.getName().equals(comment.getAuthorEmail())) {
            throw new org.springframework.security.access.AccessDeniedException("You are not the author of this comment");
        }
    }

    private User getUserFromAuthentication(Authentication authentication) {
        return userRepository.findByEmail(authentication.getName())
                .orElseThrow(() -> new RuntimeException("Authenticated user not found"));
    }
}

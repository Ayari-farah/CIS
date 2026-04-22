package com.civicplatform.controller;

import com.civicplatform.dto.request.CommentRequest;
import com.civicplatform.dto.response.CommentResponse;
import com.civicplatform.entity.CommentAttachment;
import com.civicplatform.entity.User;
import com.civicplatform.repository.CommentAttachmentRepository;
import com.civicplatform.security.CurrentUserResolver;
import com.civicplatform.security.RegularAccountPolicy;
import com.civicplatform.service.CommentService;
import com.civicplatform.service.PostMediaStorageService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@RestController
@RequestMapping("/comments")
@RequiredArgsConstructor
@Tag(name = "Comment Management", description = "Comment management APIs")
public class CommentController {

    private final CommentService commentService;
    private final CurrentUserResolver currentUserResolver;
    private final CommentAttachmentRepository commentAttachmentRepository;
    private final PostMediaStorageService postMediaStorageService;

    @Operation(summary = "Create a new comment (JSON body)")
    @PostMapping(consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<CommentResponse> createComment(@Valid @RequestBody CommentRequest commentRequest, Authentication authentication) {
        User user = getUserFromAuthentication(authentication);
        RegularAccountPolicy.requireRegularUser(user);
        Long userId = user.getId();
        CommentResponse response = commentService.createComment(commentRequest, userId);
        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }

    @Operation(summary = "Create a comment with optional image/video attachments")
    @PostMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<CommentResponse> createCommentMultipart(
            @RequestParam(required = false) String content,
            @RequestParam Long postId,
            @RequestParam(value = "files", required = false) MultipartFile[] files,
            Authentication authentication) {
        User user = getUserFromAuthentication(authentication);
        RegularAccountPolicy.requireRegularUser(user);
        List<MultipartFile> list = files == null ? List.of() : Arrays.asList(files);
        CommentResponse response = commentService.createCommentWithMedia(content, postId, list, user.getId());
        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }

    @Operation(summary = "Download a comment media attachment")
    @GetMapping("/{commentId}/attachments/{attachmentId}")
    public ResponseEntity<Resource> getCommentAttachment(
            @PathVariable Long commentId,
            @PathVariable Long attachmentId) {
        CommentAttachment a = commentAttachmentRepository.findById(attachmentId)
                .orElseThrow(() -> new RuntimeException("Attachment not found"));
        if (!a.getComment().getId().equals(commentId)) {
            return ResponseEntity.notFound().build();
        }
        try {
            Resource resource = postMediaStorageService.loadCommentResource(commentId, a.getFilename());
            if (resource == null || !resource.exists() || !resource.isReadable()) {
                return ResponseEntity.notFound().build();
            }
            MediaType mt = a.getMimeType() != null
                    ? MediaType.parseMediaType(a.getMimeType())
                    : MediaType.APPLICATION_OCTET_STREAM;
            return ResponseEntity.ok().contentType(mt).body(resource);
        } catch (IOException e) {
            return ResponseEntity.notFound().build();
        }
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
        User user = currentUserResolver.resolveRequired(authentication);
        RegularAccountPolicy.requireRegularUser(user);
        CommentResponse comment = commentService.getCommentById(commentId);
        if (!user.getEmail().equalsIgnoreCase(comment.getAuthorEmail())) {
            throw new org.springframework.security.access.AccessDeniedException("You are not the author of this comment");
        }
    }

    private User getUserFromAuthentication(Authentication authentication) {
        return currentUserResolver.resolveRequired(authentication);
    }
}

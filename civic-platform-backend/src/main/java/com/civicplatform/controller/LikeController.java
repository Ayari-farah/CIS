package com.civicplatform.controller;

import com.civicplatform.service.LikeService;
import com.civicplatform.entity.User;
import com.civicplatform.repository.UserRepository;
import com.civicplatform.security.RegularAccountPolicy;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/likes")
@RequiredArgsConstructor
@Tag(name = "Like Management", description = "Like management APIs")
public class LikeController {

    private final LikeService likeService;
    private final UserRepository userRepository;

    @Operation(summary = "Like a post")
    @PostMapping("/posts/{postId}")
    public ResponseEntity<Void> likePost(@PathVariable Long postId, Authentication authentication) {
        User user = getUserFromAuthentication(authentication);
        RegularAccountPolicy.requireRegularUser(user);
        Long userId = user.getId();
        likeService.likePost(postId, userId);
        return ResponseEntity.ok().build();
    }

    @Operation(summary = "Unlike a post")
    @DeleteMapping("/posts/{postId}")
    public ResponseEntity<Void> unlikePost(@PathVariable Long postId, Authentication authentication) {
        User user = getUserFromAuthentication(authentication);
        RegularAccountPolicy.requireRegularUser(user);
        Long userId = user.getId();
        likeService.unlikePost(postId, userId);
        return ResponseEntity.ok().build();
    }

    @Operation(summary = "Check if post is liked by user")
    @GetMapping("/posts/{postId}/check")
    public ResponseEntity<Boolean> isPostLikedByUser(@PathVariable Long postId, Authentication authentication) {
        User user = getUserFromAuthentication(authentication);
        RegularAccountPolicy.requireRegularUser(user);
        Long userId = user.getId();
        boolean isLiked = likeService.isPostLikedByUser(postId, userId);
        return ResponseEntity.ok(isLiked);
    }

    @Operation(summary = "Get likes count for a post")
    @GetMapping("/posts/{postId}/count")
    public ResponseEntity<Long> getLikesCount(@PathVariable Long postId) {
        long count = likeService.getLikesCount(postId);
        return ResponseEntity.ok(count);
    }

    private User getUserFromAuthentication(Authentication authentication) {
        return userRepository.findByEmail(authentication.getName())
                .orElseThrow(() -> new RuntimeException("Authenticated user not found"));
    }
}

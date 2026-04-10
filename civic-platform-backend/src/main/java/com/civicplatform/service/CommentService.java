package com.civicplatform.service;

import com.civicplatform.dto.request.CommentRequest;
import com.civicplatform.dto.response.CommentResponse;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface CommentService {
    CommentResponse createComment(CommentRequest commentRequest, Long authorId);
    CommentResponse createCommentWithMedia(String content, Long postId, List<MultipartFile> files, Long authorId);
    CommentResponse getCommentById(Long id);
    List<CommentResponse> getCommentsByPost(Long postId);
    List<CommentResponse> getCommentsByAuthor(Long authorId);
    CommentResponse updateComment(Long id, CommentRequest commentRequest);
    void deleteComment(Long id);
}

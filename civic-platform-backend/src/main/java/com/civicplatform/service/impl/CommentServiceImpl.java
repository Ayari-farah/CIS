package com.civicplatform.service.impl;

import com.civicplatform.dto.request.CommentRequest;
import com.civicplatform.dto.response.CommentResponse;
import com.civicplatform.entity.Comment;
import com.civicplatform.entity.Post;
import com.civicplatform.entity.User;
import com.civicplatform.mapper.CommentMapper;
import com.civicplatform.repository.CommentRepository;
import com.civicplatform.repository.PostRepository;
import com.civicplatform.repository.UserRepository;
import com.civicplatform.service.CommentService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class CommentServiceImpl implements CommentService {

    private final CommentRepository commentRepository;
    private final UserRepository userRepository;
    private final PostRepository postRepository;
    private final CommentMapper commentMapper;

    @Override
    @Transactional
    public CommentResponse createComment(CommentRequest commentRequest, Long authorId) {
        User author = userRepository.findById(authorId)
                .orElseThrow(() -> new RuntimeException("User not found with id: " + authorId));

        Post post = postRepository.findById(commentRequest.getPostId())
                .orElseThrow(() -> new RuntimeException("Post not found with id: " + commentRequest.getPostId()));

        Comment comment = commentMapper.toEntity(commentRequest);
        comment.setAuthor(author);
        comment.setPost(post);

        comment = commentRepository.save(comment);
        return commentMapper.toResponse(comment);
    }

    @Override
    public CommentResponse getCommentById(Long id) {
        Comment comment = commentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Comment not found with id: " + id));
        return commentMapper.toResponse(comment);
    }

    @Override
    public List<CommentResponse> getCommentsByPost(Long postId) {
        List<Comment> comments = commentRepository.findByPostIdOrderByCreatedAtDesc(postId);
        return comments.stream()
                .map(commentMapper::toResponse)
                .collect(Collectors.toList());
    }

    @Override
    public List<CommentResponse> getCommentsByAuthor(Long authorId) {
        List<Comment> comments = commentRepository.findByAuthorId(authorId);
        return comments.stream()
                .map(commentMapper::toResponse)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public CommentResponse updateComment(Long id, CommentRequest commentRequest) {
        Comment comment = commentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Comment not found with id: " + id));

        commentMapper.updateEntity(commentRequest, comment);
        comment = commentRepository.save(comment);
        return commentMapper.toResponse(comment);
    }

    @Override
    @Transactional
    public void deleteComment(Long id) {
        if (!commentRepository.existsById(id)) {
            throw new RuntimeException("Comment not found with id: " + id);
        }
        commentRepository.deleteById(id);
    }
}

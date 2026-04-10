package com.civicplatform.mapper;

import com.civicplatform.dto.request.CommentRequest;
import com.civicplatform.dto.response.CommentResponse;
import com.civicplatform.entity.Comment;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

import java.util.List;

@Mapper(componentModel = "spring")
public interface CommentMapper {

    @Mapping(target = "authorId", source = "author.id")
    @Mapping(target = "authorName", source = "author.userName")
    @Mapping(target = "authorEmail", source = "author.email")
    @Mapping(target = "postId", source = "post.id")
    @Mapping(target = "attachments", ignore = true)
    CommentResponse toResponse(Comment comment);
    
    List<CommentResponse> toResponseList(List<Comment> comments);
    
    @Mapping(target = "id", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "author", ignore = true)
    @Mapping(target = "post", ignore = true)
    @Mapping(target = "attachments", ignore = true)
    Comment toEntity(CommentRequest commentRequest);
    
    @Mapping(target = "id", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "author", ignore = true)
    @Mapping(target = "post", ignore = true)
    @Mapping(target = "attachments", ignore = true)
    void updateEntity(CommentRequest commentRequest, @MappingTarget Comment comment);
}

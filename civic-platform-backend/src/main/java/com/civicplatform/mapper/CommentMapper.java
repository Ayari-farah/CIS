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

    @Mapping(target = "authorName", source = "author.userName")
    @Mapping(target = "authorEmail", source = "author.email")
    CommentResponse toResponse(Comment comment);
    
    List<CommentResponse> toResponseList(List<Comment> comments);
    
    @Mapping(target = "id", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "author", ignore = true)
    @Mapping(target = "post", ignore = true)
    Comment toEntity(CommentRequest commentRequest);
    
    void updateEntity(CommentRequest commentRequest, @MappingTarget Comment comment);
}

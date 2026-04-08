package com.civicplatform.mapper;

import com.civicplatform.dto.request.PostRequest;
import com.civicplatform.dto.response.PostResponse;
import com.civicplatform.entity.Post;
import com.civicplatform.enums.PostStatus;
import org.mapstruct.AfterMapping;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.Named;

import java.util.List;

@Mapper(componentModel = "spring", uses = {CommentMapper.class})
public interface PostMapper {

    @Mapping(target = "campaignId", source = "campaign.id")
    @Mapping(target = "campaignName", source = "campaign.name")
    @Mapping(target = "comments", source = "comments")
    PostResponse toResponse(Post post);
    
    List<PostResponse> toResponseList(List<Post> posts);
    
    @Mapping(target = "id", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "likesCount", ignore = true)
    @Mapping(target = "status", ignore = true)
    @Mapping(target = "campaign", ignore = true)
    @Mapping(target = "comments", ignore = true)
    @Mapping(target = "likes", ignore = true)
    Post toEntity(PostRequest postRequest);
    
    @AfterMapping
    default void setDefaults(@MappingTarget Post post) {
        if (post.getStatus() == null) {
            post.setStatus(PostStatus.PENDING);
        }
        if (post.getLikesCount() == null) {
            post.setLikesCount(0);
        }
    }
    
    @Mapping(target = "id", ignore = true)
    @Mapping(target = "creator", ignore = true)
    @Mapping(target = "status", ignore = true)
    @Mapping(target = "likesCount", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "campaign", ignore = true)
    @Mapping(target = "comments", ignore = true)
    @Mapping(target = "likes", ignore = true)
    void updateEntity(PostRequest postRequest, @MappingTarget Post post);
    
    @Named("getCreatorName")
    default String getCreatorName(Long userId) {
        // This would typically require a service call
        return "User " + userId;
    }
}

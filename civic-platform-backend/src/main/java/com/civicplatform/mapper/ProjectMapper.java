package com.civicplatform.mapper;

import com.civicplatform.dto.request.ProjectRequest;
import com.civicplatform.dto.response.ProjectResponse;
import com.civicplatform.entity.Project;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

import java.util.List;

@Mapper(componentModel = "spring", uses = {ProjectFundingMapper.class})
public interface ProjectMapper {

    @Mapping(target = "fundings", source = "fundings")
    ProjectResponse toResponse(Project project);
    
    List<ProjectResponse> toResponseList(List<Project> projects);
    
    @Mapping(target = "id", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "currentAmount", ignore = true)
    @Mapping(target = "voteCount", ignore = true)
    @Mapping(target = "status", ignore = true)
    @Mapping(target = "startDate", ignore = true)
    @Mapping(target = "completionDate", ignore = true)
    @Mapping(target = "finalReport", ignore = true)
    @Mapping(target = "fundings", ignore = true)
    Project toEntity(ProjectRequest projectRequest);
    
    void updateEntity(ProjectRequest projectRequest, @MappingTarget Project project);
}

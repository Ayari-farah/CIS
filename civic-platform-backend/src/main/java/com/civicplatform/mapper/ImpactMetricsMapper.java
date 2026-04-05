package com.civicplatform.mapper;

import com.civicplatform.dto.response.ImpactMetricsResponse;
import com.civicplatform.entity.ImpactMetrics;
import org.mapstruct.Mapper;

import java.util.List;

@Mapper(componentModel = "spring")
public interface ImpactMetricsMapper {

    ImpactMetricsResponse toResponse(ImpactMetrics impactMetrics);
    
    List<ImpactMetricsResponse> toResponseList(List<ImpactMetrics> impactMetrics);
}

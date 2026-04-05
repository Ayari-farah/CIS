package com.civicplatform.mapper;

import com.civicplatform.dto.request.CampaignRequest;
import com.civicplatform.dto.response.CampaignResponse;
import com.civicplatform.entity.Campaign;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;
import org.mapstruct.Named;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Mapper(componentModel = "spring", uses = {PostMapper.class})
public interface CampaignMapper {

    @Mapping(target = "createdByName", expression = "java(campaign.getCreatedBy() != null ? campaign.getCreatedBy().getUserName() : null)")
    @Mapping(target = "voteCount", ignore = true)
    @Mapping(target = "posts", source = "posts")
    CampaignResponse toResponse(Campaign campaign);
    
    List<CampaignResponse> toResponseList(List<Campaign> campaigns);
    
    @Mapping(target = "id", ignore = true)
    @Mapping(target = "createdAt", ignore = true)
    @Mapping(target = "status", ignore = true)
    @Mapping(target = "currentKg", ignore = true)
    @Mapping(target = "currentMeals", ignore = true)
    @Mapping(target = "createdBy", ignore = true)
    @Mapping(target = "posts", ignore = true)
    @Mapping(target = "votes", ignore = true)
    @Mapping(target = "startDate", source = "startDate", qualifiedByName = "stringToLocalDate")
    @Mapping(target = "endDate", source = "endDate", qualifiedByName = "stringToLocalDate")
    Campaign toEntity(CampaignRequest campaignRequest);
    
    void updateEntity(CampaignRequest campaignRequest, @MappingTarget Campaign campaign);
    
    @Named("stringToLocalDate")
    default LocalDate stringToLocalDate(String date) {
        if (date == null || date.trim().isEmpty()) {
            return null;
        }
        return LocalDate.parse(date, DateTimeFormatter.ISO_LOCAL_DATE);
    }
}

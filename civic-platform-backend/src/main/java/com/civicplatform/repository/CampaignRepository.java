package com.civicplatform.repository;

import com.civicplatform.entity.Campaign;
import com.civicplatform.enums.CampaignStatus;
import com.civicplatform.enums.CampaignType;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CampaignRepository extends JpaRepository<Campaign, Long> {
    
    List<Campaign> findByStatus(CampaignStatus status);
    
    Page<Campaign> findByStatus(CampaignStatus status, Pageable pageable);
    
    List<Campaign> findByType(CampaignType type);
    
    Page<Campaign> findByType(CampaignType type, Pageable pageable);
    
    List<Campaign> findByCreatedById(Long createdById);
    
    @Query("SELECT COUNT(c) FROM Campaign c WHERE c.status = :status")
    long countByStatus(CampaignStatus status);
    
    @Query("SELECT c FROM Campaign c WHERE c.status = 'DRAFT' AND " +
           "(SELECT COUNT(cv) FROM CampaignVote cv WHERE cv.campaign.id = c.id) >= 100")
    List<Campaign> findCampaignsReadyForActivation();
}

package com.civicplatform.repository;

import com.civicplatform.entity.CampaignVote;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface CampaignVoteRepository extends JpaRepository<CampaignVote, Long> {
    
    Optional<CampaignVote> findByUserIdAndCampaignId(Long userId, Long campaignId);
    
    long countByCampaignId(Long campaignId);
    
    void deleteByUserIdAndCampaignId(Long userId, Long campaignId);
}

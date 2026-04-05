package com.civicplatform.repository;

import com.civicplatform.entity.ProjectFunding;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;

@Repository
public interface ProjectFundingRepository extends JpaRepository<ProjectFunding, Long> {
    
    List<ProjectFunding> findByProjectIdOrderByFundDateDesc(Long projectId);
    
    List<ProjectFunding> findByUserId(Long userId);
    
    @Query("SELECT SUM(pf.amount) FROM ProjectFunding pf WHERE pf.project.id = :projectId")
    BigDecimal sumFundingByProject(Long projectId);
    
    @Query("SELECT COUNT(pf) FROM ProjectFunding pf WHERE pf.user.id = :userId")
    long countFundingsByUser(Long userId);
}

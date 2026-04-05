package com.civicplatform.repository;

import com.civicplatform.entity.Project;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.List;

@Repository
public interface ProjectRepository extends JpaRepository<Project, Long> {
    
    List<Project> findByStatus(String status);
    
    Page<Project> findByStatus(String status, Pageable pageable);
    
    @Query("SELECT p FROM Project p WHERE p.currentAmount < p.goalAmount ORDER BY (p.currentAmount / p.goalAmount) DESC")
    List<Project> findProjectsNeedingFunding();
    
    @Query("SELECT p FROM Project p ORDER BY p.voteCount DESC")
    List<Project> findMostVotedProjects();
    
    @Query("SELECT COUNT(p) FROM Project p WHERE p.status = :status")
    long countByStatus(String status);
    
    @Query("SELECT SUM(p.currentAmount) FROM Project p WHERE p.status = 'COMPLETED'")
    BigDecimal sumCompletedProjectAmounts();
    
    @Query("SELECT COUNT(p) FROM Project p WHERE p.currentAmount >= p.goalAmount")
    long countFullyFundedProjects();
}

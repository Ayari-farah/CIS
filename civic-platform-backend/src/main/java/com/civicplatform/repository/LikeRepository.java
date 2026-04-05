package com.civicplatform.repository;

import com.civicplatform.entity.Like;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface LikeRepository extends JpaRepository<Like, Long> {
    
    Optional<Like> findByOwnerIdAndPostId(Long ownerId, Long postId);
    
    void deleteByOwnerIdAndPostId(Long ownerId, Long postId);
    
    long countByPostId(Long postId);
}

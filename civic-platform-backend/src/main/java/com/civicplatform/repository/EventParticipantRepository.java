package com.civicplatform.repository;

import com.civicplatform.entity.EventParticipant;
import com.civicplatform.enums.ParticipantStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface EventParticipantRepository extends JpaRepository<EventParticipant, Long> {
    
    Optional<EventParticipant> findByEventIdAndUserId(Long eventId, Long userId);
    
    List<EventParticipant> findByEventIdOrderByRegisteredAtAsc(Long eventId);
    
    List<EventParticipant> findByUserId(Long userId);
    
    @Query("SELECT COUNT(ep) FROM EventParticipant ep WHERE ep.event.id = :eventId AND ep.status IN ('REGISTERED', 'CHECKED_IN')")
    long countActiveParticipants(Long eventId);
    
    @Query("SELECT COUNT(ep) FROM EventParticipant ep WHERE ep.user.id = :userId AND ep.status = 'COMPLETED'")
    long countCompletedEventsByUser(Long userId);
    
    void deleteByEventIdAndUserId(Long eventId, Long userId);
}

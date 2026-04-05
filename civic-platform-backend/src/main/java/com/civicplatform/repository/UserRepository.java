package com.civicplatform.repository;

import com.civicplatform.entity.User;
import com.civicplatform.enums.UserType;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    
    Optional<User> findByEmail(String email);
    
    boolean existsByEmail(String email);
    
    boolean existsByUserName(String userName);
    
    List<User> findByUserType(UserType userType);
    
    @Query("SELECT COUNT(u) FROM User u WHERE u.userType = :userType")
    long countByUserType(UserType userType);
    
    @Query("SELECT u FROM User u WHERE u.userType = 'CITIZEN' AND " +
           "(SELECT COUNT(ep) FROM EventParticipant ep WHERE ep.user.id = u.id AND ep.status = 'COMPLETED') >= 3")
    List<User> findCitizensEligibleForAmbassadorPromotion();
}

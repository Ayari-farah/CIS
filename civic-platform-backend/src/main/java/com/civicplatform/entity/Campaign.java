package com.civicplatform.entity;

import com.civicplatform.enums.CampaignStatus;
import com.civicplatform.enums.CampaignType;
import com.civicplatform.enums.UserType;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "campaign")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EntityListeners(AuditingEntityListener.class)
public class Campaign {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false)
    private String name;
    
    @Column(precision = 15, scale = 2)
    private BigDecimal neededAmount;
    
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private CampaignType type;
    
    @Column(columnDefinition = "TEXT")
    private String description;
    
    @Column(name = "start_date")
    private LocalDate startDate;
    
    @Column(name = "end_date")
    private LocalDate endDate;
    
    @Column(name = "goal_kg")
    private Integer goalKg;
    
    @Column(name = "goal_meals")
    private Integer goalMeals;
    
    @Column(name = "goal_amount", precision = 15, scale = 2)
    private BigDecimal goalAmount;
    
    @Column(name = "current_kg")
    private Integer currentKg = 0;
    
    @Column(name = "current_meals")
    private Integer currentMeals = 0;
    
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private CampaignStatus status = CampaignStatus.DRAFT;
    
    private String hashtag;
    
    @CreatedDate
    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;
    
    // Relationships
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "created_by_id", nullable = false)
    private User createdBy;
    
    @OneToMany(mappedBy = "campaign", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Post> posts;
    
    @OneToMany(mappedBy = "campaign", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<CampaignVote> votes;
    
    // Helper methods
    public void launch() {
        if (this.status == CampaignStatus.DRAFT) {
            this.status = CampaignStatus.ACTIVE;
            if (this.startDate == null) {
                this.startDate = LocalDate.now();
            }
        }
    }
    
    public void close() {
        this.status = CampaignStatus.COMPLETED;
        this.endDate = LocalDate.now();
    }
    
    public void cancel() {
        this.status = CampaignStatus.CANCELLED;
        this.endDate = LocalDate.now();
    }
}

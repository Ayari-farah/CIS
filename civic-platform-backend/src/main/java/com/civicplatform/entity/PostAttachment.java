package com.civicplatform.entity;

import com.civicplatform.enums.MediaKind;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "post_attachment")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PostAttachment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "post_id", nullable = false)
    private Post post;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private MediaKind kind;

    @Column(nullable = false, length = 255)
    private String filename;

    @Column(length = 128)
    private String mimeType;
}

package com.civicplatform.repository;

import com.civicplatform.entity.PostAttachment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;

@Repository
public interface PostAttachmentRepository extends JpaRepository<PostAttachment, Long> {

    List<PostAttachment> findByPost_IdOrderByIdAsc(Long postId);

    List<PostAttachment> findByPost_IdIn(Collection<Long> postIds);
}

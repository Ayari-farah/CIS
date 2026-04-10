package com.civicplatform.repository;

import com.civicplatform.entity.CommentAttachment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;

@Repository
public interface CommentAttachmentRepository extends JpaRepository<CommentAttachment, Long> {

    List<CommentAttachment> findByComment_IdOrderByIdAsc(Long commentId);

    List<CommentAttachment> findByComment_IdIn(Collection<Long> commentIds);
}

package com.civicplatform.service;

import com.civicplatform.entity.Comment;
import com.civicplatform.entity.CommentAttachment;
import com.civicplatform.entity.Post;
import com.civicplatform.entity.PostAttachment;
import com.civicplatform.enums.MediaKind;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

@Service
public class PostMediaStorageService {

    private final Path postRoot;
    private final Path commentRoot;

    public PostMediaStorageService(
            @Value("${app.upload.post-media-dir:${user.home}/.civic-platform/uploads/post-media}") String postDir,
            @Value("${app.upload.comment-media-dir:${user.home}/.civic-platform/uploads/comment-media}") String commentDir) {
        this.postRoot = Paths.get(postDir).toAbsolutePath().normalize();
        this.commentRoot = Paths.get(commentDir).toAbsolutePath().normalize();
        try {
            Files.createDirectories(this.postRoot);
            Files.createDirectories(this.commentRoot);
        } catch (IOException e) {
            throw new IllegalStateException("Could not create post/comment media directories", e);
        }
    }

    public Path postFilePath(Long postId, String filename) {
        return postRoot.resolve(String.valueOf(postId)).resolve(filename);
    }

    public Path commentFilePath(Long commentId, String filename) {
        return commentRoot.resolve(String.valueOf(commentId)).resolve(filename);
    }

    public PostAttachment storePostFile(Post post, MultipartFile file) throws IOException {
        String ct = file.getContentType();
        if (ct == null) {
            throw new IllegalArgumentException("Could not determine file type.");
        }
        MediaKind kind = kindForContentType(ct);
        String ext = extensionFor(kind, ct);
        String filename = UUID.randomUUID().toString() + "." + ext;
        Path dir = postRoot.resolve(String.valueOf(post.getId()));
        Files.createDirectories(dir);
        Path dest = dir.resolve(filename);
        Files.copy(file.getInputStream(), dest, StandardCopyOption.REPLACE_EXISTING);
        PostAttachment att = PostAttachment.builder()
                .post(post)
                .kind(kind)
                .filename(filename)
                .mimeType(ct)
                .build();
        return att;
    }

    public CommentAttachment storeCommentFile(Comment comment, MultipartFile file) throws IOException {
        String ct = file.getContentType();
        if (ct == null) {
            throw new IllegalArgumentException("Could not determine file type.");
        }
        MediaKind kind = kindForContentType(ct);
        String ext = extensionFor(kind, ct);
        String filename = UUID.randomUUID().toString() + "." + ext;
        Path dir = commentRoot.resolve(String.valueOf(comment.getId()));
        Files.createDirectories(dir);
        Path dest = dir.resolve(filename);
        Files.copy(file.getInputStream(), dest, StandardCopyOption.REPLACE_EXISTING);
        return CommentAttachment.builder()
                .comment(comment)
                .kind(kind)
                .filename(filename)
                .mimeType(ct)
                .build();
    }

    public Resource loadPostResource(Long postId, String filename) throws IOException {
        Path p = postFilePath(postId, filename);
        if (!Files.isRegularFile(p)) {
            return null;
        }
        return new UrlResource(p.toUri());
    }

    public Resource loadCommentResource(Long commentId, String filename) throws IOException {
        Path p = commentFilePath(commentId, filename);
        if (!Files.isRegularFile(p)) {
            return null;
        }
        return new UrlResource(p.toUri());
    }

    public void deletePostFolder(Long postId) {
        deleteRecursively(postRoot.resolve(String.valueOf(postId)));
    }

    public void deleteCommentFolder(Long commentId) {
        deleteRecursively(commentRoot.resolve(String.valueOf(commentId)));
    }

    private static void deleteRecursively(Path p) {
        try {
            if (!Files.exists(p)) {
                return;
            }
            Files.walk(p)
                    .sorted((a, b) -> b.compareTo(a))
                    .forEach(path -> {
                        try {
                            Files.deleteIfExists(path);
                        } catch (IOException ignored) {
                        }
                    });
        } catch (IOException ignored) {
        }
    }

    private static MediaKind kindForContentType(String contentType) {
        String c = contentType.toLowerCase();
        if (c.startsWith("image/")) {
            return MediaKind.IMAGE;
        }
        if (c.startsWith("video/")) {
            return MediaKind.VIDEO;
        }
        throw new IllegalArgumentException("Only image and video files are allowed.");
    }

    private static String extensionFor(MediaKind kind, String contentType) {
        String c = contentType.toLowerCase();
        return switch (c) {
            case "image/jpeg", "image/jpg" -> "jpg";
            case "image/png" -> "png";
            case "image/gif" -> "gif";
            case "image/webp" -> "webp";
            case "video/mp4" -> "mp4";
            case "video/webm" -> "webm";
            case "video/quicktime" -> "mov";
            default -> kind == MediaKind.IMAGE ? "bin" : "bin";
        };
    }
}

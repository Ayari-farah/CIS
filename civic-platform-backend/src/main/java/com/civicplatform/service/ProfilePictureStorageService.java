package com.civicplatform.service;

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

@Service
public class ProfilePictureStorageService {

    private final Path rootLocation;

    public ProfilePictureStorageService(
            @Value("${app.upload.profile-dir:${user.home}/.civic-platform/uploads/profile}") String dir) {
        this.rootLocation = Paths.get(dir).toAbsolutePath().normalize();
        try {
            Files.createDirectories(this.rootLocation);
        } catch (IOException e) {
            throw new IllegalStateException("Could not create profile upload directory: " + this.rootLocation, e);
        }
    }

    public Path pathFor(Long userId, String extension) {
        return rootLocation.resolve(userId + "." + extension);
    }

    public void store(Long userId, String extension, MultipartFile file) throws IOException {
        Path dest = pathFor(userId, extension);
        Files.copy(file.getInputStream(), dest, StandardCopyOption.REPLACE_EXISTING);
    }

    public void deleteIfExists(Long userId, String extension) {
        if (extension == null || extension.isBlank()) {
            return;
        }
        try {
            Files.deleteIfExists(pathFor(userId, extension));
        } catch (IOException ignored) {
            // best-effort cleanup
        }
    }

    public Resource loadAsResource(Long userId, String extension) throws IOException {
        Path dest = pathFor(userId, extension);
        if (!Files.isRegularFile(dest)) {
            return null;
        }
        return new UrlResource(dest.toUri());
    }
}

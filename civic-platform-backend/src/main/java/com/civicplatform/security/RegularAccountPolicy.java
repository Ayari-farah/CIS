package com.civicplatform.security;

import com.civicplatform.entity.User;
import org.springframework.security.access.AccessDeniedException;

/**
 * Admin accounts manage the platform only; they must not use participant features.
 */
public final class RegularAccountPolicy {

    public static final String ADMIN_CANNOT_PARTICIPATE =
            "Admin accounts cannot perform this action. Use a regular account to participate.";

    private RegularAccountPolicy() {}

    public static void requireRegularUser(User user) {
        if (user != null && user.isAdmin()) {
            throw new AccessDeniedException(ADMIN_CANNOT_PARTICIPATE);
        }
    }
}

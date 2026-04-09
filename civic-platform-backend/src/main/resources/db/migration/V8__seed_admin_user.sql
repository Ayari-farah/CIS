-- Platform admin (seed only). Password: Admin1234!
-- BCrypt $2a$10 (Spring-compatible; hash generated for literal "Admin1234!")

INSERT INTO `user` (user_name, email, password, is_admin, user_type, badge, points, awarded_date, created_at)
VALUES (
    'admin',
    'admin@civicplatform.tn',
    '$2a$10$6eoDPw5APkb/z8rxQR4UXOCkzjzRFm865mR0RcFR1Q8rZ1D42KpeW',
    1,
    NULL,
    NULL,
    NULL,
    NULL,
    NOW()
);

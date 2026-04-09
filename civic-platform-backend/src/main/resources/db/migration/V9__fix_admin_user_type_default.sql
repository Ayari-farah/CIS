-- Platform admins must not inherit DEFAULT 'CITIZEN' on user_type (V2).
-- Clear participant fields for existing admin rows and normalize column default.

UPDATE `user`
SET user_type = NULL,
    badge = NULL,
    points = NULL,
    awarded_date = NULL
WHERE is_admin = 1;

ALTER TABLE `user` MODIFY COLUMN user_type VARCHAR(20) NULL DEFAULT NULL;

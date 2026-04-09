-- Replace role enum with is_admin; nullable columns for admin-only rows (no user_type, badge, etc.)

ALTER TABLE `user` ADD COLUMN is_admin TINYINT(1) NOT NULL DEFAULT 0;

UPDATE `user` SET is_admin = 1 WHERE role = 'ADMIN';

ALTER TABLE `user` DROP COLUMN role;

ALTER TABLE `user` MODIFY COLUMN user_type VARCHAR(20) NULL;
ALTER TABLE `user` MODIFY COLUMN badge VARCHAR(20) NULL;
ALTER TABLE `user` MODIFY COLUMN points INT NULL;
ALTER TABLE `user` MODIFY COLUMN awarded_date DATE NULL;
ALTER TABLE `user` MODIFY COLUMN first_name VARCHAR(255) NULL;
ALTER TABLE `user` MODIFY COLUMN last_name VARCHAR(255) NULL;
ALTER TABLE `user` MODIFY COLUMN phone VARCHAR(50) NULL;
ALTER TABLE `user` MODIFY COLUMN address VARCHAR(255) NULL;
ALTER TABLE `user` MODIFY COLUMN birth_date DATE NULL;

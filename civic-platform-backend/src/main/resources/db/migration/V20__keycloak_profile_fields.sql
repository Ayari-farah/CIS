ALTER TABLE `user`
    ADD COLUMN IF NOT EXISTS `keycloak_id` VARCHAR(100) NULL,
    ADD COLUMN IF NOT EXISTS `is_actif` BIT(1) NOT NULL DEFAULT b'1',
    ADD COLUMN IF NOT EXISTS `is_deletion_requested` BIT(1) NOT NULL DEFAULT b'0';

CREATE UNIQUE INDEX IF NOT EXISTS `uk_user_keycloak_id` ON `user` (`keycloak_id`);

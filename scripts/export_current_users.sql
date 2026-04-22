-- Export current users from local profile table.
-- Usage:
--   mysql -h <host> -P <port> -u <user> -p civic_platform < scripts/export_current_users.sql

SELECT
  u.id,
  u.email,
  u.user_name,
  u.first_name,
  u.last_name,
  u.user_type AS role,
  u.is_admin
FROM `user` u
ORDER BY u.id;

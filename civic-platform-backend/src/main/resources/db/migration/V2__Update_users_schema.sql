-- Update users table schema to match requirements
-- Ensure all required columns exist

-- Add missing columns to users table if they don't exist
ALTER TABLE user ADD COLUMN IF NOT EXISTS first_name VARCHAR(255);
ALTER TABLE user ADD COLUMN IF NOT EXISTS last_name VARCHAR(255);
ALTER TABLE user ADD COLUMN IF NOT EXISTS user_name VARCHAR(255);
ALTER TABLE user ADD COLUMN IF NOT EXISTS email VARCHAR(255);
ALTER TABLE user ADD COLUMN IF NOT EXISTS contact_email VARCHAR(255);
ALTER TABLE user ADD COLUMN IF NOT EXISTS password VARCHAR(255);
ALTER TABLE user ADD COLUMN IF NOT EXISTS phone VARCHAR(50);
ALTER TABLE user ADD COLUMN IF NOT EXISTS birth_date DATE;
ALTER TABLE user ADD COLUMN IF NOT EXISTS address VARCHAR(255);
ALTER TABLE user ADD COLUMN IF NOT EXISTS company_name VARCHAR(255);
ALTER TABLE user ADD COLUMN IF NOT EXISTS association_name VARCHAR(255);
ALTER TABLE user ADD COLUMN IF NOT EXISTS contact_name VARCHAR(255);

-- Ensure badge column uses correct enum values
-- Note: If badge column already exists with different enum, data migration may be needed
ALTER TABLE user MODIFY COLUMN badge VARCHAR(20) DEFAULT 'NONE';

-- Ensure role column uses correct enum
ALTER TABLE user MODIFY COLUMN role VARCHAR(20) DEFAULT 'USER';

-- Ensure user_type column uses correct enum
ALTER TABLE user MODIFY COLUMN user_type VARCHAR(20) DEFAULT 'CITIZEN';

-- Ensure points column exists with default 0
ALTER TABLE user ADD COLUMN IF NOT EXISTS points INT DEFAULT 0;

-- Ensure awarded_date column exists
ALTER TABLE user ADD COLUMN IF NOT EXISTS awarded_date DATE;

-- Add indexes for performance
CREATE INDEX IF NOT EXISTS idx_user_user_type ON user(user_type);
CREATE INDEX IF NOT EXISTS idx_user_role ON user(role);
CREATE INDEX IF NOT EXISTS idx_user_badge ON user(badge);

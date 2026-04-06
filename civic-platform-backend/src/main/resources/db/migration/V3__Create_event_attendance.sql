-- Create event_attendance table if it doesn't exist
CREATE TABLE IF NOT EXISTS event_attendance (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    event_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    attended_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (event_id) REFERENCES event(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE,
    UNIQUE KEY unique_event_user (event_id, user_id)
);

CREATE INDEX IF NOT EXISTS idx_event_attendance_user_id ON event_attendance(user_id);
CREATE INDEX IF NOT EXISTS idx_event_attendance_event_id ON event_attendance(event_id);

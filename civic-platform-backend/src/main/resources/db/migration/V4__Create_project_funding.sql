-- Create project_funding table if it doesn't exist
CREATE TABLE IF NOT EXISTS project_funding (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    amount DECIMAL(15, 2) NOT NULL,
    fund_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(50),
    project_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    FOREIGN KEY (project_id) REFERENCES project(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_project_funding_user_id ON project_funding(user_id);
CREATE INDEX IF NOT EXISTS idx_project_funding_project_id ON project_funding(project_id);

-- جدول سجلات النسخ الاحتياطي
CREATE TABLE IF NOT EXISTS backup_history (
    backup_id INT AUTO_INCREMENT PRIMARY KEY,
    backup_number VARCHAR(50) UNIQUE NOT NULL,
    backup_type ENUM('full', 'partial', 'automatic') DEFAULT 'full',
    description TEXT,
    file_name VARCHAR(255),
    file_size BIGINT DEFAULT 0,
    table_count INT DEFAULT 0,
    record_count BIGINT DEFAULT 0,
    backup_path VARCHAR(500),
    status ENUM('pending', 'in_progress', 'completed', 'failed', 'restored') DEFAULT 'pending',
    created_by INT DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP NULL,
    restored_at TIMESTAMP NULL,
    INDEX idx_status (status),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

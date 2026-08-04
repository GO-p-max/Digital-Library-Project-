-- إنشاء جدول المواد الدراسية
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

CREATE TABLE IF NOT EXISTS subjects (
    subject_id      INT UNSIGNED NOT NULL AUTO_INCREMENT,
    subject_code    VARCHAR(20)  NOT NULL UNIQUE,
    subject_name    VARCHAR(150) NOT NULL UNIQUE,
    specialization_id INT UNSIGNED NOT NULL,
    credit_hours    TINYINT UNSIGNED NOT NULL DEFAULT 3,
    subject_type    ENUM('theoretical','practical','both') NOT NULL DEFAULT 'theoretical',
    semester        ENUM('first','second','summer') NOT NULL DEFAULT 'first',
    year_level      TINYINT UNSIGNED NOT NULL DEFAULT 1 COMMENT 'السنة الدراسية 1-5',
    description     TEXT NULL,
    is_active       TINYINT(1) NOT NULL DEFAULT 1,
    created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (subject_id),
    INDEX idx_subjects_specialization (specialization_id),
    INDEX idx_subjects_active (is_active),
    CONSTRAINT fk_subjects_specialization
        FOREIGN KEY (specialization_id) REFERENCES specializations(specialization_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

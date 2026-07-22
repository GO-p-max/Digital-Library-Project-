-- تحديث بنية جدول الوظائف لتتبع السجلات ودعم حقول الصفحة الحالية
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

CREATE TABLE IF NOT EXISTS jobs (
    job_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    job_code VARCHAR(30) NOT NULL UNIQUE,
    job_title VARCHAR(150) NOT NULL,
    department VARCHAR(100) NOT NULL DEFAULT 'قسم المكتبة',
    salary DECIMAL(12,2) NOT NULL DEFAULT 0,
    status ENUM('open','occupied','inactive') NOT NULL DEFAULT 'open',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (job_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- في حال كان الجدول موجودًا مسبقًا
ALTER TABLE jobs
    MODIFY job_code VARCHAR(30) NOT NULL,
    MODIFY job_title VARCHAR(150) NOT NULL,
    MODIFY department VARCHAR(100) NOT NULL DEFAULT 'قسم المكتبة',
    MODIFY salary DECIMAL(12,2) NOT NULL DEFAULT 0,
    MODIFY status ENUM('open','occupied','inactive') NOT NULL DEFAULT 'open';

ALTER TABLE jobs
    ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

-- إنشاء جدول الموظفين + إدخال بيانات افتراضية
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

CREATE TABLE IF NOT EXISTS employees (
    employee_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    employee_number VARCHAR(30) NOT NULL UNIQUE,
    full_name VARCHAR(150) NOT NULL,
    gender ENUM('male','female') NOT NULL DEFAULT 'male',
    marital_status ENUM('single','married','divorced','widowed') NOT NULL DEFAULT 'single',
    branch_code VARCHAR(30) NOT NULL DEFAULT 'main-1',
    job_title VARCHAR(150) NOT NULL,
    salary DECIMAL(12,2) NOT NULL DEFAULT 0,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(190) NOT NULL,
    email_verified TINYINT(1) NOT NULL DEFAULT 0,
    email_verified_at DATETIME NULL DEFAULT NULL,
    image_path VARCHAR(255) NOT NULL DEFAULT 'images/user-avatar.png',
    status ENUM('active','on-leave','inactive') NOT NULL DEFAULT 'active',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (employee_id),
    INDEX idx_employees_status (status),
    INDEX idx_employees_job_title (job_title),
    INDEX idx_employees_phone (phone),
    UNIQUE KEY uniq_employees_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- بيانات افتراضية
INSERT INTO employees (
    employee_number, full_name, gender, marital_status, branch_code,
    job_title, salary, phone, email, email_verified, email_verified_at, image_path, status
) VALUES
('EMP-001', 'أحمد محمد الشيباني', 'male', 'married', 'main-1', 'أمين مكتبة', 250000, '077123456', 'ahmed@mtc-library.ye', 1, NOW(), 'images/user-avatar.png', 'active'),
('EMP-002', 'خالد عبدالله عمر', 'male', 'single', 'port-1', 'مساعد مكتبة', 150000, '077234567', 'khalid@mtc-library.ye', 1, NOW(), 'images/user-avatar.png', 'active'),
('EMP-003', 'فاطمة علي حسن', 'female', 'married', 'sub-1', 'مسؤولة أرشفة', 120000, '077345678', 'fatima@mtc-library.ye', 1, NOW(), 'images/user-avatar.png', 'active'),
('EMP-004', 'محمد صالح علي', 'male', 'married', 'main-1', 'مدير عمليات', 300000, '077456789', 'mohammed@mtc-library.ye', 1, NOW(), 'images/user-avatar.png', 'on-leave')
ON DUPLICATE KEY UPDATE
    full_name = VALUES(full_name),
    gender = VALUES(gender),
    marital_status = VALUES(marital_status),
    branch_code = VALUES(branch_code),
    job_title = VALUES(job_title),
    salary = VALUES(salary),
    phone = VALUES(phone),
    email_verified = VALUES(email_verified),
    email_verified_at = VALUES(email_verified_at),
    image_path = VALUES(image_path),
    status = VALUES(status),
    updated_at = CURRENT_TIMESTAMP;

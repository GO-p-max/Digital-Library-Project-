-- إنشاء جدول المدرسين + إدخال بيانات افتراضية
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

CREATE TABLE IF NOT EXISTS teachers (
    teacher_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    teacher_number VARCHAR(30) NOT NULL UNIQUE,
    full_name VARCHAR(150) NOT NULL,
    gender ENUM('male','female') NOT NULL DEFAULT 'male',
    marital_status ENUM('single','married','divorced','widowed') NOT NULL DEFAULT 'single',
    branch_code VARCHAR(30) NOT NULL DEFAULT 'main-1',
    specialization VARCHAR(150) NOT NULL,
    degree VARCHAR(100) NOT NULL,
    subjects TEXT NULL,
    experience_years INT UNSIGNED NOT NULL DEFAULT 0,
    salary DECIMAL(12,2) NOT NULL DEFAULT 0,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(190) NOT NULL,
    email_verified TINYINT(1) NOT NULL DEFAULT 0,
    email_verified_at DATETIME NULL DEFAULT NULL,
    image_path VARCHAR(255) NOT NULL DEFAULT 'images/user-avatar.png',
    status ENUM('active','on-leave','inactive') NOT NULL DEFAULT 'active',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (teacher_id),
    INDEX idx_teachers_status (status),
    INDEX idx_teachers_specialization (specialization),
    INDEX idx_teachers_phone (phone),
    UNIQUE KEY uniq_teachers_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- بيانات افتراضية
INSERT INTO teachers (
    teacher_number, full_name, gender, marital_status, branch_code,
    specialization, degree, subjects, experience_years, salary, phone, email, email_verified, email_verified_at, image_path, status
) VALUES
('TCH-001', 'د. أحمد محمد الشيباني', 'male', 'married', 'main-1', 'علوم الحاسوب', 'دكتوراه', 'برمجة، قواعد بيانات، شبكات', 15, 350000, '077123456', 'ahmed.teacher@mtc-library.ye', 1, NOW(), 'images/user-avatar.png', 'active'),
('TCH-002', 'أ. خالد عبدالله عمر', 'male', 'single', 'port-1', 'الرياضيات', 'ماجستير', 'جبر، حساب تفاضلي، إحصاء', 8, 280000, '077234567', 'khalid.teacher@mtc-library.ye', 1, NOW(), 'images/user-avatar.png', 'active'),
('TCH-003', 'د. فاطمة علي حسن', 'female', 'married', 'sub-1', 'الأدب العربي', 'دكتوراه', 'نحو، بلاغة، أدب إسلامي', 12, 320000, '077345678', 'fatima.teacher@mtc-library.ye', 1, NOW(), 'images/user-avatar.png', 'active'),
('TCH-004', 'أ. محمد صالح علي', 'male', 'married', 'main-1', 'الفيزياء', 'ماجستير', 'ميكانيك، كهرباء، ضوء', 10, 300000, '077456789', 'mohammed.teacher@mtc-library.ye', 1, NOW(), 'images/user-avatar.png', 'on-leave')
ON DUPLICATE KEY UPDATE
    full_name = VALUES(full_name),
    gender = VALUES(gender),
    marital_status = VALUES(marital_status),
    branch_code = VALUES(branch_code),
    specialization = VALUES(specialization),
    degree = VALUES(degree),
    subjects = VALUES(subjects),
    experience_years = VALUES(experience_years),
    salary = VALUES(salary),
    phone = VALUES(phone),
    email_verified = VALUES(email_verified),
    email_verified_at = VALUES(email_verified_at),
    image_path = VALUES(image_path),
    status = VALUES(status),
    updated_at = CURRENT_TIMESTAMP;
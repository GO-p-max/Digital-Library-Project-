-- إنشاء جدول التخصصات الأكاديمية
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

CREATE TABLE IF NOT EXISTS specializations (
    specialization_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    specialization_code VARCHAR(20) NOT NULL UNIQUE,
    specialization_name VARCHAR(150) NOT NULL UNIQUE,
    description TEXT NULL,
    department_type ENUM('academic', 'vocational', 'technical') NOT NULL DEFAULT 'academic',
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (specialization_id),
    INDEX idx_specializations_active (is_active),
    INDEX idx_specializations_type (department_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- بيانات افتراضية
INSERT INTO specializations (
    specialization_code, specialization_name, description, department_type, is_active
) VALUES
('CS', 'علوم الحاسوب', 'تخصص في علوم الحاسوب وتكنولوجيا المعلومات', 'academic', 1),
('MATH', 'الرياضيات', 'تخصص في الرياضيات والإحصاء', 'academic', 1),
('ARABIC', 'الأدب العربي', 'تخصص في الأدب العربي واللغة العربية', 'academic', 1),
('PHYSICS', 'الفيزياء', 'تخصص في الفيزياء والعلوم الطبيعية', 'academic', 1),
('CHEMISTRY', 'الكيمياء', 'تخصص في الكيمياء والعلوم الكيميائية', 'academic', 1),
('BIOLOGY', 'الأحياء', 'تخصص في علم الأحياء والعلوم البيولوجية', 'academic', 1),
('HISTORY', 'التاريخ', 'تخصص في التاريخ والحضارة', 'academic', 1),
('GEOGRAPHY', 'الجغرافيا', 'تخصص في الجغرافيا وعلوم الأرض', 'academic', 1),
('ENGLISH', 'اللغة الإنجليزية', 'تخصص في اللغة الإنجليزية وآدابها', 'academic', 1),
('ECONOMICS', 'الاقتصاد', 'تخصص في الاقتصاد والعلوم المالية', 'academic', 1),
('ACCOUNTING', 'المحاسبة', 'تخصص في المحاسبة والمالية', 'vocational', 1),
('BUSINESS', 'إدارة الأعمال', 'تخصص في إدارة الأعمال والتجارة', 'vocational', 1),
('ENGINEERING', 'الهندسة', 'تخصص في الهندسة والتكنولوجيا', 'technical', 1),
('MEDICINE', 'الطب', 'تخصص في الطب والعلوم الطبية', 'academic', 1),
('LAW', 'الحقوق', 'تخصص في القانون والعلوم القانونية', 'academic', 1)
ON DUPLICATE KEY UPDATE
    description = VALUES(description),
    department_type = VALUES(department_type),
    is_active = VALUES(is_active),
    updated_at = CURRENT_TIMESTAMP;
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

CREATE TABLE IF NOT EXISTS department_categories (
    category_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    category_name VARCHAR(190) NOT NULL,
    description VARCHAR(255) NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (category_id),
    UNIQUE KEY uniq_department_categories_name (category_name),
    KEY idx_department_categories_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO department_categories (category_name, description, is_active)
VALUES
('مراجع', 'مراجع ومعاجم وموسوعات', 1),
('علوم تطبيقية', 'الهندسة والتقنية والعلوم التطبيقية', 1),
('أدب', 'الأدب العربي والعالمي', 1),
('دينية', 'العلوم الشرعية والدينية', 1),
('تاريخ', 'التاريخ والحضارات', 1),
('أطفال', 'كتب الأطفال واليافعين', 1),
('قانون', 'القانون والقضاء', 1),
('اقتصاد', 'الاقتصاد والأعمال', 1),
('تقنية', 'تقنية المعلومات والحاسب', 1),
('طب', 'الصحة والطب', 1),
('فلسفة', 'الفلسفة والمنطق', 1),
('اجتماع', 'العلوم الاجتماعية', 1),
('لغات', 'اللغة العربية ولغات العالم', 1),
('سير وتراجم', 'السير الذاتية والتراجم', 1),
('فنون', 'الفنون والآداب البصرية', 1)
ON DUPLICATE KEY UPDATE
    description = VALUES(description),
    is_active = VALUES(is_active),
    updated_at = CURRENT_TIMESTAMP;

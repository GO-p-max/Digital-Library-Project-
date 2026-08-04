-- إنشاء جداول إدارة الأقسام وربطها بالموظفين والأرفف
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

CREATE TABLE IF NOT EXISTS library_shelves (
    shelf_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    shelf_range VARCHAR(50) NOT NULL,
    shelf_label VARCHAR(150) NULL,
    location_note VARCHAR(255) NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (shelf_id),
    UNIQUE KEY uniq_library_shelves_range (shelf_range),
    KEY idx_library_shelves_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS departments (
    department_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    department_code VARCHAR(30) NOT NULL,
    department_name VARCHAR(200) NOT NULL,
    category_id INT UNSIGNED NULL,
    shelf_id INT UNSIGNED NULL,
    manager_employee_id INT UNSIGNED NULL,
    books_count INT UNSIGNED NOT NULL DEFAULT 0,
    description TEXT NULL,
    status ENUM('active','on-leave','inactive') NOT NULL DEFAULT 'active',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (department_id),
    UNIQUE KEY uniq_departments_code (department_code),
    UNIQUE KEY uniq_departments_name (department_name),
    KEY idx_departments_status (status),
    KEY idx_departments_category (category_id),
    KEY idx_departments_shelf (shelf_id),
    KEY idx_departments_manager (manager_employee_id),
    CONSTRAINT fk_departments_category
        FOREIGN KEY (category_id) REFERENCES department_categories(category_id)
        ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT fk_departments_shelf
        FOREIGN KEY (shelf_id) REFERENCES library_shelves(shelf_id)
        ON UPDATE CASCADE ON DELETE SET NULL,
    CONSTRAINT fk_departments_manager
        FOREIGN KEY (manager_employee_id) REFERENCES employees(employee_id)
        ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS department_members (
    membership_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    department_id INT UNSIGNED NOT NULL,
    employee_id INT UNSIGNED NOT NULL,
    role ENUM('manager','assistant','staff') NOT NULL DEFAULT 'staff',
    is_primary TINYINT(1) NOT NULL DEFAULT 0,
    assigned_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    notes VARCHAR(255) NULL,
    PRIMARY KEY (membership_id),
    UNIQUE KEY uniq_department_employee_role (department_id, employee_id, role),
    KEY idx_department_members_employee (employee_id),
    KEY idx_department_members_primary (department_id, is_primary),
    CONSTRAINT fk_department_members_department
        FOREIGN KEY (department_id) REFERENCES departments(department_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_department_members_employee
        FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
        ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- بيانات افتراضية للتصنيفات
INSERT INTO department_categories (category_name, description)
VALUES
('مراجع', 'قسم المراجع العامة والمعاجم'),
('علوم تطبيقية', 'قسم العلوم التطبيقية والهندسية'),
('أدب', 'قسم الأدب العربي والعالمي'),
('دينية', 'قسم العلوم الدينية والشرعية'),
('تاريخ', 'قسم التاريخ والحضارات'),
('أطفال', 'قسم كتب الأطفال واليافعين')
ON DUPLICATE KEY UPDATE
    description = VALUES(description),
    is_active = 1,
    updated_at = CURRENT_TIMESTAMP;

-- بيانات افتراضية للأرفف
INSERT INTO library_shelves (shelf_range, shelf_label, location_note)
VALUES
('A1 - A8', 'رفوف القسم A', 'القاعة الشرقية'),
('B1 - B6', 'رفوف القسم B', 'القاعة الشرقية'),
('C1 - C5', 'رفوف القسم C', 'القاعة الوسطى'),
('D1 - D4', 'رفوف القسم D', 'القاعة الوسطى'),
('E1 - E7', 'رفوف القسم E', 'القاعة الغربية'),
('F1 - F4', 'رفوف القسم F', 'القاعة الغربية'),
('G1 - G5', 'رفوف القسم G', 'الطابق الأول'),
('H1 - H5', 'رفوف القسم H', 'الطابق الأول'),
('K1 - K4', 'رفوف القسم K', 'الطابق الثاني'),
('N1 - N2', 'رفوف القسم N', 'المخزن الآمن')
ON DUPLICATE KEY UPDATE
    shelf_label = VALUES(shelf_label),
    location_note = VALUES(location_note),
    is_active = 1,
    updated_at = CURRENT_TIMESTAMP;

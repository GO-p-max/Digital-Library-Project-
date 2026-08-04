-- ===================================================
-- نظام إدارة المستخدمين والصلاحيات
-- ===================================================
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- -----------------------------------------------
-- 1. جدول الصفحات / الوحدات (الموارد)
-- -----------------------------------------------
CREATE TABLE IF NOT EXISTS pages (
    page_id     INT UNSIGNED NOT NULL AUTO_INCREMENT,
    page_key    VARCHAR(60)  NOT NULL UNIQUE COMMENT 'مفتاح فريد مثل users.php',
    page_name   VARCHAR(100) NOT NULL COMMENT 'الاسم العربي للصفحة',
    page_group  VARCHAR(60)  NOT NULL DEFAULT 'عام' COMMENT 'المجموعة في القائمة الجانبية',
    sort_order  SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    PRIMARY KEY (page_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------
-- 2. جدول العمليات (الأذونات الأساسية)
-- -----------------------------------------------
CREATE TABLE IF NOT EXISTS operations (
    operation_id   INT UNSIGNED NOT NULL AUTO_INCREMENT,
    operation_key  VARCHAR(30)  NOT NULL UNIQUE COMMENT 'view | add | edit | delete | export',
    operation_name VARCHAR(60)  NOT NULL,
    PRIMARY KEY (operation_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------
-- 3. جدول الأدوار (الصلاحيات المجمّعة)
-- -----------------------------------------------
CREATE TABLE IF NOT EXISTS roles (
    role_id     INT UNSIGNED NOT NULL AUTO_INCREMENT,
    role_name   VARCHAR(80)  NOT NULL UNIQUE,
    description TEXT NULL,
    is_active   TINYINT(1)   NOT NULL DEFAULT 1,
    created_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP    NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (role_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------
-- 4. صلاحيات الدور (دور × صفحة × عملية)
-- -----------------------------------------------
CREATE TABLE IF NOT EXISTS role_permissions (
    role_id      INT UNSIGNED NOT NULL,
    page_id      INT UNSIGNED NOT NULL,
    operation_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (role_id, page_id, operation_id),
    CONSTRAINT fk_rp_role      FOREIGN KEY (role_id)      REFERENCES roles(role_id)          ON DELETE CASCADE,
    CONSTRAINT fk_rp_page      FOREIGN KEY (page_id)      REFERENCES pages(page_id)          ON DELETE CASCADE,
    CONSTRAINT fk_rp_operation FOREIGN KEY (operation_id) REFERENCES operations(operation_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------
-- 5. جدول المستخدمين
-- -----------------------------------------------
CREATE TABLE IF NOT EXISTS users (
    user_id       INT UNSIGNED NOT NULL AUTO_INCREMENT,
    username      VARCHAR(60)  NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    employee_id   INT UNSIGNED NOT NULL UNIQUE COMMENT 'موظف واحد = حساب واحد',
    role_id       INT UNSIGNED NOT NULL,
    is_active     TINYINT(1)   NOT NULL DEFAULT 1,
    last_login    TIMESTAMP    NULL,
    created_at    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP    NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id),
    INDEX idx_users_employee (employee_id),
    INDEX idx_users_role     (role_id),
    CONSTRAINT fk_users_employee FOREIGN KEY (employee_id) REFERENCES employees(employee_id) ON DELETE RESTRICT,
    CONSTRAINT fk_users_role     FOREIGN KEY (role_id)     REFERENCES roles(role_id)         ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------
-- 6. صلاحيات إضافية خاصة بالمستخدم (override)
-- -----------------------------------------------
CREATE TABLE IF NOT EXISTS user_permissions (
    user_id      INT UNSIGNED NOT NULL,
    page_id      INT UNSIGNED NOT NULL,
    operation_id INT UNSIGNED NOT NULL,
    granted      TINYINT(1)   NOT NULL DEFAULT 1 COMMENT '1=منح 0=سحب',
    PRIMARY KEY (user_id, page_id, operation_id),
    CONSTRAINT fk_up_user      FOREIGN KEY (user_id)      REFERENCES users(user_id)          ON DELETE CASCADE,
    CONSTRAINT fk_up_page      FOREIGN KEY (page_id)      REFERENCES pages(page_id)          ON DELETE CASCADE,
    CONSTRAINT fk_up_operation FOREIGN KEY (operation_id) REFERENCES operations(operation_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------
-- بيانات أساسية
-- -----------------------------------------------

-- العمليات
INSERT INTO operations (operation_key, operation_name) VALUES
('view',   'عرض'),
('add',    'إضافة'),
('edit',   'تعديل'),
('delete', 'حذف'),
('export', 'تصدير')
ON DUPLICATE KEY UPDATE operation_name = VALUES(operation_name);

-- الصفحات
INSERT INTO pages (page_key, page_name, page_group, sort_order) VALUES
('dashboard.php',      'لوحة التحكم',          'عام',              1),
('employees.php',      'إدارة الموظفين',        'الإدارة العامة',   2),
('jobs.php',           'إدارة الوظائف',         'الإدارة العامة',   3),
('teachers.php',       'إدارة المدرسين',        'الإدارة العامة',   4),
('specializations.php','إدارة التخصصات',        'التخصصات والمواد', 5),
('subjects.php',       'إدارة المواد',          'التخصصات والمواد', 6),
('departments.php',    'إدارة الأقسام',         'الكتب والمكتبة',   7),
('digital_library.php','المكتبة الرقمية',       'الكتب والمكتبة',   8),
('users.php',          'إدارة المستخدمين',      'إدارة المستخدمين', 9),
('roles.php',          'إدارة الصلاحيات',       'إدارة المستخدمين', 10)
ON DUPLICATE KEY UPDATE page_name = VALUES(page_name), page_group = VALUES(page_group), sort_order = VALUES(sort_order);

-- الأدوار الافتراضية
INSERT INTO roles (role_name, description, is_active) VALUES
('مدير النظام',  'صلاحيات كاملة على جميع الوحدات', 1),
('مشرف',         'صلاحيات عرض وإضافة وتعديل',       1),
('موظف',         'صلاحيات عرض فقط',                 1)
ON DUPLICATE KEY UPDATE description = VALUES(description), is_active = VALUES(is_active);

-- منح مدير النظام جميع الصلاحيات
INSERT INTO role_permissions (role_id, page_id, operation_id)
SELECT r.role_id, p.page_id, o.operation_id
FROM roles r, pages p, operations o
WHERE r.role_name = 'مدير النظام'
ON DUPLICATE KEY UPDATE role_id = VALUES(role_id);

-- منح المشرف: عرض + إضافة + تعديل على جميع الصفحات
INSERT INTO role_permissions (role_id, page_id, operation_id)
SELECT r.role_id, p.page_id, o.operation_id
FROM roles r, pages p, operations o
WHERE r.role_name = 'مشرف' AND o.operation_key IN ('view','add','edit')
ON DUPLICATE KEY UPDATE role_id = VALUES(role_id);

-- منح الموظف: عرض فقط
INSERT INTO role_permissions (role_id, page_id, operation_id)
SELECT r.role_id, p.page_id, o.operation_id
FROM roles r, pages p, operations o
WHERE r.role_name = 'موظف' AND o.operation_key = 'view'
ON DUPLICATE KEY UPDATE role_id = VALUES(role_id);

-- ============================================================================
-- ملف إصلاح وتحسين هيكل قاعدة البيانات
-- Lib Book 2 - Database Schema Fix
-- ============================================================================
-- هذا الملف يقوم بـ:
-- 1. إنشاء الجداول المفقودة
-- 2. إضافة الأعمدة المفقودة للجداول الموجودة
-- 3. إصلاح الفهارس المفقودة
-- ============================================================================

SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- ============================================================================
-- 1. جدول الموظفين (employees)
-- ============================================================================
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

-- ============================================================================
-- 2. جدول الطلاب (students)
-- ============================================================================
CREATE TABLE IF NOT EXISTS students (
    student_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    student_number VARCHAR(30) NOT NULL UNIQUE,
    full_name VARCHAR(150) NOT NULL,
    gender ENUM('male','female') NOT NULL DEFAULT 'male',
    specialization_id INT UNSIGNED NULL,
    year_level TINYINT UNSIGNED NOT NULL DEFAULT 1,
    phone VARCHAR(20) NULL,
    email VARCHAR(150) NULL,
    address VARCHAR(255) NULL,
    enrollment_date DATE NULL,
    photo_path VARCHAR(255) NULL,
    card_front_path VARCHAR(255) NULL,
    card_back_path VARCHAR(255) NULL,
    status ENUM('active','graduated','suspended','withdrawn') NOT NULL DEFAULT 'active',
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    notes TEXT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (student_id),
    INDEX idx_students_number (student_number),
    INDEX idx_students_spec (specialization_id),
    INDEX idx_students_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 3. جدول الكتب (books)
-- ============================================================================
CREATE TABLE IF NOT EXISTS books (
    book_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    book_number VARCHAR(50) NULL UNIQUE,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(150) NULL,
    publisher VARCHAR(150) NULL,
    publish_year VARCHAR(10) NULL,
    isbn VARCHAR(30) NULL,
    category_id INT UNSIGNED NULL,
    copies_total INT UNSIGNED NOT NULL DEFAULT 1,
    copies_available INT UNSIGNED NOT NULL DEFAULT 1,
    shelf_location VARCHAR(100) NULL,
    status ENUM('available','borrowed','reserved','lost') NOT NULL DEFAULT 'available',
    notes TEXT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (book_id),
    INDEX idx_books_number (book_number),
    INDEX idx_books_title (title),
    INDEX idx_books_status (status),
    INDEX idx_books_category (category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 4. جدول الإعارات (loans) - تم التصحيح ليطابق التطبيق
-- ============================================================================
CREATE TABLE IF NOT EXISTS loans (
    loan_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    loan_number VARCHAR(50) NOT NULL UNIQUE,
    student_id INT UNSIGNED NOT NULL,
    book_id INT UNSIGNED NOT NULL,
    loan_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE NULL,
    status ENUM('active','returned','overdue','lost') NOT NULL DEFAULT 'active',
    fine_amount DECIMAL(8,2) NOT NULL DEFAULT 0.00,
    fine_paid TINYINT(1) NOT NULL DEFAULT 0,
    notes TEXT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (loan_id),
    INDEX idx_loans_student (student_id),
    INDEX idx_loans_book (book_id),
    INDEX idx_loans_status (status),
    INDEX idx_loans_number (loan_number),
    INDEX idx_loans_dates (loan_date, due_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 5. جدول المناهج الدراسية (curriculums) - مع الحقول الجديدة
-- ============================================================================
CREATE TABLE IF NOT EXISTS curriculums (
    curriculum_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    curriculum_code VARCHAR(50) NULL UNIQUE,
    course_code VARCHAR(20) NOT NULL,
    course_name VARCHAR(200) NOT NULL,
    specialization_id INT UNSIGNED NULL,
    teacher_id INT UNSIGNED NULL,
    year_level TINYINT UNSIGNED NOT NULL DEFAULT 1,
    semester ENUM('first','second','summer') NOT NULL DEFAULT 'first',
    curriculum_type ENUM('theoretical','practical','both') NOT NULL DEFAULT 'theoretical',
    credits SMALLINT UNSIGNED NOT NULL DEFAULT 3,
    hours_theory SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    hours_practical SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    description TEXT NULL,
    image_path VARCHAR(255) NULL,
    file_path VARCHAR(255) NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (curriculum_id),
    INDEX idx_curr_code (curriculum_code),
    INDEX idx_curr_name (course_name),
    INDEX idx_curr_spec (specialization_id),
    INDEX idx_curr_teacher (teacher_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 6. جدول المحاضرات (lectures)
-- ============================================================================
CREATE TABLE IF NOT EXISTS lectures (
    lecture_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    lecture_code VARCHAR(20) NOT NULL UNIQUE,
    lecture_title VARCHAR(200) NOT NULL,
    subject_id INT UNSIGNED NULL,
    teacher_id INT UNSIGNED NULL,
    lecture_date DATE NULL,
    lecture_time TIME NULL,
    duration_minutes SMALLINT UNSIGNED NOT NULL DEFAULT 60,
    room VARCHAR(50) NULL,
    lecture_type ENUM('theoretical','practical','online') NOT NULL DEFAULT 'theoretical',
    file_path VARCHAR(255) NULL,
    description TEXT NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (lecture_id),
    INDEX idx_lec_code (lecture_code),
    INDEX idx_lec_subject (subject_id),
    INDEX idx_lec_teacher (teacher_id),
    INDEX idx_lec_date (lecture_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 7. جدول مشاريع التخرج (graduation_projects)
-- ============================================================================
CREATE TABLE IF NOT EXISTS graduation_projects (
    project_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    project_code VARCHAR(20) NOT NULL UNIQUE,
    project_title VARCHAR(255) NOT NULL,
    specialization_id INT UNSIGNED NULL,
    supervisor_id INT UNSIGNED NULL,
    academic_year VARCHAR(20) NOT NULL,
    semester ENUM('first','second','summer') NOT NULL DEFAULT 'second',
    project_type ENUM('individual','group') NOT NULL DEFAULT 'group',
    status ENUM('proposed','approved','in_progress','completed','rejected') NOT NULL DEFAULT 'proposed',
    grade DECIMAL(5,2) NULL,
    file_path VARCHAR(255) NULL,
    description TEXT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (project_id),
    INDEX idx_proj_code (project_code),
    INDEX idx_proj_spec (specialization_id),
    INDEX idx_proj_supervisor (supervisor_id),
    INDEX idx_proj_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 8. جدول مشاريع التخرج والطلاب (project_students)
-- ============================================================================
CREATE TABLE IF NOT EXISTS project_students (
    project_id INT UNSIGNED NOT NULL,
    student_id INT UNSIGNED NOT NULL,
    role ENUM('leader','member') NOT NULL DEFAULT 'member',
    PRIMARY KEY (project_id, student_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 9. جدول الاشتراكات (subscriptions)
-- ============================================================================
CREATE TABLE IF NOT EXISTS subscriptions (
    subscription_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    subscriber_type ENUM('student','employee','teacher','external') NOT NULL DEFAULT 'student',
    subscriber_id INT UNSIGNED NOT NULL,
    subscriber_name VARCHAR(150) NOT NULL,
    subscription_type ENUM('monthly','semester','annual') NOT NULL DEFAULT 'semester',
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    max_loans TINYINT UNSIGNED NOT NULL DEFAULT 3,
    fee DECIMAL(8,2) NOT NULL DEFAULT 0.00,
    is_paid TINYINT(1) NOT NULL DEFAULT 0,
    status ENUM('active','expired','suspended') NOT NULL DEFAULT 'active',
    notes TEXT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (subscription_id),
    INDEX idx_sub_type_id (subscriber_type, subscriber_id),
    INDEX idx_sub_status (status),
    INDEX idx_sub_dates (start_date, end_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 10. جدول الأدوار (roles)
-- ============================================================================
CREATE TABLE IF NOT EXISTS roles (
    role_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    role_name VARCHAR(50) NOT NULL UNIQUE,
    role_description VARCHAR(255) NULL,
    permissions JSON NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (role_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 11. جدول المستخدمين (users)
-- ============================================================================
CREATE TABLE IF NOT EXISTS users (
    user_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    employee_id INT UNSIGNED NULL,
    role_id INT UNSIGNED NOT NULL DEFAULT 1,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    last_login DATETIME NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id),
    INDEX idx_users_username (username),
    INDEX idx_users_employee (employee_id),
    INDEX idx_users_role (role_id),
    INDEX idx_users_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 12. جدول التخصصات (specializations)
-- ============================================================================
CREATE TABLE IF NOT EXISTS specializations (
    specialization_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    specialization_code VARCHAR(20) NOT NULL UNIQUE,
    specialization_name VARCHAR(200) NOT NULL,
    department_id INT UNSIGNED NULL,
    degree ENUM('diploma','bachelor','master','doctorate') NOT NULL DEFAULT 'bachelor',
    years_count TINYINT UNSIGNED NOT NULL DEFAULT 4,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (specialization_id),
    INDEX idx_spec_code (specialization_code),
    INDEX idx_spec_dept (department_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 13. جدول المواد (subjects)
-- ============================================================================
CREATE TABLE IF NOT EXISTS subjects (
    subject_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    subject_code VARCHAR(20) NOT NULL UNIQUE,
    subject_name VARCHAR(200) NOT NULL,
    specialization_id INT UNSIGNED NULL,
    year_level TINYINT UNSIGNED NOT NULL DEFAULT 1,
    semester ENUM('first','second','summer') NOT NULL DEFAULT 'first',
    credits SMALLINT UNSIGNED NOT NULL DEFAULT 3,
    hours_theory SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    hours_practical SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    description TEXT NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (subject_id),
    INDEX idx_subj_code (subject_code),
    INDEX idx_subj_spec (specialization_id),
    INDEX idx_subj_level (year_level)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 14. جدول أقسام المكتبة (departments)
-- ============================================================================
CREATE TABLE IF NOT EXISTS departments (
    department_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    department_code VARCHAR(20) NOT NULL UNIQUE,
    department_name VARCHAR(200) NOT NULL,
    description TEXT NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (department_id),
    INDEX idx_dept_code (department_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 15. جدول فئات الكتب (book_categories)
-- ============================================================================
CREATE TABLE IF NOT EXISTS book_categories (
    category_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    parent_id INT UNSIGNED NULL,
    description TEXT NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (category_id),
    INDEX idx_cat_name (category_name),
    INDEX idx_cat_parent (parent_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 16. جدول الوظائف (jobs)
-- ============================================================================
CREATE TABLE IF NOT EXISTS jobs (
    job_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    job_code VARCHAR(20) NOT NULL UNIQUE,
    job_title VARCHAR(150) NOT NULL,
    description TEXT NULL,
    salary_min DECIMAL(12,2) NULL,
    salary_max DECIMAL(12,2) NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (job_id),
    INDEX idx_job_code (job_code),
    INDEX idx_job_title (job_title)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 17. جدول المدرسين (teachers)
-- ============================================================================
CREATE TABLE IF NOT EXISTS teachers (
    teacher_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    teacher_number VARCHAR(30) NOT NULL UNIQUE,
    full_name VARCHAR(150) NOT NULL,
    gender ENUM('male','female') NOT NULL DEFAULT 'male',
    specialization_id INT UNSIGNED NULL,
    phone VARCHAR(20) NULL,
    email VARCHAR(150) NULL,
    qualification VARCHAR(255) NULL,
    image_path VARCHAR(255) NULL DEFAULT 'images/user-avatar.png',
    status ENUM('active','on-leave','inactive') NOT NULL DEFAULT 'active',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (teacher_id),
    INDEX idx_teacher_number (teacher_number),
    INDEX idx_teacher_spec (specialization_id),
    INDEX idx_teacher_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 18. جدول المكتبة الرقمية (digital_books)
-- ============================================================================
CREATE TABLE IF NOT EXISTS digital_books (
    digital_book_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    book_id INT UNSIGNED NULL,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(150) NULL,
    file_path VARCHAR(255) NOT NULL,
    cover_image VARCHAR(255) NULL,
    file_size BIGINT NULL,
    file_type VARCHAR(50) NULL,
    description TEXT NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    view_count INT UNSIGNED NOT NULL DEFAULT 0,
    download_count INT UNSIGNED NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (digital_book_id),
    INDEX idx_digital_book (book_id),
    INDEX idx_digital_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- ملخص الجداول:
-- ============================================================================
-- 1. employees    - الموظفين
-- 2. students     - الطلاب
-- 3. books        - الكتب
-- 4. loans        - الإعارات (تم التصحيح)
-- 5. curriculums  - المناهج الدراسية (مع الحقول الجديدة)
-- 6. lectures     - المحاضرات
-- 7. graduation_projects - مشاريع التخرج
-- 9. subscriptions - الاشتراكات
-- 10. roles       - الأدوار
-- 11. users       - المستخدمين
-- 12. specializations - التخصصات
-- 13. subjects    - المواد الدراسية
-- 14. departments - أقسام المكتبة
-- 15. book_categories - فئات الكتب
-- 16. jobs        - الوظائف
-- 17. teachers    - المدرسين
-- 18. digital_books - الكتب الرقمية
-- ============================================================================

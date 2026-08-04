-- ===================================================
-- جميع الجداول المتبقية: طلاب، كتب، اشتراكات، استعارات، مناهج، محاضرات، مشاريع تخرج
-- ===================================================
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- -----------------------------------------------
-- 1. جدول الطلاب
-- تم التحديث ليطابق التطبيق الفعلي
-- -----------------------------------------------
CREATE TABLE IF NOT EXISTS students (
    student_id        INT UNSIGNED NOT NULL AUTO_INCREMENT,
    student_number   VARCHAR(30)  NOT NULL UNIQUE,
    full_name        VARCHAR(150) NOT NULL,
    gender           ENUM('male','female') NOT NULL DEFAULT 'male',
    specialization_id INT UNSIGNED NULL,
    year_level       TINYINT UNSIGNED NOT NULL DEFAULT 1,
    phone            VARCHAR(20)  NULL,
    email            VARCHAR(150) NULL,
    address          VARCHAR(255) NULL,
    enrollment_date  DATE         NULL,
    photo_path       VARCHAR(255) NULL COMMENT 'مسار صورة الطالب',
    card_front_path  VARCHAR(255) NULL COMMENT 'مسار صورة بطاقة الطالب الامامية',
    card_back_path   VARCHAR(255) NULL COMMENT 'مسار صورة بطاقة الطالب الخلفية',
    status           ENUM('active','graduated','suspended','withdrawn') NOT NULL DEFAULT 'active',
    is_active        TINYINT(1)   NOT NULL DEFAULT 1,
    notes            TEXT NULL,
    created_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (student_id),
    INDEX idx_students_number (student_number),
    INDEX idx_students_spec (specialization_id),
    INDEX idx_students_status (status),
    CONSTRAINT fk_students_spec FOREIGN KEY (specialization_id) REFERENCES specializations(specialization_id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------
-- 2. جدول الكتب
-- تم التحديث ليطابق التطبيق الفعلي
-- -----------------------------------------------
CREATE TABLE IF NOT EXISTS books (
    book_id           INT UNSIGNED NOT NULL AUTO_INCREMENT,
    book_number      VARCHAR(50)  NULL UNIQUE,
    title            VARCHAR(255) NOT NULL,
    author           VARCHAR(150) NULL,
    publisher        VARCHAR(150) NULL,
    publish_year     VARCHAR(10)  NULL,
    isbn             VARCHAR(30)  NULL,
    category_id      INT UNSIGNED NULL,
    copies_total     INT UNSIGNED NOT NULL DEFAULT 1,
    copies_available INT UNSIGNED NOT NULL DEFAULT 1,
    shelf_location   VARCHAR(100) NULL,
    status           ENUM('available','borrowed','reserved','lost') NOT NULL DEFAULT 'available',
    notes            TEXT NULL,
    created_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (book_id),
    INDEX idx_books_number (book_number),
    INDEX idx_books_title (title),
    INDEX idx_books_status (status),
    INDEX idx_books_category (category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------
-- 3. جدول الاشتراكات
-- -----------------------------------------------
CREATE TABLE IF NOT EXISTS subscriptions (
    subscription_id   INT UNSIGNED NOT NULL AUTO_INCREMENT,
    subscriber_type   ENUM('student','employee','teacher','external') NOT NULL DEFAULT 'student',
    subscriber_id     INT UNSIGNED NOT NULL COMMENT 'ID حسب النوع',
    subscriber_name   VARCHAR(150) NOT NULL COMMENT 'نسخة مؤقتة للاسم',
    subscription_type ENUM('monthly','semester','annual') NOT NULL DEFAULT 'semester',
    start_date        DATE NOT NULL,
    end_date          DATE NOT NULL,
    max_loans         TINYINT UNSIGNED NOT NULL DEFAULT 3,
    fee               DECIMAL(8,2) NOT NULL DEFAULT 0.00,
    is_paid           TINYINT(1)   NOT NULL DEFAULT 0,
    status            ENUM('active','expired','suspended') NOT NULL DEFAULT 'active',
    notes             TEXT NULL,
    created_at        TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at        TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (subscription_id),
    INDEX idx_sub_type_id (subscriber_type, subscriber_id),
    INDEX idx_sub_status  (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------
-- 4. جدول الاستعارات (الإعارات)
-- تم تحديثه ليطابق التطبيق الفعلي (student_id بدلاً من borrower_type/id)
-- -----------------------------------------------
CREATE TABLE IF NOT EXISTS loans (
    loan_id           INT UNSIGNED NOT NULL AUTO_INCREMENT,
    loan_number      VARCHAR(50)  NOT NULL UNIQUE,
    student_id       INT UNSIGNED NOT NULL,
    book_id          INT UNSIGNED NOT NULL,
    loan_date        DATE NOT NULL,
    due_date         DATE NOT NULL,
    return_date      DATE NULL,
    status           ENUM('active','returned','overdue','lost') NOT NULL DEFAULT 'active',
    fine_amount      DECIMAL(8,2) NOT NULL DEFAULT 0.00,
    fine_paid        TINYINT(1)   NOT NULL DEFAULT 0,
    notes            TEXT NULL,
    created_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (loan_id),
    INDEX idx_loans_student (student_id),
    INDEX idx_loans_book   (book_id),
    INDEX idx_loans_status (status),
    INDEX idx_loans_number (loan_number),
    CONSTRAINT fk_loans_student FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    CONSTRAINT fk_loans_book FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------
-- 5. جدول المناهج الدراسية
-- تم التحديث لإضافة حقول جديدة (teacher_id, curriculum_type, image_path, file_path, credits)
-- -----------------------------------------------
CREATE TABLE IF NOT EXISTS curriculums (
    curriculum_id     INT UNSIGNED NOT NULL AUTO_INCREMENT,
    curriculum_code   VARCHAR(50)  NULL UNIQUE,
    course_code       VARCHAR(20)  NOT NULL,
    course_name       VARCHAR(200) NOT NULL,
    specialization_id INT UNSIGNED NULL,
    teacher_id       INT UNSIGNED NULL,
    year_level       TINYINT UNSIGNED NOT NULL DEFAULT 1,
    semester         ENUM('first','second','summer') NOT NULL DEFAULT 'first',
    curriculum_type   ENUM('theoretical','practical','both') NOT NULL DEFAULT 'theoretical',
    credits          SMALLINT UNSIGNED NOT NULL DEFAULT 3,
    hours_theory     SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    hours_practical  SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    description      TEXT NULL,
    image_path       VARCHAR(255) NULL,
    file_path        VARCHAR(255) NULL,
    is_active        TINYINT(1)   NOT NULL DEFAULT 1,
    created_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (curriculum_id),
    INDEX idx_curr_code (curriculum_code),
    INDEX idx_curr_name (course_name),
    INDEX idx_curr_spec (specialization_id),
    INDEX idx_curr_teacher (teacher_id),
    CONSTRAINT fk_curr_spec FOREIGN KEY (specialization_id) REFERENCES specializations(specialization_id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------
-- 6. جدول المحاضرات
-- -----------------------------------------------
CREATE TABLE IF NOT EXISTS lectures (
    lecture_id        INT UNSIGNED NOT NULL AUTO_INCREMENT,
    lecture_code      VARCHAR(20)  NOT NULL UNIQUE,
    lecture_title     VARCHAR(200) NOT NULL,
    subject_id        INT UNSIGNED NULL,
    teacher_id        INT UNSIGNED NULL,
    lecture_date      DATE         NULL,
    lecture_time      TIME         NULL,
    duration_minutes  SMALLINT UNSIGNED NOT NULL DEFAULT 60,
    room              VARCHAR(50)  NULL,
    lecture_type      ENUM('theoretical','practical','online') NOT NULL DEFAULT 'theoretical',
    file_path         VARCHAR(255) NULL,
    description       TEXT NULL,
    is_active         TINYINT(1)   NOT NULL DEFAULT 1,
    created_at        TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at        TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (lecture_id),
    INDEX idx_lec_subject (subject_id),
    INDEX idx_lec_teacher (teacher_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- -----------------------------------------------
-- 7. جدول مشاريع التخرج
-- -----------------------------------------------
CREATE TABLE IF NOT EXISTS graduation_projects (
    project_id        INT UNSIGNED NOT NULL AUTO_INCREMENT,
    project_code      VARCHAR(20)  NOT NULL UNIQUE,
    project_title     VARCHAR(255) NOT NULL,
    specialization_id INT UNSIGNED NULL,
    supervisor_id     INT UNSIGNED NULL COMMENT 'teacher_id',
    academic_year     VARCHAR(20)  NOT NULL,
    semester          ENUM('first','second','summer') NOT NULL DEFAULT 'second',
    project_type      ENUM('individual','group') NOT NULL DEFAULT 'group',
    status            ENUM('proposed','approved','in_progress','completed','rejected') NOT NULL DEFAULT 'proposed',
    grade             DECIMAL(5,2) NULL,
    file_path         VARCHAR(255) NULL,
    description       TEXT NULL,
    created_at        TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at        TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (project_id),
    INDEX idx_proj_spec (specialization_id),
    INDEX idx_proj_supervisor (supervisor_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ربط الطلاب بمشاريع التخرج
CREATE TABLE IF NOT EXISTS project_students (
    project_id  INT UNSIGNED NOT NULL,
    student_id  INT UNSIGNED NOT NULL,
    role        ENUM('leader','member') NOT NULL DEFAULT 'member',
    PRIMARY KEY (project_id, student_id),
    CONSTRAINT fk_ps_project FOREIGN KEY (project_id) REFERENCES graduation_projects(project_id) ON DELETE CASCADE,
    CONSTRAINT fk_ps_student FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

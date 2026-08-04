-- جدول طلبات رفع المحاضرات
CREATE TABLE IF NOT EXISTS lecture_upload_requests (
    request_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    member_id INT UNSIGNED NOT NULL COMMENT 'رقم العضو الذي يقدم الطلب',
    lecture_title VARCHAR(255) NOT NULL COMMENT 'عنوان المحاضرة',
    instructor VARCHAR(200) NULL COMMENT 'المدرس',
    course_name VARCHAR(200) NULL COMMENT 'اسم المقرر',
    department_id INT UNSIGNED NULL COMMENT 'القسم',
    academic_year VARCHAR(20) NULL COMMENT 'السنة الدراسية',
    semester VARCHAR(20) NULL COMMENT 'الفصل الدراسي',
    lecture_description TEXT NULL COMMENT 'وصف المحاضرة',
    file_path VARCHAR(500) NULL COMMENT 'مسار الملف',
    cover_image VARCHAR(500) NULL COMMENT 'صورة الغلاف',
    file_size BIGINT NULL COMMENT 'حجم الملف',
    file_type VARCHAR(50) NULL COMMENT 'نوع الملف',
    notes TEXT NULL COMMENT 'ملاحظات',
    
    -- حالة الطلب
    status ENUM('pending', 'approved', 'rejected') NOT NULL DEFAULT 'pending' COMMENT 'حالة الطلب',
    rejection_reason TEXT NULL COMMENT 'سبب الرفض',
    reviewed_by INT UNSIGNED NULL COMMENT 'المراجع',
    reviewed_at DATETIME NULL COMMENT 'وقت المراجعة',
    
    -- تتبع
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    PRIMARY KEY (request_id),
    INDEX idx_lecture_requests_member (member_id),
    INDEX idx_lecture_requests_status (status),
    INDEX idx_lecture_requests_department (department_id),
    INDEX idx_lecture_requests_created (created_at),
    
    CONSTRAINT fk_lecture_requests_member FOREIGN KEY (member_id) REFERENCES library_members(member_id) ON DELETE CASCADE,
    CONSTRAINT fk_lecture_requests_department FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- جدول طلبات رفع مشاريع التخرج
CREATE TABLE IF NOT EXISTS project_upload_requests (
    request_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    member_id INT UNSIGNED NOT NULL COMMENT 'رقم العضو الذي يقدم الطلب',
    project_title VARCHAR(255) NOT NULL COMMENT 'عنوان المشروع',
    student_names TEXT NULL COMMENT 'أسماء الطلاب',
    supervisor VARCHAR(200) NULL COMMENT 'المشرف',
    department_id INT UNSIGNED NULL COMMENT 'القسم',
    graduation_year YEAR NULL COMMENT 'سنة التخرج',
    project_description TEXT NULL COMMENT 'وصف المشروع',
    technologies_used TEXT NULL COMMENT 'التقنيات المستخدمة',
    file_path VARCHAR(500) NULL COMMENT 'مسار الملف',
    cover_image VARCHAR(500) NULL COMMENT 'صورة الغلاف',
    logo_image VARCHAR(500) NULL COMMENT 'شعار المشروع',
    file_size BIGINT NULL COMMENT 'حجم الملف',
    file_type VARCHAR(50) NULL COMMENT 'نوع الملف',
    demo_link VARCHAR(500) NULL COMMENT 'رابط العرض',
    github_link VARCHAR(500) NULL COMMENT 'رابط GitHub',
    notes TEXT NULL COMMENT 'ملاحظات',
    
    -- حالة الطلب
    status ENUM('pending', 'approved', 'rejected') NOT NULL DEFAULT 'pending' COMMENT 'حالة الطلب',
    rejection_reason TEXT NULL COMMENT 'سبب الرفض',
    reviewed_by INT UNSIGNED NULL COMMENT 'المراجع',
    reviewed_at DATETIME NULL COMMENT 'وقت المراجعة',
    
    -- تتبع
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    PRIMARY KEY (request_id),
    INDEX idx_project_requests_member (member_id),
    INDEX idx_project_requests_status (status),
    INDEX idx_project_requests_department (department_id),
    INDEX idx_project_requests_created (created_at),
    
    CONSTRAINT fk_project_requests_member FOREIGN KEY (member_id) REFERENCES library_members(member_id) ON DELETE CASCADE,
    CONSTRAINT fk_project_requests_department FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

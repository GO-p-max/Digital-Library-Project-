-- جدول طلبات رفع الكتب
CREATE TABLE IF NOT EXISTS book_upload_requests (
    request_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    member_id INT UNSIGNED NOT NULL COMMENT 'رقم العضو الذي يقدم الطلب',
    book_title VARCHAR(255) NOT NULL COMMENT 'عنوان الكتاب',
    author VARCHAR(200) NULL COMMENT 'المؤلف',
    publisher VARCHAR(200) NULL COMMENT 'الناشر',
    publish_year YEAR NULL COMMENT 'سنة النشر',
    isbn VARCHAR(50) NULL COMMENT 'رقم الكتاب',
    book_description TEXT NULL COMMENT 'وصف الكتاب',
    department_id INT UNSIGNED NULL COMMENT 'القسم',
    language VARCHAR(50) NULL DEFAULT 'العربية' COMMENT 'اللغة',
    file_path VARCHAR(500) NULL COMMENT 'مسار الملف',
    cover_image VARCHAR(500) NULL COMMENT 'صورة الغلاف',
    file_size BIGINT NULL COMMENT 'حجم الملف',
    file_type VARCHAR(50) NULL COMMENT 'نوع الملف',
    access_type ENUM('public', 'restricted') NOT NULL DEFAULT 'public' COMMENT 'نوع الوصول',
    license_type VARCHAR(100) NULL COMMENT 'نوع الترخيص',
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
    INDEX idx_book_requests_member (member_id),
    INDEX idx_book_requests_status (status),
    INDEX idx_book_requests_department (department_id),
    INDEX idx_book_requests_created (created_at),
    
    CONSTRAINT fk_book_requests_member FOREIGN KEY (member_id) REFERENCES library_members(member_id) ON DELETE CASCADE,
    CONSTRAINT fk_book_requests_department FOREIGN KEY (department_id) REFERENCES departments(department_id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

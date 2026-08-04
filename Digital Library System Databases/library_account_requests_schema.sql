-- جدول طلبات إنشاء حسابات المكتبة الرقمية
CREATE TABLE IF NOT EXISTS library_account_requests (
    request_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    request_type ENUM('new', 'password_reset', 'update') NOT NULL DEFAULT 'new' COMMENT 'new=حساب جديد, password_reset=إعادة تعيين كلمة المرور, update=تحديث البيانات',
    member_type ENUM('student', 'teacher', 'external') NOT NULL DEFAULT 'external' COMMENT 'student=طالب, teacher=مدرس, external=خارجي',
    
    -- بيانات الحساب
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    full_name VARCHAR(200) NOT NULL,
    email VARCHAR(150) NOT NULL,
    phone VARCHAR(20) NULL,
    username VARCHAR(100) NULL,
    password_hash VARCHAR(255) NOT NULL,
    gender ENUM('male', 'female') NOT NULL DEFAULT 'male',
    
    -- للطلاب
    member_number VARCHAR(50) NULL COMMENT 'رقم الطالب',
    specialization_id INT UNSIGNED NULL,
    
    -- للمعلمين
    job_title VARCHAR(100) NULL,
    qualification VARCHAR(150) NULL,
    
    -- للخارجيين
    institution VARCHAR(200) NULL,
    job_description VARCHAR(200) NULL,
    
    -- معلومات إضافية
    verification_code VARCHAR(10) NULL,
    verification_expires DATETIME NULL,
    is_verified TINYINT(1) NOT NULL DEFAULT 0,
    
    -- حالة الطلب
    status ENUM('pending', 'approved', 'rejected') NOT NULL DEFAULT 'pending',
    rejection_reason TEXT NULL,
    reviewed_by INT UNSIGNED NULL,
    reviewed_at DATETIME NULL,
    
    --timestamps
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    PRIMARY KEY (request_id),
    UNIQUE INDEX idx_account_requests_email (email),
    INDEX idx_account_requests_type (request_type),
    INDEX idx_account_requests_status (status),
    INDEX idx_account_requests_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

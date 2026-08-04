-- جدول أعضاء المكتبة (المستخدمين في الموقع العام)
CREATE TABLE IF NOT EXISTS library_members (
    member_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    member_type ENUM('student', 'teacher', 'external') NOT NULL DEFAULT 'external' COMMENT 'student=طالب, teacher=مدرس, external=خارجي',
    member_number VARCHAR(50) NULL COMMENT 'رقم الطالب أو المدرس أو رقم会员',
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    full_name VARCHAR(200) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(20) NULL,
    password_hash VARCHAR(255) NOT NULL,
    gender ENUM('male', 'female') NOT NULL DEFAULT 'male',
    date_of_birth DATE NULL,
    
    -- For students
    specialization_id INT UNSIGNED NULL,
    
    -- For teachers  
    job_title VARCHAR(100) NULL,
    qualification VARCHAR(150) NULL,
    
    -- For external users
    institution VARCHAR(200) NULL COMMENT 'المؤسسة/الجهة',
    job_description VARCHAR(200) NULL COMMENT 'المسمى الوظيفي',
    
    -- Status
    is_active TINYINT(1) NOT NULL DEFAULT 1,
    is_verified TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'تم التحقق من البريد',
    verification_code VARCHAR(10) NULL,
    verification_expires DATETIME NULL,
    
    -- Activity tracking
    last_login DATETIME NULL,
    login_count INT UNSIGNED NOT NULL DEFAULT 0,
    
    -- Notes
    notes TEXT NULL,
    
    -- Timestamps
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    PRIMARY KEY (member_id),
    UNIQUE INDEX idx_library_members_email (email),
    INDEX idx_library_members_type (member_type),
    INDEX idx_library_members_number (member_number),
    INDEX idx_library_members_active (is_active),
    INDEX idx_library_members_created (created_at),
    
    CONSTRAINT fk_library_members_specialization FOREIGN KEY (specialization_id) REFERENCES specializations(specialization_id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

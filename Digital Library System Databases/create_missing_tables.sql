-- جدول تصنيفات الكتب
CREATE TABLE IF NOT EXISTS book_categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    description TEXT,
    is_active TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_name (category_name),
    INDEX idx_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- جدول الكتب
CREATE TABLE IF NOT EXISTS books (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    book_number VARCHAR(50) UNIQUE,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(150),
    publisher VARCHAR(150),
    publish_year VARCHAR(10),
    isbn VARCHAR(30),
    category_id INT,
    copies_total INT DEFAULT 1,
    copies_available INT DEFAULT 1,
    shelf_location VARCHAR(100),
    status ENUM('available', 'borrowed', 'reserved', 'lost') DEFAULT 'available',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES book_categories(category_id) ON DELETE SET NULL,
    INDEX idx_number (book_number),
    INDEX idx_title (title),
    INDEX idx_status (status),
    INDEX idx_category (category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- جدول الطلاب
CREATE TABLE IF NOT EXISTS students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    student_number VARCHAR(30) UNIQUE,
    full_name VARCHAR(150) NOT NULL,
    gender ENUM('male', 'female') DEFAULT 'male',
    specialization_id INT,
    year_level INT DEFAULT 1,
    phone VARCHAR(20),
    email VARCHAR(150),
    enrollment_date DATE,
    status ENUM('active', 'graduated', 'suspended', 'withdrawn') DEFAULT 'active',
    notes TEXT,
    is_active TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (specialization_id) REFERENCES specializations(specialization_id) ON DELETE SET NULL,
    INDEX idx_number (student_number),
    INDEX idx_name (full_name),
    INDEX idx_status (status),
    INDEX idx_specialization (specialization_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- جدول الاشتراكات
CREATE TABLE IF NOT EXISTS subscriptions (
    subscription_id INT AUTO_INCREMENT PRIMARY KEY,
    subscription_number VARCHAR(50) UNIQUE,
    student_id INT NOT NULL,
    subscription_type ENUM('monthly', 'quarterly', 'semiannual', 'annual') DEFAULT 'monthly',
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    amount DECIMAL(10,2) DEFAULT 0,
    payment_method ENUM('cash', 'card', 'bank', 'online') DEFAULT 'cash',
    status ENUM('active', 'expired', 'cancelled') DEFAULT 'active',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    INDEX idx_number (subscription_number),
    INDEX idx_student (student_id),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- جدول الإعارات
CREATE TABLE IF NOT EXISTS loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    loan_number VARCHAR(50) UNIQUE,
    student_id INT NOT NULL,
    book_id INT NOT NULL,
    loan_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    status ENUM('active', 'returned', 'overdue') DEFAULT 'active',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    INDEX idx_number (loan_number),
    INDEX idx_student (student_id),
    INDEX idx_book (book_id),
    INDEX idx_status (status),
    INDEX idx_dates (loan_date, due_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- جدول المناهج
CREATE TABLE IF NOT EXISTS curriculums (
    curriculum_id INT AUTO_INCREMENT PRIMARY KEY,
    curriculum_code VARCHAR(50),
    course_code VARCHAR(20) NOT NULL,
    course_name VARCHAR(200) NOT NULL,
    specialization_id INT,
    year_level INT DEFAULT 1,
    semester ENUM('first', 'second', 'summer') DEFAULT 'first',
    credits INT DEFAULT 3,
    hours_theory INT DEFAULT 0,
    hours_practical INT DEFAULT 0,
    description TEXT,
    is_active TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (specialization_id) REFERENCES specializations(specialization_id) ON DELETE SET NULL,
    INDEX idx_code (course_code),
    INDEX idx_name (course_name),
    INDEX idx_specialization (specialization_id),
    INDEX idx_year (year_level)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- جدول المحاضرات
CREATE TABLE IF NOT EXISTS lectures (
    lecture_id INT AUTO_INCREMENT PRIMARY KEY,
    lecture_number VARCHAR(50) UNIQUE,
    curriculum_id INT,
    teacher_id INT,
    lecture_date DATE NOT NULL,
    lecture_time TIME NOT NULL,
    duration INT DEFAULT 90,
    type ENUM('lecture', 'lab', 'discussion', 'exam') DEFAULT 'lecture',
    location VARCHAR(100),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (curriculum_id) REFERENCES curriculums(curriculum_id) ON DELETE SET NULL,
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id) ON DELETE SET NULL,
    INDEX idx_number (lecture_number),
    INDEX idx_curriculum (curriculum_id),
    INDEX idx_teacher (teacher_id),
    INDEX idx_date (lecture_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- جدول مشاريع التخرج
CREATE TABLE IF NOT EXISTS graduation_projects (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    project_number VARCHAR(50) UNIQUE,
    title VARCHAR(300) NOT NULL,
    student_id INT NOT NULL,
    supervisor_id INT,
    start_date DATE,
    end_date DATE,
    grade VARCHAR(20),
    status ENUM('ongoing', 'completed', 'failed', 'postponed') DEFAULT 'ongoing',
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (supervisor_id) REFERENCES teachers(teacher_id) ON DELETE SET NULL,
    INDEX idx_number (project_number),
    INDEX idx_title (title),
    INDEX idx_student (student_id),
    INDEX idx_supervisor (supervisor_id),
    INDEX idx_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- إضافة تصنيفات كتب افتراضية
INSERT IGNORE INTO book_categories (category_id, category_name, description) VALUES
(1, 'علوم الحاسب', 'كتب متعلقة بعلوم الحاسب والبرمجة'),
(2, 'قواعد البيانات', 'كتب متعلقة بقواعد البيانات'),
(3, 'الشبكات', 'كتب متعلقة بشبكات الحاسب'),
(4, 'الأمن السيبراني', 'كتب متعلقة بالأمن السيبراني'),
(5, 'الذكاء الاصطناعي', 'كتب متعلقة بالذكاء الاصطناعي'),
(6, 'تطوير الويب', 'كتب متعلقة بتطوير الويب'),
(7, 'أنظمة التشغيل', 'كتب متعلقة بأنظمة التشغيل'),
(8, 'الهندسة البرمجية', 'كتب متعلقة بهندسة البرمجيات');

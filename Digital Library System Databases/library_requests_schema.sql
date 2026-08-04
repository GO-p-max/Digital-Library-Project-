-- =============================================
-- Library Requests Database Schema
-- =============================================

-- Table: library_requests
-- Stores requests from public library site (books, lectures, projects)

CREATE TABLE IF NOT EXISTS library_requests (
    request_id INT AUTO_INCREMENT PRIMARY KEY,
    request_type ENUM('book', 'lecture', 'project') NOT NULL COMMENT 'نوع الطلب: book=كتاب, lecture=محاضرة, project=مشروع تخرج',
    requester_name VARCHAR(100) NOT NULL COMMENT 'اسم الطالب/المدرس',
    requester_email VARCHAR(150) NOT NULL COMMENT 'بريد الطالب',
    requester_phone VARCHAR(20) COMMENT 'رقم الهاتف',
    requester_id VARCHAR(50) COMMENT 'رقم الطالب أو الوظيفي',
    requester_type ENUM('student', 'teacher') DEFAULT 'student' COMMENT 'نوع العضو',
    
    -- Request details
    title VARCHAR(255) NOT NULL COMMENT 'عنوان الكتاب/المحاضرة/المشروع',
    description TEXT COMMENT 'وصف إضافي',
    author VARCHAR(150) COMMENT 'المؤلف/المعد',
    publisher VARCHAR(150) COMMENT 'الناشر',
    file_path VARCHAR(255) COMMENT 'مسار الملف المرفوع',
    file_type VARCHAR(50) COMMENT 'نوع الملف',
    file_size INT COMMENT 'حجم الملف بالبايت',
    
    -- Status
    status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending' COMMENT 'حالة الطلب',
    admin_notes TEXT COMMENT 'ملاحظات الأدمن',
    reviewed_by INT COMMENT 'معرف الأدمن',
    reviewed_at DATETIME COMMENT 'وقت المراجعة',
    
    -- Timestamps
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX idx_status (status),
    INDEX idx_type (request_type),
    INDEX idx_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert sample data
INSERT INTO library_requests (request_type, requester_name, requester_email, requester_phone, requester_id, requester_type, title, description, status) VALUES
('book', 'أحمد سليم', 'ahmed@example.com', '777123456', 'STU-2024-001', 'student', 'كتاب تعلم Python', 'أحتاج هذا الكتاب لفهم أساسيات البرمجة', 'pending'),
('lecture', 'محمد علي', 'mohammed@example.com', '771234567', 'TCH-2024-001', 'teacher', 'محاضرات مادة قواعد البيانات', 'محاضرات الفصل الدراسي الحالي', 'pending'),
('project', 'خالد عمر', 'khaled@example.com', '771234568', 'STU-2024-002', 'student', 'توثيق مشروع نظام إدارة مكتبة', 'مشروع تخرج للفصل الدراسي الحالي', 'pending');

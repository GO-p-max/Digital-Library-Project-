-- إضافة الصفحات الجديدة للنظام
INSERT IGNORE INTO pages (page_key, page_name, page_group, sort_order) VALUES
('students.php', 'إدارة الطلاب', 'الإدارة العامة', 15),
('books.php', 'إدارة الكتب', 'الكتب والاستعارات', 25),
('subscriptions.php', 'إدارة الاشتراكات', 'الكتب والاستعارات', 26),
('loans.php', 'إدارة الاستعارات', 'الكتب والاستعارات', 27),
('curriculums.php', 'إدارة المناهج', 'المحتوى الدراسي', 35),
('lectures.php', 'إدارة المحاضرات', 'المحتوى الدراسي', 36),
('graduation_projects.php', 'مشاريع التخرج', 'المحتوى الدراسي', 37),
('backup.php', 'النسخ الاحتياطي', 'النظام', 50);

-- التأكد من وجود العمليات الأساسية
INSERT IGNORE INTO operations (operation_id, operation_key, operation_name) VALUES
(1, 'view', 'عرض'),
(2, 'add', 'إضافة'),
(3, 'edit', 'تعديل'),
(4, 'delete', 'حذف');

-- إنشاء دور مدير عام مع كل الصلاحيات
INSERT IGNORE INTO roles (role_id, role_name, description) VALUES (1, 'مدير عام', 'مدير عام للنظام له جميع الصلاحيات');

-- حذف صلاحيات الدور القديم وإضافة كل الصلاحيات
DELETE FROM role_permissions WHERE role_id = 1;

-- إضافة كل الصلاحيات (عرض، إضافة، تعديل، حذف) لكل الصفحات
INSERT INTO role_permissions (role_id, page_id, operation_id)
SELECT 1, p.page_id, o.operation_id
FROM pages p
CROSS JOIN operations o;

-- حذف المستخدم admin السابق إن وجد
DELETE FROM users WHERE username = 'admin';

-- حذف الموظف admin إن وجد
DELETE FROM employees WHERE employee_id = 999;

-- إنشاء موظف للمستخدم admin في جدول الموظفين أولاً
INSERT INTO employees (employee_id, employee_number, full_name, gender, marital_status, branch_code, job_title, salary, phone, email, status) VALUES 
(999, 'EMP-999', 'مدير عام النظام', 'male', 'single', 'main-1', 'مدير عام', 0, '0000000000', 'admin@system.local', 'active');

-- إنشاء مستخدم admin بكلمة السر admin (password: admin)
INSERT INTO users (username, password_hash, employee_id, role_id, is_active) VALUES 
('admin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 999, 1, 1);

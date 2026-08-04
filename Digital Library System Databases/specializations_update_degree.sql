-- تحديث جدول التخصصات: إضافة عمود نوع النظام (بكالوريوس / دبلوم عالي)
-- متوافق مع MySQL 5.7+ و MariaDB 10.0+
SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- إضافة العمود فقط إذا لم يكن موجوداً (متوافق مع MySQL 5.7)
SET @dbname = DATABASE();
SET @tablename = 'specializations';
SET @columnname = 'degree_type';
SET @preparedStatement = (
    SELECT IF(
        COUNT(*) = 0,
        CONCAT('ALTER TABLE `', @tablename, '` ADD COLUMN `degree_type` ENUM(''bachelor'', ''higher_diploma'') NOT NULL DEFAULT ''bachelor'' COMMENT ''نوع الدرجة العلمية: بكالوريوس أو دبلوم عالٍ'' AFTER `department_type`'),
        'SELECT 1'
    )
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = @dbname
      AND TABLE_NAME   = @tablename
      AND COLUMN_NAME  = @columnname
);
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

-- تخصصات كلية الحاسوب الكاملة
INSERT INTO specializations (specialization_code, specialization_name, description, department_type, degree_type, is_active) VALUES
('CS-B',    'علوم الحاسوب',              'تخصص بكالوريوس في علوم الحاسوب وتكنولوجيا المعلومات',                  'academic', 'bachelor',       1),
('IS-B',    'نظم المعلومات',             'تخصص بكالوريوس في نظم المعلومات وإدارة البيانات',                      'academic', 'bachelor',       1),
('SE-B',    'هندسة البرمجيات',           'تخصص بكالوريوس في هندسة وتطوير البرمجيات',                             'technical','bachelor',       1),
('AI-B',    'الذكاء الاصطناعي',          'تخصص بكالوريوس في الذكاء الاصطناعي وتعلم الآلة',                      'academic', 'bachelor',       1),
('CN-B',    'شبكات الحاسوب',             'تخصص بكالوريوس في شبكات الحاسوب والاتصالات',                          'technical','bachelor',       1),
('SEC-B',   'أمن المعلومات',             'تخصص بكالوريوس في أمن المعلومات والأمن السيبراني',                    'technical','bachelor',       1),
('IT-B',    'تقنية المعلومات',           'تخصص بكالوريوس في تقنية المعلومات والحوسبة',                          'technical','bachelor',       1),
('MCOM-B',  'الحوسبة المتنقلة',          'تخصص بكالوريوس في تطوير تطبيقات الهاتف والحوسبة المتنقلة',            'technical','bachelor',       1),
('MM-B',    'الوسائط المتعددة',          'تخصص بكالوريوس في تصميم الوسائط المتعددة والرسومات الحاسوبية',        'technical','bachelor',       1),
('DB-HD',   'قواعد البيانات',            'دبلوم عالٍ في إدارة وتصميم قواعد البيانات',                           'technical','higher_diploma',  1),
('CC-HD',   'الحوسبة السحابية',          'دبلوم عالٍ في الحوسبة السحابية والبنية التحتية الرقمية',              'technical','higher_diploma',  1),
('DA-HD',   'تحليل البيانات',            'دبلوم عالٍ في تحليل البيانات وعلم البيانات',                          'academic', 'higher_diploma',  1),
('IOT-HD',  'إنترنت الأشياء',            'دبلوم عالٍ في إنترنت الأشياء والأنظمة المضمنة',                      'technical','higher_diploma',  1),
('PROG-HD', 'البرمجة التطبيقية',         'دبلوم عالٍ في البرمجة التطبيقية وتطوير الويب',                        'technical','higher_diploma',  1)
ON DUPLICATE KEY UPDATE
    description  = VALUES(description),
    department_type = VALUES(department_type),
    degree_type  = VALUES(degree_type),
    is_active    = VALUES(is_active),
    updated_at   = CURRENT_TIMESTAMP;

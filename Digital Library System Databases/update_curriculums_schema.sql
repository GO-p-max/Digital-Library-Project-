-- تحديث جدول المناهج لإضافة حقول جديدة
-- هذا الملف يضيف حقول للمدرسين ونوع المقرر والصور والملفات

SET NAMES utf8mb4;

-- إضافة حقل course_code إذا لم يكن موجوداً (حقل مطلوب في قاعدة البيانات)
SET @column_exists = (SELECT COUNT(*) FROM information_schema.COLUMNS 
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'curriculums' AND COLUMN_NAME = 'course_code');
IF @column_exists = 0 THEN
    ALTER TABLE curriculums ADD COLUMN course_code VARCHAR(20) NOT NULL AFTER curriculum_code;
END IF;

-- إضافة حقل teacher_id إذا لم يكن موجوداً
SET @column_exists = (SELECT COUNT(*) FROM information_schema.COLUMNS 
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'curriculums' AND COLUMN_NAME = 'teacher_id');
IF @column_exists = 0 THEN
    ALTER TABLE curriculums ADD COLUMN teacher_id INT UNSIGNED NULL AFTER specialization_id;
END IF;

-- إضافة حقل curriculum_type إذا لم يكن موجوداً
SET @column_exists = (SELECT COUNT(*) FROM information_schema.COLUMNS 
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'curriculums' AND COLUMN_NAME = 'curriculum_type');
IF @column_exists = 0 THEN
    ALTER TABLE curriculums ADD COLUMN curriculum_type ENUM('theoretical', 'practical', 'both') NOT NULL DEFAULT 'theoretical' AFTER teacher_id;
END IF;

-- إضافة حقل image_path إذا لم يكن موجوداً
SET @column_exists = (SELECT COUNT(*) FROM information_schema.COLUMNS 
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'curriculums' AND COLUMN_NAME = 'image_path');
IF @column_exists = 0 THEN
    ALTER TABLE curriculums ADD COLUMN image_path VARCHAR(255) NULL AFTER curriculum_type;
END IF;

-- إضافة حقل file_path إذا لم يكن موجوداً
SET @column_exists = (SELECT COUNT(*) FROM information_schema.COLUMNS 
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'curriculums' AND COLUMN_NAME = 'file_path');
IF @column_exists = 0 THEN
    ALTER TABLE curriculums ADD COLUMN file_path VARCHAR(255) NULL AFTER image_path;
END IF;

-- إضافة حقل hours_theory إذا لم يكن موجوداً
SET @column_exists = (SELECT COUNT(*) FROM information_schema.COLUMNS 
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'curriculums' AND COLUMN_NAME = 'hours_theory');
IF @column_exists = 0 THEN
    ALTER TABLE curriculums ADD COLUMN hours_theory SMALLINT UNSIGNED NOT NULL DEFAULT 0 AFTER credits;
END IF;

-- إضافة حقل hours_practical إذا لم يكن موجوداً
SET @column_exists = (SELECT COUNT(*) FROM information_schema.COLUMNS 
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'curriculums' AND COLUMN_NAME = 'hours_practical');
IF @column_exists = 0 THEN
    ALTER TABLE curriculums ADD COLUMN hours_practical SMALLINT UNSIGNED NOT NULL DEFAULT 0 AFTER hours_theory;
END IF;

-- إضافة حقل file_path لجدول المحاضرات
SET @column_exists = (SELECT COUNT(*) FROM information_schema.COLUMNS 
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'lectures' AND COLUMN_NAME = 'file_path');
IF @column_exists = 0 THEN
    ALTER TABLE lectures ADD COLUMN file_path VARCHAR(255) NULL AFTER room;
END IF;

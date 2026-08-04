-- ===================================================================
-- Fix lectures table to add curriculum_id if missing
-- ===================================================================

-- إضافة curriculum_id إذا لم يكن موجوداً
SET @column_exists = (SELECT COUNT(*) FROM information_schema.COLUMNS 
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'lectures' AND COLUMN_NAME = 'curriculum_id');
IF @column_exists = 0 THEN
    ALTER TABLE lectures ADD COLUMN curriculum_id INT UNSIGNED NULL AFTER subject_id;
    ALTER TABLE lectures ADD INDEX idx_lec_curriculum (curriculum_id);
END IF;

-- إضافة file_path إذا لم يكن موجوداً (للملفات)
SET @column_exists = (SELECT COUNT(*) FROM information_schema.COLUMNS 
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'lectures' AND COLUMN_NAME = 'file_path');
IF @column_exists = 0 THEN
    ALTER TABLE lectures ADD COLUMN file_path VARCHAR(500) NULL AFTER lecture_type;
END IF;

-- إضافة notes (ملاحظات) إذا لم يكن موجوداً - قد يكون description
SET @column_exists = (SELECT COUNT(*) FROM information_schema.COLUMNS 
    WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'lectures' AND COLUMN_NAME = 'notes');
IF @column_exists = 0 THEN
    -- إذا كان يوجد description، قم بإعادة تسميته إلى notes
    SET @desc_exists = (SELECT COUNT(*) FROM information_schema.COLUMNS 
        WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'lectures' AND COLUMN_NAME = 'description');
    IF @desc_exists > 0 THEN
        ALTER TABLE lectures CHANGE description notes TEXT NULL;
    ELSE
        ALTER TABLE lectures ADD COLUMN notes TEXT NULL;
    END IF;
END IF;

-- التحقق من الأعمدة الموجودة
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE 
FROM information_schema.COLUMNS 
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'lectures' 
ORDER BY ORDINAL_POSITION;

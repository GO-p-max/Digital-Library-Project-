-- Add photo columns to students table
-- Run this SQL to add the new columns for student photos

-- Check if column doesn't exist before adding
-- For MySQL 8.0 and later, you can use:
-- ALTER TABLE students ADD COLUMN photo_path VARCHAR(255) NULL COMMENT 'مسار صورة الطالب' AFTER enrollment_date;

-- For compatibility, we'll use a simple approach:
ALTER TABLE students 
ADD COLUMN photo_path VARCHAR(255) NULL COMMENT 'مسار صورة الطالب';

ALTER TABLE students 
ADD COLUMN card_front_path VARCHAR(255) NULL COMMENT 'مسار صورة بطاقة الطالب الامامية';

ALTER TABLE students 
ADD COLUMN card_back_path VARCHAR(255) NULL COMMENT 'مسار صورة بطاقة الطالب الخلفية';

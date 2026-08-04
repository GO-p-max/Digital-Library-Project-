-- Add institution and job_title columns to library_account_requests table

ALTER TABLE library_account_requests 
ADD COLUMN IF NOT EXISTS institution VARCHAR(255) DEFAULT '' AFTER member_number,
ADD COLUMN IF NOT EXISTS job_title VARCHAR(100) DEFAULT '' AFTER institution;

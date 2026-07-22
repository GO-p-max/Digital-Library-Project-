-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 23 يونيو 2026 الساعة 22:34
-- إصدار الخادم: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";
-- ⚜ قواعد بيانات حساسة لاتقم بلتعديل او النشر الغير مصرح ⚜
-- ⚜ الملف الرئيسي لقواعد بيانات المكتبة الرقمية ⚜ 
-- ⚜ م.يوسف نصر شمسان ⚜

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `lib_book_db`
--

-- --------------------------------------------------------

--
-- بنية الجدول `backup_history`
--

CREATE TABLE `backup_history` (
  `backup_id` int(11) NOT NULL,
  `backup_number` varchar(50) NOT NULL,
  `backup_type` enum('full','partial','automatic') DEFAULT 'full',
  `description` text DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_size` bigint(20) DEFAULT 0,
  `table_count` int(11) DEFAULT 0,
  `record_count` bigint(20) DEFAULT 0,
  `backup_path` varchar(500) DEFAULT NULL,
  `status` enum('pending','in_progress','completed','failed','restored') DEFAULT 'pending',
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `completed_at` timestamp NULL DEFAULT NULL,
  `restored_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `backup_history`
--

INSERT INTO `backup_history` (`backup_id`, `backup_number`, `backup_type`, `description`, `file_name`, `file_size`, `table_count`, `record_count`, `backup_path`, `status`, `created_by`, `created_at`, `completed_at`, `restored_at`) VALUES
(1, 'BKP-2026-0001', 'full', 'نسخة 1 تجريبي', 'backups/BKP-2026-0001_20260308231116.sql', 85741, 0, 0, NULL, 'completed', NULL, '2026-03-08 22:11:16', '2026-03-14 02:54:12', NULL),
(2, 'BKP-2026-0002', 'full', 'يبلبليليبلبيل', 'backups/BKP-2026-0002_20260314034944.sql', 105613, 0, 0, NULL, 'completed', NULL, '2026-03-14 02:49:44', '2026-03-14 02:54:12', NULL),
(4, 'BKP-2026-0003', 'automatic', 'بيبليبل', 'BKP-2026-0003_20260314035621.sql', 106104, 26, 393, NULL, 'completed', NULL, '2026-03-14 02:56:21', '2026-03-14 02:56:21', NULL),
(5, 'BKP-2026-0004', 'partial', 'ربسيبس', 'BKP-2026-0004_20260314041646.sql', 99086, 24, 387, NULL, 'completed', NULL, '2026-03-14 03:16:46', '2026-03-14 03:16:46', NULL),
(6, 'BKP-2026-0005', 'partial', 'نسخة تلقائية - تاريخ: 2026-03-14 وقت: 06:26', 'BKP-2026-0005_20260314042656.sql', 97613, 24, 373, NULL, 'completed', NULL, '2026-03-14 03:26:56', '2026-03-14 03:26:56', NULL),
(7, 'BKP-2026-0006', 'full', '', 'BKP-2026-0006_20260328092050.sql', 126742, 32, 409, NULL, 'completed', NULL, '2026-03-28 08:20:50', '2026-03-28 08:20:50', NULL);

-- --------------------------------------------------------

--
-- بنية الجدول `books`
--

CREATE TABLE `books` (
  `book_id` int(10) UNSIGNED NOT NULL,
  `book_number` varchar(50) DEFAULT NULL,
  `isbn` varchar(20) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `status` enum('available','borrowed','reserved','lost') DEFAULT 'available',
  `notes` text DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `author` varchar(200) NOT NULL,
  `publisher` varchar(150) DEFAULT NULL,
  `publish_year` year(4) DEFAULT NULL,
  `edition` varchar(30) DEFAULT NULL,
  `department_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'قسم المكتبة',
  `subject_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'المادة الدراسية',
  `copies_total` smallint(5) UNSIGNED NOT NULL DEFAULT 1,
  `copies_available` smallint(5) UNSIGNED NOT NULL DEFAULT 1,
  `shelf_location` varchar(50) DEFAULT NULL,
  `language` enum('arabic','english','other') NOT NULL DEFAULT 'arabic',
  `book_type` enum('physical','digital','both') NOT NULL DEFAULT 'physical',
  `file_path` varchar(255) DEFAULT NULL COMMENT 'مسار الملف الرقمي',
  `cover_image` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `books`
--

INSERT INTO `books` (`book_id`, `book_number`, `isbn`, `category_id`, `status`, `notes`, `title`, `author`, `publisher`, `publish_year`, `edition`, `department_id`, `subject_id`, `copies_total`, `copies_available`, `shelf_location`, `language`, `book_type`, `file_path`, `cover_image`, `description`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'B001', '978-123456', 1, 'available', 'كتاب تعليمي', 'مقدمة في علوم الحاسب', 'أحمد محمد', 'دار النشر', '2023', NULL, NULL, NULL, 5, 5, 'A1', 'arabic', 'physical', NULL, NULL, NULL, 1, '2026-03-08 21:22:00', '2026-03-08 21:22:00'),
(2, 'B002', '978-123457', 2, 'available', 'كتاب برمجة', 'البرمجة بلغة بايثون', 'علي يوسف', 'دار النشر', '2022', NULL, NULL, NULL, 3, 3, 'A2', 'arabic', 'physical', NULL, NULL, NULL, 1, '2026-03-08 21:22:00', '2026-03-08 21:22:00'),
(3, 'B003', '978-123458', 4, 'available', 'كتاب تاريخ', 'تاريخ اليمن', 'يونس العباهي', 'دار النشر', '2021', NULL, NULL, NULL, 2, 2, 'B1', 'arabic', 'physical', NULL, NULL, NULL, 1, '2026-03-08 21:22:00', '2026-04-08 22:40:47'),
(4, 'BKS-2026-0001', '22', 9, 'available', 'اي حاجة', 'الجائز', 'جفري ابستين', 'الخلود', '2020', NULL, NULL, NULL, 100, 100, 'B1 - B6', 'arabic', 'physical', NULL, NULL, NULL, 1, '2026-03-09 04:12:01', '2026-05-04 01:27:53'),
(5, 'BKS-2026-0002', '110', 15, 'available', 'كتاب جميل في شرح قوانين الحياة', 'كتاب الدرة الثمنية', 'محمد ابو خداش', 'صعدة', '2020', NULL, NULL, NULL, 20, 20, 'K1 - K4', 'arabic', 'physical', NULL, NULL, NULL, 1, '2026-04-08 22:26:59', '2026-04-19 20:46:25'),
(6, 'BKS-2026-0003', '1132', 9, 'available', 'كتاب جديد في علوم النفس والحياة', 'اسرار النجاح', 'مروان الجابر الصباح', 'دار الثقافة مارب', '2021', NULL, NULL, NULL, 30, 29, 'H1 - H5', 'arabic', 'physical', NULL, NULL, NULL, 1, '2026-05-04 01:35:07', '2026-05-04 01:36:18');

-- --------------------------------------------------------

--
-- بنية الجدول `book_categories`
--

CREATE TABLE `book_categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `book_categories`
--

INSERT INTO `book_categories` (`category_id`, `category_name`, `description`, `is_active`, `created_at`) VALUES
(1, 'Ø¹Ù„ÙˆÙ… Ø§Ù„Ø­Ø§Ø³Ø¨', 'ÙƒØªØ¨ Ù…ØªØ¹Ù„Ù‚Ø© Ø¨Ø¹Ù„ÙˆÙ… Ø§Ù„Ø­Ø§Ø³Ø¨ ÙˆØ§Ù„Ø¨Ø±Ù…Ø¬Ø©', 1, '2026-03-07 02:38:07'),
(2, 'Ù‚ÙˆØ§Ø¹Ø¯ Ø§Ù„Ø¨ÙŠØ§Ù†Ø§Øª', 'ÙƒØªØ¨ Ù…ØªØ¹Ù„Ù‚Ø© Ø¨Ù‚ÙˆØ§Ø¹Ø¯ Ø§Ù„Ø¨ÙŠØ§Ù†Ø§Øª', 1, '2026-03-07 02:38:07'),
(3, 'Ø§Ù„Ø´Ø¨ÙƒØ§Øª', 'ÙƒØªØ¨ Ù…ØªØ¹Ù„Ù‚Ø© Ø¨Ø´Ø¨ÙƒØ§Øª Ø§Ù„Ø­Ø§Ø³Ø¨', 1, '2026-03-07 02:38:07'),
(4, 'Ø§Ù„Ø£Ù…Ù† Ø§Ù„Ø³ÙŠØ¨Ø±Ø§Ù†ÙŠ', 'ÙƒØªØ¨ Ù…ØªØ¹Ù„Ù‚Ø© Ø¨Ø§Ù„Ø£Ù…Ù† Ø§Ù„Ø³ÙŠØ¨Ø±Ø§Ù†ÙŠ', 1, '2026-03-07 02:38:07'),
(5, 'Ø§Ù„Ø°ÙƒØ§Ø¡ Ø§Ù„Ø§ØµØ·Ù†Ø§Ø¹ÙŠ', 'ÙƒØªØ¨ Ù…ØªØ¹Ù„Ù‚Ø© Ø¨Ø§Ù„Ø°ÙƒØ§Ø¡ Ø§Ù„Ø§ØµØ·Ù†Ø§Ø¹ÙŠ', 1, '2026-03-07 02:38:07'),
(6, 'ØªØ·ÙˆÙŠØ± Ø§Ù„ÙˆÙŠØ¨', 'ÙƒØªØ¨ Ù…ØªØ¹Ù„Ù‚Ø© Ø¨ØªØ·ÙˆÙŠØ± Ø§Ù„ÙˆÙŠØ¨', 1, '2026-03-07 02:38:07'),
(7, 'Ø£Ù†Ø¸Ù…Ø© Ø§Ù„ØªØ´ØºÙŠÙ„', 'ÙƒØªØ¨ Ù…ØªØ¹Ù„Ù‚Ø© Ø¨Ø£Ù†Ø¸Ù…Ø© Ø§Ù„ØªØ´ØºÙŠÙ„', 1, '2026-03-07 02:38:07'),
(8, 'Ø§Ù„Ù‡Ù†Ø¯Ø³Ø© Ø§Ù„Ø¨Ø±Ù…Ø¬ÙŠØ©', 'ÙƒØªØ¨ Ù…ØªØ¹Ù„Ù‚Ø© Ø¨Ù‡Ù†Ø¯Ø³Ø© Ø§Ù„Ø¨Ø±Ù…Ø¬ÙŠØ§Øª', 1, '2026-03-07 02:38:07'),
(9, 'مراجع', 'مراجع ومعاجم وموسوعات', 1, '2026-03-08 21:17:11'),
(10, 'علوم تطبيقية', 'الهندسة والتقنية والعلوم التطبيقية', 1, '2026-03-08 21:17:11'),
(11, 'أدب', 'الأدب العربي والعالمي', 1, '2026-03-08 21:17:11'),
(12, 'دينية', 'العلوم الشرعية والدينية', 1, '2026-03-08 21:17:11'),
(13, 'تاريخ', 'التاريخ والحضارات', 1, '2026-03-08 21:17:11'),
(14, 'أطفال', 'كتب الأطفال واليافعين', 1, '2026-03-08 21:17:11'),
(15, 'قانون', 'القانون والقضاء', 1, '2026-03-08 21:17:11'),
(16, 'اقتصاد', 'الاقتصاد والأعمال', 1, '2026-03-08 21:17:11'),
(17, 'تقنية', 'تقنية المعلومات والحاسب', 1, '2026-03-08 21:17:11'),
(18, 'طب', 'الصحة والطب', 1, '2026-03-08 21:17:11');

-- --------------------------------------------------------

--
-- بنية الجدول `book_upload_requests`
--

CREATE TABLE `book_upload_requests` (
  `request_id` int(10) UNSIGNED NOT NULL,
  `member_id` int(10) UNSIGNED NOT NULL COMMENT 'رقم العضو الذي يقدم الطلب',
  `book_title` varchar(255) NOT NULL COMMENT 'عنوان الكتاب',
  `author` varchar(200) DEFAULT NULL COMMENT 'المؤلف',
  `publisher` varchar(200) DEFAULT NULL COMMENT 'الناشر',
  `publish_year` year(4) DEFAULT NULL COMMENT 'سنة النشر',
  `isbn` varchar(50) DEFAULT NULL COMMENT 'رقم الكتاب',
  `book_description` text DEFAULT NULL COMMENT 'وصف الكتاب',
  `department_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'القسم',
  `language` varchar(50) DEFAULT 'العربية' COMMENT 'اللغة',
  `file_path` varchar(500) DEFAULT NULL COMMENT 'مسار الملف',
  `cover_image` varchar(500) DEFAULT NULL COMMENT 'صورة الغلاف',
  `file_size` bigint(20) DEFAULT NULL COMMENT 'حجم الملف',
  `file_type` varchar(50) DEFAULT NULL COMMENT 'نوع الملف',
  `access_type` enum('public','restricted') NOT NULL DEFAULT 'public' COMMENT 'نوع الوصول',
  `license_type` varchar(100) DEFAULT NULL COMMENT 'نوع الترخيص',
  `notes` text DEFAULT NULL COMMENT 'ملاحظات',
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending' COMMENT 'حالة الطلب',
  `rejection_reason` text DEFAULT NULL COMMENT 'سبب الرفض',
  `reviewed_by` int(10) UNSIGNED DEFAULT NULL COMMENT 'المراجع',
  `reviewed_at` datetime DEFAULT NULL COMMENT 'وقت المراجعة',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `curriculums`
--

CREATE TABLE `curriculums` (
  `curriculum_id` int(10) UNSIGNED NOT NULL,
  `curriculum_code` varchar(20) NOT NULL,
  `course_code` varchar(20) DEFAULT NULL,
  `curriculum_name` varchar(150) NOT NULL,
  `course_name` varchar(150) DEFAULT NULL,
  `specialization_id` int(10) UNSIGNED DEFAULT NULL,
  `teacher_id` int(10) UNSIGNED DEFAULT NULL,
  `curriculum_type` enum('theoretical','practical','both') NOT NULL DEFAULT 'theoretical',
  `image_path` varchar(255) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `academic_year` varchar(20) NOT NULL COMMENT 'مثال: 2024-2025',
  `semester` enum('first','second','summer') NOT NULL DEFAULT 'first',
  `year_level` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `curriculums`
--

INSERT INTO `curriculums` (`curriculum_id`, `curriculum_code`, `course_code`, `curriculum_name`, `course_name`, `specialization_id`, `teacher_id`, `curriculum_type`, `image_path`, `file_path`, `academic_year`, `semester`, `year_level`, `description`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'CS-CURR-2024', 'CS101', 'المنهج الدراسي للحاسب', 'مقدمة في البرمجة', 1, NULL, 'theoretical', NULL, NULL, '2024', 'first', 1, 'منهج الفصل الأول', 1, '2026-03-08 21:22:00', '2026-03-08 21:22:00'),
(2, 'MATH-CURR-2024', 'MATH101', 'المنهج الدراسي للرياضيات', 'الرياضيات 1', 2, NULL, 'theoretical', NULL, NULL, '2024', 'first', 1, 'منهج الفصل الأول', 1, '2026-03-08 21:22:00', '2026-03-08 21:22:00'),
(3, '', 'CUR-2026-0001', 'يشيشي', 'يشيشي', NULL, 5, 'theoretical', 'uploads/curriculums/CUR-2026-0001/image_1773449479.png', 'uploads/curriculums/CUR-2026-0001/file_1773449479.pdf', '', 'second', 1, 'يسيسي', 1, '2026-03-14 00:51:19', '2026-03-14 00:51:19');

-- --------------------------------------------------------

--
-- بنية الجدول `departments`
--

CREATE TABLE `departments` (
  `department_id` int(10) UNSIGNED NOT NULL,
  `department_code` varchar(30) NOT NULL,
  `department_name` varchar(200) NOT NULL,
  `category_id` int(10) UNSIGNED DEFAULT NULL,
  `shelf_id` int(10) UNSIGNED DEFAULT NULL,
  `manager_employee_id` int(10) UNSIGNED DEFAULT NULL,
  `books_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `description` text DEFAULT NULL,
  `status` enum('active','on-leave','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `departments`
--

INSERT INTO `departments` (`department_id`, `department_code`, `department_name`, `category_id`, `shelf_id`, `manager_employee_id`, `books_count`, `description`, `status`, `created_at`, `updated_at`) VALUES
(1, 'DPT-001', 'المراجع العامة', NULL, 1, 1, 0, 'قسم المراجع العامة والمعاجم', 'active', '2026-03-07 00:09:35', '2026-03-07 00:14:00'),
(2, 'DPT-002', 'العلوم التطبيقية', NULL, 2, 1, 0, 'قسم العلوم التطبيقية والهندسية', 'active', '2026-03-07 00:09:35', '2026-03-07 00:14:00'),
(3, 'DPT-003', 'الأدب واللغات', NULL, 3, 1, 0, 'قسم الأدب العربي والعالمي', 'on-leave', '2026-03-07 00:09:35', '2026-03-07 00:14:00'),
(12, 'DPT-007', 'المصحف الشريف', 1, 1, 1, 0, 'نسخ القران الكريم (المصحف الشريف)', 'active', '2026-03-13 22:36:18', '2026-03-13 22:36:18'),
(13, 'DPT-008', 'علوم الحاسوب', 2, 6, 7, 0, 'قسم يهتم بالكتب التي تشرح جهاز الحاسوب وطريقة عملة', 'active', '2026-03-14 23:53:42', '2026-03-14 23:53:42'),
(14, 'DPT-009', 'البرمجة', 2, 7, 5, 0, 'لتعلم البرمجة', 'active', '2026-03-14 23:58:55', '2026-03-15 00:01:12'),
(15, 'DPT-010', 'كتب الحديث والسنة', 1, 1, 5, 0, 'كتب مهتمه بالحديث النبوي والسنة النبوية الشريفة', 'active', '2026-04-08 22:22:16', '2026-04-08 22:22:16'),
(16, 'DPT-011', 'كتب في الدعم النفسي', 12, 8, 7, 100, 'كتاب يهتم بدعم الفرد نفسيا عن طريق حيل اجتماعية وثقافية', 'active', '2026-05-04 01:32:18', '2026-05-04 01:32:18');

-- --------------------------------------------------------

--
-- بنية الجدول `department_categories`
--

CREATE TABLE `department_categories` (
  `category_id` int(10) UNSIGNED NOT NULL,
  `category_name` varchar(190) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `department_categories`
--

INSERT INTO `department_categories` (`category_id`, `category_name`, `description`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'مراجع', 'مراجع ومعاجم وموسوعات', 1, '2026-03-07 00:05:44', '2026-03-07 00:21:10'),
(2, 'علوم تطبيقية', 'الهندسة والتقنية والعلوم التطبيقية', 1, '2026-03-07 00:05:44', '2026-03-07 00:21:10'),
(3, 'أدب', 'الأدب العربي والعالمي', 1, '2026-03-07 00:05:44', '2026-03-07 00:21:10'),
(4, 'دينية', 'العلوم الشرعية والدينية', 1, '2026-03-07 00:05:44', '2026-03-07 00:21:10'),
(5, 'تاريخ', 'التاريخ والحضارات', 1, '2026-03-07 00:05:44', '2026-03-07 00:21:10'),
(6, 'أطفال', 'كتب الأطفال واليافعين', 1, '2026-03-07 00:05:44', '2026-03-07 00:21:10'),
(7, 'قانون', 'القانون والقضاء', 1, '2026-03-07 00:21:10', '2026-03-07 00:21:10'),
(8, 'اقتصاد', 'الاقتصاد والأعمال', 1, '2026-03-07 00:21:10', '2026-03-07 00:21:10'),
(9, 'تقنية', 'تقنية المعلومات والحاسب', 1, '2026-03-07 00:21:10', '2026-03-07 00:21:10'),
(10, 'طب', 'الصحة والطب', 1, '2026-03-07 00:21:10', '2026-03-07 00:21:10'),
(11, 'فلسفة', 'الفلسفة والمنطق', 1, '2026-03-07 00:21:10', '2026-03-07 00:21:10'),
(12, 'اجتماع', 'العلوم الاجتماعية', 1, '2026-03-07 00:21:10', '2026-03-07 00:21:10'),
(13, 'لغات', 'اللغة العربية ولغات العالم', 1, '2026-03-07 00:21:10', '2026-03-07 00:21:10'),
(14, 'سير وتراجم', 'السير الذاتية والتراجم', 1, '2026-03-07 00:21:10', '2026-03-07 00:21:10'),
(15, 'فنون', 'الفنون والآداب البصرية', 1, '2026-03-07 00:21:10', '2026-03-07 00:21:10'),
(22, '', '  ', 1, '2026-03-08 21:15:28', '2026-03-08 21:15:28');

-- --------------------------------------------------------

--
-- بنية الجدول `department_members`
--

CREATE TABLE `department_members` (
  `membership_id` int(10) UNSIGNED NOT NULL,
  `department_id` int(10) UNSIGNED NOT NULL,
  `employee_id` int(10) UNSIGNED NOT NULL,
  `role` enum('manager','assistant','staff') NOT NULL DEFAULT 'staff',
  `is_primary` tinyint(1) NOT NULL DEFAULT 0,
  `assigned_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `notes` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `department_members`
--

INSERT INTO `department_members` (`membership_id`, `department_id`, `employee_id`, `role`, `is_primary`, `assigned_at`, `notes`) VALUES
(1, 1, 1, '', 1, '2026-03-08 21:24:04', NULL),
(2, 2, 2, '', 1, '2026-03-08 21:24:04', NULL);

-- --------------------------------------------------------

--
-- بنية الجدول `digital_books`
--

CREATE TABLE `digital_books` (
  `digital_book_id` int(10) UNSIGNED NOT NULL,
  `book_number` varchar(50) DEFAULT NULL,
  `book_title` varchar(255) NOT NULL,
  `book_description` text DEFAULT NULL,
  `department_id` int(10) UNSIGNED DEFAULT NULL,
  `cover_image` varchar(500) DEFAULT NULL,
  `file_path` varchar(500) DEFAULT NULL,
  `file_type` enum('pdf','doc','docx','ppt','pptx') DEFAULT 'pdf',
  `file_size` int(10) UNSIGNED DEFAULT 0,
  `author` varchar(255) DEFAULT NULL,
  `publisher` varchar(255) DEFAULT NULL,
  `publish_year` int(11) DEFAULT NULL,
  `isbn` varchar(50) DEFAULT NULL,
  `language` varchar(50) DEFAULT 'عربي',
  `access_type` enum('internal','external','both') DEFAULT 'internal',
  `license_type` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `downloads_count` int(10) UNSIGNED DEFAULT 0,
  `views_count` int(10) UNSIGNED DEFAULT 0,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `digital_books`
--

INSERT INTO `digital_books` (`digital_book_id`, `book_number`, `book_title`, `book_description`, `department_id`, `cover_image`, `file_path`, `file_type`, `file_size`, `author`, `publisher`, `publish_year`, `isbn`, `language`, `access_type`, `license_type`, `is_active`, `downloads_count`, `views_count`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 'DIG-2026-0001', 'المصحف الشريف', 'المصحف الشريف', 1, 'uploads/digital_books/covers//cover_1773442687.webp', 'uploads/digital_books//1773442687_Noor-Book.com  القران الكريم.pdf', '', 4331467, 'الله جل جلالة', 'الخلود', 2020, '22', 'عربي', 'both', 'مجاني', 1, 3, 7, NULL, '2026-03-13 22:58:07', '2026-04-19 21:15:56'),
(2, 'DIG-2026-0002', 'ميكرسوف ورد 2007', 'كتاب يشرح طريقة استخدمام محرر النصوص من شركة ميكروسوفت', 13, 'uploads/digital_books/covers/2007/cover_1773532586.webp', 'uploads/digital_books/2007/1773532586_Noor-Book.com  كلمة 365.pdf', '', 16052049, 'مجد ابو العلاء', 'الخلود', 2007, '6', 'عربي', 'both', 'مجاني', 1, 0, 5, NULL, '2026-03-14 23:56:26', '2026-04-09 09:32:59'),
(3, 'DIG-2026-0003', 'البرمجة بلغة السي بلس بلس', 'تعلم تصميم وبرمجة اله حاسبة بسيطة بواسطة لغة السي بلس بلس', 14, 'uploads/digital_books/covers//cover_1773532856.png', 'uploads/digital_books//1773532855_- تعلم تصميم ابسط حاسبة بلغة ++c.pdf', '', 120687, 'عدنان السنجاري', '', 0, '', 'عربي', 'both', 'مجاني', 1, 3, 10, NULL, '2026-03-15 00:00:56', '2026-05-09 01:23:22'),
(4, 'DIG-2026-0004', 'كتاب السيرة النبوية', 'كتاب يعد من أهم المصادر التي تناولت سيرة النبي صلى الله عليه وسلم؛ بدءًا من ميلاده وحتى لحوقه صلى الله عليه وسلم بالرفيق الأعلى، وقد اعتمد مؤلفه على كتاب «السيرة النبوية» لابن إسحاق؛ غير أنه قام بتهذيبها، وزاد فيها، ونقص منها وحرَّر أماكن واستدرك أشياء أخرى.', 15, 'uploads/digital_books/covers//cover_1775687635.webp', NULL, '', 0, 'مصطفى العدوي', 'بيت الثقافة صنعاء', 2025, '110', 'عربي', 'both', 'مجاني', 1, 1, 7, NULL, '2026-04-08 22:33:55', '2026-04-09 09:32:55'),
(5, 'DIG-2026-0005', 'المخدرات الرقمية', 'يحكي خظر المخدرات بشكلها الجديد الرقمي', 13, 'uploads/digital_books/covers//cover_1775689728.webp', 'uploads/digital_books//1775689728_Noor-Book.com  المخدرات الرقمية تنظيمها ومشروعيتها الجنائية.pdf', '', 10007539, 'ساجد رفعت حسين', 'بيت الثقافة صنعاء', 2020, '110', 'عربي', 'both', 'مجاني', 1, 3, 5, NULL, '2026-04-08 23:08:48', '2026-04-09 09:32:32');

-- --------------------------------------------------------

--
-- بنية الجدول `employees`
--

CREATE TABLE `employees` (
  `employee_id` int(10) UNSIGNED NOT NULL,
  `employee_number` varchar(30) NOT NULL,
  `full_name` varchar(150) NOT NULL,
  `gender` enum('male','female') NOT NULL DEFAULT 'male',
  `marital_status` enum('single','married','divorced','widowed') NOT NULL DEFAULT 'single',
  `branch_code` varchar(30) NOT NULL DEFAULT 'main-1',
  `job_title` varchar(150) NOT NULL,
  `salary` decimal(12,2) NOT NULL DEFAULT 0.00,
  `phone` varchar(20) NOT NULL,
  `email` varchar(190) NOT NULL,
  `email_verified` tinyint(1) NOT NULL DEFAULT 0,
  `email_verified_at` datetime DEFAULT NULL,
  `image_path` varchar(255) NOT NULL DEFAULT 'images/user-avatar.png',
  `status` enum('active','on-leave','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `employees`
--

INSERT INTO `employees` (`employee_id`, `employee_number`, `full_name`, `gender`, `marital_status`, `branch_code`, `job_title`, `salary`, `phone`, `email`, `email_verified`, `email_verified_at`, `image_path`, `status`, `created_at`, `updated_at`) VALUES
(1, 'EMP-001', 'يوسف نصر شمسان', 'male', 'married', 'main-1', 'أمين مكتبة', 250000.00, '077123456', 'ahmed@mtc-library.ye', 1, '2026-03-06 06:55:31', 'images/user-avatar.png', 'active', '2026-03-06 03:40:44', '2026-03-06 03:55:31'),
(2, 'EMP-002', 'هاشم العباهي', 'male', 'single', 'port-1', 'عامل التنظيف', 80000.00, '077234567', 'khalid@mtc-library.ye', 1, '2026-03-06 06:55:31', 'images/user-avatar.png', 'active', '2026-03-06 03:40:44', '2026-03-09 22:17:03'),
(3, 'EMP-003', '  يونس الخياطي', 'female', 'married', 'sub-1', 'المدقق الإملائي', 120000.00, '077345678', 'fatima@mtc-library.ye', 1, '2026-03-06 06:55:31', 'images/user-avatar.png', 'active', '2026-03-06 03:40:44', '2026-03-09 00:18:21'),
(4, 'EMP-004', 'علي حمود', 'male', 'married', 'main-1', 'مدير عمليات', 300000.00, '077456789', 'mohammed@mtc-library.ye', 1, '2026-03-06 06:55:31', 'images/user-avatar.png', 'on-leave', '2026-03-06 03:40:44', '2026-03-06 03:55:31'),
(5, 'EMP-005', 'عمار العقبي', 'male', 'married', 'main-1', 'أمين المكتبة', 250000.00, '777852123', 'ahmdalslymyahmdly@gmail.com', 0, NULL, 'uploads/EMP-005/EMP-005.png', 'active', '2026-03-06 21:31:22', '2026-04-09 06:38:11'),
(7, 'EMP-006', '  زهير', 'male', 'single', 'main-1', 'المدقق الإملائي', 120000.00, '777744112', '1ahmdalslymyahmdly@gmail.com', 0, NULL, 'uploads/EMP-006/EMP-006.png', 'active', '2026-03-06 23:45:18', '2026-03-06 23:45:18'),
(999, 'EMP-999', 'Ù…Ø¯ÙŠØ± Ø¹Ø§Ù… Ø§Ù„Ù†Ø¸Ø§Ù…', 'male', 'single', 'main-1', 'Ù…Ø¯ÙŠØ± Ø¹Ø§Ù…', 0.00, '0000000000', 'admin@system.local', 0, NULL, 'images/user-avatar.png', 'active', '2026-03-07 02:32:47', '2026-03-07 02:32:47');

-- --------------------------------------------------------

--
-- بنية الجدول `graduation_projects`
--

CREATE TABLE `graduation_projects` (
  `project_id` int(10) UNSIGNED NOT NULL,
  `project_code` varchar(20) NOT NULL,
  `student_id` int(10) UNSIGNED DEFAULT NULL,
  `project_title` varchar(255) NOT NULL,
  `logo_path` varchar(255) DEFAULT NULL,
  `specialization_id` int(10) UNSIGNED DEFAULT NULL,
  `supervisor_id` int(10) UNSIGNED DEFAULT NULL COMMENT 'teacher_id',
  `academic_year` varchar(20) NOT NULL,
  `semester` enum('first','second','summer') NOT NULL DEFAULT 'second',
  `project_type` enum('individual','group') NOT NULL DEFAULT 'group',
  `status` enum('proposed','approved','in_progress','completed','rejected') NOT NULL DEFAULT 'proposed',
  `grade` decimal(5,2) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `upload_date` date DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `documentation_path` varchar(500) DEFAULT NULL,
  `views_count` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `graduation_projects`
--

INSERT INTO `graduation_projects` (`project_id`, `project_code`, `student_id`, `project_title`, `logo_path`, `specialization_id`, `supervisor_id`, `academic_year`, `semester`, `project_type`, `status`, `grade`, `file_path`, `upload_date`, `description`, `created_at`, `updated_at`, `documentation_path`, `views_count`) VALUES
(2, 'GP-2026-0001', 6, 'شسيسشي', 'uploads/graduation_projects/GP-2026-0001/logo_1773455941.png', 27, 1, '', 'second', 'group', 'completed', 90.00, NULL, '2026-03-14', 'شسيشسي', '2026-03-14 02:39:01', '2026-06-21 20:18:15', 'uploads/graduation_projects/GP-2026-0001/doc_1773455941.pdf', 3),
(3, 'GP-2026-0002', 6, 'سبيسبسيب', 'uploads/graduation_projects/GP-2026-0002/logo_1773456535.png', 27, 1, '', 'second', 'group', 'completed', 95.00, NULL, '2026-03-14', 'يسبسيبيسب', '2026-03-14 02:48:55', '2026-05-09 01:26:39', 'uploads/graduation_projects/GP-2026-0002/doc_1773456535.pdf', 1);

-- --------------------------------------------------------

--
-- بنية الجدول `jobs`
--

CREATE TABLE `jobs` (
  `job_id` int(10) UNSIGNED NOT NULL,
  `job_code` varchar(30) NOT NULL,
  `job_title` varchar(150) NOT NULL,
  `department` varchar(100) NOT NULL,
  `salary` decimal(12,2) NOT NULL DEFAULT 0.00,
  `status` enum('open','occupied','inactive') NOT NULL DEFAULT 'open',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `jobs`
--

INSERT INTO `jobs` (`job_id`, `job_code`, `job_title`, `department`, `salary`, `status`, `created_at`, `updated_at`) VALUES
(1, 'LIB-001', 'أمين المكتبة', 'قسم المكتبة', 250000.00, 'open', '2026-03-06 02:50:06', '2026-03-06 03:07:19'),
(2, 'LIB-002', 'مساعد أمين المكتبة', 'قسم المكتبة', 150000.00, 'open', '2026-03-06 02:50:06', '2026-03-06 03:03:00'),
(3, 'LIB-003', 'المدقق الإملائي', 'قسم المكتبة', 120000.00, 'occupied', '2026-03-06 02:50:06', '2026-03-06 03:03:00'),
(4, 'MAINT-001', 'عامل التنظيف', 'قسم الصيانة', 80000.00, 'open', '2026-03-06 02:50:06', '2026-03-06 03:03:00'),
(5, 'ADMIN-001', 'مدير المكتبة', 'قسم الإدارة', 300000.00, 'occupied', '2026-03-06 02:50:06', '2026-03-06 03:03:00'),
(6, 'LIB-INT-001', 'متدرب في المكتبة', 'قسم المكتبة', 50000.00, 'open', '2026-03-06 02:50:06', '2026-03-06 03:03:00'),
(7, 'MAINT-002', 'عامل الصيانة', 'قسم الصيانة', 90000.00, 'occupied', '2026-03-06 02:50:06', '2026-03-06 03:03:00'),
(8, 'LIB-004', 'أخصائي المعلومات', 'قسم المكتبة', 220000.00, 'open', '2026-03-06 02:50:06', '2026-03-06 03:03:00'),
(9, 'ADMIN-002', 'مساعد إداري', 'قسم الإدارة', 140000.00, 'occupied', '2026-03-06 02:50:06', '2026-03-06 03:03:00'),
(10, 'LIB-005', 'موظف الاستقبال', 'قسم المكتبة', 110000.00, 'occupied', '2026-03-06 02:50:06', '2026-04-09 07:38:12'),
(11, 'LIB_0010', 'مراجع', 'قسم المكتبة', 205.00, 'open', '2026-03-06 03:03:00', '2026-03-06 03:03:00'),
(14, 'LIB_0033', 'مراجع', 'قسم المكتبة', 205.00, 'open', '2026-03-06 03:07:00', '2026-03-06 03:07:00'),
(16, 'LIB_0055', 'مراجع', 'قسم المكتبة', 25000000.00, 'open', '2026-03-09 00:17:43', '2026-03-09 00:17:43'),
(17, 'LIB_007', 'مراجع ومدقق بيانات', 'قسم المكتبة', 25000.00, 'open', '2026-04-08 22:02:53', '2026-04-08 22:02:53'),
(18, 'LIB-090', 'مشرف قسم', 'قسم المكتبة', 50000.00, 'open', '2026-05-04 00:42:36', '2026-05-04 00:42:36');

-- --------------------------------------------------------

--
-- بنية الجدول `lectures`
--

CREATE TABLE `lectures` (
  `lecture_id` int(10) UNSIGNED NOT NULL,
  `lecture_code` varchar(20) NOT NULL,
  `lecture_title` varchar(200) NOT NULL,
  `subject_id` int(10) UNSIGNED DEFAULT NULL,
  `teacher_id` int(10) UNSIGNED DEFAULT NULL,
  `curriculum_id` int(10) UNSIGNED DEFAULT NULL,
  `lecture_date` date DEFAULT NULL,
  `lecture_time` time DEFAULT NULL,
  `duration_minutes` smallint(5) UNSIGNED NOT NULL DEFAULT 60,
  `room` varchar(50) DEFAULT NULL,
  `lecture_type` enum('theoretical','practical','online') NOT NULL DEFAULT 'theoretical',
  `file_path` varchar(255) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `views_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `downloads_count` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `lectures`
--

INSERT INTO `lectures` (`lecture_id`, `lecture_code`, `lecture_title`, `subject_id`, `teacher_id`, `curriculum_id`, `lecture_date`, `lecture_time`, `duration_minutes`, `room`, `lecture_type`, `file_path`, `notes`, `is_active`, `created_at`, `updated_at`, `views_count`, `downloads_count`) VALUES
(2, 'LEC-2026-0001', '', NULL, 5, 3, '2026-03-14', '04:58:00', 60, NULL, 'theoretical', 'uploads/curriculums//lecture_LEC-2026-0001_1773453517.pdf', 'ضثءيشي', 1, '2026-03-14 01:58:37', '2026-05-09 01:23:38', 6, 1);

-- --------------------------------------------------------

--
-- بنية الجدول `lecture_upload_requests`
--

CREATE TABLE `lecture_upload_requests` (
  `request_id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `lecture_title` varchar(255) NOT NULL,
  `instructor` varchar(255) DEFAULT NULL,
  `course_name` varchar(255) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  `academic_year` varchar(50) DEFAULT NULL,
  `lecture_description` text DEFAULT NULL,
  `file_path` varchar(500) DEFAULT NULL,
  `file_size` bigint(20) DEFAULT NULL,
  `file_type` varchar(100) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `rejection_reason` text DEFAULT NULL,
  `reviewed_by` int(11) DEFAULT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `library_account_requests`
--

CREATE TABLE `library_account_requests` (
  `request_id` int(10) UNSIGNED NOT NULL,
  `request_type` enum('new','password_reset','update') NOT NULL DEFAULT 'new',
  `member_type` enum('student','teacher','external') NOT NULL DEFAULT 'external',
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `full_name` varchar(200) NOT NULL,
  `email` varchar(150) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `gender` enum('male','female') NOT NULL DEFAULT 'male',
  `member_number` varchar(50) DEFAULT NULL,
  `specialization_id` int(10) UNSIGNED DEFAULT NULL,
  `job_title` varchar(100) DEFAULT NULL,
  `qualification` varchar(150) DEFAULT NULL,
  `institution` varchar(200) DEFAULT NULL,
  `job_description` varchar(200) DEFAULT NULL,
  `verification_code` varchar(10) DEFAULT NULL,
  `verification_expires` datetime DEFAULT NULL,
  `is_verified` tinyint(1) NOT NULL DEFAULT 0,
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `rejection_reason` text DEFAULT NULL,
  `reviewed_by` int(10) UNSIGNED DEFAULT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `library_account_requests`
--

INSERT INTO `library_account_requests` (`request_id`, `request_type`, `member_type`, `first_name`, `last_name`, `full_name`, `email`, `phone`, `username`, `password_hash`, `gender`, `member_number`, `specialization_id`, `job_title`, `qualification`, `institution`, `job_description`, `verification_code`, `verification_expires`, `is_verified`, `status`, `rejection_reason`, `reviewed_by`, `reviewed_at`, `created_at`, `updated_at`) VALUES
(2, 'new', 'teacher', 'نواف', 'ابو منحيس', 'نواف ابو منحيس', 'hmdly@gmail.com', '789654123', 'hmdly', '$2y$10$kH2.s613Y4RDvLsfwbu5O.8tLJVYnwlH.bbJWP/6NnDe35X.tkY1e', 'male', 'TCH-005', NULL, '', NULL, '', NULL, '184776', '2026-03-18 04:19:47', 0, 'rejected', 'نسيايسنباتسيابت', NULL, '2026-03-18 05:07:20', '2026-03-18 01:09:47', '2026-03-18 02:07:20'),
(3, 'new', 'external', 'امين', 'ابي امين', 'امين ابي امين', 'aminalaminamin771@gmail.com', '777014012', 'aminalaminamin771', '$2y$10$bnz/vyWpRDtH2C8GDiYieubbixMrN2uzbK0lBYRQzuN4zwXWdfAxq', 'male', NULL, NULL, 'موظف', NULL, 'itc', NULL, '338192', '2026-03-18 04:52:45', 0, 'rejected', 'نيبايباسيمبامسيبامسنيبامسينابمسنياب', NULL, '2026-03-18 05:17:11', '2026-03-18 01:42:45', '2026-03-18 02:17:11'),
(4, 'new', 'student', 'مجدي', 'امين السياني', 'مجدي امين السياني', 'majdiking019@gmail.com', '772546906', 'majdiking019', '$2y$10$58.qjCYGFu0iiw4Uvhe8nOAbQnZupGmqW80hbMBoZH6KOcGXPSHcm', 'male', 'STU-2026-0003', NULL, '', NULL, '', NULL, '145830', '2026-03-28 11:27:53', 0, 'rejected', '', NULL, '2026-03-28 11:19:11', '2026-03-28 08:17:53', '2026-03-28 08:19:11'),
(6, 'new', 'student', 'nawaf', '', 'nawaf', 'ahmdalslymyahmdly@gmail.com', '770218802', 'ahmdalslymyahmdly', '$2y$10$b2Ufq0SWr0sqmdLBQli6g.Zg5n5U0nM.v0DtM46srRN25C/gDccpq', 'male', 'STU-2026-0001', NULL, '', NULL, '', NULL, '376594', '2026-04-09 11:17:40', 0, 'rejected', '', NULL, '2026-05-04 04:22:26', '2026-04-09 08:07:08', '2026-05-04 01:22:26');

-- --------------------------------------------------------

--
-- بنية الجدول `library_members`
--

CREATE TABLE `library_members` (
  `member_id` int(10) UNSIGNED NOT NULL,
  `member_type` enum('student','teacher','external') NOT NULL DEFAULT 'external' COMMENT 'student=طالب, teacher=مدرس, external=خارجي',
  `member_number` varchar(50) DEFAULT NULL COMMENT 'رقم الطالب أو المدرس أو رقم会员',
  `username` varchar(100) DEFAULT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `full_name` varchar(200) NOT NULL,
  `email` varchar(150) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `gender` enum('male','female') NOT NULL DEFAULT 'male',
  `date_of_birth` date DEFAULT NULL,
  `specialization_id` int(10) UNSIGNED DEFAULT NULL,
  `job_title` varchar(100) DEFAULT NULL,
  `qualification` varchar(150) DEFAULT NULL,
  `institution` varchar(200) DEFAULT NULL COMMENT 'المؤسسة/الجهة',
  `job_description` varchar(200) DEFAULT NULL COMMENT 'المسمى الوظيفي',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_verified` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'تم التحقق من البريد',
  `verification_code` varchar(10) DEFAULT NULL,
  `verification_expires` datetime DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `login_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `profile_image` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `library_members`
--

INSERT INTO `library_members` (`member_id`, `member_type`, `member_number`, `username`, `first_name`, `last_name`, `full_name`, `email`, `phone`, `password_hash`, `gender`, `date_of_birth`, `specialization_id`, `job_title`, `qualification`, `institution`, `job_description`, `is_active`, `is_verified`, `verification_code`, `verification_expires`, `last_login`, `login_count`, `notes`, `created_at`, `updated_at`, `profile_image`) VALUES
(2, 'student', 'STU-2024-001', 'student01', 'أحمد', 'محمد', 'أحمد محمد', 'ahmed@example.com', '777123456', '$2y$10$XLoH8YVu95/DKQvHxhnPMuIyrguV8yIoci3D5qZVYvc62mrU/6WYK', 'male', NULL, 1, NULL, NULL, NULL, NULL, 1, 1, NULL, NULL, NULL, 0, NULL, '2026-03-18 02:55:45', '2026-03-18 02:55:45', NULL),
(3, 'teacher', 'TCH-2024-001', 'teacher01', 'سارة', 'علي', 'سارة علي', 'sara@example.com', '771234567', '$2y$10$R1pMYXqkyUUYQ3WBt.uBYOvJ9FmCf/hzlQdNIWzoToDlSP/yji4dS', 'female', NULL, NULL, '0', 'دكتوراه في علوم الحاسب', NULL, NULL, 1, 1, NULL, NULL, NULL, 0, NULL, '2026-03-18 02:55:45', '2026-03-18 02:55:45', NULL),
(4, 'external', 'EXT-2024-001', 'external01', 'محمد', 'أحمد', 'محمد أحمد', 'mohamed@example.com', '773456789', '$2y$10$7kDSpfJh362TgiAS9mFP8.LI6onRptfk.iUYayhvSit8nINst8oNe', 'male', NULL, NULL, NULL, NULL, '0', 'باحث', 1, 1, NULL, NULL, NULL, 0, NULL, '2026-03-18 02:55:45', '2026-03-18 02:55:45', NULL),
(5, 'student', 'STU-2026-0004', 'admin321', 'احمد', 'الصيلمي', 'احمد الصيلمي', 'ahmdalslymyahmdly@gmail.com', '778431485', '$2y$10$iEoLqANoSuiiSJ9Vy3nfgOC1kXru0CizwxwmzrL3OsdWmDV.0MGH.', 'male', NULL, NULL, '', NULL, '', NULL, 1, 1, NULL, NULL, '2026-06-22 23:08:16', 10, NULL, '2026-04-08 20:19:13', '2026-06-22 20:08:16', NULL);

-- --------------------------------------------------------

--
-- بنية الجدول `library_shelves`
--

CREATE TABLE `library_shelves` (
  `shelf_id` int(10) UNSIGNED NOT NULL,
  `shelf_range` varchar(50) NOT NULL,
  `shelf_label` varchar(150) DEFAULT NULL,
  `location_note` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `library_shelves`
--

INSERT INTO `library_shelves` (`shelf_id`, `shelf_range`, `shelf_label`, `location_note`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'A1 - A8', 'رفوف القسم A', 'القاعة الشرقية', 1, '2026-03-07 00:05:44', '2026-03-07 00:05:44'),
(2, 'B1 - B6', 'رفوف القسم B', 'القاعة الشرقية', 1, '2026-03-07 00:05:44', '2026-03-07 00:05:44'),
(3, 'C1 - C5', 'رفوف القسم C', 'القاعة الوسطى', 1, '2026-03-07 00:05:44', '2026-03-07 00:05:44'),
(4, 'D1 - D4', 'رفوف القسم D', 'القاعة الوسطى', 1, '2026-03-07 00:05:44', '2026-03-07 00:05:44'),
(5, 'E1 - E7', 'رفوف القسم E', 'القاعة الغربية', 1, '2026-03-07 00:05:44', '2026-03-07 00:05:44'),
(6, 'F1 - F4', 'رفوف القسم F', 'القاعة الغربية', 1, '2026-03-07 00:05:44', '2026-03-07 00:05:44'),
(7, 'G1 - G5', 'رفوف القسم G', 'الطابق الأول', 1, '2026-03-07 00:05:44', '2026-03-07 00:05:44'),
(8, 'H1 - H5', 'رفوف القسم H', 'الطابق الأول', 1, '2026-03-07 00:05:44', '2026-03-07 00:05:44'),
(9, 'K1 - K4', 'رفوف القسم K', 'الطابق الثاني', 1, '2026-03-07 00:05:44', '2026-03-07 00:05:44'),
(10, 'N1 - N2', 'رفوف القسم N', 'المخزن الآمن', 1, '2026-03-07 00:05:44', '2026-03-07 00:05:44');

-- --------------------------------------------------------

--
-- بنية الجدول `loans`
--

CREATE TABLE `loans` (
  `loan_id` int(10) UNSIGNED NOT NULL,
  `loan_number` varchar(50) DEFAULT NULL,
  `student_id` int(10) UNSIGNED DEFAULT NULL,
  `book_id` int(10) UNSIGNED NOT NULL,
  `subscription_id` int(10) UNSIGNED DEFAULT NULL,
  `borrower_type` enum('student','employee','teacher','external') NOT NULL DEFAULT 'student',
  `borrower_id` int(10) UNSIGNED NOT NULL,
  `borrower_name` varchar(150) NOT NULL,
  `loan_date` date NOT NULL,
  `due_date` date NOT NULL,
  `return_date` date DEFAULT NULL,
  `status` enum('active','returned','overdue','lost') NOT NULL DEFAULT 'active',
  `fine_amount` decimal(8,2) NOT NULL DEFAULT 0.00,
  `fine_paid` tinyint(1) NOT NULL DEFAULT 0,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `loans`
--

INSERT INTO `loans` (`loan_id`, `loan_number`, `student_id`, `book_id`, `subscription_id`, `borrower_type`, `borrower_id`, `borrower_name`, `loan_date`, `due_date`, `return_date`, `status`, `fine_amount`, `fine_paid`, `notes`, `created_at`, `updated_at`) VALUES
(1, 'LN001', 1, 1, NULL, 'student', 0, '', '2024-03-01', '2024-03-15', NULL, 'active', 0.00, 0, NULL, '2026-03-08 21:22:00', '2026-03-08 21:22:00'),
(2, 'LN-2026-0001', 6, 3, NULL, 'student', 0, '', '2026-03-13', '2026-03-20', '2026-04-09', 'returned', 0.00, 0, 'اعارة', '2026-03-13 23:33:30', '2026-04-08 22:40:47'),
(3, 'LN-2026-0002', 6, 4, NULL, 'student', 0, '', '2026-04-08', '2026-04-15', '2026-05-04', 'returned', 0.00, 0, 'طلاب في الكلية', '2026-04-08 22:40:34', '2026-05-04 01:27:53'),
(4, 'LN-2026-0003', 8, 5, NULL, 'student', 0, '', '2026-04-19', '2026-04-26', '2026-04-19', 'returned', 0.00, 0, '', '2026-04-19 20:46:02', '2026-04-19 20:46:25'),
(5, 'LN-2026-0004', 6, 6, NULL, 'student', 0, '', '2026-05-04', '2026-05-07', NULL, 'active', 0.00, 0, 'لذمته', '2026-05-04 01:36:18', '2026-05-04 01:36:18');

-- --------------------------------------------------------

--
-- بنية الجدول `operations`
--

CREATE TABLE `operations` (
  `operation_id` int(10) UNSIGNED NOT NULL,
  `operation_key` varchar(30) NOT NULL COMMENT 'view | add | edit | delete | export',
  `operation_name` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `operations`
--

INSERT INTO `operations` (`operation_id`, `operation_key`, `operation_name`) VALUES
(1, 'view', 'عرض'),
(2, 'add', 'إضافة'),
(3, 'edit', 'تعديل'),
(4, 'delete', 'حذف'),
(5, 'export', 'تصدير');

-- --------------------------------------------------------

--
-- بنية الجدول `pages`
--

CREATE TABLE `pages` (
  `page_id` int(10) UNSIGNED NOT NULL,
  `page_key` varchar(60) NOT NULL COMMENT 'مفتاح فريد مثل users.php',
  `page_name` varchar(100) NOT NULL COMMENT 'الاسم العربي للصفحة',
  `page_group` varchar(60) NOT NULL DEFAULT 'عام' COMMENT 'المجموعة في القائمة الجانبية',
  `sort_order` smallint(5) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `pages`
--

INSERT INTO `pages` (`page_id`, `page_key`, `page_name`, `page_group`, `sort_order`) VALUES
(1, 'dashboard.php', 'لوحة التحكم', 'عام', 1),
(2, 'employees.php', 'إدارة الموظفين', 'الإدارة العامة', 2),
(3, 'jobs.php', 'إدارة الوظائف', 'الإدارة العامة', 3),
(4, 'teachers.php', 'إدارة المدرسين', 'الإدارة العامة', 4),
(5, 'specializations.php', 'إدارة التخصصات', 'التخصصات والمواد', 5),
(6, 'subjects.php', 'إدارة المواد', 'التخصصات والمواد', 6),
(7, 'departments.php', 'إدارة الأقسام', 'الكتب والمكتبة', 7),
(8, 'digital_library.php', 'المكتبة الرقمية', 'الكتب والمكتبة', 8),
(9, 'users.php', 'إدارة المستخدمين', 'إدارة المستخدمين', 9),
(10, 'roles.php', 'إدارة الصلاحيات', 'إدارة المستخدمين', 10),
(11, 'students.php', 'Ø¥Ø¯Ø§Ø±Ø© Ø§Ù„Ø·Ù„Ø§Ø¨', 'Ø§Ù„Ø¥Ø¯Ø§Ø±Ø© Ø§Ù„Ø¹Ø§Ù…Ø©', 15),
(12, 'books.php', 'Ø¥Ø¯Ø§Ø±Ø© Ø§Ù„ÙƒØªØ¨', 'Ø§Ù„ÙƒØªØ¨ ÙˆØ§Ù„Ø§Ø³ØªØ¹Ø§Ø±Ø§Øª', 25),
(13, 'subscriptions.php', 'Ø¥Ø¯Ø§Ø±Ø© Ø§Ù„Ø§Ø´ØªØ±Ø§ÙƒØ§Øª', 'Ø§Ù„ÙƒØªØ¨ ÙˆØ§Ù„Ø§Ø³ØªØ¹Ø§Ø±Ø§Øª', 26),
(14, 'loans.php', 'Ø¥Ø¯Ø§Ø±Ø© Ø§Ù„Ø§Ø³ØªØ¹Ø§Ø±Ø§Øª', 'Ø§Ù„ÙƒØªØ¨ ÙˆØ§Ù„Ø§Ø³ØªØ¹Ø§Ø±Ø§Øª', 27),
(15, 'curriculums.php', 'Ø¥Ø¯Ø§Ø±Ø© Ø§Ù„Ù…Ù†Ø§Ù‡Ø¬', 'Ø§Ù„Ù…Ø­ØªÙˆÙ‰ Ø§Ù„Ø¯Ø±Ø§Ø³ÙŠ', 35),
(16, 'lectures.php', 'Ø¥Ø¯Ø§Ø±Ø© Ø§Ù„Ù…Ø­Ø§Ø¶Ø±Ø§Øª', 'Ø§Ù„Ù…Ø­ØªÙˆÙ‰ Ø§Ù„Ø¯Ø±Ø§Ø³ÙŠ', 36),
(17, 'graduation_projects.php', 'Ù…Ø´Ø§Ø±ÙŠØ¹ Ø§Ù„ØªØ®Ø±Ø¬', 'Ø§Ù„Ù…Ø­ØªÙˆÙ‰ Ø§Ù„Ø¯Ø±Ø§Ø³ÙŠ', 37),
(18, 'backup.php', 'Ø§Ù„Ù†Ø³Ø® Ø§Ù„Ø§Ø­ØªÙŠØ§Ø·ÙŠ', 'Ø§Ù„Ù†Ø¸Ø§Ù…', 50);

-- --------------------------------------------------------

--
-- بنية الجدول `project_students`
--

CREATE TABLE `project_students` (
  `project_id` int(10) UNSIGNED NOT NULL,
  `student_id` int(10) UNSIGNED NOT NULL,
  `role` enum('leader','member') NOT NULL DEFAULT 'member'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `project_students`
--

INSERT INTO `project_students` (`project_id`, `student_id`, `role`) VALUES
(2, 6, 'leader'),
(3, 6, 'leader');

-- --------------------------------------------------------

--
-- بنية الجدول `project_upload_requests`
--

CREATE TABLE `project_upload_requests` (
  `request_id` int(11) NOT NULL,
  `member_id` int(11) NOT NULL,
  `project_title` varchar(255) NOT NULL,
  `student_names` text DEFAULT NULL,
  `supervisor` varchar(255) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  `graduation_year` varchar(10) DEFAULT NULL,
  `project_description` text DEFAULT NULL,
  `technologies_used` text DEFAULT NULL,
  `file_path` varchar(500) DEFAULT NULL,
  `cover_image` varchar(500) DEFAULT NULL,
  `logo_image` varchar(500) DEFAULT NULL,
  `file_size` bigint(20) DEFAULT NULL,
  `file_type` varchar(100) DEFAULT NULL,
  `demo_link` varchar(500) DEFAULT NULL,
  `github_link` varchar(500) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `rejection_reason` text DEFAULT NULL,
  `reviewed_by` int(11) DEFAULT NULL,
  `reviewed_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- بنية الجدول `roles`
--

CREATE TABLE `roles` (
  `role_id` int(10) UNSIGNED NOT NULL,
  `role_name` varchar(80) NOT NULL,
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- الصلاحيات اعداد يوسف نصر شمسان `roles`
--

INSERT INTO `roles` (`role_id`, `role_name`, `description`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'مدير النظام', 'صلاحيات كاملة على جميع الوحدات', 1, '2026-03-07 01:41:36', '2026-03-07 01:41:36'),
(2, 'مشرف', 'صلاحيات عرض وإضافة وتعديل', 1, '2026-03-07 01:41:36', '2026-03-07 01:41:36'),
(3, 'موظف', 'صلاحيات عرض فقط', 1, '2026-03-07 01:41:36', '2026-03-07 01:41:36'),
(4, 'aljlad', '', 1, '2026-03-07 22:01:13', '2026-03-07 22:01:13'),
(5, 'مشرف ثاني', 'يملك كل صلاحيات المشرف الاول', 1, '2026-03-09 03:55:33', '2026-03-09 03:55:33'),
(6, 'مشرف ثالث', 'مشرق احتياطي', 1, '2026-03-09 21:56:20', '2026-03-09 21:56:20'),
(7, 'مسؤل قواعد البيانات والنسخ الاحتياطي', 'انشاء واستعادة وتنظيم النسخ الاحتياطية', 1, '2026-04-08 22:15:24', '2026-04-08 22:15:24');

-- --------------------------------------------------------

--
-- بنية الجدول `role_permissions`
--

CREATE TABLE `role_permissions` (
  `role_id` int(10) UNSIGNED NOT NULL,
  `page_id` int(10) UNSIGNED NOT NULL,
  `operation_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `role_permissions`
--

INSERT INTO `role_permissions` (`role_id`, `page_id`, `operation_id`) VALUES
(1, 1, 1),
(1, 1, 2),
(1, 1, 3),
(1, 1, 4),
(1, 1, 5),
(1, 2, 1),
(1, 2, 2),
(1, 2, 3),
(1, 2, 4),
(1, 2, 5),
(1, 3, 1),
(1, 3, 2),
(1, 3, 3),
(1, 3, 4),
(1, 3, 5),
(1, 4, 1),
(1, 4, 2),
(1, 4, 3),
(1, 4, 4),
(1, 4, 5),
(1, 5, 1),
(1, 5, 2),
(1, 5, 3),
(1, 5, 4),
(1, 5, 5),
(1, 6, 1),
(1, 6, 2),
(1, 6, 3),
(1, 6, 4),
(1, 6, 5),
(1, 7, 1),
(1, 7, 2),
(1, 7, 3),
(1, 7, 4),
(1, 7, 5),
(1, 8, 1),
(1, 8, 2),
(1, 8, 3),
(1, 8, 4),
(1, 8, 5),
(1, 9, 1),
(1, 9, 2),
(1, 9, 3),
(1, 9, 4),
(1, 9, 5),
(1, 10, 1),
(1, 10, 2),
(1, 10, 3),
(1, 10, 4),
(1, 10, 5),
(1, 11, 1),
(1, 11, 2),
(1, 11, 3),
(1, 11, 4),
(1, 11, 5),
(1, 12, 1),
(1, 12, 2),
(1, 12, 3),
(1, 12, 4),
(1, 12, 5),
(1, 13, 1),
(1, 13, 2),
(1, 13, 3),
(1, 13, 4),
(1, 13, 5),
(1, 14, 1),
(1, 14, 2),
(1, 14, 3),
(1, 14, 4),
(1, 14, 5),
(1, 15, 1),
(1, 15, 2),
(1, 15, 3),
(1, 15, 4),
(1, 15, 5),
(1, 16, 1),
(1, 16, 2),
(1, 16, 3),
(1, 16, 4),
(1, 16, 5),
(1, 17, 1),
(1, 17, 2),
(1, 17, 3),
(1, 17, 4),
(1, 17, 5),
(1, 18, 1),
(1, 18, 2),
(1, 18, 3),
(1, 18, 4),
(1, 18, 5),
(2, 1, 1),
(2, 1, 2),
(2, 1, 3),
(2, 2, 1),
(2, 2, 2),
(2, 2, 3),
(2, 3, 1),
(2, 3, 2),
(2, 3, 3),
(2, 4, 1),
(2, 4, 2),
(2, 4, 3),
(2, 5, 1),
(2, 5, 2),
(2, 5, 3),
(2, 6, 1),
(2, 6, 2),
(2, 6, 3),
(2, 7, 1),
(2, 7, 2),
(2, 7, 3),
(2, 8, 1),
(2, 8, 2),
(2, 8, 3),
(2, 9, 1),
(2, 9, 2),
(2, 9, 3),
(2, 10, 1),
(2, 10, 2),
(2, 10, 3),
(3, 1, 1),
(3, 2, 1),
(3, 3, 1),
(3, 4, 1),
(3, 5, 1),
(3, 6, 1),
(3, 7, 1),
(3, 8, 1),
(3, 9, 1),
(3, 10, 1),
(4, 1, 1),
(4, 1, 2),
(4, 1, 3),
(4, 1, 4),
(4, 1, 5),
(6, 1, 1),
(6, 1, 2),
(6, 1, 3),
(6, 1, 4),
(6, 1, 5),
(6, 3, 1),
(6, 3, 2),
(6, 3, 3),
(6, 3, 4),
(6, 3, 5),
(6, 4, 1),
(6, 4, 2),
(6, 4, 3),
(6, 4, 4),
(6, 4, 5),
(6, 5, 1),
(6, 5, 2),
(6, 5, 3),
(6, 5, 4),
(6, 5, 5),
(6, 6, 1),
(6, 6, 2),
(6, 6, 3),
(6, 6, 4),
(6, 6, 5),
(6, 7, 1),
(6, 7, 2),
(6, 7, 3),
(6, 7, 4),
(6, 7, 5),
(6, 8, 1),
(6, 8, 2),
(6, 8, 3),
(6, 8, 4),
(6, 8, 5),
(6, 9, 1),
(6, 9, 2),
(6, 9, 3),
(6, 9, 4),
(6, 9, 5),
(6, 10, 1),
(6, 10, 2),
(6, 10, 3),
(6, 10, 4),
(6, 10, 5),
(6, 11, 1),
(6, 11, 2),
(6, 11, 3),
(6, 11, 4),
(6, 11, 5),
(6, 12, 1),
(6, 12, 2),
(6, 12, 3),
(6, 12, 4),
(6, 12, 5),
(6, 13, 1),
(6, 13, 2),
(6, 13, 3),
(6, 13, 4),
(6, 13, 5),
(6, 14, 1),
(6, 14, 2),
(6, 14, 3),
(6, 14, 4),
(6, 14, 5),
(6, 15, 1),
(6, 15, 2),
(6, 15, 3),
(6, 15, 4),
(6, 15, 5),
(6, 16, 1),
(6, 16, 2),
(6, 16, 3),
(6, 16, 4),
(6, 16, 5),
(6, 17, 1),
(6, 17, 2),
(6, 17, 3),
(6, 17, 4),
(6, 17, 5),
(6, 18, 1),
(6, 18, 2),
(6, 18, 3),
(6, 18, 4),
(6, 18, 5),
(7, 1, 1),
(7, 1, 2),
(7, 1, 3),
(7, 1, 4),
(7, 1, 5),
(7, 2, 1),
(7, 2, 2),
(7, 2, 3),
(7, 2, 4),
(7, 2, 5),
(7, 3, 1),
(7, 3, 2),
(7, 3, 3),
(7, 3, 4),
(7, 3, 5),
(7, 4, 1),
(7, 4, 2),
(7, 4, 3),
(7, 4, 4),
(7, 4, 5),
(7, 5, 1),
(7, 5, 2),
(7, 5, 3),
(7, 5, 4),
(7, 5, 5),
(7, 6, 1),
(7, 6, 2),
(7, 6, 3),
(7, 6, 4),
(7, 6, 5),
(7, 7, 1),
(7, 7, 2),
(7, 7, 3),
(7, 7, 4),
(7, 7, 5),
(7, 8, 1),
(7, 8, 2),
(7, 8, 3),
(7, 8, 4),
(7, 8, 5),
(7, 9, 1),
(7, 9, 2),
(7, 9, 3),
(7, 9, 4),
(7, 9, 5),
(7, 10, 1),
(7, 10, 2),
(7, 10, 3),
(7, 10, 4),
(7, 10, 5),
(7, 11, 1),
(7, 11, 2),
(7, 11, 3),
(7, 11, 4),
(7, 11, 5),
(7, 12, 1),
(7, 12, 2),
(7, 12, 3),
(7, 12, 4),
(7, 12, 5),
(7, 13, 1),
(7, 13, 2),
(7, 13, 3),
(7, 13, 4),
(7, 13, 5),
(7, 14, 1),
(7, 14, 2),
(7, 14, 3),
(7, 14, 4),
(7, 14, 5),
(7, 15, 1),
(7, 15, 2),
(7, 15, 3),
(7, 15, 4),
(7, 15, 5),
(7, 16, 1),
(7, 16, 2),
(7, 16, 3),
(7, 16, 4),
(7, 16, 5),
(7, 17, 1),
(7, 17, 2),
(7, 17, 3),
(7, 17, 4),
(7, 17, 5),
(7, 18, 1),
(7, 18, 2),
(7, 18, 3),
(7, 18, 4),
(7, 18, 5);

-- --------------------------------------------------------

--
-- بنية الجدول `specializations`
--

CREATE TABLE `specializations` (
  `specialization_id` int(10) UNSIGNED NOT NULL,
  `specialization_code` varchar(20) NOT NULL,
  `specialization_name` varchar(150) NOT NULL,
  `description` text DEFAULT NULL,
  `department_type` enum('academic','vocational','technical') NOT NULL DEFAULT 'academic',
  `degree_type` enum('bachelor','higher_diploma') NOT NULL DEFAULT 'bachelor' COMMENT 'نوع الدرجة العلمية: بكالوريوس أو دبلوم عالٍ',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- التخصصات والاقسام`specializations`
--

INSERT INTO `specializations` (`specialization_id`, `specialization_code`, `specialization_name`, `description`, `department_type`, `degree_type`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'CS', 'علوم الحاسوب', 'تخصص بكالوريوس في علوم الحاسوب وتكنولوجيا المعلومات', 'academic', 'bachelor', 0, '2026-03-07 00:53:32', '2026-03-07 01:28:27'),
(2, 'MATH', 'الرياضيات', 'تخصص في الرياضيات والإحصاء', 'academic', 'bachelor', 1, '2026-03-07 00:53:32', '2026-03-07 00:53:32'),
(3, 'ARABIC', 'الأدب العربي', 'تخصص في الأدب العربي واللغة العربية', 'academic', 'bachelor', 1, '2026-03-07 00:53:32', '2026-03-07 00:53:32'),
(4, 'PHYSICS', 'الفيزياء', 'تخصص في الفيزياء والعلوم الطبيعية', 'academic', 'bachelor', 0, '2026-03-07 00:53:32', '2026-03-09 04:06:06'),
(5, 'CHEMISTRY', 'الكيمياء', 'تخصص في الكيمياء والعلوم الكيميائية', 'academic', 'bachelor', 1, '2026-03-07 00:53:32', '2026-03-07 00:53:32'),
(6, 'BIOLOGY', 'الأحياء', 'تخصص في علم الأحياء والعلوم البيولوجية', 'academic', 'bachelor', 1, '2026-03-07 00:53:32', '2026-03-07 00:53:32'),
(7, 'HISTORY', 'التاريخ', 'تخصص في التاريخ والحضارة', 'academic', 'bachelor', 1, '2026-03-07 00:53:32', '2026-03-07 00:53:32'),
(8, 'GEOGRAPHY', 'الجغرافيا', 'تخصص في الجغرافيا وعلوم الأرض', 'academic', 'bachelor', 1, '2026-03-07 00:53:32', '2026-03-07 00:53:32'),
(9, 'ENGLISH', 'اللغة الإنجليزية', 'تخصص في اللغة الإنجليزية وآدابها', 'academic', 'bachelor', 1, '2026-03-07 00:53:32', '2026-03-07 00:53:32'),
(10, 'ECONOMICS', 'الاقتصاد', 'تخصص في الاقتصاد والعلوم المالية', 'academic', 'bachelor', 1, '2026-03-07 00:53:32', '2026-03-07 00:53:32'),
(11, 'ACCOUNTING', 'المحاسبة', 'تخصص في المحاسبة والمالية', 'vocational', 'bachelor', 1, '2026-03-07 00:53:32', '2026-03-07 00:53:32'),
(12, 'BUSINESS', 'إدارة الأعمال', 'تخصص في إدارة الأعمال والتجارة', 'vocational', 'bachelor', 1, '2026-03-07 00:53:32', '2026-03-07 00:53:32'),
(13, 'ENGINEERING', 'الهندسة', 'تخصص في الهندسة والتكنولوجيا', 'technical', 'bachelor', 1, '2026-03-07 00:53:32', '2026-03-07 00:53:32'),
(14, 'MEDICINE', 'الطب', 'تخصص في الطب والعلوم الطبية', 'academic', 'bachelor', 1, '2026-03-07 00:53:32', '2026-03-07 00:53:32'),
(15, 'LAW', 'الحقوق', 'تخصص في القانون والعلوم القانونية', 'academic', 'bachelor', 1, '2026-03-07 00:53:32', '2026-03-07 00:53:32'),
(16, 'IS-B', 'نظم المعلومات', 'تخصص بكالوريوس في نظم المعلومات وإدارة البيانات', 'academic', 'bachelor', 1, '2026-03-07 01:13:42', '2026-03-07 01:13:42'),
(17, 'SE-B', 'هندسة البرمجيات', 'تخصص بكالوريوس في هندسة وتطوير البرمجيات', 'technical', 'bachelor', 1, '2026-03-07 01:13:42', '2026-03-07 01:13:42'),
(18, 'AI-B', 'الذكاء الاصطناعي', 'تخصص بكالوريوس في الذكاء الاصطناعي وتعلم الآلة', 'academic', 'bachelor', 1, '2026-03-07 01:13:42', '2026-03-07 01:13:42'),
(19, 'CN-B', 'شبكات الحاسوب', 'تخصص بكالوريوس في شبكات الحاسوب والاتصالات', 'technical', 'bachelor', 1, '2026-03-07 01:13:42', '2026-03-07 01:13:42'),
(20, 'SEC-B', 'أمن المعلومات', 'تخصص بكالوريوس في أمن المعلومات والأمن السيبراني', 'technical', 'bachelor', 1, '2026-03-07 01:13:42', '2026-03-07 01:13:42'),
(21, 'IT-B', 'تقنية المعلومات', 'تخصص بكالوريوس في تقنية المعلومات والحوسبة', 'technical', 'bachelor', 1, '2026-03-07 01:13:42', '2026-03-07 01:13:42'),
(22, 'MCOM-B', 'الحوسبة المتنقلة', 'تخصص بكالوريوس في تطوير تطبيقات الهاتف والحوسبة المتنقلة', 'technical', 'bachelor', 1, '2026-03-07 01:13:42', '2026-03-07 01:13:42'),
(23, 'MM-B', 'الوسائط المتعددة', 'تخصص بكالوريوس في تصميم الوسائط المتعددة والرسومات الحاسوبية', 'technical', 'bachelor', 1, '2026-03-07 01:13:42', '2026-03-07 01:13:42'),
(24, 'DB-HD', 'قواعد البيانات', 'دبلوم عالٍ في إدارة وتصميم قواعد البيانات', 'technical', 'higher_diploma', 1, '2026-03-07 01:13:42', '2026-03-07 01:13:42'),
(25, 'CC-HD', 'الحوسبة السحابية', 'دبلوم عالٍ في الحوسبة السحابية والبنية التحتية الرقمية', 'technical', 'higher_diploma', 1, '2026-03-07 01:13:42', '2026-03-07 01:13:42'),
(26, 'DA-HD', 'تحليل البيانات', 'دبلوم عالٍ في تحليل البيانات وعلم البيانات', 'academic', 'higher_diploma', 1, '2026-03-07 01:13:42', '2026-03-07 01:13:42'),
(27, 'IOT-HD', 'إنترنت الأشياء', 'دبلوم عالٍ في إنترنت الأشياء والأنظمة المضمنة', 'technical', 'higher_diploma', 1, '2026-03-07 01:13:42', '2026-03-07 01:13:42'),
(28, 'PROG-HD', 'البرمجة التطبيقية', 'دبلوم عالٍ في البرمجة التطبيقية وتطوير الويب', 'technical', 'higher_diploma', 1, '2026-03-07 01:13:42', '2026-03-07 01:13:42'),
(30, 'ب-B', 'برمجة الحاسوب', 'جعل الاشياء تعمل', 'academic', 'bachelor', 1, '2026-03-07 01:28:59', '2026-03-07 01:29:57'),
(31, 'تما-B', 'تقنية معلومات ادارية', 'تخصص', 'academic', 'bachelor', 1, '2026-03-09 04:06:40', '2026-03-09 04:06:40'),
(32, 'SP-032', 'امن المعلومات', 'تخصص مهتم بالجانب الامني للبيانات والمعلومات اشمل من الامن السيبراني', 'academic', 'bachelor', 1, '2026-04-08 22:18:03', '2026-04-08 22:18:03');

-- --------------------------------------------------------

--
-- بنية الجدول `students`
--

CREATE TABLE `students` (
  `student_id` int(10) UNSIGNED NOT NULL,
  `student_number` varchar(20) NOT NULL,
  `full_name` varchar(150) NOT NULL,
  `gender` enum('male','female') NOT NULL DEFAULT 'male',
  `specialization_id` int(10) UNSIGNED DEFAULT NULL,
  `year_level` tinyint(3) UNSIGNED NOT NULL DEFAULT 1,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `enrollment_date` date DEFAULT NULL,
  `status` enum('active','graduated','suspended','withdrawn') NOT NULL DEFAULT 'active',
  `is_active` tinyint(1) DEFAULT 1,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `photo_path` varchar(255) DEFAULT NULL,
  `card_front_path` varchar(255) DEFAULT NULL COMMENT 'ãÓÇÑ ÕæÑÉ ÈØÇÞÉ ÇáØÇáÈ ÇáÇãÇãíÉ',
  `card_back_path` varchar(255) DEFAULT NULL COMMENT 'ãÓÇÑ ÕæÑÉ ÈØÇÞÉ ÇáØÇáÈ ÇáÎáÝíÉ'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `students`
--

INSERT INTO `students` (`student_id`, `student_number`, `full_name`, `gender`, `specialization_id`, `year_level`, `phone`, `email`, `address`, `enrollment_date`, `status`, `is_active`, `notes`, `created_at`, `updated_at`, `photo_path`, `card_front_path`, `card_back_path`) VALUES
(1, 'STU-2026-0001', 'nawaf', 'male', 20, 4, '770218802', 'ahmdalslymyahmdly@gmail.com', NULL, '2026-03-07', 'active', 1, '', '2026-03-07 21:42:20', '2026-03-09 01:18:47', 'uploads/STU-2026-0001/STU-2026-0001_photo.png', 'uploads/STU-2026-0001/STU-2026-0001_card_front.png', 'uploads/STU-2026-0001/STU-2026-0001_card_back.png'),
(6, 'STU-2026-0002', 'جابر الاسود ضخم', 'male', 27, 1, '54545454545', 'ahmdalslymyahmdly@gmail.com', NULL, '2026-03-09', 'active', 1, 'نيابتيت', '2026-03-09 03:42:02', '2026-03-09 03:46:22', 'uploads/STU-2026-0002/STU-2026-0002_photo.png', 'uploads/STU-2026-0002/STU-2026-0002_front.png', 'uploads/STU-2026-0002/STU-2026-0002_back.png'),
(8, 'STU-2026-0004', 'يوسف نصر شمسان', 'male', 16, 3, '779806141', 'yousifmo@gmail.com', NULL, '2026-04-08', 'active', 1, 'ابو صيلم', '2026-04-08 20:12:39', '2026-04-08 20:12:39', 'uploads/STU-2026-0004/STU-2026-0004_photo.jpg', 'uploads/STU-2026-0004/STU-2026-0004_front.jpg', 'uploads/STU-2026-0004/STU-2026-0004_back.jpg');

-- --------------------------------------------------------

--
-- بنية الجدول `subjects`
--

CREATE TABLE `subjects` (
  `subject_id` int(10) UNSIGNED NOT NULL,
  `subject_code` varchar(20) NOT NULL,
  `subject_name` varchar(150) NOT NULL,
  `specialization_id` int(10) UNSIGNED NOT NULL,
  `credit_hours` tinyint(3) UNSIGNED NOT NULL DEFAULT 3,
  `subject_type` enum('theoretical','practical','both') NOT NULL DEFAULT 'theoretical',
  `semester` enum('first','second','summer') NOT NULL DEFAULT 'first',
  `year_level` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT 'السنة الدراسية 1-5',
  `description` text DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `subjects`
--

INSERT INTO `subjects` (`subject_id`, `subject_code`, `subject_name`, `specialization_id`, `credit_hours`, `subject_type`, `semester`, `year_level`, `description`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'CS101', 'مقدمة في البرمجة', 1, 3, 'theoretical', 'first', 1, 'مقرر تمهيدي في البرمجة', 1, '2026-03-08 21:22:00', '2026-03-08 21:22:00'),
(2, 'CS102', 'هياكل البيانات', 1, 4, 'both', 'second', 2, 'دراسة هياكل البيانات', 1, '2026-03-08 21:22:00', '2026-03-08 21:22:00'),
(3, 'MATH101', 'الرياضيات 1', 2, 3, 'theoretical', 'first', 1, 'رياضيات عامة', 1, '2026-03-08 21:22:00', '2026-03-08 21:22:00'),
(4, 'ARAB101', 'النحو والصرف', 3, 2, 'theoretical', 'first', 1, 'النحو العربي', 1, '2026-03-08 21:22:00', '2026-03-08 21:22:00'),
(5, 'تن-S', 'تحلليل نظم', 31, 3, 'both', 'first', 1, 'اي كلام', 1, '2026-03-09 04:08:37', '2026-03-09 04:08:37'),
(6, 'تن2-S', 'تحلليل نظم 2', 31, 3, 'both', 'second', 1, 'اي حاجة', 1, '2026-03-09 04:09:21', '2026-03-09 04:09:21'),
(7, 'تجر-S', 'تحقيق جنائي رقمي', 20, 6, 'both', 'second', 3, 'تهتم المادة بتدريس الطالب اساسيات التحقيق الرقمي واكتشاف التسلسل وصياغتة كتحقيق رقمي متكامل', 1, '2026-04-08 22:19:53', '2026-04-08 22:19:53');

-- --------------------------------------------------------

--
-- بنية الجدول `subscriptions`
--

CREATE TABLE `subscriptions` (
  `subscription_id` int(10) UNSIGNED NOT NULL,
  `subscription_number` varchar(50) DEFAULT NULL,
  `student_id` int(10) UNSIGNED DEFAULT NULL,
  `subscriber_type` enum('student','employee','teacher','external') NOT NULL DEFAULT 'student',
  `subscriber_id` int(10) UNSIGNED NOT NULL COMMENT 'ID حسب النوع',
  `subscriber_name` varchar(150) NOT NULL COMMENT 'نسخة مؤقتة للاسم',
  `subscription_type` enum('monthly','semester','annual') NOT NULL DEFAULT 'semester',
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `amount` decimal(10,2) DEFAULT 0.00,
  `payment_method` enum('cash','card','bank','online') DEFAULT 'cash',
  `max_loans` tinyint(3) UNSIGNED NOT NULL DEFAULT 3,
  `fee` decimal(8,2) NOT NULL DEFAULT 0.00,
  `is_paid` tinyint(1) NOT NULL DEFAULT 0,
  `status` enum('active','expired','suspended') NOT NULL DEFAULT 'active',
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `subscriptions`
--

INSERT INTO `subscriptions` (`subscription_id`, `subscription_number`, `student_id`, `subscriber_type`, `subscriber_id`, `subscriber_name`, `subscription_type`, `start_date`, `end_date`, `amount`, `payment_method`, `max_loans`, `fee`, `is_paid`, `status`, `notes`, `created_at`, `updated_at`) VALUES
(1, 'SUB001', 1, 'student', 0, '', 'annual', '2024-01-01', '2024-12-31', 500.00, 'cash', 3, 0.00, 0, 'active', NULL, '2026-03-08 21:22:00', '2026-03-08 21:22:00'),
(2, 'SUB-2026-0001', 6, 'student', 0, '', 'annual', '2026-04-08', '0000-00-00', 3000.00, 'cash', 3, 0.00, 0, 'active', 'اشتراك جديد', '2026-04-08 22:39:00', '2026-04-08 22:39:00'),
(3, 'SUB-2026-0002', 8, 'student', 0, '', 'monthly', '2026-04-19', '0000-00-00', 2000.00, 'cash', 3, 0.00, 0, 'active', '', '2026-04-19 20:44:31', '2026-04-19 20:44:31'),
(4, 'SUB-2026-0003', 6, 'student', 0, '', 'annual', '2026-05-04', '0000-00-00', 6000.00, 'cash', 3, 0.00, 0, 'active', 'قدوة ذيك', '2026-05-04 01:37:32', '2026-05-04 01:37:32');

-- --------------------------------------------------------

--
-- بنية الجدول `system_settings`
--

CREATE TABLE `system_settings` (
  `setting_id` int(11) NOT NULL,
  `setting_key` varchar(100) NOT NULL,
  `setting_value` text DEFAULT NULL,
  `setting_type` varchar(50) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- إرجاع أو استيراد بيانات الجدول `system_settings`
--

INSERT INTO `system_settings` (`setting_id`, `setting_key`, `setting_value`, `setting_type`, `updated_at`) VALUES
(1, 'admin_logo', 'images/logo_admin.PNG', 'image', '2026-03-18 22:46:58'),
(2, 'admin_name', 'كلية التكنلوجيا الحديثة - المكتبة', 'text', '2026-04-08 14:50:17'),
(3, 'admin_slogan', 'آمن، سريع، وموثوق', 'text', '2026-04-08 14:50:17'),
(4, 'public_name', 'المكتبة الرقمية لكلية التكنلوجيا الحديثة', 'text', '2026-04-08 14:50:17'),
(5, 'public_slogan', 'مكتبتك في أي وقت وأي مكان', 'text', '2026-04-08 14:50:17'),
(10, 'language', 'en', 'text', '2026-04-08 14:50:53'),
(11, 'theme', 'light', 'text', '2026-04-08 14:50:53');

-- --------------------------------------------------------

--
-- بنية الجدول `teachers`
--

CREATE TABLE `teachers` (
  `teacher_id` int(10) UNSIGNED NOT NULL,
  `teacher_number` varchar(30) NOT NULL,
  `full_name` varchar(150) NOT NULL,
  `gender` enum('male','female') NOT NULL DEFAULT 'male',
  `marital_status` enum('single','married','divorced','widowed') NOT NULL DEFAULT 'single',
  `branch_code` varchar(30) NOT NULL DEFAULT 'main-1',
  `specialization` varchar(150) NOT NULL,
  `degree` varchar(100) NOT NULL,
  `subjects` text DEFAULT NULL,
  `experience_years` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `salary` decimal(12,2) NOT NULL DEFAULT 0.00,
  `phone` varchar(20) NOT NULL,
  `email` varchar(190) NOT NULL,
  `email_verified` tinyint(1) NOT NULL DEFAULT 0,
  `email_verified_at` datetime DEFAULT NULL,
  `image_path` varchar(255) NOT NULL DEFAULT 'images/user-avatar.png',
  `status` enum('active','on-leave','inactive') NOT NULL DEFAULT 'active',
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `teachers`
--

INSERT INTO `teachers` (`teacher_id`, `teacher_number`, `full_name`, `gender`, `marital_status`, `branch_code`, `specialization`, `degree`, `subjects`, `experience_years`, `salary`, `phone`, `email`, `email_verified`, `email_verified_at`, `image_path`, `status`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'TCH-001', 'د. أحمد محمد الشيباني', 'male', 'married', 'main-1', 'إنترنت الأشياء', 'دكتوراه', '', 15, 350000.00, '077123456', 'ahmed.teacher@mtc-library.ye', 1, '2026-03-07 03:38:51', 'images/user-avatar.png', 'active', 1, '2026-03-07 00:38:51', '2026-03-14 02:32:39'),
(2, 'TCH-002', 'أ. جفري  ابستين', 'male', 'single', 'port-1', 'الرياضيات', 'ماجستير', 'جبر، حساب تفاضلي، إحصاء', 8, 280000.00, '077234567', 'khalid.teacher@mtc-library.ye', 1, '2026-03-07 03:38:51', 'images/user-avatar.png', 'active', 1, '2026-03-07 00:38:51', '2026-03-07 00:38:51'),
(3, 'TCH-003', 'د. فاطمة علي حسن', 'female', 'married', 'sub-1', 'الأدب العربي', 'دكتوراه', 'نحو، بلاغة، أدب إسلامي', 12, 320000.00, '077345678', 'fatima.teacher@mtc-library.ye', 1, '2026-03-07 03:38:51', 'images/user-avatar.png', 'active', 1, '2026-03-07 00:38:51', '2026-03-07 00:38:51'),
(4, 'TCH-004', 'أ. محمد صالح علي', 'male', 'married', 'main-1', 'الفيزياء', 'ماجستير', 'ميكانيك، كهرباء، ضوء', 10, 300000.00, '077456789', 'mohammed.teacher@mtc-library.ye', 1, '2026-03-07 03:38:51', 'images/user-avatar.png', 'on-leave', 1, '2026-03-07 00:38:51', '2026-03-07 00:38:51'),
(5, 'TCH-005', 'نواف ابو منحيس', 'male', 'single', 'main-1', 'علوم الحاسوب', 'بكالوريوس', 'مقدمة في البرمجة', 1, 2000000.00, '789654123', 'hmdly@gmail.com', 0, NULL, 'uploads/TCH-005/profile_1773010863_69adffaf4ada8.png', 'active', 1, '2026-03-08 23:01:03', '2026-03-08 23:01:03'),
(6, 'TCH-006', 'hfef', 'male', 'divorced', 'main-1', 'الأحياء', 'بكالوريوس', '', 5, 50000.00, '887454545', 'ayahmdly@gmail.com', 0, NULL, 'uploads/TCH-006/profile_1773015552_69ae12008cd16.png', 'active', 1, '2026-03-09 00:19:12', '2026-03-09 00:27:43'),
(7, 'TCH-007', 'محمود', 'male', 'single', 'main-1', 'أمن المعلومات', 'بكالوريوس', ', تحقيق جنائي رقمي', 0, 50000.00, '777777777', 'ghyjdstyahmdly@gmail.com', 0, NULL, 'images/user-avatar.png', 'active', 1, '2026-04-09 06:42:05', '2026-04-09 06:42:05');

-- --------------------------------------------------------

--
-- بنية الجدول `users`
--

CREATE TABLE `users` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `username` varchar(60) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `employee_id` int(10) UNSIGNED NOT NULL COMMENT 'موظف واحد = حساب واحد',
  `role_id` int(10) UNSIGNED NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `last_login` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `users`
--

INSERT INTO `users` (`user_id`, `username`, `password_hash`, `employee_id`, `role_id`, `is_active`, `last_login`, `created_at`, `updated_at`) VALUES
(5, 'admin321', '$2y$10$cYkR.sE8PSBekHBXuNbknuLWiK9W217x/tiXcywT7xo/YrwejO7K6', 5, 1, 1, '2026-06-23 20:27:22', '2026-04-08 20:07:45', '2026-06-23 20:27:22'),
(6, 'majdi', '$2y$10$dtay/92x4bIFwXefh2rHJe46iP2fiVNuCNxDKXkcabA7Ql/3mg3O6', 7, 1, 1, NULL, '2026-06-23 20:31:21', '2026-06-23 20:31:21');

-- --------------------------------------------------------

--
-- بنية الجدول `user_permissions`
--

CREATE TABLE `user_permissions` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `page_id` int(10) UNSIGNED NOT NULL,
  `operation_id` int(10) UNSIGNED NOT NULL,
  `granted` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1=منح 0=سحب'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `backup_history`
--
ALTER TABLE `backup_history`
  ADD PRIMARY KEY (`backup_id`),
  ADD UNIQUE KEY `backup_number` (`backup_number`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`book_id`),
  ADD UNIQUE KEY `isbn` (`isbn`),
  ADD UNIQUE KEY `book_number` (`book_number`),
  ADD KEY `idx_books_dept` (`department_id`),
  ADD KEY `idx_books_subject` (`subject_id`),
  ADD KEY `idx_books_active` (`is_active`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `book_categories`
--
ALTER TABLE `book_categories`
  ADD PRIMARY KEY (`category_id`),
  ADD KEY `idx_name` (`category_name`),
  ADD KEY `idx_active` (`is_active`);

--
-- Indexes for table `book_upload_requests`
--
ALTER TABLE `book_upload_requests`
  ADD PRIMARY KEY (`request_id`),
  ADD KEY `idx_book_requests_member` (`member_id`),
  ADD KEY `idx_book_requests_status` (`status`),
  ADD KEY `idx_book_requests_department` (`department_id`),
  ADD KEY `idx_book_requests_created` (`created_at`);

--
-- Indexes for table `curriculums`
--
ALTER TABLE `curriculums`
  ADD PRIMARY KEY (`curriculum_id`),
  ADD UNIQUE KEY `curriculum_code` (`curriculum_code`),
  ADD KEY `idx_curr_spec` (`specialization_id`),
  ADD KEY `idx_curr_teacher` (`teacher_id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`department_id`),
  ADD UNIQUE KEY `uniq_departments_code` (`department_code`),
  ADD UNIQUE KEY `uniq_departments_name` (`department_name`),
  ADD KEY `idx_departments_status` (`status`),
  ADD KEY `idx_departments_category` (`category_id`),
  ADD KEY `idx_departments_shelf` (`shelf_id`),
  ADD KEY `idx_departments_manager` (`manager_employee_id`);

--
-- Indexes for table `department_categories`
--
ALTER TABLE `department_categories`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `uniq_department_categories_name` (`category_name`),
  ADD KEY `idx_department_categories_active` (`is_active`);

--
-- Indexes for table `department_members`
--
ALTER TABLE `department_members`
  ADD PRIMARY KEY (`membership_id`),
  ADD UNIQUE KEY `uniq_department_employee_role` (`department_id`,`employee_id`,`role`),
  ADD KEY `idx_department_members_employee` (`employee_id`),
  ADD KEY `idx_department_members_primary` (`department_id`,`is_primary`);

--
-- Indexes for table `digital_books`
--
ALTER TABLE `digital_books`
  ADD PRIMARY KEY (`digital_book_id`),
  ADD UNIQUE KEY `book_number` (`book_number`),
  ADD KEY `idx_title` (`book_title`),
  ADD KEY `idx_department` (`department_id`),
  ADD KEY `idx_active` (`is_active`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`employee_id`),
  ADD UNIQUE KEY `employee_number` (`employee_number`),
  ADD UNIQUE KEY `uniq_employees_email` (`email`),
  ADD KEY `idx_employees_status` (`status`),
  ADD KEY `idx_employees_job_title` (`job_title`),
  ADD KEY `idx_employees_phone` (`phone`);

--
-- Indexes for table `graduation_projects`
--
ALTER TABLE `graduation_projects`
  ADD PRIMARY KEY (`project_id`),
  ADD UNIQUE KEY `project_code` (`project_code`),
  ADD KEY `idx_proj_spec` (`specialization_id`),
  ADD KEY `idx_proj_supervisor` (`supervisor_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`job_id`),
  ADD UNIQUE KEY `job_code` (`job_code`);

--
-- Indexes for table `lectures`
--
ALTER TABLE `lectures`
  ADD PRIMARY KEY (`lecture_id`),
  ADD UNIQUE KEY `lecture_code` (`lecture_code`),
  ADD KEY `idx_lec_subject` (`subject_id`),
  ADD KEY `idx_lec_teacher` (`teacher_id`),
  ADD KEY `curriculum_id` (`curriculum_id`);

--
-- Indexes for table `lecture_upload_requests`
--
ALTER TABLE `lecture_upload_requests`
  ADD PRIMARY KEY (`request_id`);

--
-- Indexes for table `library_account_requests`
--
ALTER TABLE `library_account_requests`
  ADD PRIMARY KEY (`request_id`),
  ADD UNIQUE KEY `idx_account_requests_email` (`email`),
  ADD KEY `idx_account_requests_type` (`request_type`),
  ADD KEY `idx_account_requests_status` (`status`),
  ADD KEY `idx_account_requests_created` (`created_at`);

--
-- Indexes for table `library_members`
--
ALTER TABLE `library_members`
  ADD PRIMARY KEY (`member_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `idx_library_members_email` (`email`),
  ADD KEY `idx_library_members_type` (`member_type`),
  ADD KEY `idx_library_members_number` (`member_number`),
  ADD KEY `idx_library_members_active` (`is_active`),
  ADD KEY `idx_library_members_created` (`created_at`),
  ADD KEY `fk_library_members_specialization` (`specialization_id`);

--
-- Indexes for table `library_shelves`
--
ALTER TABLE `library_shelves`
  ADD PRIMARY KEY (`shelf_id`),
  ADD UNIQUE KEY `uniq_library_shelves_range` (`shelf_range`),
  ADD KEY `idx_library_shelves_active` (`is_active`);

--
-- Indexes for table `loans`
--
ALTER TABLE `loans`
  ADD PRIMARY KEY (`loan_id`),
  ADD UNIQUE KEY `loan_number` (`loan_number`),
  ADD KEY `idx_loans_book` (`book_id`),
  ADD KEY `idx_loans_status` (`status`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `operations`
--
ALTER TABLE `operations`
  ADD PRIMARY KEY (`operation_id`),
  ADD UNIQUE KEY `operation_key` (`operation_key`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`page_id`),
  ADD UNIQUE KEY `page_key` (`page_key`);

--
-- Indexes for table `project_students`
--
ALTER TABLE `project_students`
  ADD PRIMARY KEY (`project_id`,`student_id`),
  ADD KEY `fk_ps_student` (`student_id`);

--
-- Indexes for table `project_upload_requests`
--
ALTER TABLE `project_upload_requests`
  ADD PRIMARY KEY (`request_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_id`),
  ADD UNIQUE KEY `role_name` (`role_name`);

--
-- Indexes for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`role_id`,`page_id`,`operation_id`),
  ADD KEY `fk_rp_page` (`page_id`),
  ADD KEY `fk_rp_operation` (`operation_id`);

--
-- Indexes for table `specializations`
--
ALTER TABLE `specializations`
  ADD PRIMARY KEY (`specialization_id`),
  ADD UNIQUE KEY `specialization_code` (`specialization_code`),
  ADD UNIQUE KEY `specialization_name` (`specialization_name`),
  ADD KEY `idx_specializations_active` (`is_active`),
  ADD KEY `idx_specializations_type` (`department_type`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`student_id`),
  ADD UNIQUE KEY `student_number` (`student_number`),
  ADD KEY `idx_students_spec` (`specialization_id`),
  ADD KEY `idx_students_status` (`status`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`subject_id`),
  ADD UNIQUE KEY `subject_code` (`subject_code`),
  ADD UNIQUE KEY `subject_name` (`subject_name`),
  ADD KEY `idx_subjects_specialization` (`specialization_id`),
  ADD KEY `idx_subjects_active` (`is_active`);

--
-- Indexes for table `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD PRIMARY KEY (`subscription_id`),
  ADD UNIQUE KEY `subscription_number` (`subscription_number`),
  ADD KEY `idx_sub_type_id` (`subscriber_type`,`subscriber_id`),
  ADD KEY `idx_sub_status` (`status`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `system_settings`
--
ALTER TABLE `system_settings`
  ADD PRIMARY KEY (`setting_id`),
  ADD UNIQUE KEY `setting_key` (`setting_key`);

--
-- Indexes for table `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`teacher_id`),
  ADD UNIQUE KEY `teacher_number` (`teacher_number`),
  ADD UNIQUE KEY `uniq_teachers_email` (`email`),
  ADD KEY `idx_teachers_status` (`status`),
  ADD KEY `idx_teachers_specialization` (`specialization`),
  ADD KEY `idx_teachers_phone` (`phone`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `employee_id` (`employee_id`),
  ADD KEY `idx_users_employee` (`employee_id`),
  ADD KEY `idx_users_role` (`role_id`);

--
-- Indexes for table `user_permissions`
--
ALTER TABLE `user_permissions`
  ADD PRIMARY KEY (`user_id`,`page_id`,`operation_id`),
  ADD KEY `fk_up_page` (`page_id`),
  ADD KEY `fk_up_operation` (`operation_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `backup_history`
--
ALTER TABLE `backup_history`
  MODIFY `backup_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `book_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `book_categories`
--
ALTER TABLE `book_categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `book_upload_requests`
--
ALTER TABLE `book_upload_requests`
  MODIFY `request_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `curriculums`
--
ALTER TABLE `curriculums`
  MODIFY `curriculum_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `department_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `department_categories`
--
ALTER TABLE `department_categories`
  MODIFY `category_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `department_members`
--
ALTER TABLE `department_members`
  MODIFY `membership_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `digital_books`
--
ALTER TABLE `digital_books`
  MODIFY `digital_book_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `employee_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1000;

--
-- AUTO_INCREMENT for table `graduation_projects`
--
ALTER TABLE `graduation_projects`
  MODIFY `project_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `job_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `lectures`
--
ALTER TABLE `lectures`
  MODIFY `lecture_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `lecture_upload_requests`
--
ALTER TABLE `lecture_upload_requests`
  MODIFY `request_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `library_account_requests`
--
ALTER TABLE `library_account_requests`
  MODIFY `request_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `library_members`
--
ALTER TABLE `library_members`
  MODIFY `member_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `library_shelves`
--
ALTER TABLE `library_shelves`
  MODIFY `shelf_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `loans`
--
ALTER TABLE `loans`
  MODIFY `loan_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `operations`
--
ALTER TABLE `operations`
  MODIFY `operation_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `page_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `project_upload_requests`
--
ALTER TABLE `project_upload_requests`
  MODIFY `request_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `role_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `specializations`
--
ALTER TABLE `specializations`
  MODIFY `specialization_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `student_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `subjects`
--
ALTER TABLE `subjects`
  MODIFY `subject_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `subscriptions`
--
ALTER TABLE `subscriptions`
  MODIFY `subscription_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `system_settings`
--
ALTER TABLE `system_settings`
  MODIFY `setting_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `teachers`
--
ALTER TABLE `teachers`
  MODIFY `teacher_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- قيود الجداول المُلقاة.
--

--
-- قيود الجداول `books`
--
ALTER TABLE `books`
  ADD CONSTRAINT `books_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `book_categories` (`category_id`) ON DELETE SET NULL;

--
-- قيود الجداول `book_upload_requests`
--
ALTER TABLE `book_upload_requests`
  ADD CONSTRAINT `fk_book_requests_department` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `fk_book_requests_member` FOREIGN KEY (`member_id`) REFERENCES `library_members` (`member_id`) ON DELETE CASCADE;

--
-- قيود الجداول `curriculums`
--
ALTER TABLE `curriculums`
  ADD CONSTRAINT `fk_curr_spec` FOREIGN KEY (`specialization_id`) REFERENCES `specializations` (`specialization_id`) ON DELETE SET NULL;

--
-- قيود الجداول `departments`
--
ALTER TABLE `departments`
  ADD CONSTRAINT `fk_departments_category` FOREIGN KEY (`category_id`) REFERENCES `department_categories` (`category_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_departments_manager` FOREIGN KEY (`manager_employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_departments_shelf` FOREIGN KEY (`shelf_id`) REFERENCES `library_shelves` (`shelf_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- قيود الجداول `department_members`
--
ALTER TABLE `department_members`
  ADD CONSTRAINT `fk_department_members_department` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_department_members_employee` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- قيود الجداول `digital_books`
--
ALTER TABLE `digital_books`
  ADD CONSTRAINT `digital_books_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON DELETE SET NULL;

--
-- قيود الجداول `graduation_projects`
--
ALTER TABLE `graduation_projects`
  ADD CONSTRAINT `graduation_projects_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE SET NULL;

--
-- قيود الجداول `lectures`
--
ALTER TABLE `lectures`
  ADD CONSTRAINT `lectures_ibfk_1` FOREIGN KEY (`curriculum_id`) REFERENCES `curriculums` (`curriculum_id`) ON DELETE SET NULL;

--
-- قيود الجداول `library_members`
--
ALTER TABLE `library_members`
  ADD CONSTRAINT `fk_library_members_specialization` FOREIGN KEY (`specialization_id`) REFERENCES `specializations` (`specialization_id`) ON DELETE SET NULL;

--
-- قيود الجداول `loans`
--
ALTER TABLE `loans`
  ADD CONSTRAINT `fk_loans_book` FOREIGN KEY (`book_id`) REFERENCES `books` (`book_id`),
  ADD CONSTRAINT `loans_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE;

--
-- قيود الجداول `project_students`
--
ALTER TABLE `project_students`
  ADD CONSTRAINT `fk_ps_project` FOREIGN KEY (`project_id`) REFERENCES `graduation_projects` (`project_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_ps_student` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE;

--
-- قيود الجداول `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD CONSTRAINT `fk_rp_operation` FOREIGN KEY (`operation_id`) REFERENCES `operations` (`operation_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_rp_page` FOREIGN KEY (`page_id`) REFERENCES `pages` (`page_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_rp_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON DELETE CASCADE;

--
-- قيود الجداول `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `fk_students_spec` FOREIGN KEY (`specialization_id`) REFERENCES `specializations` (`specialization_id`) ON DELETE SET NULL;

--
-- قيود الجداول `subjects`
--
ALTER TABLE `subjects`
  ADD CONSTRAINT `fk_subjects_specialization` FOREIGN KEY (`specialization_id`) REFERENCES `specializations` (`specialization_id`) ON UPDATE CASCADE;

--
-- قيود الجداول `subscriptions`
--
ALTER TABLE `subscriptions`
  ADD CONSTRAINT `subscriptions_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`student_id`) ON DELETE CASCADE;

--
-- قيود الجداول `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_employee` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`),
  ADD CONSTRAINT `fk_users_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`);

--
-- قيود الجداول `user_permissions`
--
ALTER TABLE `user_permissions`
  ADD CONSTRAINT `fk_up_operation` FOREIGN KEY (`operation_id`) REFERENCES `operations` (`operation_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_up_page` FOREIGN KEY (`page_id`) REFERENCES `pages` (`page_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_up_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

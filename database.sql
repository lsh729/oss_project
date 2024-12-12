CREATE DATABASE IF NOT EXISTS study_planner
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE study_planner;

-- 과목 테이블
CREATE TABLE IF NOT EXISTS subjects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    subject_name VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    is_major BOOLEAN NOT NULL DEFAULT 0,
    priority VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Medium',
    exam_date DATE NOT NULL
);

-- 공부 기록 테이블
CREATE TABLE IF NOT EXISTS study_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    subject_id INT NOT NULL,
    study_date DATE NOT NULL,
    hours FLOAT NOT NULL,
    FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

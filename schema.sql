
ALTER DATABASE study_planner CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 데이터베이스 사용
USE study_planner;

-- 과목 테이블
CREATE TABLE IF NOT EXISTS subjects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    subject_name VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    is_major BOOLEAN DEFAULT FALSE,
    priority VARCHAR(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
    exam_date DATE
);
ALTER TABLE subjects MODIFY COLUMN exam_date DATE DEFAULT NULL;

-- 공부 기록 테이블
CREATE TABLE IF NOT EXISTS study_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    subject_id INT NOT NULL,
    study_date DATE NOT NULL,
    hours INT NOT NULL,
    FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 공부 계획 테이블
CREATE TABLE IF NOT EXISTS study_plans (
    id INT AUTO_INCREMENT PRIMARY KEY,
    subject_id INT NOT NULL,
    plan_date DATE NOT NULL,
    hours INT NOT NULL,
    FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE CASCADE
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 초기 데이터 삽입
INSERT INTO subjects (subject_name, is_major, priority, exam_date)
VALUES 
('Math', TRUE, 'High', '2024-12-15'),
('과학', TRUE, '높음', '2024-12-20'),
('역사', FALSE, '중간', '2024-12-25');

INSERT INTO study_logs (subject_id, study_date, hours)
VALUES 
(1, '2024-12-10', 3),
(2, '2024-12-12', 4);

INSERT INTO study_plans (subject_id, plan_date, hours)
VALUES 
(1, '2024-12-11', 2),
(2, '2024-12-13', 3);

-- 데이터 확인
SELECT * FROM subjects;
SELECT * FROM study_logs;
SELECT * FROM study_plans;

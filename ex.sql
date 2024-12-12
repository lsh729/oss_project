-- 데이터베이스 사용
USE study_planner;

-- 초기 과목 데이터
INSERT INTO subjects (subject_name, is_major, priority, exam_date)
VALUES
('Math', TRUE, 'High', '2024-12-15'),
('History', FALSE, 'Medium', '2024-12-20'),
('Science', TRUE, 'Low', '2024-12-25');

-- 초기 공부 기록 데이터
INSERT INTO study_logs (subject_id, study_date, hours)
VALUES
(1, '2024-12-10', 3),
(2, '2024-12-11', 2),
(1, '2024-12-12', 4);

-- 초기 공부 계획 데이터
INSERT INTO study_plans (subject_id, plan_date, hours)
VALUES
(1, '2024-12-13', 2),
(2, '2024-12-13', 3),
(3, '2024-12-14', 5);

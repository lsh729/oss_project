


# 스터디 플래너 웹 애플리케이션

Flutter와 Flask를 사용하여 제작된 **스터디 플래너 웹 애플리케이션**입니다. 사용자가 공부 계획을 추가, 조회, 삭제하며 공부 시간을 관리할 수 있도록 도와주는 목적으로 만들었습니다.

## 주요 기능
- 과목 추가, 조회 및 삭제
- 선택된 과목을 기반으로 공부 계획 생성
- 내장 타이머를 활용한 공부 시간 측정
- Flask 백엔드와 연동하여 데이터 저장 및 관리

## 실행 환경
- **Flutter**: https://docs.flutter.dev/get-started/install
- **Python 3.x**: Flask 및 필요한 의존성 설치 필요
- **MySQL**: 데이터베이스 관리용

## 백엔드 설정
1. 저장소를 클론하고 백엔드 디렉토리로 이동합니다.
   ```bash
   git clone https://github.com/사용자명/스터디-플래너.git
   cd backend

## 가상환경 활성화
python -m venv venv
source venv/bin/activate  # Windows는 venv\Scripts\activate

## 필요한 python 라이브러리 설치
pip install -r requirements.txt




1. 데이터베이스 설치
CREATE DATABASE study_planner;
USE study_planner;

CREATE TABLE subjects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL,
    is_major BOOLEAN NOT NULL DEFAULT 0,
    priority VARCHAR(20) NOT NULL DEFAULT 'Medium',
    exam_date DATE NOT NULL
);

CREATE TABLE study_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    subject_id INT NOT NULL,
    study_date DATE NOT NULL,
    hours FLOAT NOT NULL,
    FOREIGN KEY (subject_id) REFERENCES subjects(id) ON DELETE CASCADE
);

2. flask 서버 실행
   python app.py

3. 앱 실행
   flutter run






![image](https://github.com/user-attachments/assets/045552e4-fad7-4fea-a4e5-b6377fe325df)

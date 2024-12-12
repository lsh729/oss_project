from flask import Flask, request, jsonify
from flask_cors import CORS
import mysql.connector

# Flask 애플리케이션 생성
app = Flask(__name__)
CORS(app)

# MySQL 연결 설정
db = mysql.connector.connect(
    host="localhost",      
    user="root",            
    password="1234", 
    database="study_planner", # 데이터베이스 이름
    charset="utf8mb4" # 한글 지원
)
cursor = db.cursor(dictionary=True)

# 기본 경로: 홈 페이지
@app.route('/')
def home():
    return jsonify({"message": "Hello, Flask is running!"})

# 1. 과목 조회 API
@app.route('/subjects', methods=['GET'])
def get_subjects():
    try:
        cursor.execute("SELECT * FROM subjects")
        subjects = cursor.fetchall()

        # null 값 기본값 설정
        for subject in subjects:
            subject['subject_name'] = subject.get('subject_name', '이름 없음')
            subject['priority'] = subject.get('priority', '우선순위 없음')
            subject['is_major'] = subject.get('is_major', 0)

        return jsonify(subjects), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500



# 2. 과목 추가 API
@app.route('/subjects', methods=['POST'])
def add_subject():
    data = request.json  # 어플에서 보낸 JSON 데이터 받기
    sql = "INSERT INTO subjects (subject_name, is_major, priority, exam_date) VALUES (%s, %s, %s, %s)"
    val = (data['subject_name'], data['is_major'], data['priority'], data['exam_date'])
    cursor.execute(sql, val)
    db.commit()  # 데이터베이스에 변경사항 저장
    return jsonify({"message": "Subject added successfully!"})

# Flask 서버 실행
if __name__ == '__main__':
    app.run(debug=True)


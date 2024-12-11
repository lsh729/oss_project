# oss_projectfrom flask import Flask
from flask_cors import CORS
import mysql.connector
from routes import subjects_bp, study_plan_bp, study_logs_bp


# Flask 애플리케이션 생성
app = Flask(__name__)
CORS(app)

# MySQL 연결 설정
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="1234",
    database="study_planner",
    charset="utf8mb4"
)
cursor = db.cursor(dictionary=True)

# 블루프린트 등록
app.register_blueprint(subjects_bp, url_prefix='/subjects')
app.register_blueprint(study_logs_bp, url_prefix='/study_logs')
app.register_blueprint(study_plan_bp, url_prefix='/study_plan')

if __name__ == '__main__':
    app.run(debug=True)

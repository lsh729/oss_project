from flask import Blueprint, request, jsonify
from .. import db, cursor

# Blueprint 설정
study_logs_bp = Blueprint('study_logs', __name__)

# 공부 시간 기록 API
@study_logs_bp.route('/logs', methods=['POST'])
def log_study_time():
    try:
        # 사용자가 보낸 데이터
        data = request.json
        sql = "INSERT INTO study_logs (subject_id, study_date, hours) VALUES (%s, %s, %s)"
        val = (data['subject_id'], data['study_date'], data['hours'])
        cursor.execute(sql, val)
        db.commit()
        return jsonify({"message": "Study log added successfully!"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

# 공부 통계 API
@study_logs_bp.route('/statistics', methods=['GET'])
def get_study_statistics():
    try:
        cursor.execute("""
            SELECT 
                s.subject_name, 
                l.subject_id, 
                SUM(l.hours) AS total_hours, 
                COUNT(DISTINCT l.study_date) AS days_studied
            FROM study_logs l
            JOIN subjects s ON l.subject_id = s.id
            GROUP BY l.subject_id, s.subject_name
        """)
        statistics = cursor.fetchall()
        return jsonify(statistics), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500


from flask import Blueprint, request, jsonify
from database import db, cursor

# Blueprint 설정
study_plan_bp = Blueprint('study_plan', __name__)

# 공부 계획 생성 API
@study_plan_bp.route('', methods=['POST'])
def generate_study_plan():
    try:
        # 사용자가 보낸 데이터
        data = request.json
        total_hours = data['total_hours']  # 총 공부 시간
        days_left = data['days_left']     # 남은 일수

        if days_left <= 0:
            return jsonify({"error": "Days left must be greater than zero."}), 400

        # MySQL에서 과목 정보 가져오기 (우선순위 내림차순)
        cursor.execute("SELECT subject_name, priority FROM subjects ORDER BY priority DESC")
        subjects = cursor.fetchall()

        if not subjects:
            return jsonify({"error": "No subjects found."}), 404

        # 과목별 공부 시간 계산
        hours_per_day = total_hours / days_left
        study_plan = []
        for subject in subjects:
            study_plan.append({
                "subject_name": subject['subject_name'],
                "hours_per_day": round(hours_per_day / len(subjects), 2)
            })

        return jsonify(study_plan), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

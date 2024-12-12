from flask import Blueprint, request, jsonify
from .. import db, cursor

subjects_bp = Blueprint('subjects', __name__)

@subjects_bp.route('', methods=['GET'])
def get_subjects():
    cursor.execute("SELECT * FROM subjects")
    subjects = cursor.fetchall()
    return jsonify(subjects), 200

@subjects_bp.route('', methods=['POST'])
def add_subject():
    data = request.json
    sql = "INSERT INTO subjects (subject_name, is_major, priority, exam_date) VALUES (%s, %s, %s, %s)"
    val = (data['subject_name'], data['is_major'], data['priority'], data['exam_date'])
    cursor.execute(sql, val)
    db.commit()
    return jsonify({"message": "Subject added successfully!"}), 200

@subjects_bp.route('/<int:subject_id>', methods=['PUT'])
def update_subject(subject_id):
    try:
        data = request.json
        sql = """
            UPDATE subjects 
            SET subject_name = %s, is_major = %s, priority = %s, exam_date = %s
            WHERE id = %s
        """
        val = (data['subject_name'], data['is_major'], data['priority'], data['exam_date'], subject_id)
        cursor.execute(sql, val)
        db.commit()
        return jsonify({"message": "Subject updated successfully!"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@subjects_bp.route('/<int:subject_id>', methods=['DELETE'])
def delete_subject(subject_id):
    try:
        sql = "DELETE FROM subjects WHERE id = %s"
        cursor.execute(sql, (subject_id,))
        db.commit()
        return jsonify({"message": "Subject deleted successfully!"}), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    
@subjects_bp.route('/exam-schedule', methods=['GET'])
def get_exam_schedule():
    try:
        cursor.execute("SELECT subject_name, exam_date FROM subjects ORDER BY exam_date ASC")
        schedule = cursor.fetchall()
        return jsonify(schedule), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500

        

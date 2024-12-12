from flask import Blueprint

# Blueprint 초기화
subjects_bp = Blueprint('subjects', __name__)
study_plan_bp = Blueprint('study_plan', __name__)
study_logs_bp = Blueprint('study_logs', __name__)

# 블루프린트 등록
from .subjects import subjects_bp
from .study_plan import study_plan_bp
from .study_logs import study_logs_bp

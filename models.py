class Subject:
    def __init__(self, id, subject_name, is_major, priority, exam_date):
        self.id = id
        self.subject_name = subject_name
        self.is_major = is_major
        self.priority = priority
        self.exam_date = exam_date

    def to_dict(self):
        return {
            "id": self.id,
            "subject_name": self.subject_name,
            "is_major": self.is_major,
            "priority": self.priority,
            "exam_date": self.exam_date
        }

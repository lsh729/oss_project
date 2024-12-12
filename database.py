import mysql.connector

db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="1234",
    database="study_planner",
    charset="utf8mb4"
)
cursor = db.cursor(dictionary=True)

-- Create students table
CREATE TABLE students_ex7 (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(100),
    total_score NUMERIC(6,2),   -- total exam points
    exams_taken INT
);

-- Insert sample students
INSERT INTO students_ex7 (student_name, total_score, exams_taken) VALUES
('Alice', 450, 5),
('Bob', 370, 5),
('Charlie', 280, 4),
('Diana', 500, 6),
('Evan', 310, 3);


SELECT * FROM students_ex7;

1. Show each student’s average score per exam (total_score / exams_taken).
SELECT student_id, student_name, (total_score/ exams_taken) as avg_score
FROM students_ex7;

2. Show the average score per exam, rounded to 2 decimal places.
SELECT student_id, student_name, ROUND(total_score/ exams_taken, 2) asg_score
FROM students_ex7;

3. Divide each student’s total score by 100 and show the result.
SELECT student_id, student_name, (total_score/100) as result
FROM students_ex7;

4. Find the student with the highest average score per exam.
SELECT student_id, student_name, ROUND(total_score/ exams_taken, 2)
FROM students_ex7
ORDER BY ROUND(AVG(total_score/ exams_taken),2) DESC 
LIMIT 1;

5. Show each student’s average score per exam, but rounded down to the nearest integer.
SELECT student_id, student_name, FLOOR(total_score/ exams_taken) as avg_score_floor
FROM students_ex7;

-- Create table students
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(100),
    major VARCHAR(50)
);

-- Create table courses
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100),
    department VARCHAR(50)
);

-- Create table enrollments (many-to-many)
CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id),
    course_id INT REFERENCES courses(course_id),
    semester VARCHAR(20)
);

-- Insert sample students
INSERT INTO students (student_name, major) VALUES
('Alice', 'Computer Science'),
('Bob', 'Mathematics'),
('Charlie', 'Computer Science'),
('Diana', 'Physics'),
('Evan', 'Mathematics');

-- Insert sample courses
INSERT INTO courses (course_name, department) VALUES
('Database Systems', 'Computer Science'),
('Calculus', 'Mathematics'),
('Linear Algebra', 'Mathematics'),
('Quantum Physics', 'Physics'),
('Algorithms', 'Computer Science');

-- Insert sample enrollments
INSERT INTO enrollments (student_id, course_id, semester) VALUES
(1, 1, 'Spring 2023'),
(1, 5, 'Spring 2023'),
(2, 2, 'Spring 2023'),
(2, 3, 'Fall 2023'),
(3, 1, 'Spring 2023'),
(3, 5, 'Fall 2023'),
(4, 4, 'Fall 2023'),
(5, 2, 'Spring 2023'),
(5, 3, 'Fall 2023');

SELECT * FROM students
SELECT * FROM courses
SELECT * FROM enrollments

1. Show all unique majors from the students table.
SELECT  DISTINCT major FROM students;

2. List all distinct departments from the courses table.
SELECT DISTINCT department FROM courses;

3. Find all distinct semesters from the enrollments table.
SELECT DISTINCT semester FROM enrollments;

4. Show all unique student IDs that appear in the enrollments table.
SELECT DISTINCT  student_id FROM enrollments;

5. Count how many distinct majors exist among students.
SELECT COUNT(DISTINCT major) as total_major
FROM students
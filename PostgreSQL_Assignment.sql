-- Active: 1729503552095@@127.0.0.1@5432@university_db@public

-- Create database
CREATE DATABASE university_db;

-- Create students table
CREATE TABLE students(
    student_id INTEGER PRIMARY KEY,
    student_name VARCHAR(60) NOT NULL,
    age INTEGER,
    email VARCHAR(100) UNIQUE NOT NULL,
    frontend_mark INTEGER,
    backend_mark INTEGER,
    status VARCHAR(40)
)

-- Create cousers table
CREATE TABLE courses (
    course_id INTEGER PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INTEGER
);

-- Create enrollment table
CREATE TABLE enrollment(
    enrollment_id INTEGER PRIMARY KEY,
    student_id INTEGER REFERENCES students(student_id),
    course_id INTEGER REFERENCES courses(course_id)
    
)

-- Insert demo data into students table
INSERT INTO students VALUES
(1, 'Sameer', 21, 'sameer@example.com', 48, 60, NULL),
(2, 'Zoya', 23, 'zoya@example.com', 52, 58, NULL),
(3, 'Nabil', 22, 'nabil@example.com', 37, 46, NULL),
(4, 'Riya', 24, 'riya@example.com', 68, 74, NULL),
(5, 'Aarav', 20, 'aarav@example.com', 55, 61, NULL),
(6, 'Priya', 22, 'priya@example.com', 42, 50, NULL),
(7, 'Kabir', 25, 'kabir@example.com', 71, 79, NULL),
(8, 'Alia', 23, 'alia@example.com', 60, 65, NULL),
(9, 'Arjun', 21, 'arjun@example.com', 58, 62, NULL),
(10, 'Meera', 20, 'meera@example.com', 47, 53, NULL),
(11, 'Anaya', 24, 'anaya@example.com', 62, 70, NULL),
(12, 'Ishan', 22, 'ishan@example.com', 36, 44, NULL),
(13, 'Naina', 23, 'naina@example.com', 65, 71, NULL),
(14, 'Raj', 21, 'raj@example.com', 50, 55, NULL),
(15, 'Sara', 24, 'sara@example.com', 59, 64, NULL);


-- Insert demo data into couses table
INSERT INTO courses (course_id, course_name, credits)
VALUES
(1, 'Next.js', 3),
(2, 'React.js', 4),
(3, 'Databases', 3),
(4, 'Prisma', 3),
(5, 'Node.js', 4),
(6, 'GraphQL', 3),
(7, 'TypeScript', 3),
(8, 'JavaScript', 3),
(9, 'CSS & HTML', 2),
(10, 'AWS Cloud Services', 4),
(11, 'Docker & Kubernetes', 4),
(12, 'Python', 3),
(13, 'Data Structures', 4),
(14, 'Machine Learning', 3),
(15, 'Agile Project Management', 2);


-- Insert demo data into enrolment table
INSERT INTO enrollment(enrollment_id, student_id, course_id)
VALUES
(1, 1, 1),
(2, 1, 2),
(3, 2, 1),
(4, 3, 2),
(5, 2, 3),
(6, 3, 1),
(7, 4, 4),
(8, 5, 2),
(9, 6, 3),
(10, 7, 1),
(11, 8, 4),
(12, 9, 3),
(13, 10, 2),
(14, 11, 4),
(15, 12, 1);

-- Query 1:
-- Insert a new student record with the following details:
INSERT INTO students (student_id, student_name, age, email, frontend_mark, backend_mark, status)
VALUES ( 16,'Fahim Hasan', 21, 'fahimhasan683031@gmail.com', 120, 80, NULL);

SELECT * FROM students;

-- Query 2:
-- Retrieve the names of all students who are enrolled in the course titled 'Next.js'.
SELECT s.student_name
FROM students as s
JOIN enrollment as e ON s.student_id = e.student_id
JOIN courses as c ON e.course_id = c.course_id
WHERE c.course_name = 'Next.js';

SELECT student_name
FROM students 
JOIN enrollment USING(student_id)
JOIN courses USING(course_id)
WHERE course_name = 'Next.js';


-- Query 3:
-- Update the status of the student with the highest total (frontend_mark + backend_mark) to 'Awarded'.
UPDATE students
SET status = 'Awarded'
WHERE student_id = (
    SELECT student_id FROM students
    ORDER BY (frontend_mark+backend_mark) DESC 
    LIMIT 1
);

SELECT * FROM students


-- Query 4:
-- Delete all courses that have no students enrolled.
DELETE FROM courses
WHERE course_id IN (
    SELECT course_id FROM courses 
    LEFT JOIN enrollment USING(course_id)
    WHERE student_id is NULL
);


-- Query 5:
-- Retrieve the names of students using a limit of 2, starting from the 3rd student.
SELECT student_name FROM students
OFFSET 2
LIMIT 2;


-- Query 6:
-- Retrieve the course names and the number of students enrolled in each course.
SELECT course_name, count(student_id) FROM courses
LEFT JOIN enrollment USING(course_id)
GROUP BY course_name;

-- Query 7:
-- Calculate and display the average age of all students.
SELECT avg(age) FROM students;


-- Query 8:
-- Retrieve the names of students whose email addresses contain 'example.com'.
SELECT student_name,email FROM students
WHERE  email LIKE '%example.com';
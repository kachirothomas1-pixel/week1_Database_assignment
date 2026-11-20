-- Week 1 Database Assignment
-- Topic: School Management System
-- Database: school_management
-- Run this script in MySQL Workbench or the MySQL Terminal.

-- 1. Create the database.
CREATE DATABASE IF NOT EXISTS school_management;

-- 2. Select the database to use.
USE school_management;

-- 3. Create the students table.
CREATE TABLE IF NOT EXISTS students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    date_of_birth DATE
);

-- 4. Create the teachers table.
CREATE TABLE IF NOT EXISTS teachers (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    department VARCHAR(100)
);

-- 5. Create the courses table.
-- Each course is assigned to one teacher.
CREATE TABLE IF NOT EXISTS courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    course_code VARCHAR(20) NOT NULL UNIQUE,
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

-- 6. Create the enrollments table.
-- This table connects students to the courses they take.
CREATE TABLE IF NOT EXISTS enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
    grade VARCHAR(2),
    UNIQUE (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- 7. Insert sample teachers.
INSERT INTO teachers (first_name, last_name, email, department)
VALUES
    ('Grace', 'Wanjiku', 'grace.wanjiku@example.com', 'Mathematics'),
    ('David', 'Otieno', 'david.otieno@example.com', 'Computer Science');

-- 8. Insert sample students.
INSERT INTO students (first_name, last_name, email, date_of_birth)
VALUES
    ('Brian', 'Kamau', 'brian.kamau@example.com', '2008-04-12'),
    ('Mary', 'Achieng', 'mary.achieng@example.com', '2007-09-23'),
    ('Peter', 'Mwangi', 'peter.mwangi@example.com', '2008-01-15');

-- 9. Insert sample courses.
INSERT INTO courses (course_name, course_code, teacher_id)
VALUES
    ('Mathematics', 'MATH101', 1),
    ('Introduction to Programming', 'CS101', 2);

-- 10. Enroll students in courses.
INSERT INTO enrollments (student_id, course_id, enrollment_date, grade)
VALUES
    (1, 1, '2026-01-12', 'A'),
    (1, 2, '2026-01-12', 'B'),
    (2, 1, '2026-01-13', 'A'),
    (3, 2, '2026-01-14', 'B');

-- 11. Display the records in each table.
SELECT * FROM students;
SELECT * FROM teachers;
SELECT * FROM courses;
SELECT * FROM enrollments;

-- 12. Example query: show students and the courses they are enrolled in.
SELECT
    students.first_name,
    students.last_name,
    courses.course_name,
    enrollments.enrollment_date,
    enrollments.grade
FROM enrollments
JOIN students ON enrollments.student_id = students.student_id
JOIN courses ON enrollments.course_id = courses.course_id
ORDER BY students.last_name, courses.course_name;

-- End of Week 1 Database Assignment.

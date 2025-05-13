-- PROJECT: Student Course Enrollment System
-- CREATE DATABASE
CREATE DATABASE IF NOT EXISTS student_enrollment_db;
USE student_enrollment_db;

-- TABLE: Students
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    enrollment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Automatically uses current timestamp
);

-- TABLE: Courses
CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    course_code VARCHAR(10) UNIQUE NOT NULL,
    credit_hours INT CHECK (credit_hours > 0)
);

-- TABLE: Instructors
CREATE TABLE instructors (
    instructor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    department VARCHAR(50)
);

-- TABLE: Course Offerings (Many-to-Many: courses <-> instructors)
CREATE TABLE course_offerings (
    offering_id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT NOT NULL,
    instructor_id INT NOT NULL,
    semester VARCHAR(20) NOT NULL,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE,
    FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id) ON DELETE CASCADE
);

-- TABLE: Enrollments (Many-to-Many: students <-> course_offerings)
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    offering_id INT NOT NULL,
    enrollment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    grade VARCHAR(2),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (offering_id) REFERENCES course_offerings(offering_id) ON DELETE CASCADE
);

-- INSERT MOCK DATA

-- Students
INSERT INTO students (full_name, email)
VALUES 
('Alice Johnson', 'alice@example.com'),
('Bob Smith', 'bob@example.com'),
('Clara Lee', 'clara@example.com');

-- Courses
INSERT INTO courses (course_name, course_code, credit_hours)
VALUES 
('Database Systems', 'DBS101', 3),
('Computer Networks', 'NET201', 4),
('Operating Systems', 'OS301', 3);

-- Instructors
INSERT INTO instructors (name, email, department)
VALUES 
('Dr. John Doe', 'jdoe@university.edu', 'Computer Science'),
('Prof. Jane Roe', 'jroe@university.edu', 'Information Technology');

-- Course Offerings
INSERT INTO course_offerings (course_id, instructor_id, semester)
VALUES 
(1, 1, 'Fall 2024'), -- DBS101 by Dr. John Doe
(2, 2, 'Fall 2024'), -- NET201 by Prof. Jane Roe
(3, 1, 'Spring 2025'); -- OS301 by Dr. John Doe

-- Enrollments
INSERT INTO enrollments (student_id, offering_id, grade)
VALUES 
(1, 1, 'A'),
(1, 2, 'B'),
(2, 1, 'A'),
(3, 3, 'B+');



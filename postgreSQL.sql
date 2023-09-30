-- Active: 1696053613195@@127.0.0.1@5432@assignment_7_postgresql@public
-- Create the "students" table
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY ,
    student_name VARCHAR(255),
    age INTEGER,
    email VARCHAR(255),
    backend_mark INTEGER,
    frontend_mark INTEGER,
    status VARCHAR(255)
);

-- Create the "courses" table
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(255),
    credits INTEGER
);

-- Create the "enrollment" table
CREATE TABLE enrollment (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INTEGER,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    course_id INTEGER,
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Sample Data Insertion

-- Insert sample data into the "students" table
INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status)
VALUES
    ('Alice', 22, 'alice@example.com', 55, 57, NULL),
    ('Bob', 21, 'bob@example.com', 34, 45, NULL),
    ('Charlie', 23, 'charlie@example.com', 60, 59, NULL),
    ('David', 20, 'david@example.com', 40, 49, NULL),
    ('Eve', 24, 'newemail@example.com', 45, 34, NULL),
    ('Rahim', 23, 'rahim@gmail.com', 46, 42, NULL);

    SELECT * FROM students;

    -- Insert sample data into the "courses" table
INSERT INTO courses (course_name, credits)
VALUES
    ('Next.js', 3),
    ('React.js', 4),
    ('Databases', 3),
    ('Prisma', 3);

SELECT * FROM courses

-- Insert sample data into the "enrollment" table
INSERT INTO enrollment (student_id, course_id)
VALUES
    (1, 1),
    (1, 2),
    (2, 1),
    (3, 2);


SELECT * FROM enrollment

-- Queries

SELECT student_name FROM students 
WHERE student_id IN (
    SELECT student_id
    FROM enrollment
    WHERE course_id = (SELECT course_id FROM courses WHERE course_name = 'Next.js')
);

-- Query 3: Update the status of the student with the highest total (frontend_mark + backend_mark) mark to 'Awarded'.
UPDATE students
SET status = 'Awarded'
WHERE student_id = (
    SELECT student_id
    FROM students
    ORDER BY frontend_mark + backend_mark DESC
    LIMIT 1
);

SELECT * FROM courses

-- Query 4: Delete all courses that have no students enrolled.
DELETE FROM courses
WHERE course_id NOT IN (SELECT DISTINCT course_id FROM enrollment);


-- Query 5: Retrieve the names of students using a limit of 2, starting from the 3rd student.
SELECT student_name
FROM students
LIMIT 2 OFFSET 2;

-- Query 6: Retrieve the course names and the number of students enrolled in each course.
SELECT c.course_name, COUNT(e.student_id) AS students_enrolled
FROM courses c
LEFT JOIN enrollment e ON c.course_id = e.course_id
GROUP BY c.course_name;

-- Query 7: Calculate and display the average age of all students.
SELECT AVG(age) AS average_age
FROM students;

-- Query 8: Retrieve the names of students whose email addresses contain 'example.com'.
SELECT student_name
FROM students
WHERE email LIKE '%example.com%';
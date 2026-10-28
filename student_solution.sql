CREATE DATABASE IF NOT EXISTS CollegeDB;
USE CollegeDB;

DROP TABLE IF EXISTS StudentCourse;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Faculty;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Department;

-- Create Department table
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

-- Create Faculty table
CREATE TABLE Faculty (
    FacultyID INT PRIMARY KEY,
    FacultyName VARCHAR(100),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID)
        REFERENCES Department(DepartmentID)
);

-- Create Student table
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100)
);

-- Create Course table
CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    FacultyID INT,
    FOREIGN KEY (FacultyID)
        REFERENCES Faculty(FacultyID)
);

-- Create StudentCourse table
CREATE TABLE StudentCourse (
    StudentID INT,
    CourseID INT,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID)
        REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID)
        REFERENCES Course(CourseID)
);

-- Insert 2 Department records
INSERT INTO Department VALUES
(10, 'Computer Science'),
(20, 'Mathematics');

-- Insert 2 Faculty records
INSERT INTO Faculty VALUES
(101, 'Ravi', 10),
(102, 'Priya', 20);

-- Insert 3 Student records
INSERT INTO Student VALUES
(1001, 'Arun'),
(1002, 'Priya'),
(1003, 'Kumar');

-- Insert 3 Course records
INSERT INTO Course VALUES
(201, 'Database Systems', 101),
(202, 'Data Structures', 101),
(203, 'Mathematics', 102);

-- Insert 4 StudentCourse records
INSERT INTO StudentCourse VALUES
(1001, 201),
(1001, 202),
(1002, 203),
(1003, 201);

-- Display normalized data using JOIN
SELECT
    s.StudentID,
    s.StudentName,
    c.CourseID,
    c.CourseName,
    f.FacultyName,
    d.DepartmentName
FROM Student s
JOIN StudentCourse sc
    ON s.StudentID = sc.StudentID
JOIN Course c
    ON sc.CourseID = c.CourseID
JOIN Faculty f
    ON c.FacultyID = f.FacultyID
JOIN Department d
    ON f.DepartmentID = d.DepartmentID
ORDER BY s.StudentID, c.CourseID;

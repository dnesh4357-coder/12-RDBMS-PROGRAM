USE CollegeDB;

-- Remove existing tables
DROP TABLE IF EXISTS Enrollment;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Faculty;
DROP TABLE IF EXISTS Department;

-- Department Entity
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL
);

-- Student Entity
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50) NOT NULL,
    DepartmentID INT NOT NULL,
    FOREIGN KEY (DepartmentID)
        REFERENCES Department(DepartmentID)
);

-- Faculty Entity
CREATE TABLE Faculty (
    FacultyID INT PRIMARY KEY,
    FacultyName VARCHAR(50) NOT NULL
);

-- Course Entity
CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    FacultyID INT NOT NULL,
    FOREIGN KEY (FacultyID)
        REFERENCES Faculty(FacultyID)
);

-- Enrollment Entity
-- Resolves the M:N relationship
-- between Student and Course
CREATE TABLE Enrollment (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,

    FOREIGN KEY (StudentID)
        REFERENCES Student(StudentID),

    FOREIGN KEY (CourseID)
        REFERENCES Course(CourseID),

    UNIQUE (StudentID, CourseID)
);

-- Department Records
INSERT INTO Department
(DepartmentID, DepartmentName)
VALUES
(101, 'Computer Science'),
(102, 'Information Technology'),
(103, 'Electronics');

-- Student Records
INSERT INTO Student
(StudentID, StudentName, DepartmentID)
VALUES
(1001, 'Arun', 101),
(1002, 'Divya', 102),
(1003, 'Karthik', 101),
(1004, 'Nisha', 103);

-- Faculty Records
INSERT INTO Faculty
(FacultyID, FacultyName)
VALUES
(501, 'Dr. Kumar'),
(502, 'Dr. Priya'),
(503, 'Dr. Ravi');

-- Course Records
INSERT INTO Course
(CourseID, CourseName, FacultyID)
VALUES
(201, 'Database Systems', 501),
(202, 'Python Programming', 502),
(203, 'Operating Systems', 501),
(204, 'Computer Networks', 503);

-- Enrollment Records
INSERT INTO Enrollment
(EnrollmentID, StudentID, CourseID)
VALUES
(1, 1001, 201),
(2, 1001, 203),
(3, 1002, 202),
(4, 1003, 201),
(5, 1003, 203),
(6, 1004, 204);

-- Display Department and Students
SELECT
    d.DepartmentName,
    s.StudentName
FROM Department d
INNER JOIN Student s
    ON d.DepartmentID = s.DepartmentID;

-- Display Faculty and Courses
SELECT
    f.FacultyName,
    c.CourseName
FROM Faculty f
INNER JOIN Course c
    ON f.FacultyID = c.FacultyID;

-- Display Students and their Courses
SELECT
    s.StudentName,
    c.CourseName
FROM Student s
INNER JOIN Enrollment e
    ON s.StudentID = e.StudentID
INNER JOIN Course c
    ON e.CourseID = c.CourseID;

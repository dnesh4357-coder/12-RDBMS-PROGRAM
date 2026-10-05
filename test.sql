USE CollegeDB;

-- Test 1: Check required tables
SELECT
    CASE
        WHEN COUNT(*) = 5
        THEN 'PASS: All required tables exist'
        ELSE 'FAIL: Required tables are missing'
    END AS TestResult
FROM information_schema.tables
WHERE table_schema = 'CollegeDB'
AND table_name IN
(
    'Department',
    'Student',
    'Faculty',
    'Course',
    'Enrollment'
);


-- Test 2: Department Primary Key
SELECT
    CASE
        WHEN COUNT(*) = 1
        THEN 'PASS: DepartmentID is Primary Key'
        ELSE 'FAIL: DepartmentID Primary Key missing'
    END AS TestResult
FROM information_schema.key_column_usage
WHERE table_schema = 'CollegeDB'
AND table_name = 'Department'
AND column_name = 'DepartmentID'
AND constraint_name = 'PRIMARY';


-- Test 3: Student Primary Key
SELECT
    CASE
        WHEN COUNT(*) = 1
        THEN 'PASS: StudentID is Primary Key'
        ELSE 'FAIL: StudentID Primary Key missing'
    END AS TestResult
FROM information_schema.key_column_usage
WHERE table_schema = 'CollegeDB'
AND table_name = 'Student'
AND column_name = 'StudentID'
AND constraint_name = 'PRIMARY';


-- Test 4: Faculty Primary Key
SELECT
    CASE
        WHEN COUNT(*) = 1
        THEN 'PASS: FacultyID is Primary Key'
        ELSE 'FAIL: FacultyID Primary Key missing'
    END AS TestResult
FROM information_schema.key_column_usage
WHERE table_schema = 'CollegeDB'
AND table_name = 'Faculty'
AND column_name = 'FacultyID'
AND constraint_name = 'PRIMARY';


-- Test 5: Course Primary Key
SELECT
    CASE
        WHEN COUNT(*) = 1
        THEN 'PASS: CourseID is Primary Key'
        ELSE 'FAIL: CourseID Primary Key missing'
    END AS TestResult
FROM information_schema.key_column_usage
WHERE table_schema = 'CollegeDB'
AND table_name = 'Course'
AND column_name = 'CourseID'
AND constraint_name = 'PRIMARY';


-- Test 6: Enrollment Primary Key
SELECT
    CASE
        WHEN COUNT(*) = 1
        THEN 'PASS: EnrollmentID is Primary Key'
        ELSE 'FAIL: EnrollmentID Primary Key missing'
    END AS TestResult
FROM information_schema.key_column_usage
WHERE table_schema = 'CollegeDB'
AND table_name = 'Enrollment'
AND column_name = 'EnrollmentID'
AND constraint_name = 'PRIMARY';


-- Test 7: Department 1:N Student relationship
SELECT
    CASE
        WHEN COUNT(*) >= 1
        THEN 'PASS: Department-Student relationship exists (1:N)'
        ELSE 'FAIL: Department-Student relationship missing'
    END AS TestResult
FROM information_schema.key_column_usage
WHERE table_schema = 'CollegeDB'
AND table_name = 'Student'
AND column_name = 'DepartmentID'
AND referenced_table_name = 'Department'
AND referenced_column_name = 'DepartmentID';


-- Test 8: Faculty 1:N Course relationship
SELECT
    CASE
        WHEN COUNT(*) >= 1
        THEN 'PASS: Faculty-Course relationship exists (1:N)'
        ELSE 'FAIL: Faculty-Course relationship missing'
    END AS TestResult
FROM information_schema.key_column_usage
WHERE table_schema = 'CollegeDB'
AND table_name = 'Course'
AND column_name = 'FacultyID'
AND referenced_table_name = 'Faculty'
AND referenced_column_name = 'FacultyID';


-- Test 9: Student-Enrollment relationship
SELECT
    CASE
        WHEN COUNT(*) >= 1
        THEN 'PASS: Student-Enrollment relationship exists'
        ELSE 'FAIL: Student-Enrollment relationship missing'
    END AS TestResult
FROM information_schema.key_column_usage
WHERE table_schema = 'CollegeDB'
AND table_name = 'Enrollment'
AND column_name = 'StudentID'
AND referenced_table_name = 'Student'
AND referenced_column_name = 'StudentID';


-- Test 10: Course-Enrollment relationship
SELECT
    CASE
        WHEN COUNT(*) >= 1
        THEN 'PASS: Course-Enrollment relationship exists'
        ELSE 'FAIL: Course-Enrollment relationship missing'
    END AS TestResult
FROM information_schema.key_column_usage
WHERE table_schema = 'CollegeDB'
AND table_name = 'Enrollment'
AND column_name = 'CourseID'
AND referenced_table_name = 'Course'
AND referenced_column_name = 'CourseID';


-- Test 11: Check sample data
SELECT
    CASE
        WHEN
            (SELECT COUNT(*) FROM Department) >= 3
            AND
            (SELECT COUNT(*) FROM Student) >= 4
            AND
            (SELECT COUNT(*) FROM Faculty) >= 3
            AND
            (SELECT COUNT(*) FROM Course) >= 4
            AND
            (SELECT COUNT(*) FROM Enrollment) >= 6
        THEN 'PASS: Sample data exists'
        ELSE 'FAIL: Sample data is incomplete'
    END AS TestResult;


-- Test 12: Verify M:N relationship
-- One student should be able to enroll in multiple courses
SELECT
    CASE
        WHEN COUNT(*) >= 1
        THEN 'PASS: Student can enroll in multiple courses'
        ELSE 'FAIL: M:N relationship not implemented correctly'
    END AS TestResult
FROM Enrollment
GROUP BY StudentID
HAVING COUNT(*) > 1;


-- Test 13: Verify M:N relationship
-- One course should be able to have multiple students
SELECT
    CASE
        WHEN COUNT(*) >= 1
        THEN 'PASS: Course can have multiple students'
        ELSE 'FAIL: M:N relationship not implemented correctly'
    END AS TestResult
FROM Enrollment
GROUP BY CourseID
HAVING COUNT(*) > 1;


-- Test 14: Check Student-Course uniqueness
SELECT
    CASE
        WHEN COUNT(*) >= 1
        THEN 'PASS: Student-Course enrollment is uniquely maintained'
        ELSE 'FAIL: Student-Course uniqueness missing'
    END AS TestResult
FROM information_schema.table_constraints
WHERE table_schema = 'CollegeDB'
AND table_name = 'Enrollment'
AND constraint_type = 'UNIQUE';

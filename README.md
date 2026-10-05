# College Management System – ER Diagram

## Question

Draw an ER diagram for a College Management System including the following entities:

- Student
- Course
- Faculty
- Department

Use the following relationships:

1. One Department has many Students.
2. One Faculty handles many Courses.
3. Many Students can enroll in many Courses.

## Relationships

### 1. Department – Student

One Department has many Students.

**Cardinality:** 1 : N

```text
Department 1 ───────── N Student

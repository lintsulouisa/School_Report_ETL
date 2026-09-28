/* ==========================================================================
   Script:  prelim_science_marks_by_grade.sql
   Purpose: Split the combined Bronze.prelim_science_students_marks table
            into separate tables for Grade 10, 11 and 12.
   Steps:   1. Inspect the source data
            2. Adjust the precision of average_mark in the source table
            3. Create one table per grade
            4. Load each grade table from the source table
            5. Verify the results
   ========================================================================== */


/* --------------------------------------------------------------------------
   1. Inspect the source data (sorted by grade)
   -------------------------------------------------------------------------- */
SELECT *
FROM   Bronze.prelim_science_students_marks
ORDER BY grade;


/* --------------------------------------------------------------------------
   2. Change average_mark to 1 decimal place (max 999.9)
   NOTE: In SQL Server, ALTER COLUMN resets nullability if it is not stated,
         so NULL is stated explicitly. Change to NOT NULL if that is required.
   -------------------------------------------------------------------------- */
ALTER TABLE Bronze.prelim_science_students_marks
    ALTER COLUMN average_mark DECIMAL(4,1) NULL;


/* --------------------------------------------------------------------------
   3. Create one table per grade (all three share the same structure)
   -------------------------------------------------------------------------- */

-- Grade 10
CREATE TABLE Bronze.prelim_science_students_marks_grade10 (
    student_id                  VARCHAR(50),
    student_name                VARCHAR(255),
    grade                       VARCHAR(10),
    mathematics_mark            DECIMAL(5,2),
    physical_science_mark       DECIMAL(5,2),
    life_sciences_mark          DECIMAL(5,2),
    english_home_language_mark  DECIMAL(5,2),
    life_orientation_mark       DECIMAL(5,2),
    information_technology_mark DECIMAL(5,2),
    agricultural_science_mark   DECIMAL(5,2),
    total_mark                  DECIMAL(6,2),
    average_mark                DECIMAL(5,2)
);

-- Grade 11
CREATE TABLE Bronze.prelim_science_students_marks_grade11 (
    student_id                  VARCHAR(50),
    student_name                VARCHAR(255),
    grade                       VARCHAR(10),
    mathematics_mark            DECIMAL(5,2),
    physical_science_mark       DECIMAL(5,2),
    life_sciences_mark          DECIMAL(5,2),
    english_home_language_mark  DECIMAL(5,2),
    life_orientation_mark       DECIMAL(5,2),
    information_technology_mark DECIMAL(5,2),
    agricultural_science_mark   DECIMAL(5,2),
    total_mark                  DECIMAL(6,2),
    average_mark                DECIMAL(5,2)
);

-- Grade 12
CREATE TABLE Bronze.prelim_science_students_marks_grade12 (
    student_id                  VARCHAR(50),
    student_name                VARCHAR(255),
    grade                       VARCHAR(10),
    mathematics_mark            DECIMAL(5,2),
    physical_science_mark       DECIMAL(5,2),
    life_sciences_mark          DECIMAL(5,2),
    english_home_language_mark  DECIMAL(5,2),
    life_orientation_mark       DECIMAL(5,2),
    information_technology_mark DECIMAL(5,2),
    agricultural_science_mark   DECIMAL(5,2),
    total_mark                  DECIMAL(6,2),
    average_mark                DECIMAL(5,2)
);


/* --------------------------------------------------------------------------
   4. Load each grade table from the source table
   Columns are listed explicitly in the SELECT (instead of SELECT *) so the
   load still works if the column order in the source table ever changes.
   -------------------------------------------------------------------------- */

-- Grade 10
INSERT INTO Bronze.prelim_science_students_marks_grade10 (
    student_id, student_name, grade,
    mathematics_mark, physical_science_mark, life_sciences_mark,
    english_home_language_mark, life_orientation_mark,
    information_technology_mark, agricultural_science_mark,
    total_mark, average_mark
)
SELECT
    student_id, student_name, grade,
    mathematics_mark, physical_science_mark, life_sciences_mark,
    english_home_language_mark, life_orientation_mark,
    information_technology_mark, agricultural_science_mark,
    total_mark, average_mark
FROM   Bronze.prelim_science_students_marks
WHERE  grade LIKE '%10%';

-- Grade 11
INSERT INTO Bronze.prelim_science_students_marks_grade11 (
    student_id, student_name, grade,
    mathematics_mark, physical_science_mark, life_sciences_mark,
    english_home_language_mark, life_orientation_mark,
    information_technology_mark, agricultural_science_mark,
    total_mark, average_mark
)
SELECT
    student_id, student_name, grade,
    mathematics_mark, physical_science_mark, life_sciences_mark,
    english_home_language_mark, life_orientation_mark,
    information_technology_mark, agricultural_science_mark,
    total_mark, average_mark
FROM   Bronze.prelim_science_students_marks
WHERE  grade LIKE '%11%';

-- Grade 12
INSERT INTO Bronze.prelim_science_students_marks_grade12 (
    student_id, student_name, grade,
    mathematics_mark, physical_science_mark, life_sciences_mark,
    english_home_language_mark, life_orientation_mark,
    information_technology_mark, agricultural_science_mark,
    total_mark, average_mark
)
SELECT
    student_id, student_name, grade,
    mathematics_mark, physical_science_mark, life_sciences_mark,
    english_home_language_mark, life_orientation_mark,
    information_technology_mark, agricultural_science_mark,
    total_mark, average_mark
FROM   Bronze.prelim_science_students_marks
WHERE  grade LIKE '%12%';


/* --------------------------------------------------------------------------
   5. Verify the results
   The three grade tables together should hold the same rows as the source.
   -------------------------------------------------------------------------- */
SELECT * FROM Bronze.prelim_science_students_marks_grade10;
SELECT * FROM Bronze.prelim_science_students_marks_grade11;
SELECT * FROM Bronze.prelim_science_students_marks_grade12;
SELECT * FROM Bronze.prelim_science_students_marks;
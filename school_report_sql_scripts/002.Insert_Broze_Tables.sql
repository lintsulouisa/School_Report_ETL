
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


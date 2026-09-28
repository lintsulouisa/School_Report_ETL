
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


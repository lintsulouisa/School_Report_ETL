/* ==========================================================================
   Prelim Science Students Marks
   --------------------------------------------------------------------------
   Purpose : Create the silver-layer tables for preliminary science marks
             and load new records from the bronze (staging) layer.
   Source  : [Ekurhuleni_West_College_stg].bronze.*
   Target  : silver.* (current database, i.e. the data warehouse)
   Load    : Incremental - only students not already in silver are inserted
             (matched on student_id), so reruns will not create duplicates.
   ========================================================================== */


/* --------------------------------------------------------------------------
   1. Create tables
   Four tables with an identical structure: one for all grades combined,
   and one each for grades 10, 11 and 12.
   -------------------------------------------------------------------------- */

-- All grades combined
create table silver.prelim_science_students_marks (
    -- Student details
    student_id                  varchar(50),    -- unique student identifier (used for de-duplication)
    student_name                varchar(255),
    grade                       varchar(10),    -- grade / class, e.g. '12A'

    -- Subject marks (percentages, up to 999.99)
    mathematics_mark            decimal(5,2),
    physical_science_mark       decimal(5,2),
    life_sciences_mark          decimal(5,2),
    english_home_language_mark  decimal(5,2),
    life_orientation_mark       decimal(5,2),
    information_technology_mark decimal(5,2),
    agricultural_science_mark   decimal(5,2),

    -- Calculated fields
    total_mark                  decimal(6,2),   -- sum of subject marks (wider type to hold the total)
    average_mark                decimal(5,2)    -- average across subjects
);

-- Grade 10 only
create table silver.prelim_science_students_marks_grade10 (
    student_id                  varchar(50),
    student_name                varchar(255),
    grade                       varchar(10),
    mathematics_mark            decimal(5,2),
    physical_science_mark       decimal(5,2),
    life_sciences_mark          decimal(5,2),
    english_home_language_mark  decimal(5,2),
    life_orientation_mark       decimal(5,2),
    information_technology_mark decimal(5,2),
    agricultural_science_mark   decimal(5,2),
    total_mark                  decimal(6,2),
    average_mark                decimal(5,2)
);

-- Grade 11 only
create table silver.prelim_science_students_marks_grade11 (
    student_id                  varchar(50),
    student_name                varchar(255),
    grade                       varchar(10),
    mathematics_mark            decimal(5,2),
    physical_science_mark       decimal(5,2),
    life_sciences_mark          decimal(5,2),
    english_home_language_mark  decimal(5,2),
    life_orientation_mark       decimal(5,2),
    information_technology_mark decimal(5,2),
    agricultural_science_mark   decimal(5,2),
    total_mark                  decimal(6,2),
    average_mark                decimal(5,2)
);

-- Grade 12 only
create table silver.prelim_science_students_marks_grade12 (
    student_id                  varchar(50),
    student_name                varchar(255),
    grade                       varchar(10),
    mathematics_mark            decimal(5,2),
    physical_science_mark       decimal(5,2),
    life_sciences_mark          decimal(5,2),
    english_home_language_mark  decimal(5,2),
    life_orientation_mark       decimal(5,2),
    information_technology_mark decimal(5,2),
    agricultural_science_mark   decimal(5,2),
    total_mark                  decimal(6,2),
    average_mark                decimal(5,2)
);


/* --------------------------------------------------------------------------
   2. Load new records from bronze into silver
   Each insert follows the same pattern:
     - select every row from the matching bronze (staging) table
     - keep only rows whose student_id is not already in the silver table
       (the "not exists" check makes the load incremental)
   -------------------------------------------------------------------------- */

-- All grades: load every new student from the combined bronze table
insert into silver.prelim_science_students_marks
(
    student_id, student_name, grade,
    mathematics_mark, physical_science_mark, life_sciences_mark,
    english_home_language_mark, life_orientation_mark,
    information_technology_mark, agricultural_science_mark,
    total_mark, average_mark
)
select
    a.student_id, a.student_name, a.grade,
    a.mathematics_mark, a.physical_science_mark, a.life_sciences_mark,
    a.english_home_language_mark, a.life_orientation_mark,
    a.information_technology_mark, a.agricultural_science_mark,
    a.total_mark, a.average_mark
from [Ekurhuleni_West_College_stg].bronze.prelim_science_students_marks as a
where not exists (
    -- Skip students already loaded into silver
    select 1
    from [Ekurhuleni_West_College_dhw].silver.prelim_science_students_marks as b
    where b.student_id = a.student_id
);


-- Grade 10: load new students from the grade 10 bronze table
insert into silver.prelim_science_students_marks_grade10
(
    student_id, student_name, grade,
    mathematics_mark, physical_science_mark, life_sciences_mark,
    english_home_language_mark, life_orientation_mark,
    information_technology_mark, agricultural_science_mark,
    total_mark, average_mark
)
select
    a.student_id, a.student_name, a.grade,
    a.mathematics_mark, a.physical_science_mark, a.life_sciences_mark,
    a.english_home_language_mark, a.life_orientation_mark,
    a.information_technology_mark, a.agricultural_science_mark,
    a.total_mark, a.average_mark
from [Ekurhuleni_West_College_stg].bronze.prelim_science_students_marks_grade10 as a
where not exists (
    -- Skip students already loaded into silver
    select 1
    from [Ekurhuleni_West_College_dhw].silver.prelim_science_students_marks_grade10 as b
    where b.student_id = a.student_id
);


-- Grade 11: load new students from the grade 11 bronze table
insert into silver.prelim_science_students_marks_grade11
(
    student_id, student_name, grade,
    mathematics_mark, physical_science_mark, life_sciences_mark,
    english_home_language_mark, life_orientation_mark,
    information_technology_mark, agricultural_science_mark,
    total_mark, average_mark
)
select
    a.student_id, a.student_name, a.grade,
    a.mathematics_mark, a.physical_science_mark, a.life_sciences_mark,
    a.english_home_language_mark, a.life_orientation_mark,
    a.information_technology_mark, a.agricultural_science_mark,
    a.total_mark, a.average_mark
from [Ekurhuleni_West_College_stg].bronze.prelim_science_students_marks_grade11 as a
where not exists (
    -- Skip students already loaded into silver
    select 1
    from [Ekurhuleni_West_College_dhw].silver.prelim_science_students_marks_grade11 as b
    where b.student_id = a.student_id
);


-- Grade 12: load new students, restricted to classes 12A and 12B
insert into silver.prelim_science_students_marks_grade12
(
    student_id, student_name, grade,
    mathematics_mark, physical_science_mark, life_sciences_mark,
    english_home_language_mark, life_orientation_mark,
    information_technology_mark, agricultural_science_mark,
    total_mark, average_mark
)
select
    a.student_id, a.student_name, a.grade,
    a.mathematics_mark, a.physical_science_mark, a.life_sciences_mark,
    a.english_home_language_mark, a.life_orientation_mark,
    a.information_technology_mark, a.agricultural_science_mark,
    a.total_mark, a.average_mark
from [Ekurhuleni_West_College_stg].bronze.prelim_science_students_marks_grade12 as a
where a.grade in ('12A', '12B')     -- only these grade 12 classes are loaded
  and not exists (
    -- Skip students already loaded into silver
    select 1
    from [Ekurhuleni_West_College_dhw].silver.prelim_science_students_marks_grade12 as b
    where b.student_id = a.student_id
);


/* --------------------------------------------------------------------------
   3. Checks
   Quick queries to verify the loads.
   -------------------------------------------------------------------------- */

-- Grade 12 students in the combined table (any class containing '12')
select * from silver.prelim_science_students_marks where grade like '%12%';

-- Review the contents of each silver table
select * from silver.prelim_science_students_marks;          -- all grades
select * from silver.prelim_science_students_marks_grade10;   -- grade 10
select * from silver.prelim_science_students_marks_grade11;   -- grade 11
select * from silver.prelim_science_students_marks_grade12;   -- grade 12

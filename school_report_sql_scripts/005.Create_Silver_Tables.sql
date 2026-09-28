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



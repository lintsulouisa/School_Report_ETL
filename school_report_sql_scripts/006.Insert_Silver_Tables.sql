
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


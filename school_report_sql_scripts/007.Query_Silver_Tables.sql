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


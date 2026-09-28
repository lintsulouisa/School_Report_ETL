
/* --------------------------------------------------------------------------
   5. Verify the results
   The three grade tables together should hold the same rows as the source.
   -------------------------------------------------------------------------- */
SELECT * FROM Bronze.prelim_science_students_marks_grade10;
SELECT * FROM Bronze.prelim_science_students_marks_grade11;
SELECT * FROM Bronze.prelim_science_students_marks_grade12;
SELECT * FROM Bronze.prelim_science_students_marks;
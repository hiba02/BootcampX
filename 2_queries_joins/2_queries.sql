SELECT sum(assignment_submissions.duration) as total_duration
FROM assignment_submissions
JOIN students ON CAST(students.id AS int) = CAST(student_id AS int)
WHERE students.name = 'Ibrahim Schimmel';


SELECT sum(assignment_submissions.duration) as total_duration
FROM assignment_submissions
JOIN students ON students.id = CAST(student_id as int)
JOIN cohorts ON cohorts.id = CAST(cohort_id as int)
WHERE cohorts.name = 'FEB12';
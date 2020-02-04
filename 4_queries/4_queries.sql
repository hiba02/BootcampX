/*
SELECT count(assistance_requests.*) 
FROM assistance_requests 
JOIN teachers ON teachers.id = teacher_id 
WHERE teachers.name = "Waylon Boehm";
GROUP BY teacher_id;
*/


SELECT count(assistance_requests.*) as total_assistances, teachers.name
FROM assistance_requests
JOIN teachers ON teachers.id = teacher_id
WHERE teachers.name = 'Waylon Boehm'
GROUP BY name;


SELECT count(assistance_requests.*), students.name 
FROM assistance_requests
JOIN students ON student_id = students.id 
WHERE students.name = 'Elliot Dickinson'
GROUP BY students.name;

SELECT teachers.name as teacher, students.name as student, assignments.name as assignment, (completed_at-started_at) as duration 
FROM assistance_requests
JOIN teachers ON teacher_id = teachers.id
JOIN students ON student_id = students.id 
JOIN assignments ON assignment_id = assignments.id
ORDER BY duration;

SELECT AVG(completed_at-started_at) as average_assistance_request_duration 
FROM assistance_requests;


SELECT cohorts.name, AVG(completed_at-started_at) as average_assistance_request_duration
FROM assistance_requests
JOIN students ON student_id = students.id
JOIN cohorts ON cohorts.id = cohort_id
GROUP BY cohorts.name
ORDER BY average_assistance_request_duration;


/*
SELECT cohorts.name, completed_at-started_at as average_assistance_request_duration
FROM assistance_requests
JOIN students ON student_id = students.id 
JOIN cohorts ON cohorts.id = cohort_id
GROUP BY cohorts.name
HAVING MAX(average_assistance_request_duration);
*/



SELECT AVG(started_at-created_at) as average_waite_time
FROM assistance_requests;


SELECT cohorts.name, SUM(completed_at-started_at) as total_duration
FROM assistance_requests
JOIN students ON student_id = students.id 
JOIN cohorts ON cohort_id = cohorts.id 
GROUP BY cohorts.name
ORDER BY total_duration;





SELECT AVG(completed_at-started_at) as average_total_duration 
FROM assistance_requests
JOIN students ON student_id = students.id 
JOIN cohorts ON cohort_id = cohorts.id 
GROUP BY cohorts.name;



SELECT avg (total_duration) as average_total_duration
FROM (
  SELECT cohorts.name as cohort, sum(completed_at-started_at) as total_duration
  FROM assistance_requests
  JOIN students ON students.id = student_id
  JOIN cohorts on cohorts.id = cohort_id
  GROUP BY cohorts.name
  ORDER BY total_duration
) as total_durations;




SELECT assignments.id, assignments.name, assignments.day, assignments.chapter, count(assistance_requests.*) AS total_requests
FROM assistance_requests
JOIN assignments
ON assignments.id = assignment_id
GROUP BY assignments.id
ORDER BY total_requests DESC;



SELECT day, count(name), SUM(duration)
FROM assignments 
GROUP BY day 
ORDER BY day;





SELECT DISTINCT(teachers.name) as teacher, cohorts.name as cohort 
FROM teachers
JOIN assistance_requests on teachers.id = assistance_requests.teacher_id
JOIN students on students.id = assistance_requests.student_id
JOIN cohorts on cohorts.id = students.id
WHERE cohorts.name='JUL02'
ORDER BY teachers.name;








SELECT teachers.name as teacher, cohorts.name as cohort, count(assistance_requests) as total_assistances
FROM teachers
JOIN assistance_requests ON teacher_id = teachers.id
JOIN students ON student_id = students.id
JOIN cohorts ON cohort_id = cohorts.id
WHERE cohorts.name = 'JUL02'
GROUP BY teachers.name, cohorts.name
ORDER BY teacher;








































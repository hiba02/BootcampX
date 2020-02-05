## Create a Test Database

```sql
CREATE DATABASE test_db;

\c test_db;


```

## Create a Sample Table

Create a table, famous_people:

```sql
CREATE TABLE famous_people (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  birthdate DATE
);

```

## BootcampX

```sql
-- Create the database
CREATE DATABASE bootcampx;
-- Start using the database
\c bootcampx;
```

### make file 
create_table.sql 

```sql
CREATE TABLE cohorts (
  id SERIAL PRIMARY KEY NOT NULL,
  name VARCHAR(255) NOT NULL,
  start_date DATE,
  end_date DATE
);

CREATE TABLE students (
  id SERIAL PRIMARY KEY NOT NULL,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  phone VARCHAR(32),
  github VARCHAR(255),
  start_date DATE,
  end_date DATE,
  cohort_id INTEGER REFERENCES cohorts(id) ON DELETE CASCADE
);

```
### Add tables to the database
1. bootcampx=# psql bootcampx < create_table.sql;

2. \i migrations/students_cohorts.sql  (change file name)


### To check tables
```sql
\dt
```

### Take a look at all of the data in the students and cohorts tables

```sql
SELECT * FROM students;
SELECT * FROM cohorts;
```

### Download sql files

[Students](http://bit.ly/2Z0fN4t)

[Cohorts](http://bit.ly/300nIQy)

* Create a folder named seeds inside the BootcampX folder.
Download both of the .sql files using wget.
* Download both of the .sql files using wget.

```
wget http://bit.ly/2Z0fN4t -O seeds/students.sql

wget http://bit.ly/300nIQy -O seeds/cohorts.sql
```

### Run the cohorts.sql and students.sql files against the bootcampx database

Inside the psql session,

```sql
\i seeds/cohorts.sql

\i seeds/students.sql
```

```sql
SELECT count(*) FROM students;
```

### git submit code

…or create a new repository on the command line
echo "# BootcampX" >> README.md
git init
git add README.md
git commit -m "first commit"
git remote add origin https://github.com/hiba02/BootcampX.git
git push -u origin master

make new repository named 'BootcampX'

```
vagrant [BootcampX]> git init

vagrant [BootcampX]> git add .

vagrant [BootcampX]> git commit -m "Intialization"

vagrant [BootcampX]> git remote add origin git@github.com:hiba02/BootcampX.git

vagrant [BootcampX]> git push -u origin master

```


### Create a new directory in BootcampX called 0_selects

We will then execute the query against our database using **\i filename.sql** from within our psql session.

```
vagrant [BootcampX]> mkdir 0_selects
```

### Create a New SQL File

```
vagrant [0_selects]> touch 1_students_without_github.sql
```
```sql
SELECT id, name, email, cohort_id
FROM students
WHERE github IS NULL
ORDER BY cohort_id
```

### Execute the SQL file
In a psql session

```
\i 0_selects/1_students_without_github.sql
```

## BootcampX Queries 1
* Get the names of all of the students from a single cohort.

```
vagrant [BootcampX]> mkdir 1_queries
```

```sql
SELECT id, name 
FROM students 
WHERE cohort_id = 1
ORDER BY name;
```

### Caution: ORDER BY should be located in after WHERE caluse

* Select the total number of students who were in the first 3 cohorts.

```sql
SELECT count(id)
FROM students 
WHERE cohort_id IN (1,2,3);
```

### Get all of the students that don't have an email or phone number

```sql
SELECT name, id, cohort_id
FROM students
WHERE email IS NULL
OR phone IS NULL;
```

### Get all of the students without a gmail.com or phone number

```sql
SELECT name, id, email, cohort_id
FROM students
WHERE email NOT LIKE '%gmail.com'
AND phone IS NULL;
```

### Get all of the students currently enrolled

```sql
SELECT name, id, cohort_id
FROM students
WHERE end_date IS NULL
ORDER BY cohort_id;
```

### Get all graduates without a linked Github account

```sql
SELECT name, email, phone
FROM students
WHERE github IS NULL
AND end_date IS NOT NULL;
```

* execution
```
\i 1_queries/1_queries.sql
```



## BootcampX Assignments

```
vagrant [migrations]> mkdir assignments_submissions.sql
```

### Write the CREATE TABLE statements for the assignments and a assignment_submissions tables

```
vagrant [migrations]> touch assignments_submissions.sql
```

```sql
CREATE TABLE assignments (
  id SERIAL PRIMARY KEY NOT NULL,
  name VARCHAR(255),
  content TEXT,
  day INTEGER,
  chapter INTEGER,
  duration INTEGER
);

CREATE TABLE assignment_submissions (
  id SERIAL PRIMARY KEY NOT NULL,
  assignment_id INTEGER REFERENCES assignments(id) ON DELETE CASCADE,
  student_id INTEGER REFERENCES students(id) ON DELETE CASCADE,
  duration FLOAT,
  submission_date DATE
);
```

```
\i migrations/assignments_submissions.sql

\dt
```



### Download the .sql files with the fake data in them

Within the seeds directory, download both of the .sql files using wget.

```
wget http://bit.ly/2N1uWQy -O seeds/assignments_seeds.sql

wget http://bit.ly/33vpmMb -O seeds/assignment_submissions_seeds.sql
```



### Run the assignments_seeds.sql and assignment_submissions_seeds.sql files against the bootcampx database

Inside your psql session

```sql
CREATE TABLE assignment_submissions (
  id SERIAL PRIMARY KEY NOT NULL,
  assignment_id VARCHAR(255) NOT NULL,
  student_id VARCHAR(255) NOT NULL,
  duration FLOAT,
  submission_date DATE
);

CREATE TABLE assignments (
  id SERIAL PRIMARY KEY NOT NULL,
  name VARCHAR(255) NOT NULL,
  content TEXT,
  day INTEGER,
  chapter INTEGER,
  duration INTEGER
);
```
* CAUTION: data format changed

```sql
\i seeds/assignments_seeds.sql
\i seeds/assignment_submissions_seeds.sql
```





### JOINing Tables

```sql
SELECT students.name as student_name, email, cohorts.name as cohort_name
FROM students JOIN cohorts ON cohort_id = cohorts.id;
```

* Every JOIN must also have an ON.


### INNER JOIN

* same as JOIN

```sql
SELECT students.name as student_name, email, cohorts.name as cohort_name
FROM students INNER JOIN cohorts ON cohorts.id = cohort_id;
```

* If the foreign key is NULL, the row will not be included in the result of an INNER JOIN.
* Most of the time, like 99% of the time, we want to use an INNER JOIN. 



### OUTER JOIN

* 3 different types of OUTER JOIN
* error occurs witout LEFT, RIGHT, or FULL

```sql
SELECT students.name as student_name, email, cohorts.name as cohort_name
FROM students LEFT OUTER JOIN cohorts ON cohorts.id = cohort_id;

SELECT students.name as student_name, email, cohorts.name as cohort_name
FROM students RIGHT OUTER JOIN cohorts ON cohorts.id = cohort_id;

SELECT students.name as student_name, email, cohorts.name as cohort_name
FROM students FULL OUTER JOIN cohorts ON cohorts.id = cohort_id;
```


* The LEFT OUTER JOIN will return all of the students, even ones without a cohort_id.

* The RIGHT OUTER JOIN will return all cohorts, even ones without any students enrolled.

* The FULL OUTER JOIN will return all cohorts and all students, even when there is no match.


* When we write a LEFT OUTER JOIN or a RIGHT OUTER JOIN, we can omit the word OUTER. 



### A student may have started in one cohort, gotten sick, and had to finish in a different cohort. We'll call this type of student a rollover student.

```sql
SELECT students.name, cohorts.name, cohorts.start_date as cohort_start_date, students.start_date as student_start_date
FROM students
JOIN cohorts ON cohort_id = cohorts.id
WHERE cohorts.start_date != students.start_date;
```





## BootcampX Queries II - JOIN

### Get the total amount of time that a student has spent on all assignments.
This should work for any student but use 'Ibrahim Schimmel' for now.
Select only the total amount of time as a single column.



```sql
bootcampx=# SELECT sum(assignment_submissions.duration) as total_duration
FROM assignment_submissions
JOIN students ON students.id = CAST(student_id AS int)
WHERE students.name = 'Ibrahim Schimmel';
```

* CAUTION: assignment_submissions.student_id is not int type.


Get the total amount of time that all students from a specific cohort have spent on all assignments.

This should work for any cohort but use FEB12 for now.
Select only the total amount of time as a single column.

```sql
SELECT sum(assignment_submissions.duration) as total_duration
FROM assignment_submissions
JOIN students ON students.id = CAST(student_id as int)
JOIN cohorts ON cohorts.id = CAST(cohort_id as int)
WHERE cohorts.name = 'FEB12';
```






## Group By and Having

### Group By

```sql
SELECT students.name as student, count(assignment_submissions.*) as total_submissions
FROM assignment_submissions
JOIN students ON students.id =  CAST(student_id AS int);
```



```sql
SELECT students.name as student, count(assignment_submissions.*) as total_submissions
FROM assignment_submissions
JOIN students ON students.id = CAST(student_id AS int)
GROUP BY students.name;
```


A currently enrolled student has a null end_date.

```sql
SELECT students.name as student, count(assignment_submissions.*) as total_submissions
FROM assignment_submissions
JOIN students ON students.id =  CAST(student_id AS int)
WHERE students.end_date IS NULL
GROUP BY students.name;
```


### HAVING

Let's only return currently enrolled students who's total submissions are less than 100

```sql
SELECT students.name as student, count(assignment_submissions.*) as total_submissions
FROM assignment_submissions
JOIN students ON students.id = CAST(student_id AS int)
WHERE students.end_date IS NULL
GROUP BY students.name
HAVING count(assignment_submissions.*) < 100;
```


#### The HAVING clause is like WHERE but works on aggregated data. Our WHERE clause works on normal data students.end_date and our HAVING clause works on the aggregated data count(assignment_submissions.*).



## BootcampX Queries 3 - Group By

### Get the total number of assignments for each day of bootcamp.

```sql
SELECT day, count(*) as total_assignments 
FROM assignments
GROUP BY day
ORDER BY day;
```

### The same query as before, but only return rows where total assignments is greater than or equal to 10.

```sql
SELECT day, count(*) as total_assignments 
FROM assignments
GROUP BY day
HAVING count(*) >= 10
ORDER BY day;
```


### Get all cohorts with 18 or more students.
Select the cohort name and the total students.
Order by total students from smallest to greatest.

```sql
SELECT cohorts.name as cohort_name, count(students.*) AS student_count 
FROM cohorts
JOIN students ON cohorts.id = cohort_id
GROUP BY cohort_name 
HAVING count(students.*) >= 18
ORDER BY student_count;
```


### Total Assignment Submissions
Get the total number of assignment submissions for each cohort.

Select the cohort name and total submissions.
Order the results from greatest to least submissions.

```sql
SELECT cohorts.name, count(assignment_submissions.*) 
FROM assignment_submissions 
JOIN students ON CAST(student_id AS int) = students.id
JOIN cohorts ON students.id = cohorts.id;
```













2/4/20

## BootcampX Assistance Requests

### Total Teacher Assistance Requests

Get the total number of assistance_requests for a teacher.

Select the teacher's name and the total assistance requests.
Since this query needs to work with any specific teacher name, use 'Waylon Boehm' for the teacher's name here.

Expected Result:
```
 total_assistances |     name     
-------------------+--------------
              4227 | Waylon Boehm
(1 row)
```

```sql
SELECT count(assistance_requests.*) as total_assistances, teachers.name
FROM assistance_requests
JOIN teachers ON teachers.id = teacher_id
WHERE teachers.name = 'Waylon Boehm'
GROUP BY name;
```






Total Student Assistance Requests
We need to be able to see how many assistance requests any student has requested.

Get the total number of assistance_requests for a student.

Select the student's name and the total assistance requests.
Since this query needs to work with any specific student name, use 'Elliot Dickinson' for the student's name here.
Expected Result:

```
 total_assistances |       name       
-------------------+------------------
               138 | Elliot Dickinson
(1 row)
```

```sql
SELECT count(assistance_requests.*), students.name 
FROM assistance_requests
JOIN students ON student_id = students.id 
WHERE students.name = 'Elliot Dickinson'
GROUP BY students.name;
```


Assistance Requests Data
Each assistance request is related to a bunch of data like a teacher, student, assignment, and more. We want to be able to see all important data about an assistance request.

Get important data about each assistance request.

Select the teacher's name, student's name, assignment's name, and the duration of each assistance request.
Subtract completed_at by started_at to find the duration.
Order by the duration of the request.
Expected Result:
```
      teacher       |         student          |    assignment    | duration 
--------------------+--------------------------+------------------+----------
 Helmer Rodriguez   | Maximillian Pfannerstill | Expedita officia | 00:02:45
 Roberto Towne      | Vivien Mosciski          | Ea totam iste    | 00:02:45
 Georgiana Fahey    | Gene Carter              | Ut fuga          | 00:02:45
 Cheyanne Powlowski | Vivien Mosciski          | Eum eaque        | 00:02:45
 Roberto Towne      | Maximillia Willms        | Quibusdam est    | 00:03:00
(26299 rows)
```


```sql
SELECT teachers.name as teacher, students.name as student, assignments.name as assignment, (completed_at-started_at) as duration 
FROM assistance_requests
JOIN teachers ON teacher_id = teachers.id
JOIN students ON student_id = students.id 
JOIN assignments ON assignment_id = assignments.id
ORDER BY duration;
```




Average Assistance Time
We need to be able to see the current average time it takes to complete an assistance request.

Get the average time of an assistance request.

Select just a single row here and name it average_assistance_request_duration
In Postgres, we can subtract two timestamps to find the duration between them. (timestamp1 - timestamp2)
Expected Result:



```
 average_assistance_request_duration 
-------------------------------------
 00:14:21.556903
(1 row)
```

```sql
SELECT AVG(completed_at-started_at) as average_assistance_request_duration 
FROM assistance_requests;
```



Average Cohort Assistance Time
We need to be able to see the average duration of a single assistance request for each cohort.

Get the average duration of assistance requests for each cohort.

Select the cohort's name and the average assistance request time.
Order the results from shortest average to longest.
Expected Result:
```
 name  | average_assistance_time 
-------+-------------------------
 SEP24 | 00:13:23.071576
 JUL30 | 00:13:23.956547
 FEB12 | 00:13:42.66022
 JUN04 | 00:13:45.974562
 MAY07 | 00:13:58.745754
...
(11 rows)
```

```sql
SELECT cohorts.name, AVG(completed_at-started_at) as average_assistance_request_duration
FROM assistance_requests
JOIN students ON student_id = students.id
JOIN cohorts ON cohorts.id = cohort_id
GROUP BY cohorts.name
ORDER BY average_assistance_request_duration;
```



Cohort With Longest Assistances
Get the cohort with the longest average duration of assistance requests.

The same requirements as the previous query, but only return the single row with the longest average.
Expected Result:
```
 name  | average_assistance_time 
-------+-------------------------
 MAR12 | 00:15:44.556041
(1 row)
```

```sql
SELECT cohorts.name, avg(completed_at - started_at) as average_assistance_time
FROM assistance_requests 
JOIN students ON students.id = assistance_requests.student_id
JOIN cohorts ON cohorts.id = cohort_id
GROUP BY cohorts.name
ORDER BY average_assistance_time DESC
LIMIT 1;
```


Average Assistance Request Wait Time
We need to know the average amount of time that students are waiting for an assistance request. This is the duration between an assistance request being created, and it being started.

Calculate the average time it takes to start an assistance request.

Return just a single column here.
Expected Result:
```
 average_wait_time 
-------------------
 00:08:46.258793
(1 row)
```

```sql
SELECT avg(started_at-created_at) as average_wait_time
FROM assistance_requests;
```



Total Cohort Assistance Duration
We need to be able to see the total amount of time being spent on an assistance request for each cohort. This number will tell use how much time is being spent on assistance requests for each cohort.

Get the total duration of all assistance requests for each cohort.

Select the cohort's name and the total duration the assistance requests.
Order by total_duration.
Look at the ERD to see how to join the tables.
Expected Result:
```
 cohort | total_duration 
--------+----------------
 JUL30  | 390:35:20
 AUG27  | 398:19:00
 JUL02  | 453:50:30
 NOV19  | 462:34:40
 MAY07  | 480:10:55
 ...
 (11 rows)
```

```sql
SELECT cohorts.name, SUM(completed_at-started_at) as total_duration
FROM assistance_requests
JOIN students ON student_id = students.id 
JOIN cohorts ON cohort_id = cohorts.id 
GROUP BY cohorts.name
ORDER BY total_duration;
```

### ??sub query
Cohort Average Assistance Duration
We also need to know the average total amount of time being spent on an assistance request for each cohort. This is just the average of the total_duration column from the previous query.

Calculate the average total duration of assistance requests for each cohort.

Use the previous query as a sub query to determine the duration per cohort.
Return a single row average_total_duration
Expected Result:
```
 average_total_duration 
------------------------
 555:22:25.909091
(1 row)
```
```sql
SELECT avg (total_duration) as average_total_duration
FROM (
  SELECT cohorts.name as cohort, sum(completed_at-started_at) as total_duration
  FROM assistance_requests
  JOIN students ON students.id = student_id
  JOIN cohorts on cohorts.id = cohort_id
  GROUP BY cohorts.name
  ORDER BY total_duration
) as total_durations;
```



Most Confusing Assignments
We need to know which assignments are causing the most assistance requests.

List each assignment with the total number of assistance requests with it.

Select the assignment's id, day, chapter, name and the total assistances.
Order by total assistances in order of most to least.
Expected Result:

```
 id  |       name       | day | chapter |total_requests 
-----+------------------+-----+---------+------------------
 424 | Ullam cumque     |  51 |      12 |           143
 423 | Culpa esse sint  |  51 |      11 |           113
  45 | Quia quasi       |   5 |       7 |            86
  50 | A rerum          |   6 |       5 |            83
 141 | Illo error dolor |  17 |       9 |            82
 ...
(424 rows)
```

???? GROUP BY assignments.id;
???? Why not name?

```sql
SELECT assignments.id, assignments.name, assignments.day, assignments.chapter, count(assistance_requests.*) AS total_requests
FROM assistance_requests
JOIN assignments
ON assignments.id = assignment_id
GROUP BY assignments.id
ORDER BY total_requests DESC;
```



Total Assignments and duration
We need to be able to see the number of assignments that each day has and the total duration of assignments for each day.

Get each day with the total number of assignments and the total duration of the assignments.

Select the day, number of assignments, and the total duration of assignments.
Order the results by the day.
Expected Result:
```
 day | number_of_assignments | duration 
-----+-----------------------+----------
   1 |                    11 |      590
   2 |                     9 |      585
   3 |                     9 |      425
   4 |                     9 |      380
   5 |                     7 |      405
...
(51 rows)
```

```sql
SELECT day, count(*) as number_of_assignments, sum(duration) as duration
FROM assignments
GROUP BY day
ORDER BY day;
```

Name of Teachers That Assisted
We need to know which teachers actually assisted students during any cohort.

Get the name of all teachers that performed an assistance request during a cohort.

Select the instructor's name and the cohort's name.
Don't repeat the instructor's name in the results list.
Order by the instructor's name.
This query needs to select data for a cohort with a specific name, use 'JUL02' for the cohort's name here.
Expected Result:
```
      teacher       | cohort 
--------------------+--------
 Cheyanne Powlowski | JUL02
 Georgiana Fahey    | JUL02
 Helmer Rodriguez   | JUL02
 Jadyn Bosco        | JUL02
...
(8 rows)
```

```sql
SELECT DISTINCT(teachers.name) as teacher, cohorts.name as cohort 
FROM teachers
JOIN assistance_requests on teachers.id = assistance_requests.teacher_id
JOIN students on students.id = assistance_requests.student_id
JOIN cohorts on cohorts.id = students.id
WHERE cohorts.name='JUL02'
ORDER BY teachers.name;
```


Name of Teachers and Number of Assistances
We need to know which teachers actually assisted students during any cohort, and how many assistances they did for that cohort.

Perform the same query as before, but include the number of assistances as well.

Expected Result:
```
      teacher       | cohort | total_assistances 
--------------------+--------+-------------------
 Cheyanne Powlowski | JUL02  |               336
 Georgiana Fahey    | JUL02  |               158
 Helmer Rodriguez   | JUL02  |               157
 Jadyn Bosco        | JUL02  |               177
...
(8 rows)
```

```sql
SELECT teachers.name as teacher, cohorts.name as cohort, count(assistance_requests) 
FROM teachers
JOIN assistance_requests on teachers.id = assistance_requests.teacher_id
JOIN students on students.id = assistance_requests.student_id
JOIN cohorts on cohorts.id = cohort_id
WHERE cohorts.name = 'JUL02'
GROUP BY teachers.name, cohorts.name
ORDER BY teacher;
```
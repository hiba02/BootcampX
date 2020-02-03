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
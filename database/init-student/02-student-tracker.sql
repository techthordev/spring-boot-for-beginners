-- Database already created by POSTGRES_DB env var
-- Just connect to it
\c student_tracker;

-- Grant schema rights FIRST (before creating tables!)
GRANT ALL ON SCHEMA public TO springstudent;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO springstudent;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO springstudent;

-- Create student table
DROP TABLE IF EXISTS student;

CREATE TABLE student (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(45) DEFAULT NULL,
  last_name VARCHAR(45) DEFAULT NULL,
  email VARCHAR(45) DEFAULT NULL
);

-- Grant privileges on existing objects
GRANT ALL PRIVILEGES ON DATABASE student_tracker TO springstudent;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO springstudent;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO springstudent;
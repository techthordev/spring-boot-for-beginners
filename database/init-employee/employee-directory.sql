-- employee-directory.sql
-- Run as postgres superuser during container startup

-- 1. USER & DB LEVEL
DROP USER IF EXISTS springstudent;
CREATE USER springstudent WITH PASSWORD 'springstudent';

-- Dem User die Datenbank "schenken"
ALTER DATABASE employee_directory OWNER TO springstudent;
GRANT ALL PRIVILEGES ON DATABASE employee_directory TO springstudent;

\connect employee_directory

-- 2. SCHEMA LEVEL (Important for Postgres 15+)
GRANT ALL ON SCHEMA public TO springstudent;
ALTER SCHEMA public OWNER TO springstudent;

-- 3. OBJECT CREATION
CREATE TABLE IF NOT EXISTS employee (
    id         SERIAL PRIMARY KEY,
    first_name VARCHAR(45) NOT NULL,
    last_name  VARCHAR(45) NOT NULL,
    email      VARCHAR(45) NOT NULL UNIQUE
    );

-- 4. DATA INSERTION
INSERT INTO employee (first_name, last_name, email) VALUES
                                                        ('Leslie',  'Andrews',    'leslie@luv2code.com'),
                                                        ('Emma',    'Baumgarten', 'emma@luv2code.com'),
                                                        ('Avani',   'Gupta',      'avani@luv2code.com'),
                                                        ('Yuri',    'Petrov',     'yuri@luv2code.com'),
                                                        ('Juan',    'Vega',       'juan@luv2code.com');

-- 5. SEQUENCE CORRECTION
SELECT setval('employee_id_seq', (SELECT MAX(id) FROM employee));

-- 6. OWNERSHIP & PRIVILEGES (Der "Gott-Modus" für springstudent)
ALTER TABLE employee OWNER TO springstudent;
ALTER SEQUENCE employee_id_seq OWNER TO springstudent;

-- Sicherheitshalber für alle bestehenden Tabellen
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO springstudent;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO springstudent;

-- 7. FUTURE OBJECTS
-- Damit auch Tabellen, die Hibernate später erstellt, ihm gehören/zugänglich sind
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO springstudent;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON SEQUENCES TO springstudent;
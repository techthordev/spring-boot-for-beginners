-- In PostgreSQL we usually use schemas instead of "USE database"
-- CREATE SCHEMA IF NOT EXISTS employee_directory;
-- SET search_path TO employee_directory;

DROP TABLE IF EXISTS authorities;
DROP TABLE IF EXISTS users;

--
-- Table structure for table users
--

CREATE TABLE users (
                       username varchar(50) NOT NULL,
                       password varchar(100) NOT NULL, -- Increased length for potential hashing
                       enabled smallint NOT NULL,      -- PostgreSQL uses smallint or boolean
                       PRIMARY KEY (username)
);

--
-- Inserting data for table users
--

INSERT INTO users (username, password, enabled)
VALUES
    ('john','{noop}test123',1),
    ('mary','{noop}test123',1),
    ('susan','{noop}test123',1);


--
-- Table structure for table authorities
--

CREATE TABLE authorities (
                             username varchar(50) NOT NULL,
                             authority varchar(50) NOT NULL,
                             CONSTRAINT authorities_idx_1 UNIQUE (username, authority),
                             CONSTRAINT authorities_ibfk_1 FOREIGN KEY (username) REFERENCES users (username)
);

--
-- Inserting data for table authorities
--

INSERT INTO authorities (username, authority)
VALUES
    ('john','ROLE_EMPLOYEE'),
    ('mary','ROLE_EMPLOYEE'),
    ('mary','ROLE_MANAGER'),
    ('susan','ROLE_EMPLOYEE'),
    ('susan','ROLE_MANAGER'),
    ('susan','ROLE_ADMIN');
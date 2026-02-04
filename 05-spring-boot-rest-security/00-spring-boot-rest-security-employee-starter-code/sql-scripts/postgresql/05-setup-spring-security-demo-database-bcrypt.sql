-- In PostgreSQL nutzen wir keine "USE" Anweisung.
-- Stelle sicher, dass du mit der richtigen DB verbunden bist.

DROP TABLE IF EXISTS authorities;
DROP TABLE IF EXISTS users;

--
-- Table structure for table users
--

CREATE TABLE users (
                       username varchar(50) NOT NULL,
                       password char(68) NOT NULL, -- char(68) passt perfekt für BCrypt mit Präfix
                       enabled  smallint NOT NULL,  -- In Postgres nehmen wir smallint für 0/1 (kompatibel mit Spring JDBC)
                       PRIMARY KEY (username)
);

--
-- Inserting data for table users
--
-- Passwords: fun123
--

INSERT INTO users (username, password, enabled)
VALUES
    ('john','{bcrypt}$2a$10$qeS0HEh7urweMojsnwNAR.vcXJeXR1UcMRZ2WcGQl9YeuspUdgF.q',1),
    ('mary','{bcrypt}$2a$10$qeS0HEh7urweMojsnwNAR.vcXJeXR1UcMRZ2WcGQl9YeuspUdgF.q',1),
    ('susan','{bcrypt}$2a$10$qeS0HEh7urweMojsnwNAR.vcXJeXR1UcMRZ2WcGQl9YeuspUdgF.q',1);


--
-- Table structure for table authorities
--

CREATE TABLE authorities (
                             username  varchar(50) NOT NULL,
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
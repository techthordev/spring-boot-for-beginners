-- Hinweis: In PostgreSQL verbinden wir uns direkt mit der Datenbank,
-- daher entfällt "USE employee_directory".

DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS members;

--
-- Table structure for table members
--

CREATE TABLE members (
                         user_id varchar(50) NOT NULL,
                         pw      char(68)    NOT NULL, -- BCrypt Hash-Länge
                         active  smallint    NOT NULL, -- 1 für aktiv, 0 für inaktiv
                         PRIMARY KEY (user_id)
);

--
-- Inserting data for table members
--

INSERT INTO members (user_id, pw, active)
VALUES
    ('john', '{bcrypt}$2a$10$qeS0HEh7urweMojsnwNAR.vcXJeXR1UcMRZ2WcGQl9YeuspUdgF.q', 1),
    ('mary', '{bcrypt}$2a$10$qeS0HEh7urweMojsnwNAR.vcXJeXR1UcMRZ2WcGQl9YeuspUdgF.q', 1),
    ('susan','{bcrypt}$2a$10$qeS0HEh7urweMojsnwNAR.vcXJeXR1UcMRZ2WcGQl9YeuspUdgF.q', 1);


--
-- Table structure for table roles
--

CREATE TABLE roles (
                       user_id varchar(50) NOT NULL,
                       role    varchar(50) NOT NULL,
                       CONSTRAINT roles_idx_1 UNIQUE (user_id, role),
                       CONSTRAINT roles_ibfk_1 FOREIGN KEY (user_id) REFERENCES members (user_id)
);

--
-- Inserting data for table roles
--

INSERT INTO roles (user_id, role)
VALUES
    ('john', 'ROLE_EMPLOYEE'),
    ('mary', 'ROLE_EMPLOYEE'),
    ('mary', 'ROLE_MANAGER'),
    ('susan','ROLE_EMPLOYEE'),
    ('susan','ROLE_MANAGER'),
    ('susan','ROLE_ADMIN');
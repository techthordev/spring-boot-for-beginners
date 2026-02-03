# Student Tracker Database

## Overview

PostgreSQL database setup for the Spring Boot Student Tracker application.

**Database:** PostgreSQL 18  
**Container:** Podman  
**Port:** 5433 (host) → 5432 (container)

---

## Quick Start

```bash
# Start database (first time)
podman compose up -d

# Stop database
podman compose down

# View logs
podman compose logs -f

# Connect to database
podman exec -it student-tracker-db psql -U springstudent -d student_tracker
````

---

## Configuration Files

### Environment Variables

Edit `.env` in project root:

```properties
POSTGRES_PASSWORD=postgres
POSTGRES_PORT=5433
```

**Note:** `.env` is git-ignored and contains local settings only.

---

## Database Schema

### Student Table

| Column     | Type        | Description                  |
| ---------- | ----------- | ---------------------------- |
| id         | SERIAL      | Primary key (auto-increment) |
| first_name | VARCHAR(45) | Student first name           |
| last_name  | VARCHAR(45) | Student last name            |
| email      | VARCHAR(45) | Student email                |

### Auto-Increment Configuration

PostgreSQL uses **SEQUENCES** for auto-increment (unlike MySQL's AUTO_INCREMENT).

**Change starting ID value:**

```sql
ALTER SEQUENCE student_id_seq RESTART WITH 3000;
SELECT last_value FROM student_id_seq;
```

**Clear all data and reset sequence:**

```sql
TRUNCATE TABLE student RESTART IDENTITY;
TRUNCATE TABLE student;
TRUNCATE TABLE student RESTART IDENTITY CASCADE;
```

---

## Initialization Scripts

Scripts in `database/init/` run automatically on first startup:

1. **01-create-user.sql** - Creates application user `springstudent`
2. **02-student-tracker.sql** - Creates database and schema

To re-run initialization scripts:

```bash
podman compose down -v
podman compose up -d
```

---

## DBeaver Connection

### Admin User (`postgres`)

| Setting  | Value           |
| -------- | --------------- |
| Host     | localhost       |
| Port     | 5433            |
| Database | student_tracker |
| Username | postgres        |
| Password | postgres        |

### Application User (`springstudent`)

| Setting  | Value           |
| -------- | --------------- |
| Host     | localhost       |
| Port     | 5433            |
| Database | student_tracker |
| Username | springstudent   |
| Password | springstudent   |

---

## Spring Boot Configuration

Add to `src/main/resources/application.properties`:

```properties
spring.datasource.url=jdbc:postgresql://localhost:5433/student_tracker
spring.datasource.username=springstudent
spring.datasource.password=springstudent
spring.datasource.driver-class-name=org.postgresql.Driver

spring.jpa.database-platform=org.hibernate.dialect.PostgreSQLDialect
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
```

---

## Common Commands

```bash
podman ps
podman ps -a
podman compose restart

podman exec -it student-tracker-db psql -U springstudent -d student_tracker
podman exec -it student-tracker-db psql -U postgres -d student_tracker
```

### psql Commands

```sql
\l
\dt
\d student
\q
```

---

## Troubleshooting

### Permission Denied

```sql
GRANT ALL ON SCHEMA public TO springstudent;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO springstudent;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO springstudent;

ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO springstudent;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO springstudent;
```

### Port Conflict

```bash
sudo ss -tlnp | grep 5433
# Or change port in .env
POSTGRES_PORT=5434
```

### Clean Slate

```bash
podman compose down -v
podman compose up -d
```

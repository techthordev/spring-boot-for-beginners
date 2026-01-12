# Student Tracker Database

## Overview

PostgreSQL database setup for Spring Boot Student Tracker application.

**Database:** PostgreSQL 18  
**Container:** Podman  
**Port:** 5433 (host) → 5432 (container)

---

## Quick Start

```bash
# Start database
podman compose up -d

# Stop database
podman compose down

# View logs
podman compose logs -f

# Connect to database
podman exec -it student-tracker-db psql -U springstudent -d student_tracker
```

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

| Column      | Type         | Description          |
|-------------|--------------|----------------------|
| id          | SERIAL       | Primary key (auto-increment) |
| first_name  | VARCHAR(45)  | Student first name   |
| last_name   | VARCHAR(45)  | Student last name    |
| email       | VARCHAR(45)  | Student email        |

### Auto-Increment Configuration

PostgreSQL uses **SEQUENCES** for auto-increment (not like MySQL's AUTO_INCREMENT).

**Change starting ID value:**

```sql
-- Set next ID to start at 3000
ALTER SEQUENCE student_id_seq RESTART WITH 3000;

-- Verify current value
SELECT last_value FROM student_id_seq;
```

**Clear all data and reset sequence:**

```sql
-- Delete all rows and reset auto-increment to 1
TRUNCATE TABLE student RESTART IDENTITY;

-- Delete all rows but keep current sequence value
TRUNCATE TABLE student;

-- Delete with cascade (if foreign keys exist)
TRUNCATE TABLE student RESTART IDENTITY CASCADE;
```

**Important:** PostgreSQL syntax differs from MySQL:

| Feature | MySQL | PostgreSQL |
|---------|-------|------------|
| Auto-increment type | `AUTO_INCREMENT` | `SERIAL` |
| Change start value | `ALTER TABLE student AUTO_INCREMENT=3000;` | `ALTER SEQUENCE student_id_seq RESTART WITH 3000;` |
| Clear table + reset | `TRUNCATE TABLE student;` (auto-resets) | `TRUNCATE TABLE student RESTART IDENTITY;` |
| View current value | `SHOW TABLE STATUS;` | `SELECT last_value FROM student_id_seq;` |

---

## Initialization Scripts

Scripts in `databse/init/` run automatically on first startup:

1. **01-create-user.sql** - Creates application user `springstudent`
2. **02-student-tracker.sql** - Creates database and schema

**Note:** Scripts in `/docker-entrypoint-initdb.d` are executed in alphabetical order.

To re-run initialization scripts:

```bash
# Remove volume and restart
podman compose down -v
podman compose up -d
```

---

## DBeaver Connection

### Connection 1: Admin User (postgres)

For database administration and setup verification.

| Setting  | Value              |
|----------|--------------------|
| Host     | localhost          |
| Port     | 5433               |
| Database | student_tracker    |
| Username | postgres           |
| Password | postgres           |

### Connection 2: Application User (springstudent)

For application development and Spring Boot connection.

| Setting  | Value              |
|----------|--------------------|
| Host     | localhost          |
| Port     | 5433               |
| Database | student_tracker    |
| Username | springstudent      |
| Password | springstudent      |

**Note:** Spring Boot uses the `springstudent` connection.

---

## Spring Boot Configuration

Add to `src/main/resources/application.properties`:

```properties
# Database
spring.datasource.url=jdbc:postgresql://localhost:5433/student_tracker
spring.datasource.username=springstudent
spring.datasource.password=springstudent
spring.datasource.driver-class-name=org.postgresql.Driver

# JPA
spring.jpa.database-platform=org.hibernate.dialect.PostgreSQLDialect
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
```

---

## Common Commands

### Container Management

```bash
# Check status
podman ps

# View all containers
podman ps -a

# Restart container
podman compose restart
```

### Database Access

```bash
# Connect as application user
podman exec -it student-tracker-db psql -U springstudent -d student_tracker

# Connect as admin
podman exec -it student-tracker-db psql -U postgres -d student_tracker
```

### psql Commands

```sql
-- List databases
\l

-- List tables
\dt

-- Describe table
\d student

-- Quit
\q
```

---

## Troubleshooting

### Permission Denied for Schema Public

If you get `ERROR: permission denied for schema public` when running Spring Boot:

```bash
# Connect as admin
podman exec -it student-tracker-db psql -U postgres -d student_tracker
```

**In psql, run:**

```sql
-- Grant all rights on public schema
GRANT ALL ON SCHEMA public TO springstudent;

-- Grant rights on all tables
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO springstudent;

-- Grant rights on all sequences
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO springstudent;

-- Set default privileges for future tables
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO springstudent;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO springstudent;

-- Exit
\q
```

**Or fix permanently:** Update `databse/init/02-student-tracker.sql` to include schema grants before creating tables.

### Port already in use

```bash
# Check what's using port 5433
sudo ss -tlnp | grep 5433

# Change port in .env
POSTGRES_PORT=5434
```

### Container won't start

```bash
# Check logs
podman compose logs

# Fresh start
podman compose down -v
podman compose up -d
```

---

## Clean Slate

```bash
# Stop and remove everything (including data!)
podman compose down -v

# Start fresh
podman compose up -d
```

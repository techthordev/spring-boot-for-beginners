# 🚀 Spring Boot for Beginners

> Complete Spring Boot tutorial following [Chad Darby's Udemy Course](https://www.udemy.com/course/spring-hibernate-tutorial) - Adapted for PostgreSQL 18 & Podman

[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-4.0.1-brightgreen.svg)](https://spring.io/projects/spring-boot)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-18-blue.svg)](https://www.postgresql.org/)
[![Java](https://img.shields.io/badge/Java-25-orange.svg)](https://openjdk.org/)
[![Podman](https://img.shields.io/badge/Podman-Ready-purple.svg)](https://podman.io/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## 📚 Course Progress

- [x] **Section 1-2:** Spring Boot Overview & Spring Core
- [x] **Section 3:** Hibernate/JPA CRUD with PostgreSQL
- [ ] **Section 4:** REST CRUD APIs
- [ ] **Section 5:** REST API Security
- [ ] **Section 6-8:** Spring MVC
- [ ] **Section 9:** JPA Advanced Mappings
- [ ] **Section 10:** AOP - Aspect-Oriented Programming

---

## 🎯 Key Features

- ✅ **PostgreSQL 18** instead of MySQL (modern, powerful)
- ✅ **Podman Compose** for containerized database
- ✅ **IntelliJ IDEA CE** project setup
- ✅ Complete DAO implementation with JPA/Hibernate
- ✅ Production-ready configuration
- ✅ Comprehensive documentation

---

## 🛠️ Tech Stack

| Technology | Version | Purpose |
|------------|---------|---------|
| Spring Boot | 4.0.1 | Backend Framework |
| PostgreSQL | 18 | Database |
| Hibernate | 7.2.0 | ORM |
| Maven | 3.9+ | Build Tool |
| Podman | 5.0+ | Container Runtime |
| Java | 25 | Programming Language |

---

## 🚀 Quick Start

### Prerequisites

- Java 25+
- Maven 3.9+
- Podman & podman-compose
- IntelliJ IDEA CE (recommended)

### 1. Clone Repository

```bash
git clone https://github.com/yourusername/spring-boot-for-beginners.git
cd spring-boot-for-beginners
```

### 2. Start Database

```bash
# Start PostgreSQL container
podman compose up -d

# Verify container is running
podman ps
```

### 3. Configure Environment

```bash
# Copy environment template
cp .env.example .env

# Edit if needed (default values work fine)
nano .env
```

### 4. Run Application

```bash
# From project root
mvn -pl ./03-spring-boot-hibernate-jpa-crud/01-cruddemo-student spring-boot:run

# Or in IntelliJ IDEA
# Open project -> Run 'CruddemoApplication'
```

---

## 📁 Project Structure

```
spring-boot-for-beginners/
├── 01-spring-boot-overview/          # Introduction & Setup
├── 02-spring-boot-spring-core/       # Dependency Injection
├── 03-spring-boot-hibernate-jpa-crud/# Database Operations
│   └── 01-cruddemo-student/
│       ├── src/
│       │   ├── main/
│       │   │   ├── java/
│       │   │   │   └── br/com/techthordev/cruddemo/
│       │   │   │       ├── entity/    # JPA Entities
│       │   │   │       └── dao/       # Data Access Objects
│       │   │   └── resources/
│       │   │       └── application.properties
│       │   └── test/
│       └── pom.xml
├── database/                         # Database Setup
│   ├── init/
│   │   ├── 01-create-user.sql
│   │   └── 02-student-tracker.sql
│   └── README.md                     # Database Documentation
├── compose.yml                       # Podman Compose Config
├── .env.example                      # Environment Template
└── README.md                         # This file
```

---

## 🗄️ Database Configuration

### Connection Details

| Parameter | Value |
|-----------|-------|
| Host | localhost |
| Port | 5433 |
| Database | student_tracker |
| Username | springstudent |
| Password | springstudent |

### Quick Commands

```bash
# Connect to database
podman exec -it student-tracker-db psql -U springstudent -d student_tracker

# View logs
podman compose logs -f

# Stop database
podman compose down

# Fresh start (deletes all data!)
podman compose down -v && podman compose up -d
```

**Full documentation:** [database/README.md](database/README.md)

---

## 🎓 Learning Path

### Completed ✅

1. **Spring Core Basics**
    - Dependency Injection
    - Component Scanning
    - Bean Lifecycle

2. **Hibernate/JPA CRUD**
    - Entity Mapping
    - DAO Pattern
    - CRUD Operations
    - PostgreSQL Integration

### In Progress 🚧

3. **REST APIs**
    - REST Controllers
    - Request/Response Handling
    - Exception Handling

### Coming Soon 📅

4. **Security**
5. **Advanced JPA**
6. **AOP**

---

## 🔧 Development Setup

### IntelliJ IDEA Configuration

1. **Import Project**
   ```
   File -> Open -> Select pom.xml
   ```

2. **Configure JDK**
   ```
   File -> Project Structure -> Project SDK: Java 25
   ```

3. **Enable Annotation Processing**
   ```
   Settings -> Build -> Compiler -> Annotation Processors
   ☑ Enable annotation processing
   ```

4. **Run Configuration**
    - Main class: `br.com.techthordev.cruddemo.CruddemoApplication`
    - VM options: (none required)
    - Program arguments: (none required)

### Database Tools in IntelliJ

1. **Open Database Tool Window**
   ```
   View -> Tool Windows -> Database
   ```

2. **Add PostgreSQL Connection**
    - Host: localhost
    - Port: 5433
    - Database: student_tracker
    - User: springstudent
    - Password: springstudent

---

## 📖 Key Differences from Course

### MySQL → PostgreSQL

| Feature | MySQL (Course) | PostgreSQL (This Project) |
|---------|----------------|---------------------------|
| Auto-increment | `AUTO_INCREMENT` | `SERIAL` |
| Change start value | `ALTER TABLE ... AUTO_INCREMENT=3000` | `ALTER SEQUENCE ... RESTART WITH 3000` |
| Clear table | `TRUNCATE TABLE student;` | `TRUNCATE TABLE student RESTART IDENTITY;` |
| JDBC Driver | `com.mysql.cj.jdbc.Driver` | `org.postgresql.Driver` |
| Dialect | `MySQLDialect` | `PostgreSQLDialect` |

### Docker → Podman

- No daemon required (rootless!)
- Better security
- Compatible with Docker Compose files
- Native on Fedora/RHEL

---

## 🐛 Common Issues

### Port 5433 Already in Use

```bash
# Check what's using the port
sudo ss -tlnp | grep 5433

# Change port in .env
POSTGRES_PORT=5434
```

### Permission Denied for Schema Public

```bash
# Connect as admin and grant rights
podman exec -it student-tracker-db psql -U postgres -d student_tracker
```

```sql
GRANT ALL ON SCHEMA public TO springstudent;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO springstudent;
```

**More troubleshooting:** [database/README.md](database/README.md)

---

## 📝 License

MIT License - feel free to use this project for learning!

---

## 🙏 Acknowledgments

- **Chad Darby** - [Original Udemy Course](https://www.udemy.com/course/spring-hibernate-tutorial)
- **Spring Team** - For the amazing framework
- **PostgreSQL Community** - For the best open-source database

---

## 📬 Contact

**Your Name**  
🌐 [techthordev.com.br](https://techthordev.com.br)  
💼 [LinkedIn](https://linkedin.com/in/thorstenfey)  
🐙 [GitHub](https://github.com/techthordev)

---

⭐ **Star this repo** if you find it helpful!

🐛 **Found a bug?** Open an issue!

🤝 **Want to contribute?** Pull requests welcome!
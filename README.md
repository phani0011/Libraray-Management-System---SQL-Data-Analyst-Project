# 📚 Library Management System  
### End-to-End SQL Data Analyst Project

---

## 1. Project Overview
This project demonstrates a complete **SQL-based data workflow** for a Library Management System, starting from **raw CSV data** and ending with **analytics-ready relational tables**.
The Main aim of the project is to provide best insights which helps the district library chairman to know about the data in library databases

The focus of this project is on **data engineering and analytical preparation**, not just writing queries. It reflects real-world practices followed in data-driven organizations.

---

## 2. Problem Context
Library operations generate data from multiple independent sources such as:
- Book inventory management
- Reader registrations
- Book issue and return tracking
- Employee records
- Fund allocation and fine collection

This data is often **unstructured, inconsistent, and difficult to analyze**.  
The objective of this project is to transform such raw data into a **clean, reliable, and well-related SQL database** that supports analysis and reporting.

---

## 3. Data Collection
- Data is collected in **CSV format** from libraries in prakasam district
- Included 10 major libraries from my aunt functional zone
- Each CSV represents a functional area of the library system
- Data  contains:
  - Missing values
  - Inconsistent date formats
  - Invalid and duplicate records

This simulates **real-world raw data conditions**.

---

## 4. Database Architecture
The project follows a **two-layer database design**.

### 4.1 Staging Layer
Purpose:
- Store raw data exactly as received
- Perform validation and cleaning
- Prevent corruption of actual tables

Characteristics:
- No primary keys
- No foreign keys
- Accepts inconsistent formats

---

### 4.2 Actual (Core) Layer
Purpose:
- Store clean and validated data
- Maintain referential integrity
- Support analytical queries

Characteristics:
- Primary keys and foreign keys enforced
- Standardized data types
- Business rules applied

---

## 5. End-to-End Workflow
The complete data pipeline followed in this project:

Raw CSV Files
↓
Staging Tables
↓
Data Cleaning & Validation
↓
Transformation & Standardization
↓
Actual Tables with Constraints
↓
Analytics & Business Insights


Each step is implemented using **separate SQL scripts** for clarity and maintainability.

---

## 6. Data Cleaning & Validation
Before inserting data into actual tables, the following processes were performed:

- Date format normalization
- NULL and empty value handling
- Data type conversion
- Duplicate removal
- Foreign key validation
- Business rule enforcement

Only **validated and clean data** is moved to the actual tables.

---

## 7. Data Transformation
During data movement from staging to actual tables:
- Derived columns were calculated
- Invalid records were filtered out
- Relationships between entities were enforced
- Raw operational data was converted into analytical format

---

## 8. Processing Strategy
- SQL scripts executed in a logical sequence
- Each script performs one specific responsibility
- Errors are isolated and easy to debug
- Data can be reprocessed without data loss

This approach mirrors **real ETL pipelines**


---

## 10. Documentation
- ER diagrams explain table relationships
- Workflow diagrams show data movement
- SQL scripts are modular and readable
- Naming conventions follow SQL standards

---

## 11. Business Perspective
From a **Library Chairman or Administrator’s viewpoint**, this system helps:
- Monitor resource utilization
- Track reader activity
- Evaluate operational efficiency
- Analyze fund usage and fines
- Enable data-driven decision-making

---

## 12. Skills Demonstrated
- SQL database design
- Data staging and ETL concepts
- Data cleaning and validation
- Analytical data modeling
- Real-world project structuring
- Professional documentation

---

## 13. Conclusion
This project showcases a **full SQL data lifecycle**, focusing on **process, structure, and reliability** rather than isolated queries.

It represents how real analytical systems are built and maintained in production environments.

---

## 14. Author
**Phani Inturi**  
SQL Data Analyst | Aspiring Data Scientist  
GitHub: https://github.com/phani0011



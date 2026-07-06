# Energy Site Operations Database

## Project Overview

This project is a relational SQL database designed to track facilities, equipment, employees, inspections, and maintenance records for a regional energy operations environment.

The goal of the project is to model how an operations or facilities team could organize asset information, inspection results, maintenance activity, and facility-level reporting in a structured database.

## Business Problem

Organizations that manage energy or infrastructure sites need reliable ways to track:

- Which equipment is located at each facility
- Which equipment has passed or failed inspection
- Maintenance activity and repair costs
- Employees assigned to each facility
- Facility-level maintenance spending

This database supports those needs by organizing operational records into related tables and allowing business questions to be answered with SQL queries.

## Database Design

The database includes five main tables:

- `Facility`
- `Equipment`
- `Employee`
- `InspectionRecord`
- `MaintenanceRecord`

The tables are connected using primary keys and foreign keys. The included ERD image shows the relationships between the entities.

## SQL Skills Demonstrated

This project demonstrates:

- Relational database design
- Primary keys and foreign keys
- Table creation with `CREATE TABLE`
- Sample data insertion with `INSERT INTO`
- SQL joins
- Filtering with `WHERE`
- Aggregation with `SUM()`
- Grouping with `GROUP BY`
- Sorting with `ORDER BY`
- Subqueries using `NOT IN`

## Business Questions Answered

The SQL queries answer questions such as:

1. Which inspections failed?
2. What are all inspection records with equipment names included?
3. Which maintenance job cost the most?
4. How much has each facility spent on maintenance?
5. Which equipment is located at each facility?
6. Which employees work at each facility?
7. Which equipment has never failed inspection?
8. Which inspections occurred in June?

## Files in This Repository

- `portfolio project.sql` — SQL script containing database creation, sample data, and queries
- `Portfolio Project SQL (6).pdf` — PDF version of the SQL project
- `ERD.jpg` — entity relationship diagram for the database

## Tools Used

- MySQL Workbench
- SQL
- Entity Relationship Diagram design
- GitHub

- Update README with project overview

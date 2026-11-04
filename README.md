Employee Management and Attendance Tracking System

A database-driven system designed to manage employee information and track employee attendance. The project uses Oracle SQL and PL/SQL to demonstrate database design, data management, security, and automated database operations.

📌 Project Overview

The Employee Management and Attendance Tracking System provides a structured way to manage employee records and attendance information.

The system includes database tables, relationships, constraints, sample data, SQL queries, user roles, permissions, views, procedures, functions, and triggers.

✨ Features

* Manage employee information and employment details.
* Track employee attendance records.
* Maintain data integrity using primary keys, foreign keys, unique constraints, and check constraints.
* Automatically generate employee and attendance IDs using sequences.
* Query active employees and attendance issues.
* Implement role-based access control for different types of users.
* Use a restricted view to control employee access to attendance information.
* Use PL/SQL procedures and functions for reusable database operations.
* Use a trigger to respond automatically to salary increases.

🗂️ Database Structure

The system is based on two main tables:

Employees

The employees table stores employee information, including:

* Employee ID
* Full name
* Department
* Job code
* Employment status
* Hire date
* Email
* Phone number
* Salary
* Manager ID
* Database username

The employee_id is the primary key. The manager_id creates a self-referencing relationship that connects an employee to their manager.

Attendance

The attendance table stores employee attendance information, including:

* Attendance ID
* Employee ID
* Attendance date
* Time in
* Time out
* Attendance status

Each attendance record is connected to an employee through a foreign key.

💻 Technologies Used

* Oracle SQL
* PL/SQL
* Oracle Database
* SQL Developer or another Oracle database client

🔐 Security and Access Control

The project demonstrates role-based access control by creating different users and roles with different permissions.

HR Administrator

The HR Administrator has full access to employee and attendance data.

Department Manager

The Department Manager can view employee information and manage attendance records based on the assigned permissions.

Regular Employee

The Regular Employee has restricted access to attendance information through a dedicated view.

The system uses the database username and SYS_CONTEXT('USERENV', 'SESSION_USER') to identify the current user and control access to their attendance data.

⚙️ PL/SQL Components

Procedure: Count_High_Salaries

This procedure counts the number of employees with a salary above 8,000 and returns the result through an output parameter.

Function: Calculate_Annual_Salary

This function calculates an employee’s annual salary and adds a bonus based on salary conditions.

Trigger: Congratulate on Salary Increase

This trigger runs automatically after an employee’s salary is increased and displays a message about the salary update.

🔎 Sample Queries

The project includes queries to:

* View all active employees.
* Display employee information by department.
* Identify recent attendance issues, such as late or absent employees.
* Combine employee and attendance information using SQL JOIN operations.

🚀 How to Run the Project

1. Open Oracle SQL Developer or another Oracle database client.
2. Create or connect to an Oracle database.
3. Open the SQL project file.
4. Run the script in the correct order.
5. Review the created tables, sample data, queries, and PL/SQL components.

📁 Project Files

* Employee Attendance Management.sql — Contains the complete database implementation, including tables, sample data, security settings, queries, views, procedures, functions, and triggers.

🎯 Learning Outcomes

This project demonstrates practical knowledge of:

* Relational database design.
* SQL table creation and data manipulation.
* Database constraints and relationships.
* Sequences and automated ID generation.
* SQL queries and JOIN operations.
* User roles and database permissions.
* Views for controlled data access.
* PL/SQL procedures and functions.
* Database automation using triggers.

👩‍💻 Author
Waad Alhmoud

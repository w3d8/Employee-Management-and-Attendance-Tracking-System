-------------------------------------------
-- 1. Create Enhanced Employee Table
-------------------------------------------

CREATE TABLE employees (
    employee_id NUMBER PRIMARY KEY,
    full_name VARCHAR2(100) NOT NULL,
    department VARCHAR2(50),
    job_code VARCHAR2(20) UNIQUE,
    status VARCHAR2(20) DEFAULT 'Active',
    -- Additional employee details
    hire_date DATE,
    email VARCHAR2(100) UNIQUE,
    phone_number VARCHAR2(20),
    salary NUMBER(10,2),
    manager_id NUMBER,
    CONSTRAINT fk_manager FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

-------------------------------------------
-- 2. Create Attendance Table (unchanged)
-------------------------------------------

CREATE TABLE attendance (
    attendance_id NUMBER PRIMARY KEY,
    employee_id NUMBER NOT NULL,
    attendance_date DATE NOT NULL,
    time_in TIMESTAMP,
    time_out TIMESTAMP,
    status VARCHAR2(20) DEFAULT 'Present' CHECK (status IN ('Present', 'Absent', 'Late', 'On Leave')),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-------------------------------------------
-- 3. Create Sequences (unchanged)
-------------------------------------------

CREATE SEQUENCE seq_employees START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_attendance START WITH 1 INCREMENT BY 1;

-------------------------------------------
-- 4. Insert Expanded Employee Data (6 employees)
-------------------------------------------

-- Management
INSERT INTO employees VALUES (seq_employees.NEXTVAL, 'John Smith', 'Executive', 'CEO001', 'Active', 
                            TO_DATE('2010-01-15', 'YYYY-MM-DD'), 'john.smith@company.com', '555-0101', 12000, NULL);

INSERT INTO employees VALUES (seq_employees.NEXTVAL, 'Sarah Johnson', 'HR', 'HR001', 'Active',
                            TO_DATE('2015-03-22', 'YYYY-MM-DD'), 'sarah.johnson@company.com', '555-0102', 8000, 1);

-- Department staff
INSERT INTO employees VALUES (seq_employees.NEXTVAL, 'Michael Brown', 'IT', 'IT001', 'Active',
                            TO_DATE('2018-05-10', 'YYYY-MM-DD'), 'michael.brown@company.com', '555-0103', 6000, 1);

INSERT INTO employees VALUES (seq_employees.NEXTVAL, 'Emily Davis', 'Sales', 'SALES001', 'Active',
                            TO_DATE('2019-07-14', 'YYYY-MM-DD'), 'emily.davis@company.com', '555-0104', 5500, 1);

INSERT INTO employees VALUES (seq_employees.NEXTVAL, 'Robert Wilson', 'Finance', 'FIN001', 'Active',
                            TO_DATE('2020-02-18', 'YYYY-MM-DD'), 'robert.wilson@company.com', '555-0105', 5800, 1);

INSERT INTO employees VALUES (seq_employees.NEXTVAL, 'Lisa Miller', 'Marketing', 'MKT001', 'Inactive',
                            TO_DATE('2021-09-05', 'YYYY-MM-DD'), 'lisa.miller@company.com', '555-0106', 5200, 1);

-------------------------------------------
-- 5. User Roles and Permissions (UNCHANGED)
-------------------------------------------

-- HR Administrator (Full Access)
CREATE USER hr_admin IDENTIFIED BY admin123;
GRANT CONNECT, RESOURCE TO hr_admin;
GRANT ALL PRIVILEGES ON employees TO hr_admin;
GRANT ALL PRIVILEGES ON attendance TO hr_admin;

-- Department Manager (Limited Access)
CREATE USER dept_manager IDENTIFIED BY manager456;
GRANT CONNECT TO dept_manager;
GRANT SELECT, INSERT, UPDATE ON attendance TO dept_manager;
GRANT SELECT ON employees TO dept_manager;

-- Regular Employee (View Only)
CREATE USER emp_user IDENTIFIED BY user789;
GRANT CONNECT TO emp_user;
GRANT SELECT ON attendance TO emp_user;

-------------------------------------------
-- 6. Sample Attendance Data (expanded)
-------------------------------------------

-- Insert attendance records for last week
INSERT INTO attendance VALUES (seq_attendance.NEXTVAL, 2, SYSDATE-7, 
                            TO_TIMESTAMP(TO_CHAR(SYSDATE-7,'YYYY-MM-DD')||' 08:05:00','YYYY-MM-DD HH24:MI:SS'), 
                            TO_TIMESTAMP(TO_CHAR(SYSDATE-7,'YYYY-MM-DD')||' 16:55:00','YYYY-MM-DD HH24:MI:SS'), 'Present');

INSERT INTO attendance VALUES (seq_attendance.NEXTVAL, 3, SYSDATE-6,
TO_TIMESTAMP(TO_CHAR(SYSDATE-6,'YYYY-MM-DD')||' 09:15:00','YYYY-MM-DD HH24:MI:SS'), 
                            TO_TIMESTAMP(TO_CHAR(SYSDATE-6,'YYYY-MM-DD')||' 17:30:00','YYYY-MM-DD HH24:MI:SS'), 'Late');

INSERT INTO attendance VALUES (seq_attendance.NEXTVAL, 4, SYSDATE-5, NULL, NULL, 'On Leave');

INSERT INTO attendance VALUES (seq_attendance.NEXTVAL, 5, SYSDATE-4, 
                            TO_TIMESTAMP(TO_CHAR(SYSDATE-4,'YYYY-MM-DD')||' 08:10:00','YYYY-MM-DD HH24:MI:SS'), 
                            TO_TIMESTAMP(TO_CHAR(SYSDATE-4,'YYYY-MM-DD')||' 17:05:00','YYYY-MM-DD HH24:MI:SS'), 'Present');

-------------------------------------------
-- 7. Useful Queries (unchanged structure)
-------------------------------------------

-- View all active employees
SELECT employee_id, full_name, department, job_code, email, phone_number
FROM employees
WHERE status = 'Active'
ORDER BY department, full_name;

-- View attendance issues
SELECT e.full_name, a.attendance_date, a.status, a.time_in, a.time_out
FROM employees e
JOIN attendance a ON e.employee_id = a.employee_id
WHERE a.status IN ('Late', 'Absent')
AND a.attendance_date BETWEEN SYSDATE-7 AND SYSDATE
ORDER BY a.attendance_date;

COMMIT;

-------------------------------------------
-- 8. Roles and Restricted View (with FIX)
-------------------------------------------

-- 1. Create roles
CREATE ROLE role_hr_admin;
CREATE ROLE role_dept_manager;
CREATE ROLE role_emp_user;

-- 2. Grant permissions based on tasks

-- HR Admin: Full control
GRANT SELECT, INSERT, UPDATE, DELETE ON employees TO role_hr_admin;
GRANT SELECT, INSERT, UPDATE, DELETE ON attendance TO role_hr_admin;

-- Department Manager: View employees + manage attendance
GRANT SELECT ON employees TO role_dept_manager;
GRANT SELECT, INSERT, UPDATE ON attendance TO role_dept_manager;

-- Regular Employee: View only their own attendance (via View)
-- No direct access to attendance table
-- Instead, view only their records
GRANT SELECT ON emp_user_attendance_view TO role_emp_user;

-- 3. Assign roles to users
GRANT role_hr_admin TO hr_admin;
GRANT role_dept_manager TO dept_manager;
GRANT role_emp_user TO emp_user;






CREATE INDEX idx_emp_status_dept ON employees(status, department); 

SELECT e.full_name, a.attendance_date, a.status FROM employees e JOIN attendance a ON e.employee_id = a.employee_id WHERE a.status = 'Late'; 

EXPLAIN PLAN FOR 
SELECT full_name FROM employees WHERE status = 'Active'; 

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
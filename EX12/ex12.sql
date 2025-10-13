-- Departments table
CREATE TABLE departments_ex12 (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50)
);

-- Employees table
CREATE TABLE employees_ex12 (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT REFERENCES departments_ex12(department_id),
    salary NUMERIC(10,2),
    hire_date DATE,
    email VARCHAR(100)
);

-- Projects table
CREATE TABLE projects_ex12 (
    project_id SERIAL PRIMARY KEY,
    project_name VARCHAR(100),
    department_id INT REFERENCES departments_ex12(department_id),
    budget NUMERIC(10,2)
);

-- Insert sample departments
INSERT INTO departments_ex12 (department_name) VALUES
('HR'),
('IT'),
('Finance'),
('Sales');

-- Insert sample employees
INSERT INTO employees_ex12 (first_name, last_name, department_id, salary, hire_date, email) VALUES
('Alice', 'Brown', 1, 40000, '2018-03-15', 'alice.brown@company.com'),
('Bob', 'Smith', 2, 55000, '2019-07-22', 'bob.smith@company.com'),
('Charlie', 'Davis', 2, 60000, '2020-01-10', NULL),
('Diana', 'Miller', 3, 45000, '2017-11-05', 'diana.miller@company.com'),
('Evan', 'Wilson', 4, 70000, '2021-04-01', 'evan.wilson@company.com'),
('Fiona', 'Taylor', 4, 72000, '2016-06-25', NULL);

-- Insert sample projects
INSERT INTO projects_ex12 (project_name, department_id, budget) VALUES
('HR Portal', 1, 12000),
('Cloud Migration', 2, 25000),
('Budget Tracker', 3, 18000),
('Sales Dashboard', 4, 30000),
('IT Infrastructure', 2, 40000);

SELECT * FROM projects_ex12;
SELECT * FROM employees_ex12;
1. Find the top 3 highest-paid employees per department.
SELECT employee_id, first_name, last_name, department_id, salary
FROM (
    SELECT *,
           RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rnk
    FROM employees_ex12
) t
WHERE rnk <= 3;


2. Show total project budget per department, only where total > 20,000.
SELECT department_id, sum(budget)
FROM projects_ex12
GROUP BY department_id
HAVING sum(budget) > 20000;

3. List all employees with distinct email domains (use SPLIT_PART(email, '@', 2)).
SELECT DISTINCT SPLIT_PART(email, '@', 2) as domain_email
FROM employees_ex12
WHERE email IS NOT NULL;

4. Show each employee’s salary and rounded annual salary.
SELECT employee_id, CONCAT(first_name, ' ', last_name), salary, ROUND(salary*12, 2) as annual_salary
FROM employees_ex12;

5. Find the average salary per department, but exclude employees with NULL emails.
SELECT e.department_id, d.department_name, AVG(salary) AS avg_salary
FROM employees_ex12 e
JOIN departments_ex12 d 
  ON e.department_id = d.department_id
WHERE e.email IS NOT NULL
GROUP BY e.department_id, d.department_name;

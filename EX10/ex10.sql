-- Departments table
CREATE TABLE departments_ex10 (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50)
);

-- Employees table
CREATE TABLE employees_ex10 (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT REFERENCES departments_ex10(department_id)
);

-- Projects table
CREATE TABLE projects_ex10 (
    project_id SERIAL PRIMARY KEY,
    project_name VARCHAR(100),
    department_id INT REFERENCES departments_ex10(department_id)
);

-- Insert sample departments
INSERT INTO departments_ex10 (department_name) VALUES
('HR'),
('IT'),
('Finance'),
('Sales');

-- Insert sample employees
INSERT INTO employees_ex10 (first_name, last_name, department_id) VALUES
('Alice', 'Brown', 1),
('Bob', 'Smith', 2),
('Charlie', 'Davis', 2),
('Diana', 'Miller', 3),
('Evan', 'Wilson', NULL);  -- has no department

-- Insert sample projects
INSERT INTO projects_ex10 (project_name, department_id) VALUES
('Recruitment System', 1),
('Website Upgrade', 2),
('Budget Planning', 3),
('Sales Dashboard', 4),
('Cloud Migration', 2);


SELECT * FROM employees_ex10;
SELECT * FROM departments_ex10;
SELECT * FROM projects_ex10;
1. Show employee names with their department names.
SELECT e.employee_id, CONCAT(first_name, ' ', last_name) as employee_name, e.department_id, d.department_name
FROM employees_ex10 e
JOIN departments_ex10 d
ON e.department_id = d.department_id;

2. List all projects with their department names.
SELECT p.project_id, p.project_name, d.department_name
FROM projects_ex10 p
LEFT JOIN departments_ex10 d
ON p.department_id = d.department_id;

3. Find employees who do not belong to any department.
SELECT e.employee_id, CONCAT(first_name, ' ', last_name), e.department_id, d.department_name
FROM employees_ex10 e
LEFT JOIN departments_ex10 d
ON e.department_id = d.department_id
WHERE d.department_id IS NULL;

4. Show all departments with their employees (even if no employees).
SELECT d.department_id, d.department_name, e.employee_id, CONCAT(first_name, ' ', last_name)
FROM departments_ex10 d	
LEFT JOIN employees_ex10 e
ON d.department_id = e.department_id;

5 .Show all employees and all projects, matching by department (even if no match).
SELECT e.employee_id, CONCAT(first_name, ' ', last_name), p.project_id, p.project_name, d.department_name
FROM employees_ex10 e
FULL JOIN departments_ex10 d ON e.department_id = d.department_id
FULL JOIN projects_ex10 p ON d.department_id = p.department_id;
-- Create employees table with some NULL values
CREATE TABLE employees_ex8 (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    manager_id INT
);

-- Insert sample employees
INSERT INTO employees_ex8 (first_name, last_name, email, phone, manager_id) VALUES
('Alice', 'Brown', 'alice.brown@company.com', '123-456-7890', NULL),
('Bob', 'Smith', NULL, '987-654-3210', 1),
('Charlie', 'Davis', 'charlie.davis@company.com', NULL, 2),
('Diana', 'Miller', NULL, NULL, 1),
('Evan', 'Wilson', 'evan.wilson@company.com', '555-111-2222', NULL);


SELECT * FROM employees_ex8
1. Show all employees who have no email address.
SELECT *
FROM employees_ex8
WHERE email IS NULL;

2. Show all employees who have a phone number.
SELECT *
FROM employees_ex8
WHERE phone IS NOT NULL;

3. Count how many employees have no manager assigned.
SELECT count(*) as no_manager_count
FROM employees_ex8
WHERE manager_id IS NULL;

4. Replace all NULL phone numbers with 'Unknown' using COALESCE().
SELECT employee_id, first_name, last_name, email, COALESCE(phone, 'Unknown') as phone, manager_id
FROM employees_ex8;

5. Show all employees where either email OR phone is missing.
SELECT *
FROM employees_ex8
WHERE email IS NULL OR phone IS NULL;
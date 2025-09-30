-- Create employees table
CREATE TABLE employees_ex9 (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    age INT,
    salary NUMERIC(10,2),
    department VARCHAR(50)
);

-- Insert sample employees
INSERT INTO employees_ex9 (first_name, last_name, age, salary, department) VALUES
('Alice', 'Brown', 25, 38000, 'HR'),
('Bob', 'Smith', 45, 52000, 'IT'),
('Charlie', 'Davis', 32, 61000, 'Finance'),
('Diana', 'Miller', 29, 45000, 'Sales'),
('Evan', 'Wilson', 54, 75000, 'IT');


SELECT * FROM employees_ex9
1. Label employees as "High" if salary > 50,000, otherwise "Low".
SELECT *, 
		CASE 
			WHEN salary > 50000 then 'High'
			ELSE 'Low'
		END as level_salary
FROM employees_ex9;

2. Show each employee’s age group: <30 → 'Young', 30–50 → 'Mid', >50 → 'Senior'.
SELECT *,
		CASE
			WHEN age > 50 then 'Senior'
			WHEN age BETWEEN 30 AND 50 then 'Mid'
			ELSE 'Young'
		END as level_age
FROM employees_ex9;

3. Give a 10% bonus only if salary < 40,000, otherwise 5%.
SELECT *,
		CASE
			WHEN salary < 40000 then salary * 0.1
			ELSE salary * 0.05
		END as bonus_amount
FROM employees_ex9;

4. Categorize departments: 'IT' and 'Finance' → 'Technical', others → 'Non-Technical'.
SELECT *,
		CASE department
			WHEN 'IT' THEN 'Technical'
			WHEN 'Finance' THEN 'Technical'
			ELSE 'Non-Technical'
		END as categorize_departments
FROM employees_ex9;

5. Assign grades based on salary: >=70,000 → 'A', 50,000–69,999 → 'B', <50,000 → 'C'.
SELECT *,
		CASE
			WHEN salary >= 70000 THEN 'A'
			WHEN salary BETWEEN 50000 AND 69999 THEN 'B'
			ELSE 'C'
		END as assign_salary
FROM employees_ex9;
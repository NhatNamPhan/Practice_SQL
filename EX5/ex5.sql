-- Create employees table
CREATE TABLE employees_ex5 (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    base_salary NUMERIC(10,2),
    bonus NUMERIC(10,2),
    tax_rate NUMERIC(5,2) -- percentage (e.g., 10 = 10%)
);

-- Insert sample employees
INSERT INTO employees_ex5 (first_name, last_name, base_salary, bonus, tax_rate) VALUES
('Alice', 'Brown', 4000, 500, 10),
('Bob', 'Smith', 5500, 700, 12),
('Charlie', 'Davis', 6000, 0, 15),
('Diana', 'Miller', 4500, 600, 8),
('Evan', 'Wilson', 7000, 1000, 20);


SELECT * FROM employees_ex5
1. Show each employee’s total income (base_salary + bonus).
SELECT employee_id, 
		CONCAT(first_name, ' ', last_name) as employee, 
		(base_salary + bonus) as income
FROM employees_ex5;

2. Show each employee’s annual salary ((base_salary + bonus) * 12).
SELECT employee_id, 
		CONCAT(first_name, ' ', last_name) as employee, 
		((base_salary + bonus)*12) as annual_income
FROM employees_ex5;

3. Calculate each employee’s tax amount ((base_salary + bonus) * tax_rate / 100).
SELECT employee_id, 
		CONCAT(first_name, ' ', last_name) as employee, 
		((base_salary + bonus)* tax_rate /100) as tax_amount
FROM employees_ex5;

4. Show each employee’s salary after tax deduction.
SELECT employee_id, 
		CONCAT(first_name, ' ', last_name) as employee, 
		(base_salary + bonus)- ((base_salary + bonus)* tax_rate /100) as salary_after_tax
FROM employees_ex5;

5 .Show the remainder when dividing each employee’s annual salary by 1000.
SELECT employee_id, 
		CONCAT(first_name, ' ', last_name) as employee, 
		((base_salary + bonus) * 12) % 1000 as remainder
FROM employees_ex5;
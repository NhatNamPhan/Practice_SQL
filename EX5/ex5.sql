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

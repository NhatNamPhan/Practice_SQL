-- Create table departments
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL
);

-- Create table employees
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT REFERENCES departments(department_id),
    salary NUMERIC(10,2),
    hire_date DATE,
    email VARCHAR(100)
);

-- Insert sample data into departments
INSERT INTO departments (department_name) VALUES
('HR'),
('IT'),
('Finance'),
('Sales');

-- Insert sample data into employees
INSERT INTO employees (first_name, last_name, department_id, salary, hire_date, email) VALUES
('Alice', 'Brown', 1, 40000, '2018-03-15', 'alice.brown@company.com'),
('Bob', 'Smith', 2, 55000, '2019-07-22', 'bob.smith@company.com'),
('Charlie', 'Davis', 2, 60000, '2020-01-10', NULL),
('Diana', 'Miller', 3, 45000, '2017-11-05', 'diana.miller@company.com'),
('Evan', 'Wilson', 4, 70000, '2021-04-01', 'evan.wilson@company.com'),
('Fiona', 'Taylor', 4, 72000, '2016-06-25', NULL);




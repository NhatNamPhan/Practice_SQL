-- Create table
CREATE TABLE employees_ex11 (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    hire_date DATE,
    birth_date DATE,
    salary NUMERIC(10,2)
);

-- Insert sample employees
INSERT INTO employees_ex11 (first_name, last_name, hire_date, birth_date, salary) VALUES
('Alice', 'Brown', '2018-03-15', '1995-06-21', 40000),
('Bob', 'Smith', '2019-07-22', '1988-01-10', 55000),
('Charlie', 'Davis', '2020-01-10', '1992-12-03', 60000),
('Diana', 'Miller', '2017-11-05', '1985-09-14', 45000),
('Evan', 'Wilson', '2021-04-01', '1998-02-25', 70000);

SELECT * FROM employees_ex11

1. Show today’s date using CURRENT_DATE.

2. Extract the year from each employee’s hire date.

3. Find employees hired in 2020.

4. Calculate how many years each employee has worked (hint: AGE() or DATE_PART).

5. Show employees who were born in February.

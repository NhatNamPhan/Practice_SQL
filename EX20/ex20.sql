CREATE TABLE departments_ex20 (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

CREATE TABLE employees_ex20 (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    salary INT,
    manager_id INT,
    department_id INT
);

CREATE TABLE customers_ex20 (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

CREATE TABLE orders_ex20 (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE
);

CREATE TABLE projects_ex20 (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50)
);

CREATE TABLE employee_projects_ex20 (
    employee_id INT,
    project_id INT
);

CREATE TABLE products_ex20 (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE order_details_ex20 (
    order_id INT,
    product_id INT,
    quantity INT
);

INSERT INTO departments_ex20 VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing');

INSERT INTO employees_ex20 VALUES
(1, 'Alice', 70000, NULL, 1),
(2, 'Bob', 50000, 1, 1),
(3, 'Carol', 48000, 1, 1),
(4, 'David', 60000, NULL, 2),
(5, 'Emma', 45000, 4, 2),
(6, 'Frank', 80000, NULL, 3),
(7, 'Grace', 40000, 6, 3),
(8, 'Helen', 52000, NULL, NULL);

INSERT INTO customers_ex20 VALUES
(1, 'John'),
(2, 'Mary'),
(3, 'Steve'),
(4, 'Anna');

INSERT INTO orders_ex20 VALUES
(1, 1, '2023-01-10'),
(2, 1, '2023-02-15'),
(3, 2, '2023-03-01'),
(4, 3, '2022-12-20');

INSERT INTO projects_ex20 VALUES
(1, 'Website'),
(2, 'Mobile App'),
(3, 'Data Migration');

INSERT INTO employee_projects_ex20 VALUES
(1, 1),
(2, 1),
(2, 2),
(4, 3);

INSERT INTO products_ex20 VALUES
(1, 'Laptop', 1200.00),
(2, 'Mouse', 25.00),
(3, 'Keyboard', 75.00),
(4, 'Monitor', 300.00),
(5, 'Headphones', 50.00);

INSERT INTO order_details_ex20 VALUES
(1, 1, 2),
(1, 2, 5),
(2, 3, 1),
(3, 1, 1),
(4, 4, 2);


SELECT * FROM departments_ex20;
SELECT * FROM employees_ex20;
SELECT * FROM customers_ex20;
SELECT * FROM orders_ex20;
SELECT * FROM projects_ex20;
SELECT * FROM employee_projects_ex20;
SELECT * FROM products_ex20;
SELECT * FROM order_details_ex20;

Exercise 1: Self Join  
1. Show each employee along with their manager’s name.
SELECT 
	e1.employee_id,
	e1.employee_name,
	e2.employee_id AS manager_id,
	e2.employee_name AS manager_name
FROM employees_ex20 e1
JOIN employees_ex20 e2 ON e2.employee_id = e1.manager_id;

2. List employees who have the same manager.
SELECT 
	e1.employee_id,
	e1.employee_name,
	e2.employee_id AS manager_id,
	e2.employee_name AS manager_name
FROM employees_ex20 e1
JOIN employees_ex20 e2 ON e2.employee_id = e1.manager_id
WHERE e1.manager_id IN (
	SELECT manager_id
	FROM employees_ex20
	WHERE manager_id IS NOT NULL
	GROUP BY manager_id
	HAVING count(*) > 1
)
ORDER BY e1.employee_id;

3. Find managers who manage more than 1 employee.
SELECT 
	e1.employee_id AS manager_id,
	e1.employee_name AS manager_name,
	count(*) AS total_employees
FROM employees_ex20 e1
JOIN employees_ex20 e2 ON e2.manager_id = e1.employee_id
WHERE e2.manager_id IN (
	SELECT manager_id
	FROM employees_ex20
	WHERE manager_id IS NOT NULL
	GROUP BY manager_id
	HAVING count(*) > 1
)
GROUP BY e1.employee_id;

4. Show employees who do not have a manager.
SELECT * FROM employees_ex20
WHERE manager_id IS NULL;

5. Display employee–manager pairs ordered by manager name.
SELECT 
	e1.employee_id,
	e1.employee_name,
	e2.employee_id AS manager_id,
	e2.employee_name AS manager_name
FROM employees_ex20 e1
JOIN employees_ex20 e2 ON e2.employee_id = e1.manager_id
ORDER BY manager_name;
 
Exercise 2: INNER vs LEFT JOIN
1. Show each employee along with their manager’s name.
SELECT 
	e1.employee_id,
	e1.employee_name,
	e2.employee_id AS manager_id,
	e2.employee_name AS manager_name
FROM employees_ex20 e1
JOIN employees_ex20 e2 ON e2.employee_id = e1.manager_id;

2. List employees who have the same manager.
SELECT 
	e1.employee_id,
	e1.employee_name,
	e2.employee_id AS manager_id,
	e2.employee_name AS manager_name
FROM employees_ex20 e1
JOIN employees_ex20 e2 ON e2.employee_id = e1.manager_id
WHERE e1.manager_id IN (
	SELECT manager_id
	FROM employees_ex20
	WHERE manager_id IS NOT NULL
	GROUP BY manager_id
	HAVING count(*) > 1
)
ORDER BY e1.employee_id;

3. Find managers who manage more than 1 employee.
SELECT 
	e1.employee_id AS manager_id,
	e1.employee_name AS manager_name,
	count(*) AS total_employees
FROM employees_ex20 e1
JOIN employees_ex20 e2 ON e2.manager_id = e1.employee_id
WHERE e2.manager_id IN (
	SELECT manager_id
	FROM employees_ex20
	WHERE manager_id IS NOT NULL
	GROUP BY manager_id
	HAVING count(*) > 1
)
GROUP BY e1.employee_id;

4. Show employees who do not have a manager.
SELECT * FROM employees_ex20
WHERE manager_id IS NULL;

5. Display employee–manager pairs ordered by manager name.
SELECT 
	e1.employee_id,
	e1.employee_name,
	e2.employee_id AS manager_id,
	e2.employee_name AS manager_name
FROM employees_ex20 e1
JOIN employees_ex20 e2 ON e2.employee_id = e1.manager_id
ORDER BY manager_name;

Exercise 3: Anti Join (NOT EXISTS/LEFT JOIN IS NULL)
1. Show all employees and their department names.
SELECT e.employee_id, e.employee_name, de.department_id, de.department_name
FROM employees_ex20 e
JOIN departments_ex20 de ON de.department_id = e.department_id;

2. Show all employees, including those without a department.
SELECT e.employee_id, e.employee_name, de.department_id, de.department_name
FROM employees_ex20 e
LEFT JOIN departments_ex20 de ON de.department_id = e.department_id;

3. Find departments that currently have no employees.
SELECT *
FROM departments_ex20
WHERE department_id NOT IN (
	SELECT de.department_id
	FROM departments_ex20 de
	JOIN employees_ex20 e ON de.department_id = e.department_id
);

4. Count employees per department (include empty departments).
SELECT de.department_id, de.department_name, count(e.employee_id)
FROM departments_ex20 de
LEFT JOIN employees_ex20 e ON e.department_id = de.department_id
GROUP BY de.department_id, de.department_name;

5. Show only employees who belong to a department.
SELECT e.employee_id, e.employee_name, de.department_id, de.department_name
FROM employees_ex20 e
JOIN departments_ex20 de ON de.department_id = e.department_id;

Exercise 4: Semi Join (IN/EXISTS)
1. List customers who have placed at least one order.
SELECT customer_id, customer_name
FROM customers_ex20 
WHERE customer_id IN (
	SELECT customer_id
	FROM orders_ex20
);

2. Show employees who manage at least one other employee.
SELECT 
	e1.employee_id AS manager_id,
	e1.employee_name AS manager_name, 
	e2.employee_id,
	e2.employee_name
FROM employees_ex20 e1
JOIN employees_ex20 e2 ON e2.manager_id = e1.employee_id;

3. Find products that appear in at least one order.
SELECT p.product_id, p.product_name
FROM products_ex20 p
WHERE EXISTS (
	SELECT 1
	FROM order_details_ex20 od
	WHERE od.product_id = p.product_id
);
4. Show departments that have employees earning more than 50,000.
SELECT DISTINCT d.department_id, d.department_name
FROM departments_ex20 d
WHERE EXISTS (
	SELECT 1
	FROM employees_ex20 e
	WHERE e.department_id = d.department_id
	AND e.salary > 50000
);

5. List customers who placed orders in 2023.
SELECT DISTINCT c.customer_id, c.customer_name
FROM customers_ex20 c
WHERE EXISTS (
	SELECT 1
	FROM orders_ex20 o
	WHERE o.customer_id = c.customer_id
	AND EXTRACT(year FROM o.order_date) = 2023
);

Exercise 5: Advanced Join Scenarios
1. Show employees who work in the same department as “Alice”.
SELECT e2.employee_id, e2.employee_name, e2.department_id
FROM employees_ex20 e1
JOIN employees_ex20 e2 ON e1.department_id = e2.department_id
WHERE e1.employee_name = 'Alice'
AND e2.employee_name != 'Alice';

2. Find customers who ordered the same product more than once.
SELECT c.customer_id, c.customer_name, od.product_id, p.product_name, COUNT(*) AS order_count
FROM customers_ex20 c
JOIN orders_ex20 o ON o.customer_id = c.customer_id
JOIN order_details_ex20 od ON od.order_id = o.order_id
JOIN products_ex20 p ON p.product_id = od.product_id
GROUP BY c.customer_id, c.customer_name, od.product_id, p.product_name
HAVING COUNT(*) > 1;

3. List employees who earn more than the average salary in their department.
SELECT e.employee_id, e.employee_name, e.department_id, e.salary
FROM employees_ex20 e
WHERE e.salary > (
	SELECT AVG(e2.salary)
	FROM employees_ex20 e2
	WHERE e2.department_id = e.department_id
);

4. Show departments where all employees earn more than 40,000.
SELECT d.department_id, d.department_name
FROM departments_ex20 d
WHERE NOT EXISTS (
	SELECT 1
	FROM employees_ex20 e
	WHERE e.department_id = d.department_id
	AND e.salary <= 40000
)
AND EXISTS (
	SELECT 1
	FROM employees_ex20 e
	WHERE e.department_id = d.department_id
);

5. Find managers whose subordinates earn more than they do.
SELECT DISTINCT 
	mgr.employee_id AS manager_id,
	mgr.employee_name AS manager_name,
	mgr.salary AS manager_salary,
	emp.employee_id AS subordinate_id,
	emp.employee_name AS subordinate_name,
	emp.salary AS subordinate_salary
FROM employees_ex20 mgr
JOIN employees_ex20 emp ON emp.manager_id = mgr.employee_id
WHERE emp.salary > mgr.salary
ORDER BY mgr.employee_id, emp.salary DESC;

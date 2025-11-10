CREATE TABLE employees_ex15 (
    employee_id SERIAL PRIMARY KEY,
    employee_name VARCHAR(50),
    department VARCHAR(50)
);

CREATE TABLE sales_ex15 (
    sale_id SERIAL PRIMARY KEY,
    employee_id INT REFERENCES employees_ex15(employee_id),
    region VARCHAR(50),
    sale_amount NUMERIC(10,2),
    sale_date DATE
);

INSERT INTO employees_ex15 (employee_name, department) VALUES
('Alice', 'Sales'),
('Bob', 'Sales'),
('Carol', 'Marketing'),
('David', 'Sales');

INSERT INTO sales_ex15 (employee_id, region, sale_amount, sale_date) VALUES
(1, 'North', 800, '2024-01-10'),
(2, 'South', 1200, '2024-01-15'),
(3, 'North', 900, '2024-01-18'),
(1, 'North', 1500, '2024-02-01'),
(4, 'East', 1300, '2024-02-05'),
(2, 'South', 1000, '2024-02-10'),
(3, 'North', 1100, '2024-02-15'),
(4, 'East', 1700, '2024-02-20');



SELECT * FROM employees_ex15;
SELECT * FROM sales_ex15;

1. Rank employees by total sales (highest to lowest).
SELECT employee_id, 
		SUM(sale_amount) AS total_sales,
		RANK() OVER (ORDER BY SUM(sale_amount) DESC) AS rank_employee
FROM sales_ex15
GROUP BY employee_id;

2. Rank sales per region using RANK(), showing ties with the same rank.
SELECT region,
		SUM(sale_amount) AS total_sales,
		RANK() OVER (ORDER BY SUM(sale_amount) DESC) AS rank_region
FROM sales_ex15
GROUP BY region;

3. Rank sales per region using DENSE_RANK(), and compare with RANK().
SELECT region,
		SUM(sale_amount) AS total_sales,
		DENSE_RANK() OVER (ORDER BY SUM(sale_amount) DESC) AS rank_region
FROM sales_ex15
GROUP BY region;

4. Assign a ROW_NUMBER() to each sale ordered by sale_amount descending.
SELECT *, ROW_NUMBER() OVER (ORDER BY sale_amount DESC)
FROM sales_ex15;

5. Find the top 2 sales per region using a window function filter.
WITH rank_sales AS (
	SELECT region,
			sale_id,
			sale_amount,
			RANK() OVER (PARTITION BY region ORDER BY sale_amount DESC) AS sale_rank
	FROM sales_ex15
)
SELECT region, sale_id, sale_amount 
FROM rank_sales
WHERE sale_rank <= 2
ORDER BY region, sale_rank;


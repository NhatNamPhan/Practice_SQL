CREATE TABLE customers_ex16 (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE sales_ex16 (
    sale_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers_ex16(customer_id),
    region VARCHAR(50),
    sale_amount NUMERIC(10,2),
    sale_date DATE
);

INSERT INTO customers_ex16 (customer_name, country)
VALUES ('Alice', 'USA'), ('Bob', 'Canada'), ('Carol', 'UK');

INSERT INTO sales_ex16 (customer_id, region, sale_amount, sale_date)
VALUES
(1, 'North', 200, '2024-01-01'),
(1, 'North', 400, '2024-01-10'),
(2, 'South', 500, '2024-01-12'),
(2, 'South', 800, '2024-02-01'),
(3, 'East', 300, '2024-02-10'),
(1, 'North', 600, '2024-02-15'),
(3, 'East', 900, '2024-02-20'),
(2, 'South', 1000, '2024-02-28');



SELECT * FROM customers_ex16;
SELECT * FROM sales_ex16;

1. Show each sale with a running total of sale_amount ordered by sale_date.
SELECT
	sale_id,
	sale_date,
	sale_amount,
	SUM(sale_amount) OVER (ORDER BY sale_date) AS running_total
FROM sales_ex16
ORDER BY sale_date;
2. For each region, calculate a running total per region ordered by sale_date.
SELECT 
	region,
	sale_id,
	sale_date,
	sale_amount,
	SUM(sale_amount) OVER (
		PARTITION BY region
		ORDER BY sale_date
	) AS runnign_total_region
FROM sales_ex16
ORDER BY region, sale_date;

3. Show each sale with the average sale_amount per region (using AVG() OVER (PARTITION BY region)).
SELECT 
    sale_id,
    region,
    sale_amount,
    AVG(sale_amount) OVER (PARTITION BY region) AS avg_per_region
FROM sales_ex16;

4. Find each customer’s total and average spending using window functions (no GROUP BY).
SELECT 
    s.customer_id,
    c.customer_name,
    SUM(sale_amount) OVER (PARTITION BY s.customer_id) AS total_per_customer,
    AVG(sale_amount) OVER (PARTITION BY s.customer_id) AS avg_per_customer
FROM sales_ex16 s
JOIN customers_ex16 c ON s.customer_id = c.customer_id;

5. Show each region’s sale and its difference from the previous sale (use LAG()).
SELECT 
    region,
    sale_id,
    sale_date,
    sale_amount,
    LAG(sale_amount) OVER (PARTITION BY region ORDER BY sale_date) AS previous_sale,
    sale_amount - LAG(sale_amount) OVER (PARTITION BY region ORDER BY sale_date) AS diff_from_previous
FROM sales_ex16
ORDER BY region, sale_date;


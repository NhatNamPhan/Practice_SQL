DROP TABLE IF EXISTS sales_ex17;

CREATE TABLE sales_ex17 (
    sale_id SERIAL PRIMARY KEY,
    region VARCHAR(50),
    sale_date DATE,
    sale_amount NUMERIC(10,2)
);

INSERT INTO sales_ex17 (region, sale_date, sale_amount) VALUES
('North', '2024-01-01', 500),
('North', '2024-01-15', 700),
('North', '2024-02-01', 650),
('South', '2024-01-05', 400),
('South', '2024-02-05', 900),
('East',  '2024-01-10', 300),
('East',  '2024-02-10', 600);


SELECT * FROM sales_ex17





1. Show each sale with the previous sale amount in the same region.
SELECT region, sale_amount, sale_date, 
		LAG(sale_amount, 1) OVER (PARTITION BY region ORDER BY sale_date) AS previous_sale_amount
FROM sales_ex17;

2. Show each sale with the difference between the current sale and the previous sale (per region).
SELECT region, sale_amount, sale_date, 
		(sale_amount - LAG(sale_amount, 1) OVER (PARTITION BY region ORDER BY sale_date)) AS difference_sale_amount
FROM sales_ex17;
 
3. Show each sale with the next sale amount in the same region.
SELECT region, sale_amount, sale_date, 
		LEAD(sale_amount, 1) OVER (PARTITION BY region ORDER BY sale_date) AS next_sale_amount
FROM sales_ex17;
 
4. Calculate the percentage change from the previous sale per region.
WITH cte AS (
	SELECT 
        region, 
        sale_date, 
        sale_amount,
        LAG(sale_amount, 1) OVER (PARTITION BY region ORDER BY sale_date) AS sale_previous
    FROM sales_ex17
)
SELECT 
	region,
	sale_date,
	sale_amount,
	ROUND((sale_amount - sale_previous) * 100.0 / sale_previous, 2) AS percentage_change
FROM cte;
 
5. Show only the rows where the sale increased compared to the previous sale.
WITH cte AS (
    SELECT 
        region, 
        sale_date, 
        sale_amount,
        LAG(sale_amount, 1) OVER (PARTITION BY region ORDER BY sale_date) AS previous_sale_amount
    FROM sales_ex17
)
SELECT 
    region, 
    sale_date, 
    sale_amount,
    previous_sale_amount
FROM cte
WHERE previous_sale_amount < sale_amount;



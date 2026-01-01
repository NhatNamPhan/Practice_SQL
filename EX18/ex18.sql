DROP TABLE IF EXISTS sales_ex18;

CREATE TABLE sales_ex18 (
    sale_id SERIAL PRIMARY KEY,
    region VARCHAR(50),
    sale_date DATE,
    sale_amount NUMERIC(10,2)
);

INSERT INTO sales_ex18 (region, sale_date, sale_amount) VALUES
('North', '2024-01-01', 100),
('North', '2024-01-05', 200),
('North', '2024-01-10', 300),
('North', '2024-01-20', 400),
('South', '2024-01-03', 150),
('South', '2024-01-08', 250),
('South', '2024-01-15', 350);



SELECT * FROM sales_ex18;


1. Show each sale with a running total per region using ROWS.
SELECT sale_id, region, sale_amount, sale_date, SUM(sale_amount) OVER (
	PARTITION BY region
	ORDER BY sale_date
	ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
)
FROM sales_ex18;

2. Show each sale with a 3-row moving average of sale_amount per region.
SELECT sale_id, region, sale_amount, sale_date, AVG(sale_amount) OVER (
	PARTITION BY region
	ORDER BY sale_date
	ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
)
FROM sales_ex18;

3. Show each sale with a running total per region using RANGE.
SELECT sale_id, region, sale_amount, SUM(sale_amount) OVER (
	PARTITION BY region
	ORDER BY sale_date
	RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
)
FROM sales_ex18;

4. Compare ROWS vs RANGE results for the North region.
SELECT sale_id, region, sale_amount, SUM(sale_amount) OVER (
	PARTITION BY region
	ORDER BY sale_date
	RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS running_total_range,
	SUM(sale_amount) OVER (
		PARTITION BY region
		ORDER BY sale_date
		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS running_total_rows
FROM sales_ex18;

5. Show each sale with the sum of the previous 2 sales and the current sale per region.
SELECT sale_id, region, sale_amount, SUM(sale_amount) OVER (
	PARTITION BY region
	ORDER BY sale_date
	ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
)
FROM sales_ex18;

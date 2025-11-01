

CREATE TABLE customers_ex14 (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE orders_ex14 (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers_ex14(customer_id),
    order_date DATE,
    total_amount NUMERIC(10,2)
);

INSERT INTO customers_ex14 (customer_name, country) VALUES
('Alice', 'USA'),
('Bob', 'Canada'),
('Carol', 'USA');

INSERT INTO orders_ex14 (customer_id, order_date, total_amount) VALUES
(1, '2024-01-10', 400),
(2, '2024-02-20', 800),
(1, '2024-03-15', 1200),
(3, '2024-03-22', 500),
(2, '2024-04-10', 300);

SELECT * FROM orders_ex14
SELECT * FROM customers_ex14



1. Using a CTE, find the total order amount per customer and show only those with totals > 1000.
WITH cus_total_amount AS (
    SELECT customer_id, SUM(total_amount) AS total_amount
    FROM orders_ex14
    GROUP BY customer_id
    HAVING SUM(total_amount) > 1000
)
SELECT c.customer_id, c.customer_name, c.country, t.total_amount
FROM customers_ex14 c
JOIN cus_total_amount t ON c.customer_id = t.customer_id;

2. Rewrite the previous query using a subquery instead of a CTE.
SELECT *
FROM customers_ex14
WHERE customer_id IN (
	SELECT customer_id
	FROM orders_ex14
	GROUP BY customer_id
	HAVING sum(total_amount) > 1000
)

3. Using a CTE, calculate each customer’s average order amount, then show those above the global average.
WITH avg_global AS (
    SELECT AVG(total_amount) AS global_avg
    FROM orders_ex14
),
customer_avg AS (
    SELECT customer_id, AVG(total_amount) AS avg_amount
    FROM orders_ex14
    GROUP BY customer_id
)
SELECT c.customer_id, c.customer_name, ca.avg_amount
FROM customers_ex14 c
JOIN customer_avg ca ON c.customer_id = ca.customer_id
JOIN avg_global ag ON ca.avg_amount > ag.global_avg;

4. Create a CTE that finds each customer’s highest order, and display it alongside their name.
WITH Max_Ord_Cus AS (
	SELECT customer_id, max(total_amount) as max_order
	FROM orders_ex14
	GROUP BY customer_id
)
SELECT c.customer_id, c.customer_name, m.max_order
FROM customers_ex14 c
JOIN Max_Ord_Cus m ON c.customer_id = m.customer_id 

5. Find all customers who spent more than the average spending of all customers (use a subquery inside WHERE).
SELECT *
FROM customers_ex14
WHERE customer_id IN (
	SELECT customer_id
	FROM orders_ex14
	GROUP BY customer_id
	HAVING sum(total_amount) > (SELECT avg(total_amount) FROM orders_ex14)
)

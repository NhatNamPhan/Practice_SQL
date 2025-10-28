
-- Create customers table
CREATE TABLE customers_ex13 (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(50),
    country VARCHAR(50)
);

-- Create orders table
CREATE TABLE orders_ex13 (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers_ex13(customer_id),
    order_date DATE,
    amount NUMERIC(10,2)
);

-- Insert sample data into customers
INSERT INTO customers_ex13 (customer_name, country)
VALUES
('Alice', 'USA'),
('Bob', 'Canada'),
('Carol', 'USA'),
('David', 'UK');

-- Insert sample data into orders
INSERT INTO orders_ex13 (customer_id, order_date, amount)
VALUES
(1, '2023-01-10', 500),
(2, '2023-02-15', 800),
(1, '2023-03-20', 1200),
(3, '2023-03-25', 300),
(4, '2023-04-10', 700);

SELECT * FROM customers_ex13;
SELECT * FROM orders_ex13;

1. Show each customer’s total order amount and sort them by total spending (highest first).
SELECT customer_id, sum(amount) as total_amount
FROM orders_ex13
GROUP BY customer_id
ORDER BY total_amount DESC;

2. Find all customers who placed more than one order.
SELECT customer_id, count(customer_id) as total_order
FROM orders_ex13
GROUP BY customer_id
HAVING count(customer_id) > 1;

3. Show all orders placed in 2023, but only for customers from the USA.
SELECT o.order_id, o.customer_id, o.order_date, o.amount
FROM orders_ex13 o
JOIN customers_ex13 c ON c.customer_id = o.customer_id
WHERE c.country = 'USA' and extract(YEAR from order_date) = 2023;

4. Find the total sales per country and order by total descending.
SELECT c.country, sum(o.amount) as total_amount
FROM orders_ex13 o
JOIN customers_ex13 c ON c.customer_id = o.customer_id
GROUP BY c.country
ORDER BY total_amount DESC;

5. Display each customer name and the average order amount they placed.
SELECT c.customer_name, AVG(o.amount) AS avg_order
FROM orders_ex13 o
JOIN customers_ex13 c ON c.customer_id = o.customer_id
GROUP BY c.customer_name;
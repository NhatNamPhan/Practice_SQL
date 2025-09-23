-- Create table customers
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

-- Create table orders
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    order_date DATE,
    amount NUMERIC(10,2)
);

-- Insert sample customers
INSERT INTO customers (customer_name, city) VALUES
('Alice', 'New York'),
('Bob', 'Chicago'),
('Charlie', 'New York'),
('Diana', 'Los Angeles'),
('Evan', 'Chicago');

-- Insert sample orders
INSERT INTO orders (customer_id, order_date, amount) VALUES
(1, '2023-01-05', 250),
(1, '2023-01-10', 300),
(2, '2023-01-15', 150),
(2, '2023-02-01', 200),
(3, '2023-02-10', 500),
(4, '2023-02-20', 400),
(5, '2023-03-01', 350),
(5, '2023-03-10', 100);
SELECT * FROM customers;
SELECT * FROM orders;

1. Count how many orders each customer placed.
SELECT customer_id, count(order_id) as total_order_customer
FROM orders
GROUP BY customer_id;

2. Show the total sales amount per customer.
SELECT customer_id, sum(amount) as Total_money
FROM orders
GROUP BY customer_id;

3. Find the average order amount for each city.
SELECT city, avg(amount)
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY city;

4. Show how many orders were placed in each month (by year and month).
SELECT EXTRACT(MONTH FROM order_date), count (order_id)
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY EXTRACT(MONTH FROM order_date);

5. Find the highest order amount per customer.
SELECT customer_id, max(amount)
FROM orders
GROUP BY customer_id;
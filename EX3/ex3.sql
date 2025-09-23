-- Create table products
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price NUMERIC(10,2)
);
-- Reuse customers table from Week 2
-- Reuse orders table, but now link to products

-- Add product_id to orders
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    product_id INT REFERENCES products(product_id),
    order_date DATE,
    amount NUMERIC(10,2)
);	
-- Insert sample products
INSERT INTO products (product_name, category, price) VALUES
('Laptop', 'Electronics', 1000),
('Phone', 'Electronics', 600),
('Desk', 'Furniture', 200),
('Chair', 'Furniture', 150),
('Printer', 'Electronics', 300);
--Inser sample orders
INSERT INTO orders (customer_id, product_id, order_date, amount) VALUES
(1, 1, '2023-01-05', 1000),
(1, 2, '2023-01-10', 600),
(2, 3, '2023-01-15', 200),
(2, 4, '2023-02-01', 150),
(3, 1, '2023-02-10', 1000),
(3, 5, '2023-02-12', 300),
(4, 2, '2023-02-20', 600),
(5, 3, '2023-03-01', 200),
(5, 4, '2023-03-10', 150),
(5, 5, '2023-03-15', 300);

SELECT * FROM products
SELECT * FROM orders

1. List customers who placed more than 2 orders.
SELECT o.customer_id, c.customer_name, count(order_id)
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY o.customer_id, c.customer_name
HAVING count(order_id) > 2;

2. Show product categories where the average order amount is greater than 300.
SELECT pr.category, AVG(o.amount)
FROM orders o
JOIN products pr ON o.product_id = pr.product_id
GROUP BY pr.category
HAVING AVG(o.amount) >= 300;

3. Find customers whose total spending is more than 1000.
SELECT customer_id, sum(amount)
FROM orders
GROUP BY customer_id
HAVING sum(amount) > 1000;

4. Show categories that have at least 2 different products.
SELECT category
FROM products
GROUP BY category
HAVING count(product_id) >= 2;

5. List customers who bought products totaling more than 2,000 in 2023.
SELECT customer_id, sum(amount)
FROM orders
where EXTRACT(YEAR FROM order_date) = 2023
GROUP BY customer_id
HAVING sum(amount) > 2000;
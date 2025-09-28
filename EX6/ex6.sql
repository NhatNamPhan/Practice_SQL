-- Create products table
CREATE TABLE products_ex6 (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    price NUMERIC(10,2),
    discount NUMERIC(5,2) -- percentage (e.g., 7.5 = 7.5%)
);

-- Insert sample products
INSERT INTO products_ex6 (product_name, price, discount) VALUES
('Laptop', 999.99, 10.5),
('Phone', 599.49, 5.0),
('Desk', 249.75, 0),
('Chair', 149.30, 12.25),
('Printer', 310.10, 7.75);

SELECT * FROM products_ex6;

1. Show the absolute difference between each product’s price and 500. (ABS())
SELECT product_id, product_name, abs(price - 500) as Absolute_Difference
FROM products_ex6;

2. Round each product’s price to the nearest whole number. (ROUND())
SELECT product_id, product_name, ROUND(price) as round_price
FROM products_ex6;

3. Round each product’s price up to the nearest integer. (CEIL())
SELECT product_id, product_name, CEIL(price) as ceil_price
FROM products_ex6;

4. Round each product’s price down to the nearest integer. (FLOOR())
SELECT product_id, product_name, FLOOR(price) as floor_price
FROM products_ex6;

5. Show the square root of each product’s price. (SQRT())
SELECT product_id, product_name, SQRT(price) as sqrt_price
FROM products_ex6;
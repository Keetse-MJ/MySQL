CREATE DATABASE customer_order_project;

USE customer_order_project;

CREATE TABLE customers (
    customer_id INT,
    customer_name VARCHAR(50),
    city VARCHAR(50),
    email VARCHAR(100)
);

INSERT INTO customers
VALUES
(1, 'Thabo', 'Johannesburg', 'thabo@email.com'),
(2, 'Sarah', 'Pretoria', 'sarah@email.com'),
(3, 'Lerato', 'Centurion', 'lerato@email.com'),
(4, 'John', 'Pretoria', 'john@email.com'),
(5, 'Maria', 'Johannesburg', 'maria@email.com'),
(6, 'Peter', 'Midrand', 'peter@email.com'),
(7, 'David', 'Soweto', 'david@email.com'),
(8, 'Nomsa', 'Pretoria', 'nomsa@email.com');

CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    product VARCHAR(50),
    category VARCHAR(50),
    quantity INT,
    amount DECIMAL(10,2),
    order_date DATE
);

INSERT INTO orders
VALUES
(101, 1, 'Laptop', 'Electronics', 1, 8500, '2026-01-05'),
(102, 2, 'Phone', 'Electronics', 2, 6500, '2026-01-08'),
(103, 3, 'Laptop', 'Electronics', 1, 8500, '2026-01-10'),
(104, 4, 'Keyboard', 'Accessories', 3, 2400, '2026-01-12'),
(105, 5, 'Monitor', 'Electronics', 2, 5000, '2026-01-15'),
(106, 6, 'Phone', 'Electronics', 1, 3200, '2026-01-18'),
(107, 1, 'Keyboard', 'Accessories', 2, 1600, '2026-01-20'),
(108, 2, 'Laptop', 'Electronics', 1, 8500, '2026-01-22'),
(109, 3, 'Mouse', 'Accessories', 4, 1200, '2026-01-25'),
(110, 4, 'Monitor', 'Electronics', 1, 2500, '2026-01-28'),
(111, 5, 'Laptop', 'Electronics', 1, 8500, '2026-02-02'),
(112, 6, 'Keyboard', 'Accessories', 3, 2400, '2026-02-05'),
(113, 1, 'Phone', 'Electronics', 2, 6400, '2026-02-08'),
(114, 2, 'Mouse', 'Accessories', 5, 1500, '2026-02-10'),
(115, 3, 'Monitor', 'Electronics', 2, 5000, '2026-02-12'),
(116, 4, 'Laptop', 'Electronics', 1, 8500, '2026-02-15'),
(117, 5, 'Phone', 'Electronics', 1, 3200, '2026-02-18'),
(118, 6, 'Mouse', 'Accessories', 3, 900, '2026-02-20'),
(119, 1, 'Monitor', 'Electronics', 1, 2500, '2026-02-22'),
(120, 2, 'Phone', 'Electronics', 2, 6400, '2026-02-25'),
(121, 7, 'Tablet', 'Electronics', 1, 4500, '2026-02-27');
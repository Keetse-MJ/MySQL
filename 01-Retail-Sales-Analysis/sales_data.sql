CREATE DATABASE retail_sales_project;

USE retail_sales_project;

CREATE TABLE sales (
    sale_id INT,
    customer VARCHAR(50),
    city VARCHAR(50),
    product VARCHAR(50),
    category VARCHAR(50),
    quantity INT,
    amount DECIMAL(10,2),
    sale_date DATE
);

INSERT INTO sales
VALUES
(1, 'Thabo', 'Johannesburg', 'Laptop', 'Electronics', 1, 8500, '2026-01-05'),
(2, 'Sarah', 'Pretoria', 'Phone', 'Electronics', 2, 6500, '2026-01-08'),
(3, 'Lerato', 'Centurion', 'Laptop', 'Electronics', 1, 8500, '2026-01-10'),
(4, 'John', 'Pretoria', 'Keyboard', 'Accessories', 3, 2400, '2026-01-12'),
(5, 'Maria', 'Johannesburg', 'Monitor', 'Electronics', 2, 5000, '2026-01-15'),
(6, 'Peter', 'Midrand', 'Phone', 'Electronics', 1, 3200, '2026-01-18'),
(7, 'Thabo', 'Johannesburg', 'Keyboard', 'Accessories', 2, 1600, '2026-01-20'),
(8, 'Sarah', 'Pretoria', 'Laptop', 'Electronics', 1, 8500, '2026-01-22'),
(9, 'Lerato', 'Centurion', 'Mouse', 'Accessories', 4, 1200, '2026-01-25'),
(10, 'John', 'Pretoria', 'Monitor', 'Electronics', 1, 2500, '2026-01-28'),
(11, 'Maria', 'Johannesburg', 'Laptop', 'Electronics', 1, 8500, '2026-02-02'),
(12, 'Peter', 'Midrand', 'Keyboard', 'Accessories', 3, 2400, '2026-02-05'),
(13, 'Thabo', 'Johannesburg', 'Phone', 'Electronics', 2, 6400, '2026-02-08'),
(14, 'Sarah', 'Pretoria', 'Mouse', 'Accessories', 5, 1500, '2026-02-10'),
(15, 'Lerato', 'Centurion', 'Monitor', 'Electronics', 2, 5000, '2026-02-12'),
(16, 'John', 'Pretoria', 'Laptop', 'Electronics', 1, 8500, '2026-02-15'),
(17, 'Maria', 'Johannesburg', 'Phone', 'Electronics', 1, 3200, '2026-02-18'),
(18, 'Peter', 'Midrand', 'Mouse', 'Accessories', 3, 900, '2026-02-20'),
(19, 'Thabo', 'Johannesburg', 'Monitor', 'Electronics', 1, 2500, '2026-02-22'),
(20, 'Sarah', 'Pretoria', 'Phone', 'Electronics', 2, 6400, '2026-02-25');
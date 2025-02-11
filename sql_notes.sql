-- Databases
CREATE DATABASE myDB;
DROP DATABASE myDB;
SHOW DATABASES;
USE myDB;

ALTER DATABASE myDB READ ONLY = 0;
-- ___________________________________

-- Tables
CREATE TABLE employees(
	employee_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    hourly_pay DECIMAL(5, 2),
    hire_date DATE
);
SHOW TABLES;
SELECT * FROM employees;

RENAME TABLE workers TO employees;
SELECT * FROM workers;
DROP TABLE workers;

ALTER TABLE employees  -- Add new column
ADD phone_number VARCHAR(15);

ALTER TABLE employees  -- Change column name
RENAME COLUMN phone_number TO email;

ALTER TABLE employees  -- Change column type
MODIFY COLUMN email VARCHAR(100);

ALTER TABLE employees  -- Change column positioning
MODIFY email VARCHAR(100)
AFTER last_name;

ALTER TABLE employees  -- Drop column
DROP COLUMN email;
-- ___________________________________

-- INSERT ROWS 
INSERT INTO employees      -- Inserting row
VALUES  (2, "Squidward", "Tentacles", 15.00, "2025-02-10");

INSERT INTO employees      -- Inserting multiple rows at once
VALUES  (2, "Squidward", "Tentacles", 15.00, "2025-02-10"),
		(3, "Spongebob", "Squarepants", 12.50, "2025-02-11"),
		(4, "Patrick", "Star", 12.50, "2025-02-12"),
		(5, "Sandy", "Cheeks", 17.25, "2025-02-13");

INSERT INTO employees (employee_id, first_name, last_name)   -- Inserting data to only part of the row
VALUES (6, "Sheldon", "Plankton");

SELECT * FROM employees;
-- ___________________________________

-- SELECT
SELECT * FROM employees;
SELECT first_name, last_name  -- Show data from [first_name] and {last_name]
FROM employees;

SELECT last_name,first_name  -- Showing [last_name] first, and then show [first_name]
FROM employees;

SELECT * 
FROM employees 
WHERE employee_id = 1;       -- Show specific data from [employees] where [employee_id] is equal to 1

SELECT * 
FROM employees
WHERE hourly_pay >= 15;

SELECT * 
FROM employees
WHERE hire_date <= "2025-02-11";

SELECT * 
FROM employees
WHERE employee_id != 1;

SELECT * 
FROM employees
WHERE hourly_pay IS NULL;  -- Instead of using [=], we use [IS] with [NULL]

SELECT * 
FROM employees
WHERE hourly_pay IS NOT NULL;
-- ___________________________________

-- UPDATE & DELETE 
SET SQL_SAFE_UPDATES = 0;  -- for error that cannot updates or deletes without a condition on a primary key or unique key
SET SQL_SAFE_UPDATES = 1;

UPDATE employees        -- Updating row where [employee_id] = [6]
SET hourly_pay = 10.25
WHERE employee_id = 6;

UPDATE employees        -- Multi-Updating row where [employee_id] = [6]
SET hourly_pay = 10.50,
	hire_date = "2025-02-17"
WHERE employee_id = 6;

UPDATE employees
SET employee_id = 1,
	first_name = "Mr.Krab",
    last_name = "Eugene",
    hourly_pay = 25.00
WHERE employee_id = 2;

UPDATE employees
SET hire_date = NULL 
WHERE employee_id = 6;

UPDATE employees        -- Set hourly_pay of all rows to [NULL]
SET hourly_pay = NULL;

DELETE FROM employees;  -- Delete all rows from employees
DELETE FROM employees   -- Delete the row from employees where [employee_id] = [6]
WHERE employee_id = 6;

SELECT * FROM employees;
-- ___________________________________

-- AUTOCOMMIT COMMIT ROLLBACK

SET AUTOCOMMIT = OFF;  -- Our [transactions] will not save automatically!
COMMIT;                -- Create a [save-point]

SELECT * FROM employees;
DELETE FROM employees;
SET SQL_SAFE_UPDATES = 0;
ROLLBACK;              -- Go back to the [save-point]
-- ___________________________________

-- CURRENT_DATE() & CURRENT_TIME()
CREATE TABLE test(
	my_date DATE,
    my_time TIME,
    my_datetime DATETIME
);

SELECT * FROM test;

INSERT INTO test
VALUES (CURRENT_DATE(), CURRENT_TIME(), NOW());

INSERT INTO test
VALUES (CURRENT_DATE(), NULL, NULL);

INSERT INTO test
VALUES (CURRENT_DATE() + 1, NULL, NULL);

INSERT INTO test
VALUES (CURRENT_DATE() - 1, NULL, NULL);

DROP TABLE test;
-- ___________________________________

-- UNIQUE

CREATE TABLE products(
	product_id INT,
    product_name VARCHAR(25) UNIQUE,
    price DECIMAL(4, 2)
);

ALTER TABLE products
ADD CONSTRAINT
UNIQUE(product_name);  -- Adding [UNIQUE] to the [column]

INSERT INTO products
VALUES  (100, "hamburger", 3.99),
		(101, "fries", 1.89),
        (102, "soda", 1.00),
        (103, "ice cream", 1.49);
        
SELECT * FROM products;
-- ___________________________________

-- NOT NULL

CREATE TABLE products(
	product_id INT,
    product_name VARCHAR(25) UNIQUE,
    price DECIMAL(4, 2) NOT NULL
);

ALTER TABLE products
MODIFY price DECIMAL(4, 2) NOT NULL;

INSERT INTO products 
VALUES (104, "cookies", NULL);  -- Being [0] is acceptable but it cannot be [NULL]

-- ___________________________________

-- CHECK
CREATE TABLE employees(
	employee_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    hourly_pay DECIMAL(5, 2),
    hire_date DATE
    CONSTRAINT chk_hourly_pay CHECK (hourly_pay >= 10.00)
);

ALTER TABLE employees 
ADD CONSTRAINT chk_hourly_pay CHECK(hourly_pay >= 10.00);

SELECT * FROM employees;

INSERT INTO employees
VALUES (6, "Sheldo", "Plankton", 5.00, "2025-02-10");

ALTER TABLE employees
DROP CHECK chk_hourly_pay;
-- ___________________________________

-- DEFAULT
SELECT * FROM products;

INSERT INTO products
VALUES 	(104, "straws", 0.00),
		(105, "napkin", 0.00),
        (106, "fork", 0.00),
        (107, "spoon", 0.00);
        
DELETE FROM products
WHERE product_id >= 104;

CREATE TABLE products(
	product_id INT,
    product_name VARCHAR(25) UNIQUE,
    price DECIMAL(4, 2) DEFAULT 0
);

ALTER TABLE products
ALTER price SET DEFAULT 0;

INSERT INTO products (product_id, product_name)
VALUES  (104, "straws"),
		(105, "napkin"),
		(106, "fork"),
		(107, "spoon");
        
CREATE TABLE transactions (
	transaction_id INT,
    amount DECIMAL(5, 2),
    transaction_date DATETIME DEFAULT NOW()  
);

SELECT * FROM transactions;

INSERT INTO transactions (transaction_id, amount)
VALUES  (1, 4.99);

DROP TABLE transactions;
-- ___________________________________

-- PRIMARY KEYS
CREATE TABLE transactions(
	transaction_id INT PRIMARY KEY,
    amount DECIMAL(5, 2)
);

ALTER TABLE transactions
ADD CONSTRAINT
PRIMARY KEY(transaction_id);

INSERT INTO transactions
VALUES (1000, 4.99);
INSERT INTO transactions
VALUES (1001, 2.89);
INSERT INTO transactions

VALUES (1001, 3.38);      --  Cannot be duplicate [1001]. Must be [unique]
INSERT INTO transactions
VALUES (NULL, 3.38);	  -- Cannot be [NULL]

SELECT * FROM transactions;
SELECT amount 
FROM transactions 
WHERE transaction_id = 1001;
-- ___________________________________

-- AUTO_INCREMENT
DROP TABLE transactions;

CREATE TABLE transactions(
	transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    amount DECIMAL(5, 2)
);

SELECT * FROM transactions;

INSERT INTO transactions (amount)
VALUES (4.99);
INSERT INTO transactions (amount)
VALUES (3.38);

ALTER TABLE transactions
AUTO_INCREMENT = 1000;

SET SQL_SAFE_UPDATES = 0;
DELETE FROM transactions;

INSERT INTO transactions (amount)
VALUES (4.99);
INSERT INTO transactions (amount)
VALUES (3.38);

-- ___________________________________

-- FOREIGN KEY

CREATE TABLE customers (
	customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

INSERT INTO customers (first_name, last_name)
VALUES 	("Fred", "Fish"),
		("Larry", "Lobster"),
        ("Bubble", "Bass");

SELECT * FROM customers;

DROP TABLE transactions;

CREATE TABLE transactions(
	transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    amount DECIMAL(5, 2),
    customer_id INT,
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);

ALTER TABLE transactions
DROP FOREIGN KEY transactions_ibfk_1;  

ALTER TABLE transactions
ADD CONSTRAINT fk_customer_id
FOREIGN KEY(customer_id) REFERENCES customers(customer_id); -- Renaming the [FOREIGN KEY]

SELECT * FROM transactions;
DELETE FROM transactions;

ALTER TABLE transactions
AUTO_INCREMENT = 1000;

INSERT INTO transactions (amount, customer_id)
VALUES  (4.99, 3),
		(2.89, 2),
        (3.38, 3),
        (4.99, 1);
        
DELETE FROM customers
WHERE customer_id = 1;
-- ___________________________________








-- Databases
CREATE DATABASE myDB;
DROP DATABASE myDB;
SHOW DATABASES;
USE myDB;

ALTER DATABASE myDB READ ONLY = 0;
-- ___________________________________
DROP TABLE employees;
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
VALUES  (1, "Eugene", "Krabs", 25.50, "2025-02-10");

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

-- JOIN

SELECT * FROM transactions;
SELECT * FROM customers;

INSERT INTO transactions (amount, customer_id)
VALUES (1.00, NULL);

INSERT INTO customers (first_name, last_name)
VALUES ("Poppy", "Puff");

SELECT * 
FROM transactions INNER JOIN customers
ON transactions.customer_id = customers.customer_id;

SELECT transaction_id, amount, first_name, last_name
FROM transactions INNER JOIN customers
ON transactions.customer_id = customers.customer_id;

SELECT *
FROM transactions LEFT JOIN customers
ON transactions.customer_id = customers.customer_id;

SELECT *
FROM transactions RIGHT JOIN customers
ON transactions.customer_id = customers.customer_id;
-- ___________________________________

-- FUNCTIONS [some of the more used]

SELECT * FROM transactions;

SELECT COUNT(amount)
FROM transactions;

SELECT COUNT(amount) AS count    -- Renaming the [column-name]
FROM transactions;

SELECT COUNT(amount) AS "today's transactions"    -- Renaming the [column-name]
FROM transactions;

SELECT MAX(amount) AS maximum
FROM transactions;

SELECT MIN(amount) AS minimum
FROM transactions;

SELECT AVG(amount) AS average
FROM transactions;

SELECT SUM(amount) AS sum
FROM transactions;

SELECT * FROM employees;

SELECT CONCAT(first_name, " ", last_name) AS full_name
FROM employees;
-- ___________________________________

-- AND, OR, NOT

SELECT * FROM employees;
ALTER TABLE employees
ADD COLUMN job VARCHAR(25) AFTER hourly_pay;

SET SQL_SAFE_UPDATES = 0;
UPDATE employees
SET job = "manager" 
WHERE employee_id = 1;

UPDATE employees
SET job = "cashier" 
WHERE employee_id = 2;

UPDATE employees
SET job = "cook" 
WHERE employee_id = 3;

UPDATE employees
SET job = "cook" 
WHERE employee_id = 4;

UPDATE employees
SET job = "asst. manager" 
WHERE employee_id = 5;

UPDATE employees
SET job = "janitor" 
WHERE employee_id = 6;

SELECT * 
FROM employees
WHERE job = "cook" AND hire_date <= "2025-02-12";

SELECT * 
FROM employees
WHERE job = "cook" OR job = "manager";

SELECT * 
FROM employees
WHERE NOT job = "manager";

SELECT * 
FROM employees
WHERE NOT job = "cook" AND NOT job = "manager";

SELECT * FROM employees;
SELECT * 
FROM employees
WHERE hire_date BETWEEN "2025-02-10" AND "2025-02-12";

SELECT *
FROM employees
WHERE job IN ("cook", "asst. manager", "janitor");

-- ___________________________________

-- WILD CARDS

SELECT * FROM employees
WHERE first_name LIKE "s%";   -- Works for both [s] and [S]
 
SELECT * FROM employees
WHERE hire_date LIKE "2025%";
 
SELECT * FROM employees
WHERE last_name LIKE "%r";
 
SELECT * FROM employees
WHERE first_name LIKE "sp%";
 
SELECT * FROM employees
WHERE job LIKE "_ook";
 
SELECT * FROM employees
WHERE hire_date LIKE "____-02-11";

SELECT * FROM employees
WHERE job LIKE "_a%";

-- ___________________________________

-- ORDER BY

SELECT * FROM employees 
ORDER BY last_name;

SELECT * FROM employees 
ORDER BY last_name DESC;

SELECT * FROM transactions
ORDER BY amount, customer_id;

SELECT * FROM transactions
ORDER BY amount, customer_id DESC;  -- [DESC] is only for [customer_id]
-- ___________________________________

-- LIMIT

SELECT * FROM customers
LIMIT 3;

SELECT * FROM customers
ORDER BY last_name DESC LIMIT 3;

SELECT * FROM customers
LIMIT 1, 2;        -- [1] means limiting data to 1, [2] means [2-row] after limiting 1.

-- ___________________________________

-- UNION

CREATE TABLE income(
	income_name VARCHAR(50),
    amount DECIMAL(10, 2)
);

INSERT INTO income
VALUES  ("orders", 1000000),
		("merchandise", 50000),
        ("services", 125000);
        
SELECT * FROM income;

CREATE TABLE expenses(
	expense_name VARCHAR(50),
    amount DECIMAL(10, 2)
);

INSERT INTO expenses
VALUES  ("wages", 250000),
		("tax", 50000),
        ("repairs", 15000);
        
SELECT * FROM expenses;

SELECT * FROM income
UNION
SELECT * FROM expenses;

DROP TABLE income;
DROP TABLE expenses;

SELECT * FROM employees;

SELECT * FROM employees
UNION
SELECT * FROM customers;   -- Not gonna work because numbers of [columns] don't match.

SELECT first_name, last_name FROM employees
UNION
SELECT first_name, last_name FROM customers;

SELECT * FROM customers;
INSERT INTO customers
VALUES (5, "Sheldon", "Plankton");
SELECT * FROM employees;

DELETE FROM customers
WHERE customer_id = 6;

SELECT first_name, last_name FROM employees
UNION ALL
SELECT first_name, last_name FROM customers;
-- ___________________________________

-- SELF JOINS

ALTER TABLE customers
ADD referral_id INT;

SELECT * FROM customers;

UPDATE customers 
SET referral_id = 1
WHERE customer_id = 2;

UPDATE customers 
SET referral_id = 2
WHERE customer_id = 3;

UPDATE customers 
SET referral_id = 2
WHERE customer_id = 4;

DELETE FROM customers 
WHERE customer_id = 5;

SELECT  a.customer_id, a.first_name, b.last_name,
		CONCAT(b.first_name," ", b.last_name) AS "referred_by"
FROM customers AS a 
INNER JOIN customers AS b
ON a.referral_id = b.customer_id;

USE mydb;
SET SQL_SAFE_UPDATES = off;
SELECT * FROM employees;

ALTER TABLE employees
ADD COLUMN supervisor_id INT;

UPDATE employees 
SET supervisor_id = 5
WHERE employee_id = 2;

UPDATE employees 
SET supervisor_id = 5
WHERE employee_id = 3;

UPDATE employees 
SET supervisor_id = 5
WHERE employee_id = 4;

UPDATE employees 
SET supervisor_id = 1
WHERE employee_id = 5;

SELECT  CONCAT(a.first_name, " ", a.last_name) AS employees,
		CONCAT(b.first_name, " ", b.last_name) AS supervisors
FROM employees AS a
INNER JOIN employees AS b 
ON a.supervisor_id = b.employee_id;

-- ___________________________________

-- VIEWS

SELECT * FROM employees;

CREATE VIEW employee_attendance AS 
SELECT first_name, last_name
FROM employees;

SELECT * FROM employee_attendance
ORDER BY last_name;

DROP VIEW employee_attendance;

SELECT * FROM customers;
ALTER TABLE customers
ADD COLUMN email VARCHAR(50);

UPDATE customers
SET email = "FFish@gmail.com" 
WHERE customer_id = 1;

UPDATE customers
SET email = "LLobster@gmail.com" 
WHERE customer_id = 2;

UPDATE customers
SET email = "BBass@gmail.com" 
WHERE customer_id = 3;

UPDATE customers
SET email = "PPuff@gmail.com" 
WHERE customer_id = 4;

CREATE VIEW customer_emails AS
SELECT email
FROM customers;

SELECT * FROM customer_emails;

SELECT * FROM customers;

INSERT INTO customers 
VALUES (5, "Pearl", "Krabs", NULL, "PKrabs@gmail.com");

-- ___________________________________

-- INDEXES

SHOW INDEXES FROM customers; 
CREATE INDEX last_name_idx
ON customers(last_name);

SELECT * FROM customers
WHERE first_name = "Puff";

CREATE INDEX last_name_first_name_idx
ON customers(last_name, first_name);

ALTER TABLE customers
DROP INDEX last_name_idx;

-- ___________________________________

-- SUBQUERIES

SELECT * FROM employees;

SELECT first_name, last_name, hourly_pay, 
	   (SELECT AVG(hourly_pay) FROM employees) AS avg_pay
FROM employees;

SELECT first_name, last_name, hourly_pay
FROM employees
WHERE hourly_pay > (SELECT AVG(hourly_pay) FROM employees);

SELECT * FROM transactions;

SELECT first_name, last_name 
FROM customers 
WHERE customer_id IN 
(SELECT  DISTINCT customer_id 
FROM transactions 
WHERE customer_id IS NOT NULL);

SELECT first_name, last_name 
FROM customers 
WHERE customer_id NOT IN 
(SELECT  DISTINCT customer_id 
FROM transactions 
WHERE customer_id IS NOT NULL);
-- ___________________________________

-- GROUP BY

ALTER TABLE transactions
ADD COLUMN order_date DATE;

INSERT INTO transactions (amount, customer_id)
VALUES 	(2.49, 4),
		(5.48, NULL);

UPDATE transactions
SET order_date = "2023-01-01" WHERE transaction_id = 1000;
UPDATE transactions
SET order_date = "2023-01-01" WHERE transaction_id = 1001;
UPDATE transactions
SET order_date = "2023-01-02" WHERE transaction_id = 1002;
UPDATE transactions
SET order_date = "2023-01-02" WHERE transaction_id = 1003;
UPDATE transactions
SET order_date = "2023-01-03" WHERE transaction_id = 1004;
UPDATE transactions
SET order_date = "2023-01-03" WHERE transaction_id = 1005;
UPDATE transactions
SET order_date = "2023-01-03" WHERE transaction_id = 1006;

SELECT * FROM transactions;

SELECT SUM(amount), order_date
FROM transactions
GROUP BY order_date;

SELECT MAX(amount), order_date
FROM transactions
GROUP BY order_date;

SELECT MIN(amount), order_date
FROM transactions
GROUP BY order_date;

SELECT COUNT(amount), order_date
FROM transactions
GROUP BY order_date;

SELECT COUNT(amount), customer_id
FROM transactions
GROUP BY customer_id
HAVING COUNT(amount) > 1; 

SELECT COUNT(amount), customer_id
FROM transactions
GROUP BY customer_id
HAVING COUNT(amount) > 1 AND customer_id IS NOT NULL;

-- ___________________________________

-- ROLLUP

SELECT SUM(amount), order_date
FROM transactions
GROUP BY order_date WITH ROLLUP;

SELECT * FROM transactions;

SELECT COUNT(transaction_id), order_date
FROM transactions
GROUP BY order_date WITH ROLLUP;

SELECT COUNT(transaction_id) AS "# of orders", customer_id
FROM transactions
GROUP BY customer_id WITH ROLLUP;

SELECT * FROM employees;

SELECT SUM(hourly_pay) AS "hourly pay", employee_id
FROM employees
GROUP BY employee_id WITH ROLLUP;
-- ___________________________________

-- ON DELETE

SELECT * FROM transactions;
SELECT * FROM customers;

SET foreign_key_checks = 1;

DELETE FROM customers
WHERE customer_id = 4;

INSERT INTO customers
VALUES (4, "Poppy", "Puff", 2, "PPuff@gmail.com");

CREATE TABLE transactions(
	transaction_id INT PRIMARY KEY,
    amount DECIMAL(5, 2),
    customer_id INT,
    order_date DATE,
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
    ON DELETE SET NULL
);

ALTER TABLE transactions 
DROP FOREIGN KEY fk_customer_id;

ALTER TABLE transactions
ADD CONSTRAINT fk_customer_id
FOREIGN KEY(customer_id) REFERENCES customers(customer_id) 
ON DELETE SET NULL;

UPDATE transactions
SET customer_id = 4 
WHERE transaction_id = 1005;

ALTER TABLE transactions
ADD CONSTRAINT fk_transactions_id
FOREIGN KEY(customer_id) REFERENCES customers(customer_id) 
ON DELETE CASCADE;

-- ___________________________________

-- STORED PROCEDURES

DELIMITER $$
CREATE PROCEDURE get_customers()
BEGIN
	SELECT * FROM customers;
END $$
DELIMITER ;

Call get_customers();

DROP PROCEDURE get_customers;

DELIMITER $$
CREATE PROCEDURE find_customer(IN id INT)
BEGIN
	SELECT * 
    FROM customers
    WHERE customer_id = id;
END $$
DELIMITER ;

CALL find_customer(1);

DROP PROCEDURE find_customer;

DELIMITER $$
CREATE PROCEDURE find_customer(IN f_name VARCHAR(50), 
							   IN l_name VARCHAR(50))
BEGIN
	SELECT * 
    FROM customers
    WHERE first_name = f_name AND last_name = l_name;
END $$
DELIMITER ;

CALL find_customer("Larry", "Lobster");
-- ___________________________________

-- TRIGGERS

SELECT * FROM employees;

ALTER TABLE employees
ADD COLUMN salary DECIMAL(10, 2) AFTER hourly_pay;

UPDATE employees
SET salary = hourly_pay * 2080;

CREATE TRIGGER before_houryly_pay_update
BEFORE UPDATE ON employees
FOR EACH ROW
SET NEW.salary = (NEW.hourly_pay * 2080);

SHOW TRIGGERS;

UPDATE employees
SET hourly_pay = 50
WHERE employee_id = 1;

UPDATE employees
SET hourly_pay = hourly_pay + 1;

CREATE TRIGGER before_hourly_pay_insert
BEFORE INSERT ON employees
FOR EACH ROW
SET NEW.salary= (NEW.hourly_pay * 2080);

INSERT INTO employees
VALUES (6, "Sheldon", "Plankton", 10, NULL, "janitor", "2025-2-15", 5);

DELETE FROM employees
WHERE employee_id = 6;

DROP TRIGGER before_hourly_pay_insert;

CREATE TABLE expenses(
	expense_id INT PRIMARY KEY,
    expense_name VARCHAR(50),
    expense_total DECIMAL(10, 2)
);
SELECT * FROM expenses;

INSERT INTO expenses 
VALUES  (1, "salaries", 0),
		(2, "supplies", 0),
        (3, "taxes", 0);
        
UPDATE expenses
SET expense_total = (SELECT SUM(salary) FROM employees)
WHERE expense_name = "salaries";

CREATE TRIGGER after_salary_delete
AFTER DELETE ON employees
FOR EACH ROW 
UPDATE expenses
SET expense_total = expense_total - OLD.salary
WHERE expense_name = "salaries";

SELECT * FROM employees;
SELECT * FROM expenses;

DELETE FROM employees
WHERE employee_id = 6;

CREATE TRIGGER after_salary_insert
AFTER INSERT ON employees
FOR EACH ROW
UPDATE expenses
SET expense_total = expense_total + NEW.salary
WHERE expense_name = "salaries";

DROP TRIGGER after_salary_insert;

INSERT INTO employees
VALUES (6, "Sheldon", "Plankton", 10, NULL, "janitor", "2025-2-15", 5);

CREATE TRIGGER after_salary_update
AFTER UPDATE ON employees
FOR EACH ROW
UPDATE expenses
SET expense_total = expense_total + (NEW.salary - OLD.salary)
WHERE expense_name = "salaries";

SELECT * FROM expenses;

UPDATE employees
SET hourly_pay = 100
WHERE employee_id = 1;
-- ___________________________________
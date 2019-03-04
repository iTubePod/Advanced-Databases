-- Ejercicio 1

-- 4
CREATE DATABASE test

-- 5
connect to test

-- 6
CREATE TABLE products (id INTEGER NOT NULL, description VARCHAR(30) NOT NULL, start_date DATE NOT NULL, end_date DATE NOT NULL, PERIOD BUSINESS_TIME(start_date, end_date))

-- 7
CREATE UNIQUE INDEX index_period_products ON products(id, BUSINESS_TIME WITHOUT OVERLAPS)

-- 8
INSERT INTO products (id, description, start_date, end_date) VALUES (1, 'pan', '2019-01-21', '2019-01-31')

-- 9
SELECT * FROM products

-- 10
UPDATE products FOR PORTION OF BUSINESS_TIME FROM '2019-01-23' TO '2019-01-25' SET description = 'pan de caja' WHERE id = 1

-- 11
SELECT * FROM products

-- 12
DELETE products FOR PORTION OF BUSINESS_TIME FROM '2019-01-27' TO '2019-01-29' WHERE id = 1

-- 13
SELECT * FROM products

-- 14
SELECT description FROM products FOR BUSINESS_TIME FROM '2019-01-24' TO '2019-01-25'



-- Ejercicio 2

-- 4
CREATE DATABASE test2

-- 5
connect to test2

-- 6
-- Create table with system versioning
CREATE TABLE policy ( policy_id    CHAR(4) NOT NULL, coverage  INT NOT NULL, sys_start    TIMESTAMP(12) NOT NULL GENERATED ALWAYS AS ROW BEGIN, sys_end      TIMESTAMP(12) NOT NULL GENERATED ALWAYS AS ROW END,  ts_id        TIMESTAMP(12) NOT NULL GENERATED ALWAYS AS TRANSACTION START ID, PERIOD SYSTEM_TIME (sys_start, sys_end) )

-- 7
--Creates copy of structure of table policy
CREATE TABLE hist_policy LIKE policy

-- 8
-- Indicates that policy historic table is hist_policy
ALTER TABLE policy ADD VERSIONING USE HISTORY TABLE hist_policy

-- 9
INSERT INTO policy(policy_id, coverage)  VALUES('A123',12000)
INSERT INTO policy(policy_id, coverage)  VALUES('B345',18000)
INSERT INTO policy(policy_id, coverage)  VALUES('C567',20000)

-- 10
SELECT * FROM policy

-- 11
UPDATE policy    SET coverage = 25000    WHERE policy_id = 'C567'

-- 12
SELECT * FROM policy
SELECT * FROM hist_policy

-- 13
DELETE FROM policy WHERE policy_id = 'B345'

-- 14
SELECT * FROM policy
SELECT * FROM hist_policy

-- 15
SELECT * FROM policy WHERE policy_id = 'C567'

-- 16
SELECT policy_id, coverage FROM policy FOR SYSTEM_TIME AS OF '2019-01-19-16.28.23.034724000000'

-- 17
SELECT policy_id, coverage, sys_start, sys_end FROM policy FOR SYSTEM_TIME FROM '0001-01-01-00.00.00.000000' TO '9999-12-30-00.00.00.000000000000' WHERE policy_id = 'C567'

-- 18
SELECT policy_id, coverage FROM policy FOR SYSTEM_TIME BETWEEN '2019-01-19-16.28.23.034724000000' AND '9999-12-30-00.00.00.000000000000'

-- 19
UPDATE (SELECT * FROM policy FOR SYSTEM_TIME AS OF '2019-01-22') SET coverage = coverage + 1000

DELETE FROM (SELECT * FROM policy FOR SYSTEM_TIME AS OF '2019-01-19') WHERE policy_id = 'C567'
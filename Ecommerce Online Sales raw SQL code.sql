-- Created database

CREATE DATABASE onlineretail;

-- Created table to import data

CREATE TABLE sales( 
	invoice_no VARCHAR(10),
    stock_code VARCHAR(20),
    description VARCHAR(100),
    quantity VARCHAR(100),
    invoice_date VARCHAR(20),
    unit_price VARCHAR(100),
    customer VARCHAR(20),
    country VARCHAR(20)
    );
    
-- Imported data into table

SET GLOBAL LOCAL_INFILE=1;

LOAD DATA LOCAL INFILE 'D:OnlineRetail.csv' INTO TABLE sales
CHARACTER SET latin1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

-- Queried table and explored the data before cleaning
    
SELECT quantity * unit_price
FROM sales;

SELECT DISTINCT `description`, COUNT(`description`), SUM(quantity * unit_price)
FROM sales
GROUP BY `description`
ORDER BY 2 DESC;

SELECT `description`, unit_price
FROM sales
WHERE `description` = '';

-- Data cleaning

SELECT *
FROM sales;

SELECT *, 
ROW_NUMBER() OVER(PARTITION BY invoice_no, stock_code, description, quantity, invoice_date, unit_price, customer, country) AS row_num
FROM sales;

WITH duplicates AS
(
SELECT *, 
ROW_NUMBER() 
OVER(PARTITION BY invoice_no, stock_code, description, quantity, invoice_date, unit_price, customer, country) AS row_num
FROM sales
)
SELECT row_num, COUNT(row_num)
FROM duplicates
WHERE row_num > 1
GROUP BY row_num;
;

SELECT *
FROM sales
WHERE quantity <= -1;

DELETE
FROM sales
WHERE quantity <= -1;

SELECT description
FROM sales
WHERE description LIKE '%7%';

SELECT *
FROM sales
WHERE unit_price = '0';

DELETE
FROM sales
WHERE unit_price = '0';

SELECT country
FROM sales
WHERE country LIKE '%EIRE%';

UPDATE sales
SET country = 'Ireland'
WHERE country LIKE '%EIRE%';

SELECT country
FROM sales
WHERE country LIKE '%RSA%';

UPDATE sales
SET country = 'South Africa'
WHERE country LIKE '%RSA%';

UPDATE sales
SET customer = NULL
WHERE customer = '';

ALTER TABLE sales
MODIFY COLUMN unit_price DECIMAL(10,2);

SELECT revenue
FROM sales
WHERE revenue IS NULL;

DELETE
FROM sales
WHERE invoice_no IS NULL;

-- Feature engineering

SELECT *
FROM sales;

SELECT ROUND(quantity * unit_price,2) AS revenue
FROM sales;

ALTER TABLE sales
ADD COLUMN revenue DECIMAL(10,2);

UPDATE sales
SET revenue = ROUND(quantity * unit_price,2);

ALTER TABLE sales
ADD COLUMN `date` VARCHAR(20);

SELECT invoice_date, SUBSTRING(invoice_date,1,10)
FROM sales;

UPDATE sales
SET `date` = SUBSTRING(invoice_date,1,10);

UPDATE sales
SET `date` = STR_TO_DATE(`date`,'%d-%m-%Y');

-- Feature Engineering

ALTER TABLE sales
ADD COLUMN day_of_week VARCHAR(20);

UPDATE sales
SET day_of_week = DAYNAME(`date`);

ALTER TABLE sales
ADD `month` VARCHAR(20);

UPDATE sales
SET `month` = MONTHNAME(`date`);

ALTER TABLE sales
ADD COLUMN `time` TIME;

SELECT invoice_date, SUBSTRING(invoice_date,12,5)
FROM sales;

UPDATE sales
SET `time` = SUBSTRING(invoice_date,12,5);

SELECT *,
	(
    CASE
    WHEN `time` BETWEEN '00:00:00' AND '11:59:59' THEN 'Morning'
    WHEN `time` BETWEEN '12:00:00' AND '16:00:00' THEN 'Afternoon'
    ELSE 'Evening'
    END
    ) AS time_of_day
FROM sales;

ALTER TABLE sales
ADD time_of_day VARCHAR(20);

UPDATE sales
SET time_of_day = (
    CASE
    WHEN `time` BETWEEN '00:00:00' AND '11:59:59' THEN 'Morning'
    WHEN `time` BETWEEN '12:00:00' AND '16:00:00' THEN 'Afternoon'
    ELSE 'Evening'
    END);

-- Quering data

SELECT `description`, COUNT(`description`), ROW_NUMBER() OVER()
FROM sales
GROUP BY `description`
ORDER BY 2 DESC;

SELECT `description`, SUM(revenue)
FROM sales
GROUP BY `description`
ORDER BY 2 DESC;

SELECT `month`, SUM(revenue)
FROM sales
GROUP BY `month`
ORDER BY 2 DESC;

SELECT day_of_week, SUM(revenue)
FROM sales
GROUP BY day_of_week
ORDER BY 2 DESC;

SELECT country, SUM(revenue)
FROM sales
GROUP BY country
ORDER BY 2 DESC;

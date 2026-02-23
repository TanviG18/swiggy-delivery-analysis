CREATE DATABASE delivery_project;
USE delivery_project;
CREATE TABLE orders(
ID VARCHAR(100),
delivery_time INT,
late_delivery INT
);
SELECT DATABASE();
USE delivery_project;
DESCRIBE orders_2;
SELECT * FROM orders LIMIT 10;

-- Total number of deliveries
SELECT COUNT(*) AS total_orders
FROM orders;

-- Orders delivered late
SELECT COUNT(*) AS late_orders
FROM orders
WHERE late_delivery = TRUE;

-- Orders delivered on time
SELECT COUNT(*) AS on_time_orders
FROM orders
WHERE late_delivery = FALSE;

-- Percentage of late deliveries
SELECT 
(
	COUNT(CASE WHEN late_delivery = TRUE THEN 1 END) * 100.0 
/ COUNT(*)
) AS late_delivery_percentage
FROM orders;

-- Average delivery time
SELECT AVG(delivery_time)
FROM orders;

-- Fastest delivery time
SELECT MIN(delivery_time)
FROM orders;

-- late delivery time
SELECT MAX(delivery_time)
FROM orders;

-- Group deliveries according time
SELECT
CASE 
    WHEN delivery_time <= 30 THEN 'Fast'
    WHEN delivery_time BETWEEN 31 AND 45 THEN 'Moderate'
    ELSE 'Late'
END AS delivery_category,
COUNT(*) AS total_orders
FROM orders
GROUP BY delivery_category;

-- SLA Breach Severity Index
SELECT 
ROUND(
SUM(CASE WHEN delivery_time > 45 THEN (delivery_time - 45) ELSE 0 END)
/ COUNT(*), 2
) AS avg_delay_severity
FROM orders;

-- Delivery Time Standard Deviation
SELECT 
ROUND(STDDEV(delivery_time),2) AS delivery_time_variability
FROM orders;

-- % of orders delivered within SLA (45 min)
SELECT 
ROUND(
SUM(CASE WHEN delivery_time <= 45 THEN 1 ELSE 0 END) * 100.0
/ COUNT(*), 2
) AS delivery_efficiency_percentage
FROM orders;

-- Orders delivered in optimal time span
SELECT COUNT(*) AS optimal_time_orders
FROM orders
WHERE delivery_time BETWEEN 20 AND 40;

-- Average delay for late deliveries
SELECT 
ROUND(AVG(delivery_time),2) AS avg_late_delivery_time
FROM orders
WHERE late_delivery = TRUE;

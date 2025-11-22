-- create database
CREATE DATABASE IF NOT EXISTS blinkit_analytics;
USE blinkit_analytics;

SHOW TABLES;

SELECT * FROM blinkit_data LIMIT 10;

-- rename them into clean snake_case:

ALTER TABLE blinkit_data CHANGE `ï»¿Item Fat Content` item_fat_content VARCHAR(50);
ALTER TABLE blinkit_data CHANGE `Item Identifier` item_identifier VARCHAR(50);
ALTER TABLE blinkit_data CHANGE `Item Type` item_type VARCHAR(100);
ALTER TABLE blinkit_data CHANGE `Outlet Establishment Year` outlet_establishment_year INT;
ALTER TABLE blinkit_data CHANGE `Outlet Identifier` outlet_identifier VARCHAR(50);
ALTER TABLE blinkit_data CHANGE `Outlet Location Type` outlet_location_type VARCHAR(50);
ALTER TABLE blinkit_data CHANGE `Outlet Size` outlet_size VARCHAR(50);
ALTER TABLE blinkit_data CHANGE `Outlet Type` outlet_type VARCHAR(50);
ALTER TABLE blinkit_data CHANGE `Item Visibility` item_visibility DOUBLE;
ALTER TABLE blinkit_data CHANGE `Item Weight` item_weight DOUBLE;
ALTER TABLE blinkit_data CHANGE `Sales` sales DOUBLE;
ALTER TABLE blinkit_data CHANGE `Rating` rating DOUBLE;

-- Outlet Dimension Table
CREATE TABLE IF NOT EXISTS outlet_dim_new (
  outlet_identifier VARCHAR(50) NOT NULL PRIMARY KEY,
  outlet_location_type VARCHAR(50),
  outlet_size VARCHAR(50),
  outlet_type VARCHAR(50),
  outlet_establishment_year INT
);

INSERT INTO outlet_dim_new (outlet_identifier, outlet_location_type, outlet_size, outlet_type, outlet_establishment_year)
SELECT 
    outlet_identifier,
    ANY_VALUE(outlet_location_type),
    ANY_VALUE(outlet_size),
    ANY_VALUE(outlet_type),
    ANY_VALUE(outlet_establishment_year)
FROM blinkit_data
WHERE outlet_identifier IS NOT NULL
GROUP BY outlet_identifier;

DROP TABLE IF EXISTS outlet_dim;
RENAME TABLE outlet_dim_new TO outlet_dim;

-- Item Dimension Table
CREATE TABLE IF NOT EXISTS item_dim_new (
  item_identifier VARCHAR(50) NOT NULL PRIMARY KEY,
  item_type VARCHAR(100),
  item_fat_content VARCHAR(50),
  item_weight DOUBLE
);

INSERT INTO item_dim_new (item_identifier, item_type, item_fat_content, item_weight)
SELECT 
    item_identifier,
    ANY_VALUE(item_type),
    ANY_VALUE(item_fat_content),
    ANY_VALUE(item_weight)
FROM blinkit_data
WHERE item_identifier IS NOT NULL
GROUP BY item_identifier;

DROP TABLE IF EXISTS item_dim;
RENAME TABLE item_dim_new TO item_dim;


-- sales_fact Table
DROP TABLE IF EXISTS sales_fact;
CREATE TABLE IF NOT EXISTS sales_fact (
    sale_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    item_identifier VARCHAR(50) NOT NULL,
    outlet_identifier VARCHAR(50) NOT NULL,
    sales_amount DOUBLE,
    rating DOUBLE
);

INSERT INTO sales_fact (
    item_identifier,
    outlet_identifier,
    sales_amount,
    rating
)
SELECT
    item_identifier,
    outlet_identifier,
    SUM(sales) AS sales_amount,
    AVG(rating) AS rating
FROM blinkit_data
WHERE item_identifier IS NOT NULL
  AND outlet_identifier IS NOT NULL
GROUP BY item_identifier, outlet_identifier;

-- Create Summary / Results Table

CREATE TABLE sales_summary (
  summary_id INT AUTO_INCREMENT PRIMARY KEY,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  summary_type VARCHAR(50),
  entity_id VARCHAR(50),
  entity_name VARCHAR(255),
  metric_name VARCHAR(50),
  metric_value DOUBLE
);

INSERT INTO sales_summary (summary_type, entity_id, entity_name, metric_name, metric_value)
SELECT
    'outlet_total' AS summary_type,
    outlet_identifier AS entity_id,
    outlet_identifier AS entity_name,
    'total_sales' AS metric_name,
    SUM(sales) AS metric_value
FROM blinkit_data
GROUP BY outlet_identifier;


SHOW TABLES;

select * from outlet_dim;
select * from item_dim;
select * from sales_fact;
select * from sales_summary;


SELECT SUM(sales_amount) AS total_sales
FROM sales_fact;


-- 1. Top 10 Items by Sales
SELECT 
    item_identifier,
    SUM(sales_amount) AS total_sales
FROM sales_fact
GROUP BY item_identifier
ORDER BY total_sales DESC
LIMIT 10;

-- 2. Top 10 Outlets by Sales
SELECT 
    outlet_identifier,
    SUM(sales_amount) AS total_sales
FROM sales_fact
GROUP BY outlet_identifier
ORDER BY total_sales DESC
LIMIT 10;

-- 3. Total Sales by Item Type
SELECT 
    i.item_type,
    SUM(f.sales_amount) AS total_sales
FROM sales_fact f
JOIN item_dim i USING (item_identifier)
GROUP BY i.item_type
ORDER BY total_sales DESC;

-- 4. Average Rating by Item
SELECT 
    item_identifier,
    AVG(rating) AS avg_rating
FROM sales_fact
GROUP BY item_identifier
ORDER BY avg_rating DESC;

-- 5. Overall KPIs (Quick Summary)
SELECT 
    SUM(sales_amount) AS total_sales,
    AVG(rating) AS avg_rating,
    COUNT(*) AS total_records
FROM sales_fact;

-- 6.Best Performing Item Type (Top 1)
SELECT 
    i.item_type,
    SUM(f.sales_amount) AS total_sales
FROM sales_fact f
JOIN item_dim i USING (item_identifier)
GROUP BY i.item_type
ORDER BY total_sales DESC
LIMIT 1;



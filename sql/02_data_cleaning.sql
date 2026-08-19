USE ecommerce_sales;

-- Create clean table
CREATE TABLE clean_ecommerce_sales AS
SELECT *
FROM raw_ecommerce_sales;

-- Disable safe update mode for cleaning
SET SQL_SAFE_UPDATES = 0;

-- Standardize category
UPDATE clean_ecommerce_sales
SET Category = 'Electronics'
WHERE LOWER(TRIM(Category)) = 'electronic';

-- Convert "nan" to NULL
UPDATE clean_ecommerce_sales
SET Category = NULL
WHERE LOWER(TRIM(Category)) = 'nan';


-- Quantity cleaning

UPDATE clean_ecommerce_sales
SET Quantity = NULL
WHERE TRIM(Quantity) = ''
   OR Quantity NOT REGEXP '^[0-9]+$'
   OR CAST(Quantity AS SIGNED) <= 0;

-- Clean and recalculate Total

UPDATE clean_ecommerce_sales
SET Total =
    CASE
        WHEN Quantity REGEXP '^[0-9]+$'
             AND CAST(Quantity AS DECIMAL(10,2)) > 0
             AND Price REGEXP '^[0-9]+(\.[0-9]+)?$'
             AND CAST(Price AS DECIMAL(10,2)) >= 0
        THEN ROUND(
            CAST(Quantity AS DECIMAL(10,2)) *
            CAST(Price AS DECIMAL(10,2)),
            2
        )
        ELSE NULL
    END;

-- Remove exact duplicate records
CREATE TABLE final_ecommerce_sales AS
SELECT DISTINCT *
FROM clean_ecommerce_sales;
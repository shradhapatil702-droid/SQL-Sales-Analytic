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

-- Turn safe update mode back on
SET SQL_SAFE_UPDATES = 1;
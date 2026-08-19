USE ecommerce_sales;

SELECT COUNT(*) AS total_rows
FROM raw_ecommerce_sales;

SELECT *
FROM raw_ecommerce_sales
LIMIT 10;

-- NULL check
SELECT
    SUM(ID IS NULL) AS missing_ID,
    SUM(Customer_Name IS NULL) AS missing_Customer_Name,
    SUM(Order_ID IS NULL) AS missing_Order_ID,
    SUM(Order_Date IS NULL) AS missing_Order_Date,
    SUM(Product IS NULL) AS missing_Product,
    SUM(Category IS NULL) AS missing_Category,
    SUM(Quantity IS NULL) AS missing_Quantity,
    SUM(Price IS NULL) AS missing_Price,
    SUM(Payment_Method IS NULL) AS missing_Payment_Method,
    SUM(Status IS NULL) AS missing_Status,
    SUM(Total IS NULL) AS missing_Total
FROM raw_ecommerce_sales;

-- Duplicate IDs
SELECT ID, COUNT(*) AS duplicate_count
FROM raw_ecommerce_sales
GROUP BY ID
HAVING COUNT(*) > 1;

-- Category
SELECT DISTINCT Category
FROM raw_ecommerce_sales;

-- Payment methods
SELECT DISTINCT Payment_Method
FROM raw_ecommerce_sales;

-- Status
SELECT DISTINCT Status
FROM raw_ecommerce_sales;

-- Quantity
SELECT DISTINCT Quantity
FROM raw_ecommerce_sales
ORDER BY Quantity;

-- Price
SELECT DISTINCT Price
FROM raw_ecommerce_sales
ORDER BY Price;


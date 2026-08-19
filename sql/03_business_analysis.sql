USE ecommerce_sales;


-- ============================================================
-- E-COMMERCE SALES ANALYSIS
-- ============================================================
-- Final cleaned table:
-- final_ecommerce_sales
--
-- Business questions answered:
-- 1. Overall sales performance
-- 2. Category performance
-- 3. Product performance
-- 4. Customer analysis
-- 5. Payment method analysis
-- 6. Order status analysis
-- 7. Monthly sales trends
-- 8. High-value orders
-- 9. CTE analysis
-- 10. Window function analysis
-- ============================================================



-- ============================================================
-- SECTION 1: OVERALL BUSINESS PERFORMANCE
-- ============================================================


-- 1. Total Revenue

SELECT
    ROUND(SUM(CAST(Total AS DECIMAL(10,2))), 2) AS total_revenue
FROM final_ecommerce_sales;


-- 2. Total Orders

SELECT
    COUNT(DISTINCT Order_ID) AS total_orders
FROM final_ecommerce_sales;


-- 3. Total Customers

SELECT
    COUNT(DISTINCT Customer_Name) AS total_customers
FROM final_ecommerce_sales;


-- 4. Total Units Sold

SELECT
    SUM(CAST(Quantity AS DECIMAL(10,2))) AS total_units_sold
FROM final_ecommerce_sales
WHERE Quantity IS NOT NULL;


-- 5. Average Order Value

SELECT
    ROUND(
        SUM(CAST(Total AS DECIMAL(10,2)))
        / COUNT(DISTINCT Order_ID),
        2
    ) AS average_order_value
FROM final_ecommerce_sales
WHERE Total IS NOT NULL;


-- 6. Minimum and Maximum Order Value

SELECT
    ROUND(MIN(CAST(Total AS DECIMAL(10,2))), 2) AS minimum_order_value,
    ROUND(MAX(CAST(Total AS DECIMAL(10,2))), 2) AS maximum_order_value
FROM final_ecommerce_sales
WHERE Total IS NOT NULL;



-- ============================================================
-- SECTION 2: CATEGORY ANALYSIS
-- ============================================================


-- 7. Revenue by Category

SELECT
    Category,
    ROUND(SUM(CAST(Total AS DECIMAL(10,2))), 2) AS revenue
FROM final_ecommerce_sales
WHERE Category IS NOT NULL
  AND Total IS NOT NULL
GROUP BY Category
ORDER BY revenue DESC;


-- 8. Units Sold by Category

SELECT
    Category,
    SUM(CAST(Quantity AS DECIMAL(10,2))) AS units_sold
FROM final_ecommerce_sales
WHERE Category IS NOT NULL
  AND Quantity IS NOT NULL
GROUP BY Category
ORDER BY units_sold DESC;


-- 9. Orders by Category

SELECT
    Category,
    COUNT(DISTINCT Order_ID) AS total_orders
FROM final_ecommerce_sales
WHERE Category IS NOT NULL
GROUP BY Category
ORDER BY total_orders DESC;


-- 10. Average Order Value by Category

SELECT
    Category,
    ROUND(
        SUM(CAST(Total AS DECIMAL(10,2)))
        / COUNT(DISTINCT Order_ID),
        2
    ) AS average_order_value
FROM final_ecommerce_sales
WHERE Category IS NOT NULL
  AND Total IS NOT NULL
GROUP BY Category
ORDER BY average_order_value DESC;



-- ============================================================
-- SECTION 3: PRODUCT ANALYSIS
-- ============================================================


-- 11. Top Products by Units Sold

SELECT
    Product,
    SUM(CAST(Quantity AS DECIMAL(10,2))) AS units_sold
FROM final_ecommerce_sales
WHERE Product IS NOT NULL
  AND Quantity IS NOT NULL
GROUP BY Product
ORDER BY units_sold DESC;


-- 12. Top Products by Revenue

SELECT
    Product,
    ROUND(SUM(CAST(Total AS DECIMAL(10,2))), 2) AS revenue
FROM final_ecommerce_sales
WHERE Product IS NOT NULL
  AND Total IS NOT NULL
GROUP BY Product
ORDER BY revenue DESC;


-- 13. Product Performance with Orders and Revenue

SELECT
    Product,
    COUNT(DISTINCT Order_ID) AS orders,
    SUM(CAST(Quantity AS DECIMAL(10,2))) AS units_sold,
    ROUND(SUM(CAST(Total AS DECIMAL(10,2))), 2) AS revenue
FROM final_ecommerce_sales
WHERE Product IS NOT NULL
GROUP BY Product
ORDER BY revenue DESC;


-- 14. Products with Revenue Above Average Product Revenue

SELECT
    Product,
    ROUND(SUM(CAST(Total AS DECIMAL(10,2))), 2) AS revenue
FROM final_ecommerce_sales
WHERE Product IS NOT NULL
  AND Total IS NOT NULL
GROUP BY Product
HAVING SUM(CAST(Total AS DECIMAL(10,2))) >
(
    SELECT AVG(product_revenue)
    FROM
    (
        SELECT
            SUM(CAST(Total AS DECIMAL(10,2))) AS product_revenue
        FROM final_ecommerce_sales
        WHERE Product IS NOT NULL
          AND Total IS NOT NULL
        GROUP BY Product
    ) AS product_sales
)
ORDER BY revenue DESC;



-- ============================================================
-- SECTION 4: CUSTOMER ANALYSIS
-- ============================================================


-- 15. Top Customers by Revenue

SELECT
    Customer_Name,
    COUNT(DISTINCT Order_ID) AS total_orders,
    ROUND(SUM(CAST(Total AS DECIMAL(10,2))), 2) AS total_spent
FROM final_ecommerce_sales
WHERE Customer_Name IS NOT NULL
  AND Total IS NOT NULL
GROUP BY Customer_Name
ORDER BY total_spent DESC
LIMIT 10;


-- 16. Customers with More Than One Order

SELECT
    Customer_Name,
    COUNT(DISTINCT Order_ID) AS total_orders,
    ROUND(SUM(CAST(Total AS DECIMAL(10,2))), 2) AS total_spent
FROM final_ecommerce_sales
WHERE Customer_Name IS NOT NULL
GROUP BY Customer_Name
HAVING COUNT(DISTINCT Order_ID) > 1
ORDER BY total_orders DESC;


-- 17. Highest Value Customer

SELECT
    Customer_Name,
    ROUND(SUM(CAST(Total AS DECIMAL(10,2))), 2) AS total_spent
FROM final_ecommerce_sales
WHERE Customer_Name IS NOT NULL
  AND Total IS NOT NULL
GROUP BY Customer_Name
ORDER BY total_spent DESC
LIMIT 1;



-- ============================================================
-- SECTION 5: PAYMENT METHOD ANALYSIS
-- ============================================================


-- 18. Orders and Revenue by Payment Method

SELECT
    Payment_Method,
    COUNT(DISTINCT Order_ID) AS total_orders,
    ROUND(SUM(CAST(Total AS DECIMAL(10,2))), 2) AS revenue
FROM final_ecommerce_sales
WHERE Payment_Method IS NOT NULL
GROUP BY Payment_Method
ORDER BY revenue DESC;


-- 19. Payment Method Revenue Percentage

SELECT
    Payment_Method,
    ROUND(SUM(CAST(Total AS DECIMAL(10,2))), 2) AS revenue,
    ROUND(
        100 * SUM(CAST(Total AS DECIMAL(10,2)))
        / (
            SELECT SUM(CAST(Total AS DECIMAL(10,2)))
            FROM final_ecommerce_sales
        ),
        2
    ) AS revenue_percentage
FROM final_ecommerce_sales
WHERE Payment_Method IS NOT NULL
  AND Total IS NOT NULL
GROUP BY Payment_Method
ORDER BY revenue_percentage DESC;



-- ============================================================
-- SECTION 6: ORDER STATUS ANALYSIS
-- ============================================================


-- 20. Orders by Status

SELECT
    Status,
    COUNT(DISTINCT Order_ID) AS total_orders
FROM final_ecommerce_sales
WHERE Status IS NOT NULL
GROUP BY Status
ORDER BY total_orders DESC;


-- 21. Revenue by Status

SELECT
    Status,
    ROUND(SUM(CAST(Total AS DECIMAL(10,2))), 2) AS revenue
FROM final_ecommerce_sales
WHERE Status IS NOT NULL
  AND Total IS NOT NULL
GROUP BY Status
ORDER BY revenue DESC;


-- 22. Status Percentage

SELECT
    Status,
    COUNT(DISTINCT Order_ID) AS orders,
    ROUND(
        100 * COUNT(DISTINCT Order_ID)
        / (
            SELECT COUNT(DISTINCT Order_ID)
            FROM final_ecommerce_sales
        ),
        2
    ) AS order_percentage
FROM final_ecommerce_sales
WHERE Status IS NOT NULL
GROUP BY Status
ORDER BY order_percentage DESC;



-- ============================================================
-- SECTION 7: DATE / MONTHLY ANALYSIS
-- ============================================================


-- 23. Monthly Revenue

SELECT
    YEAR(Order_Date) AS order_year,
    MONTH(Order_Date) AS order_month,
    DATE_FORMAT(Order_Date, '%Y-%m') AS month,
    ROUND(SUM(CAST(Total AS DECIMAL(10,2))), 2) AS revenue
FROM final_ecommerce_sales
WHERE Order_Date IS NOT NULL
  AND Total IS NOT NULL
GROUP BY
    YEAR(Order_Date),
    MONTH(Order_Date),
    DATE_FORMAT(Order_Date, '%Y-%m')
ORDER BY order_year, order_month;


-- 24. Monthly Orders

SELECT
    DATE_FORMAT(Order_Date, '%Y-%m') AS month,
    COUNT(DISTINCT Order_ID) AS total_orders
FROM final_ecommerce_sales
WHERE Order_Date IS NOT NULL
GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
ORDER BY month;


-- 25. Monthly Units Sold

SELECT
    DATE_FORMAT(Order_Date, '%Y-%m') AS month,
    SUM(CAST(Quantity AS DECIMAL(10,2))) AS units_sold
FROM final_ecommerce_sales
WHERE Order_Date IS NOT NULL
  AND Quantity IS NOT NULL
GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
ORDER BY month;



-- ============================================================
-- SECTION 8: HIGH-VALUE ORDERS
-- ============================================================


-- 26. Top 10 Highest Value Orders

SELECT
    Order_ID,
    Customer_Name,
    Product,
    Category,
    Quantity,
    Price,
    Total,
    Status
FROM final_ecommerce_sales
WHERE Total IS NOT NULL
ORDER BY CAST(Total AS DECIMAL(10,2)) DESC
LIMIT 10;


-- 27. Orders Above 1000

SELECT
    Order_ID,
    Customer_Name,
    Product,
    Total
FROM final_ecommerce_sales
WHERE Total IS NOT NULL
  AND CAST(Total AS DECIMAL(10,2)) > 1000
ORDER BY CAST(Total AS DECIMAL(10,2)) DESC;



-- ============================================================
-- SECTION 9: CASE STATEMENT ANALYSIS
-- ============================================================


-- 28. Categorize Orders by Value

SELECT
    Order_ID,
    Customer_Name,
    Total,
    CASE
        WHEN CAST(Total AS DECIMAL(10,2)) < 500
            THEN 'Low Value'
        WHEN CAST(Total AS DECIMAL(10,2)) < 1000
            THEN 'Medium Value'
        ELSE 'High Value'
    END AS order_value_category
FROM final_ecommerce_sales
WHERE Total IS NOT NULL
ORDER BY CAST(Total AS DECIMAL(10,2)) DESC;


-- 29. Count Orders by Value Category

SELECT
    CASE
        WHEN CAST(Total AS DECIMAL(10,2)) < 500
            THEN 'Low Value'
        WHEN CAST(Total AS DECIMAL(10,2)) < 1000
            THEN 'Medium Value'
        ELSE 'High Value'
    END AS order_value_category,
    COUNT(*) AS number_of_orders
FROM final_ecommerce_sales
WHERE Total IS NOT NULL
GROUP BY order_value_category
ORDER BY number_of_orders DESC;



-- ============================================================
-- SECTION 10: CTE ANALYSIS
-- ============================================================


-- 30. Category Revenue Ranking using CTE

WITH category_sales AS
(
    SELECT
        Category,
        SUM(CAST(Total AS DECIMAL(10,2))) AS revenue
    FROM final_ecommerce_sales
    WHERE Category IS NOT NULL
      AND Total IS NOT NULL
    GROUP BY Category
)
SELECT
    Category,
    ROUND(revenue, 2) AS revenue
FROM category_sales
ORDER BY revenue DESC;


-- 31. Top 3 Products by Revenue using CTE

WITH product_sales AS
(
    SELECT
        Product,
        SUM(CAST(Total AS DECIMAL(10,2))) AS revenue
    FROM final_ecommerce_sales
    WHERE Product IS NOT NULL
      AND Total IS NOT NULL
    GROUP BY Product
)
SELECT
    Product,
    ROUND(revenue, 2) AS revenue
FROM product_sales
ORDER BY revenue DESC
LIMIT 3;



-- ============================================================
-- SECTION 11: WINDOW FUNCTIONS
-- ============================================================


-- 32. Rank Products by Revenue

WITH product_sales AS
(
    SELECT
        Product,
        SUM(CAST(Total AS DECIMAL(10,2))) AS revenue
    FROM final_ecommerce_sales
    WHERE Product IS NOT NULL
      AND Total IS NOT NULL
    GROUP BY Product
)
SELECT
    Product,
    ROUND(revenue, 2) AS revenue,
    RANK() OVER (ORDER BY revenue DESC) AS revenue_rank
FROM product_sales
ORDER BY revenue_rank;


-- 33. Rank Categories by Revenue

WITH category_sales AS
(
    SELECT
        Category,
        SUM(CAST(Total AS DECIMAL(10,2))) AS revenue
    FROM final_ecommerce_sales
    WHERE Category IS NOT NULL
      AND Total IS NOT NULL
    GROUP BY Category
)
SELECT
    Category,
    ROUND(revenue, 2) AS revenue,
    RANK() OVER (ORDER BY revenue DESC) AS category_rank
FROM category_sales
ORDER BY category_rank;


-- 34. Monthly Revenue with Previous Month Revenue

WITH monthly_sales AS
(
    SELECT
        DATE_FORMAT(Order_Date, '%Y-%m') AS month,
        SUM(CAST(Total AS DECIMAL(10,2))) AS revenue
    FROM final_ecommerce_sales
    WHERE Order_Date IS NOT NULL
      AND Total IS NOT NULL
    GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
)
SELECT
    month,
    ROUND(revenue, 2) AS revenue,
    ROUND(
        LAG(revenue) OVER (ORDER BY month),
        2
    ) AS previous_month_revenue
FROM monthly_sales
ORDER BY month;


-- 35. Monthly Revenue Growth

WITH monthly_sales AS
(
    SELECT
        DATE_FORMAT(Order_Date, '%Y-%m') AS month,
        SUM(CAST(Total AS DECIMAL(10,2))) AS revenue
    FROM final_ecommerce_sales
    WHERE Order_Date IS NOT NULL
      AND Total IS NOT NULL
    GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
),
monthly_comparison AS
(
    SELECT
        month,
        revenue,
        LAG(revenue) OVER (ORDER BY month) AS previous_revenue
    FROM monthly_sales
)
SELECT
    month,
    ROUND(revenue, 2) AS revenue,
    ROUND(previous_revenue, 2) AS previous_revenue,
    ROUND(
        ((revenue - previous_revenue) / previous_revenue) * 100,
        2
    ) AS growth_percentage
FROM monthly_comparison
ORDER BY month;



-- ============================================================
-- SECTION 12: BUSINESS INSIGHTS
-- ============================================================


-- 36. Best Performing Category

SELECT
    Category,
    ROUND(SUM(CAST(Total AS DECIMAL(10,2))), 2) AS revenue
FROM final_ecommerce_sales
WHERE Category IS NOT NULL
  AND Total IS NOT NULL
GROUP BY Category
ORDER BY revenue DESC
LIMIT 1;


-- 37. Best Performing Product

SELECT
    Product,
    ROUND(SUM(CAST(Total AS DECIMAL(10,2))), 2) AS revenue
FROM final_ecommerce_sales
WHERE Product IS NOT NULL
  AND Total IS NOT NULL
GROUP BY Product
ORDER BY revenue DESC
LIMIT 1;


-- 38. Most Popular Product

SELECT
    Product,
    SUM(CAST(Quantity AS DECIMAL(10,2))) AS units_sold
FROM final_ecommerce_sales
WHERE Product IS NOT NULL
  AND Quantity IS NOT NULL
GROUP BY Product
ORDER BY units_sold DESC
LIMIT 1;


-- 39. Most Used Payment Method

SELECT
    Payment_Method,
    COUNT(DISTINCT Order_ID) AS total_orders
FROM final_ecommerce_sales
WHERE Payment_Method IS NOT NULL
GROUP BY Payment_Method
ORDER BY total_orders DESC
LIMIT 1;


-- 40. Most Common Order Status

SELECT
    Status,
    COUNT(DISTINCT Order_ID) AS total_orders
FROM final_ecommerce_sales
WHERE Status IS NOT NULL
GROUP BY Status
ORDER BY total_orders DESC
LIMIT 1;



-- ============================================================
-- PROJECT SUMMARY
-- ============================================================


SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT Order_ID) AS total_orders,
    COUNT(DISTINCT Customer_Name) AS total_customers,
    COUNT(DISTINCT Product) AS total_products,
    COUNT(DISTINCT Category) AS total_categories,
    ROUND(SUM(CAST(Total AS DECIMAL(10,2))), 2) AS total_revenue,
    ROUND(AVG(CAST(Total AS DECIMAL(10,2))), 2) AS average_transaction_value
FROM final_ecommerce_sales;
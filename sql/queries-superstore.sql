
-- KPI — Total Sales, Total Profit, Profit Margin (%)
SELECT 
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(100.0 * SUM(Profit) / NULLIF(SUM(Sales), 0), 2) AS profit_margin_pct
FROM superstore



-- KPI — Average Order Value (AOV)
SELECT 
    COUNT(DISTINCT Order_ID) AS total_orders,
    SUM(Sales) AS total_sales,
    ROUND(SUM(Sales) / NULLIF(COUNT(DISTINCT Order_ID), 0), 2) AS AOV
FROM superstore;



--  Sales, Profit & Margin by Category
SELECT
    Category,
    SUM(Sales) AS sales,
    SUM(Profit) AS profit,
    ROUND(100.0 * SUM(Profit) / NULLIF(SUM(Sales), 0), 2) AS margin_pct
FROM superstore
GROUP BY Category
ORDER BY profit DESC;



-- KPI — Top 10 Most Profitable Products
SELECT TOP 10
    Product_Name,
    SUM(Sales) AS total_sales,
    SUM(Profit) AS total_profit,
    SUM(Quantity) AS total_quantity
FROM superstore
GROUP BY Product_Name
ORDER BY total_profit DESC;



-- Impact of Discount — Bucket Analysis
SELECT
    CASE
        WHEN Discount = 0 THEN '0%'
        WHEN Discount > 0 AND Discount <= 0.10 THEN '0–10%'
        WHEN Discount > 0.10 AND Discount <= 0.25 THEN '10–25%'
        WHEN Discount > 0.25 AND Discount <= 0.50 THEN '25–50%'
        ELSE '>50%'
    END AS discount_bucket,
    COUNT(*) AS transaction_count,
    SUM(Sales) AS sales,
    SUM(Profit) AS profit,
    ROUND(100.0 * SUM(Profit) / NULLIF(SUM(Sales), 0), 2) AS margin_pct
FROM superstore
GROUP BY 
    CASE
        WHEN Discount = 0 THEN '0%'
        WHEN Discount > 0 AND Discount <= 0.10 THEN '0–10%'
        WHEN Discount > 0.10 AND Discount <= 0.25 THEN '10–25%'
        WHEN Discount > 0.25 AND Discount <= 0.50 THEN '25–50%'
        ELSE '>50%'
    END
ORDER BY discount_bucket;



-- Monthly Sales & Profit Trend (Year-Month)
SELECT
    FORMAT(Order_Date, 'yyyy-MM') AS year_month,
    SUM(Sales) AS sales,
    SUM(Profit) AS profit
FROM superstore
GROUP BY FORMAT(Order_Date, 'yyyy-MM')
ORDER BY year_month;



-- Sales & Profit by Sub-Category 
SELECT
    Sub_Category,
    SUM(Sales) AS sales,
    SUM(Profit) AS profit,
    ROUND(100.0 * SUM(Profit) / NULLIF(SUM(Sales), 0), 2) AS margin_pct
FROM superstore
GROUP BY Sub_Category
ORDER BY profit DESC;

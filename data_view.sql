USE DWH;
GO
CREATE OR ALTER VIEW gold.vw_sales_trends AS
SELECT 
    YEAR(o.Order_Date) AS Order_Year,
    MONTH(o.Order_Date) AS Order_Month,
    DATENAME(MONTH, o.Order_Date) AS Month_Name,
    COUNT(DISTINCT f.Order_ID) AS Total_Orders,
    SUM(f.Quantity) AS Total_Items_Sold,
    SUM(f.Sales) AS Total_Sales,
    SUM(f.Profit) AS Total_Profit
FROM gold.fact_sales f
JOIN gold.dim_orders o ON f.Order_ID = o.Order_ID
GROUP BY YEAR(o.Order_Date), MONTH(o.Order_Date), DATENAME(MONTH, o.Order_Date);
GO




CREATE OR ALTER VIEW gold.vw_profitability_analysis AS
SELECT 
    p.Category,
    p.Sub_Category,
    SUM(f.Sales) AS Total_Sales,
    SUM(f.Profit) AS Total_Profit,
    CASE 
        WHEN SUM(f.Sales) = 0 THEN 0 
        ELSE CAST((SUM(f.Profit) / SUM(f.Sales)) * 100 AS DECIMAL(5,2)) 
    END AS Profit_Margin_Percentage
FROM gold.fact_sales f
JOIN gold.dim_products p ON f.Product_ID = p.Product_ID
GROUP BY p.Category, p.Sub_Category;
GO




CREATE OR ALTER VIEW gold.vw_customer_behavior AS
SELECT 
    c.Customer_ID,
    c.Customer_Key,
    c.Customer_Name,
    c.Segment,
    COUNT(DISTINCT f.Order_ID) AS Total_Orders,
    SUM(f.Sales) AS Total_Spent,
    SUM(f.Profit) AS Total_Profit_Generated,
    CASE 
        WHEN COUNT(DISTINCT f.Order_ID) = 0 THEN 0 
        ELSE CAST(SUM(f.Sales) / COUNT(DISTINCT f.Order_ID) AS DECIMAL(10,2)) 
    END AS Avg_Order_Value
FROM gold.fact_sales f
JOIN gold.dim_customers c ON f.Customer_ID = c.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Key, c.Customer_Name, c.Segment;

# Central Superstore Data Warehouse & ETL Pipeline

## ✦ Project Overview
This project focuses on designing and implementing an end-to-end Data Warehouse (DWH) for a "Central Superstore" retail dataset using a Medallion Architecture. The SQL-based pipeline systematically processes data through Staging, Bronze, Silver, and Gold layers to deliver clean, optimized, and business-ready data structures.

## ✦ Problem Statement
Raw retail data initially supplied in an Excel spreadsheet format requires a scalable and automated ETL (Extract, Transform, Load) pipeline to be useful for analytics. The challenge involves converting this file format, bulk-loading the data into a database, systematically cleaning it to handle anomalies (such as outliers, missing fields, and invalid entries), and ultimately restructuring the flat data into a Star Schema optimized for Business Intelligence (BI) reporting[cite: 18, 19, 20].

## ✦ Goals
* **Data Ingestion & Formatting:** Utilize a Python script to convert the source `.xlsx` file into a `.csv` format, enabling high-performance SQL `BULK INSERT` operations into the staging layer.
* **Medallion Architecture Implementation:** Construct a multi-layered database schema (`staging`, `bronze`, `silver`, `gold`) to process data incrementally from raw ingestion to business-level aggregations.
* **Data Quality & Validation:** Implement dynamic SQL logic in the Silver layer to detect and flag missing values, invalid mathematical records (e.g., negative sales, or discounts outside the 0-1 range), and statistical outliers using the Interquartile Range (IQR).
* **Dimensional Modeling:** Transform the cleansed dataset into a standard Star Schema comprising a central `fact_sales` table and supporting dimension tables (`dim_customers`, `dim_products`, `dim_orders`).
* **Business Intelligence Readiness:** Develop stored procedures and SQL views to calculate Executive KPIs, analyze profitability, track sales trends, and evaluate customer purchasing behavior.

## ✦ Key Insights from the Data Engineering Pipeline
* **Silver Layer Cleansing:** The `silver.load_central_superstore` stored procedure standardizes data types and deduplicates records using `ROW_NUMBER()` partitioning. It successfully flags outliers dynamically by calculating `PERCENTILE_CONT(0.25)` and `PERCENTILE_CONT(0.75)` bounds for Sales, Profit, and Discount metrics.
* **Gold Layer Optimization:** The `gold.load_gold_layer` procedure populates a clean Star Schema, enforcing strict referential integrity through Primary and Foreign Keys between the sales facts and the customer, product, and order dimensions.
* **Analytical Views & KPIs:** Dedicated SQL views (`vw_sales_trends`, `vw_profitability_analysis`, `vw_customer_behavior`) aggregate critical business metrics, automatically calculating values like Profit Margin Percentage, Total Items Sold, and Average Order Value for immediate dashboard integration.

## ✦ Tools & Technologies
* **Database Management:** SQL Server (T-SQL, Stored Procedures, Views, MERGE statements, Window Functions).
* **Data Architecture:** Medallion Architecture (Bronze, Silver, Gold layers) and Star Schema Dimensional Modeling.
* **Scripting & Automation:** Python (Pandas library) for `.xlsx` to `.csv` format transformation.

## ✦ Conclusion
The implementation of this Data Warehouse successfully bridges the gap between raw transactional spreadsheets and strategic business intelligence. By enforcing strict, automated data quality checks in the Silver layer and restructuring the data into an optimized Star Schema within the Gold layer, the ETL pipeline provides a reliable, high-performance foundation for analyzing sales trends, customer behavior, and product profitability[cite: 19, 21].

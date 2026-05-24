-- =====================================================
-- SALES ANALYSIS SQL PROJECT
-- =====================================================

-- Project: Global Super Store Sales Analysis
-- Tool Used: MySQL Workbench
-- Dataset: Super Store Orders Dataset
-- Objective:
-- Analyze sales, profit, customer behavior,
-- product performance, and regional trends
-- using SQL queries.

-- =====================================================
-- DATABASE SELECTION
-- =====================================================

USE sales_analysis;

-- =====================================================
-- DATA VALIDATION & CLEANING
-- =====================================================

-- View first 10 rows of dataset

SELECT * FROM super_store_orders
LIMIT 10;

-- Check table structure and column data types

DESCRIBE super_store_orders;

-- Rename corrupted column name caused by UTF-8 encoding issue

-- This query was used once to fix corrupted column name

-- ALTER TABLE super_store_orders
-- CHANGE COLUMN `ï»¿order_id` order_id TEXT;

-- Verify cleaned table structure

DESCRIBE super_store_orders;

-- =====================================================
-- KPI ANALYSIS
-- =====================================================

-- Calculate total revenue generated

SELECT SUM(sales) AS total_revenue
FROM super_store_orders;

-- Calculate total profit earned

SELECT SUM(profit) AS total_profit
FROM super_store_orders;

-- Count total number of orders

SELECT COUNT(order_id) AS total_orders
FROM super_store_orders;

-- Calculate average sales value

SELECT AVG(sales) AS average_sales
FROM super_store_orders;

-- =====================================================
-- MARKET ANALYSIS
-- =====================================================

-- Top 5 markets by revenue

SELECT market,
       SUM(sales) AS revenue
FROM super_store_orders
GROUP BY market
ORDER BY revenue DESC
LIMIT 5;

-- Market-wise sales and profit analysis

SELECT market,
       SUM(sales) AS total_sales,
       SUM(profit) AS total_profit
FROM super_store_orders
GROUP BY market
ORDER BY total_sales DESC;

-- Market ranking based on sales performance

SELECT market,
       SUM(sales) AS total_sales,
       RANK() OVER (ORDER BY SUM(sales) DESC) AS sales_rank
FROM super_store_orders
GROUP BY market;

-- Markets with sales greater than 1 million

SELECT market,
       SUM(sales) AS total_sales
FROM super_store_orders
GROUP BY market
HAVING total_sales > 1000000;

-- =====================================================
-- CATEGORY ANALYSIS
-- =====================================================

-- Top categories by revenue

SELECT category,
       SUM(sales) AS revenue
FROM super_store_orders
GROUP BY category
ORDER BY revenue DESC
LIMIT 5;

-- Category-wise profit analysis

SELECT category,
       SUM(profit) AS total_profit
FROM super_store_orders
GROUP BY category
ORDER BY total_profit DESC;

-- Average profit by category

SELECT category,
       AVG(profit) AS average_profit
FROM super_store_orders
GROUP BY category
ORDER BY average_profit DESC;

-- Category with lowest total profit

SELECT category,
       SUM(profit) AS total_profit
FROM super_store_orders
GROUP BY category
ORDER BY total_profit ASC
LIMIT 1;

-- =====================================================
-- PRODUCT ANALYSIS
-- =====================================================

-- Top 10 products by profit

SELECT product_name,
       SUM(profit) AS total_profit
FROM super_store_orders
GROUP BY product_name
ORDER BY total_profit DESC
LIMIT 10;

-- Top 10 loss-making products

SELECT product_name,
       SUM(profit) AS total_loss
FROM super_store_orders
GROUP BY product_name
ORDER BY total_loss ASC
LIMIT 10;

-- Top 10 products by sales

SELECT product_name,
       SUM(sales) AS total_sales
FROM super_store_orders
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;

-- Most frequently ordered products

SELECT product_name,
       COUNT(*) AS total_orders
FROM super_store_orders
GROUP BY product_name
ORDER BY total_orders DESC
LIMIT 10;

-- Products with highest average shipping cost

SELECT product_name,
       AVG(shipping_cost) AS avg_shipping_cost
FROM super_store_orders
GROUP BY product_name
ORDER BY avg_shipping_cost DESC
LIMIT 10;

-- =====================================================
-- CUSTOMER ANALYSIS
-- =====================================================

-- Top 10 customers by sales

SELECT customer_name,
       SUM(sales) AS total_sales
FROM super_store_orders
GROUP BY customer_name
ORDER BY total_sales DESC
LIMIT 10;

-- Rank customers based on sales

SELECT customer_name,
       SUM(sales) AS total_sales,
       DENSE_RANK() OVER (ORDER BY SUM(sales) DESC) AS customer_rank
FROM super_store_orders
GROUP BY customer_name
LIMIT 10;

-- =====================================================
-- ORDER & SEGMENT ANALYSIS
-- =====================================================

-- Order priority distribution

SELECT order_priority,
       COUNT(*) AS total_orders
FROM super_store_orders
GROUP BY order_priority
ORDER BY total_orders DESC;

-- Segment-wise sales analysis

SELECT segment,
       SUM(sales) AS total_sales
FROM super_store_orders
GROUP BY segment
ORDER BY total_sales DESC;

-- =====================================================
-- COUNTRY & REGION ANALYSIS
-- =====================================================

-- Top 5 countries by sales

SELECT country,
       SUM(sales) AS total_sales
FROM super_store_orders
GROUP BY country
ORDER BY total_sales DESC
LIMIT 5;

-- Region-wise profit analysis

SELECT region,
       SUM(profit) AS total_profit
FROM super_store_orders
GROUP BY region
ORDER BY total_profit DESC;

-- =====================================================
-- TREND ANALYSIS
-- =====================================================

-- Year-wise revenue trend

SELECT year,
       SUM(sales) AS yearly_revenue
FROM super_store_orders
GROUP BY year
ORDER BY year;

-- Year and market-wise sales trend

SELECT year,
       market,
       SUM(sales) AS total_sales
FROM super_store_orders
GROUP BY year, market
ORDER BY year, total_sales DESC;

-- =====================================================
-- CASE WHEN ANALYSIS
-- =====================================================

-- Classify products as Profit or Loss

SELECT product_name,
       profit,
       CASE
           WHEN profit > 0 THEN 'Profit'
           ELSE 'Loss'
       END AS profit_status
FROM super_store_orders
LIMIT 20;

-- =====================================================
-- SUBQUERY ANALYSIS
-- =====================================================

-- Top selling products using subquery

SELECT product_name,
       total_sales
FROM (
    SELECT product_name,
           SUM(sales) AS total_sales
    FROM super_store_orders
    GROUP BY product_name
) AS product_summary
ORDER BY total_sales DESC
LIMIT 10;

-- =====================================================
-- CTE ANALYSIS
-- =====================================================

-- Common Table Expression for market sales analysis

WITH market_sales AS (
    SELECT market,
           SUM(sales) AS total_sales
    FROM super_store_orders
    GROUP BY market
)

SELECT *
FROM market_sales
ORDER BY total_sales DESC;


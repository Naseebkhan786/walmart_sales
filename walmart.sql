create database walmart_db;
use walmart_db;
select * from walmart limit 10;
select count(*) from walmart;
select distinct category from walmart;
select distinct payment_method from walmart;

select count(*),payment_method from walmart
group by payment_method;

-- Business problems
-- Find different payment method and number of transactions, number of quqntity sold
select payment_method,count(*) as no_payment ,sum(quantity) as no_of_quantity from walmart  
group by payment_method;

-- Identify the highest_rated category in each branch,displaying the branch, category,avg rating
select  round(avg(rating),2) as avg_rating,category,branch from walmart
group by category,branch
order by branch, avg_rating desc;

-- calucate the total profit for each category by considering total_profit as (unit_price * quantity * profit_margin)
-- List category and total_profit,ordered from highest to lowest profite.
select  round(sum(unit_price * quantity * profit_margin),2) as total_profit,category from walmart
group by category
order by total_profit desc;


-- 1. Revenue & Sales Analysis

-- Total revenue
select round(sum(total),2) as total_revenue from walmart;
-- Revenue by branch
select round(sum(total),2) as total_revenue,branch from walmart 
group by branch;
-- Revenue by city and branch
select round(sum(total),2) as total_revenue,branch,city from walmart 
group by branch,city;
-- Average transaction value 
SELECT AVG(total) AS avg_transaction
FROM walmart;
-- 2. Product & Category Insights

-- Top selling category (by revenue)
select category,round(sum(total),2)as revenue from walmart 
group by category
order by revenue desc;
-- Top selling category (by quantity) 
select category,sum(quantity) as quantity from walmart 
group by category
order by quantity desc;
-- Most expensive product category 
select category,round(sum(total),2)as expensive_product from walmart 
group by category
order by expensive_product desc limit 1;

-- 3. Time-Based Analysis (Very Important)

-- Sales by hour (Peak hour)
select hour(time) as hours,sum(total) as revenue from walmart 
group by hours
order by revenue desc;
-- Sales by day of week
select dayname(date) as day_name,round(sum(total),2) as revenue from walmart
group by day_name 
order by revenue desc; 
-- Monthly revenue trend
select monthname(date) as month_name,round(sum(total),2) as revenue from walmart 
group by month_name
order by revenue desc;

-- 4. Customer Behavior Analysis

-- Most used payment method
select payment_method,count(*) as transcation from walmart
group by payment_method
order by transcation desc ;

-- Average rating by category
select round(avg(rating),2) as avg_rating , category from walmart 
group by category
order by avg_rating desc;

-- Does high rating mean high sales?
SELECT 
  CASE 
    WHEN rating >= 8 THEN 'High Rating'
    ELSE 'Low Rating'
  END AS rating_group,
  AVG(total) AS avg_sales
FROM walmart
GROUP BY rating_group;

-- 5. Profitability Analysis
-- Profit per transaction
select invoice_id,round(total,2),profit_margin,round((total*profit_margin),2) as profit from walmart;

-- Total profit by category

select category,round(sum(total*profit_margin),2) as total_profit from walmart 
group by category
order by total_profit desc;

-- Most profitable branch
select branch,round(sum(total*profit_margin),2) as most_profit from walmart 
group by branch
order by most_profit desc limit 1;







-- SQL Retail Sales Analysis--
SET SQL_SAFE_UPDATES = 0;
select * from retail_analysis.retail_analysis;

-- select count(*) from retail_analysis.retail_analysis;

-- where records have Null value--
select * from retail_analysis.retail_analysis
where ï»¿transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null 
or gender is null
or age is null
or category is null
or quantiy is null
or price_per_unit is null
or cogs is null 
or total_sale is null;

-- delete the null values--
Delete from retail_analysis.retail_analysis
where
ï»¿transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null 
or gender is null
or age is null
or category is null
or quantiy is null
or price_per_unit is null
or cogs is null 
or total_sale is null;

select count(*) from retail_analysis.retail_analysis;

-- Data Exploration--
-- How many sales we have--
select count(*) as total_sale from retail_analysis.retail_analysis;

-- How many customers we have--
select count(customer_id) as total_customer from retail_analysis.retail_analysis;

-- unique categories--
select distinct category from retail_analysis.retail_analysis;

-- Data Analysis and Business Problems --
-- Write a SQL query to retrieve all columns for sales made on '2022-11-05:Write a SQL query to retrieve all columns for sales made on '2022-11-05: --
select * from retail_analysis.retail_analysis
where sale_date = '2022-11-05';

-- Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022: --
SELECT *
FROM retail_analysis.retail_analysis
WHERE category = 'Clothing'
  AND quantiy >=  4
  AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';

-- Write a SQL query to calculate the total sales (total_sale) for each category.: --
select category,sum(total_sale) as total_sale from retail_analysis.retail_analysis
group by category;

-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.: --
select avg(age) from retail_analysis.retail_analysis
where category = 'Beauty';

-- Write a SQL query to find all transactions where the total_sale is greater than 1000.: --
select * from retail_analysis.retail_analysis
where total_sale > 1000;
-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.: --
select gender, count(ï»¿transactions_id) from retail_analysis.retail_analysis
group by gender;

-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year: --
SELECT year, month, total_sale
FROM (
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        SUM(total_sale) AS total_sale,
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY SUM(total_sale) DESC) AS rank_in_year
    FROM retail_analysis.retail_analysis
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS monthly_sales
WHERE rank_in_year = 1;

-- **Write a SQL query to find the top 5 customers based on the highest total sales **: --
select customer_id, total_sale from retail_analysis.retail_analysis
order by total_sale desc
limit 5;

-- Write a SQL query to find the number of unique customers who purchased items from each category.:--
select category , count(distinct(ï»¿transactions_id)) from retail_analysis.retail_analysis
group by category;

-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):--
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_analysis.retail_analysis
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift




-- How many customers placed only one order vs. multiple orders?

select `Customer ID`,
case when count(*) = 1 then "One Time Customer"
else "Repeat Customer"
end as customer_type,
count(*) as num_customers
from ecommerse.orders
group by `Customer ID`;

-- total number in each category --
SELECT customer_type, COUNT(*) AS customer_count
FROM (
  SELECT 
    `Customer ID`,
    CASE 
      WHEN COUNT(*) = 1 THEN 'One-Time Customers'
      ELSE 'Repeat Customers'
    END AS customer_type
  FROM ecommerse.orders
  GROUP BY `Customer ID`
) AS customer_groups
GROUP BY customer_type;

-- What is the average order amount of returning vs. one-time customers?

SELECT 
  customer_type, 
  COUNT(*) AS customer_count,
  AVG(`Order Amount Numeric`) AS avg_amount
FROM (
  SELECT 
    o.`Customer ID`,
    o.`Order Amount Numeric`,
    CASE 
      WHEN c.order_count = 1 THEN 'One-Time Customers'
      ELSE 'Repeat Customers'
    END AS customer_type
  FROM ecommerse.orders o
  JOIN (
    SELECT `Customer ID`, COUNT(*) AS order_count
    FROM ecommerse.orders
    GROUP BY `Customer ID`
  ) c ON o.`Customer ID` = c.`Customer ID`
) AS customer_groups
GROUP BY customer_type;

-- What is the average time gap between a customer’s first and second order?
with ranked_orders as 
            ( select  `Customer ID` , `Order Date`,
		      row_number() over( partition by `Customer ID` order by `Order Date`) as rn
              from ecommerse.orders
			),
	first_orders as (
             select  `Customer ID` , `Order Date` as first_order_date
             from ranked_orders
             where rn=1
             ),
	second_orders as (
			 select  `Customer ID` , `Order Date` as second_order_date
             from ranked_orders
             where rn=2
			)
select round(avg(datediff(second_order_date,first_order_date)),2) as ang_days_between_first_and_second_order
from first_orders join second_orders on 
first_orders.`Customer ID` = second_orders.`Customer ID`;

-- which age group has the highest percentage of returning customers
WITH age_grouping AS (
  SELECT 
    `Customer ID`,
    CASE 
      WHEN Age <= 25 THEN '0-25'
      WHEN Age > 25 AND Age < 35 THEN '25-35'
      WHEN Age >= 35 AND Age < 45 THEN '35-45'
      WHEN Age >= 45 AND Age < 55 THEN '45-55'
      WHEN Age >= 55 AND Age < 65 THEN '55-65'
      ELSE '65+'
    END AS age_group
  FROM ecommerse.customers
),
order_counts AS (
  SELECT 
    `Customer ID`, 
    COUNT(*) AS order_count
  FROM ecommerse.orders
  GROUP BY `Customer ID`
),
grouped_returning AS (
  SELECT 
    ag.age_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN oc.order_count > 1 THEN 1 ELSE 0 END) AS returning_customers
  FROM age_grouping ag
  JOIN order_counts oc ON ag.`Customer ID` = oc.`Customer ID`
  GROUP BY ag.age_group
),
returning_percentages AS (
  SELECT 
    age_group,
    ROUND(returning_customers * 100.0 / total_customers, 2) AS returning_percentage
  FROM grouped_returning
)
SELECT *
FROM returning_percentages
ORDER BY returning_percentage DESC
LIMIT 1;

-- What is the gender distribution among returning and one-time customers?

 with retention_status as (select  `Customer ID` ,
 case when count(*) > 1 then "Returning_customer"
 else "non_returning_customer"
 end as return_status
 from ecommerse.orders
 group by `Customer ID`)
 select rs.`Customer ID` , c.Gender ,rs.return_status
 from retention_status as rs join
 ecommerse.customers c on
 rs.`Customer ID` = c.`Customer ID`
 group by `Customer ID`;
 
-- To find the total number of returning and one-time customers gender-wise
with retention_status as (select  `Customer ID` ,
 case when count(*) > 1 then "Returning_customer"
 else "non_returning_customer"
 end as return_status
 from ecommerse.orders
 group by `Customer ID`)
 select  c.Gender ,rs.return_status ,count(rs.`Customer ID`) as total_customers
 from retention_status as rs join
 ecommerse.customers c on
 rs.`Customer ID` = c.`Customer ID`
 group by c.Gender ,rs.return_status; 

-- Which cities have the highest number of repeat customers?        
 
SELECT c.City, COUNT(DISTINCT o.`Customer ID`) AS repeat_customers
FROM ecommerse.orders o
JOIN ecommerse.customers c ON o.`Customer ID` = c.`Customer ID`
WHERE o.`Customer ID` IN (
    SELECT `Customer ID`
    FROM ecommerse.orders
    GROUP BY `Customer ID`
    HAVING COUNT(*) > 1
)
GROUP BY c.City
ORDER BY repeat_customers DESC;

-- Which signup month had the highest conversion to repeat buyers?
select DATE_FORMAT(c.`Signup Date`, '%Y-%m') AS signup_month , count(distinct o.`Customer ID`) as repeat_customers
from ecommerse.customers c join
ecommerse.orders o on c.`Customer ID`=o.`Customer ID`
where o.`Customer ID` in (
             select `Customer ID` 
             from ecommerse.orders
            group by `Customer ID`
            having count(*) >1
)
GROUP BY signup_month
ORDER BY repeat_customers DESC
Limit 5;

-- Which product categories have the highest total sales (by order amount)?
select p.Category , sum(o.`Order Amount Numeric`) as total_amount
from ecommerse.orders o join 
ecommerse.products p on o.`Product ID`=p.`Product ID` 
group by p.Category
order by total_amount desc;

-- What is the average order amount by product category?
select p.Category , avg(o.`Order Amount Numeric`) as total_amount
from ecommerse.orders o join 
ecommerse.products p on o.`Product ID`=p.`Product ID` 
group by p.Category
order by total_amount desc;

-- Which brands are purchased most frequently by repeat customers?
select p.Brand , count(distinct(o.`Customer ID`)) as total_products
from ecommerse.orders o join 
ecommerse.products p on o.`Product ID` = p.`Product ID`
where o.`Customer ID` in 
              ( select `Customer ID` from 
                ecommerse.orders
                group by `Customer ID` 
                having count(*) >1
			 )
group by p.Brand
order by total_products desc
Limit 5;

-- What is the most commonly ordered product among first-time buyers?
select p.`Name` ,p.Category , count(distinct(o.`Customer ID`)) as total_products
from ecommerse.orders o join 
ecommerse.products p on o.`Product ID` = p.`Product ID`
where o.`Customer ID` in 
              ( select `Customer ID` from 
                ecommerse.orders
                group by `Customer ID` 
                having count(*) = 1
			 )
group by p.`Name`,p.Category
order by total_products desc
Limit 5;

-- Which product categories have higher average order values for repeat customers vs. first-time customers?
with return_status as (
             select `Customer ID` ,
             case when count(*)>1 then "Returning_customers"
             else "Non_Reurting_customers"
             end as returning_status
             from ecommerse.orders
             group by `Customer ID`
             )
select p.Category , rs.returning_status ,avg(o.`Order Amount Numeric`) as avg_order
from ecommerse.orders o join 
ecommerse.products p on o.`Product ID` = p.`Product ID`
join return_status as rs on o.`Customer ID` = rs.`Customer ID`
group by p.Category,rs.returning_status
order by avg_order desc
Limit 5;

-- What is the overall return rate (% of orders that were returned)?
SELECT 
  ROUND(
    COUNT(DISTINCT r.`Order ID`) / COUNT(DISTINCT o.`Order ID`) * 100, 2
  ) AS return_rate_percentage
FROM ecommerse.orders o
LEFT JOIN ecommerse.returns r ON o.`Order ID` = r.`Order ID`;

-- Which product categories have the highest return rate?
SELECT p.Category,
  ROUND(
    COUNT(DISTINCT r.`Order ID`) / COUNT(DISTINCT o.`Order ID`) * 100, 2
  ) AS return_rate_percentage
FROM ecommerse.orders o
LEFT JOIN ecommerse.returns r ON o.`Order ID` = r.`Order ID`
join ecommerse.products p on o.`Product ID`=p.`Product ID` 
group by p.Category
order by return_rate_percentage desc;

-- What are the top 5 most common return reasons?
SELECT r.`Return Reason`,
COUNT(*) AS total_returns
FROM ecommerse.orders o
LEFT JOIN ecommerse.returns r ON o.`Order ID` = r.`Order ID`
join ecommerse.products p on o.`Product ID`=p.`Product ID` 
group by r.`Return Reason`
order by total_returns desc
limit 5;
-- return_reason_percentage
SELECT 
  r.`Return Reason`,
  ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM ecommerse.returns), 2) AS return_reason_percentage
FROM ecommerse.returns r
GROUP BY r.`Return Reason`
ORDER BY return_reason_percentage DESC
LIMIT 5;

-- Which age group initiates the most returns?
with age_group as (
        SELECT 
    `Customer ID`,
    CASE 
      WHEN Age <= 25 THEN '0-25'
      WHEN Age > 25 AND Age < 35 THEN '25-35'
      WHEN Age >= 35 AND Age < 45 THEN '35-45'
      WHEN Age >= 45 AND Age < 55 THEN '45-55'
      WHEN Age >= 55 AND Age < 65 THEN '55-65'
      ELSE '65+'
    END AS age_group
  FROM ecommerse.customers)
SELECT ag.`age_group`,
COUNT(DISTINCT r.`Order ID`) AS total_returns
FROM ecommerse.orders o
LEFT JOIN ecommerse.returns r ON o.`Order ID` = r.`Order ID`
join age_group ag on o.`Customer ID`=ag.`Customer ID` 
group by ag.`age_group`
order by total_returns desc
Limit 5;

-- Which brands have the highest return rates? 
SELECT p.Brand,
COUNT(DISTINCT r.`Order ID`) AS total_returns,ROUND(
    COUNT(DISTINCT r.`Order ID`) / COUNT(DISTINCT o.`Order ID`) * 100, 2
  ) AS return_rate_percentage
FROM ecommerse.orders o
LEFT JOIN ecommerse.returns r ON o.`Order ID` = r.`Order ID`
join ecommerse.products p on o.`Product ID`=p.`Product ID` 
group by p.Brand
order by total_returns desc;
 
 # with CTE
 WITH brand_orders AS (
    SELECT 
        p.Brand,
        COUNT(o.`Order ID`) AS total_orders
    FROM ecommerse.orders o
    JOIN ecommerse.products p ON o.`Product ID` = p.`Product ID`
    GROUP BY p.Brand
),
brand_returns AS (
    SELECT 
        p.Brand,
        COUNT(DISTINCT r.`Order ID`) AS total_returns
    FROM ecommerse.orders o
    JOIN ecommerse.returns r ON o.`Order ID` = r.`Order ID`
    JOIN ecommerse.products p ON o.`Product ID` = p.`Product ID`
    GROUP BY p.Brand
)
SELECT 
    bo.Brand,
    bo.total_orders,
    COALESCE(br.total_returns, 0) AS total_returns,
    ROUND(COALESCE(br.total_returns, 0) * 100.0 / bo.total_orders, 2) AS return_rate_percentage
FROM brand_orders bo
LEFT JOIN brand_returns br ON bo.Brand = br.Brand
ORDER BY return_rate_percentage DESC
Limit 5;


WITH brand_orders AS (
    SELECT 
        p.Brand,
        COUNT(o.`Order ID`) AS total_orders
    FROM ecommerse.orders o
    JOIN ecommerse.products p ON o.`Product ID` = p.`Product ID`
    GROUP BY p.Brand
),
brand_returns AS (
    SELECT 
        p.Brand,
        COUNT(DISTINCT r.`Order ID`) AS total_returns
    FROM ecommerse.orders o
    JOIN ecommerse.returns r ON o.`Order ID` = r.`Order ID`
    JOIN ecommerse.products p ON o.`Product ID` = p.`Product ID`
    GROUP BY p.Brand
)
SELECT 
    bo.Brand,
    bo.total_orders,
    COALESCE(br.total_returns, 0) AS total_returns,
    ROUND(COALESCE(br.total_returns, 0) * 100.0 / bo.total_orders, 2) AS return_rate_percentage
FROM brand_orders bo
LEFT JOIN brand_returns br ON bo.Brand = br.Brand
WHERE bo.total_orders >= 10  -- Filter brands with at least 10 orders
ORDER BY return_rate_percentage DESC;

-- How many days after delivery are products usually returned (on average)?
with delivery_date as 
            ( select  `Order ID` , `Order Date`as delivery_order_date
              from ecommerse.orders
			),
return_date as (
              select  `Order ID` , `Return Date` as return_order_date
              from ecommerse.returns
             )
select round(avg(datediff(return_order_date,delivery_order_date)),2) as avg_days_between_delivery_and_return_order
from delivery_date dd join return_date rd on 
dd.`Order ID` = rd.`Order ID`;

-- What is the monthly trend of returns over the last 6 months?
#last 6 months
SELECT 
  DATE_FORMAT(`Return Date`, '%Y-%m') AS return_month,
  COUNT(*) AS total_returns
FROM ecommerse.returns
WHERE `Return Date` >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
GROUP BY return_month
ORDER BY return_month;

#last one year
SELECT 
  DATE_FORMAT(`Return Date`, '%Y-%m') AS return_month,
  COUNT(*) AS total_returns
FROM ecommerse.returns
WHERE `Return Date` >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH)
GROUP BY return_month
ORDER BY return_month
Limit 5;

#YOY for Each Month
SELECT 
  MONTH(`Return Date`) AS month_num,
  YEAR(`Return Date`) AS year,
  DATE_FORMAT(MIN(`Return Date`), '%M') AS month_name,
  COUNT(*) AS total_returns
FROM ecommerse.returns
WHERE `Return Date` >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
GROUP BY YEAR(`Return Date`), MONTH(`Return Date`)
ORDER BY YEAR(`Return Date`), MONTH(`Return Date`);

#YOY Total (Current Year vs Previous Year)
SELECT 
  YEAR(`Return Date`) AS year,
  COUNT(*) AS total_returns
FROM ecommerse.returns
WHERE `Return Date` >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR)
GROUP BY year
ORDER BY year;

-- How has the repeat purchase rate changed month over month in the past year?
WITH all_orders AS (
    SELECT 
        `Customer ID`,
        `Order Date`,
        DATE_FORMAT(`Order Date`, '%Y-%m') AS order_month
    FROM ecommerse.orders
    WHERE `Order Date` >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR)
),
first_order_month AS (
    SELECT 
        `Customer ID`,
        MIN(DATE_FORMAT(`Order Date`, '%Y-%m')) AS first_month
    FROM all_orders
    GROUP BY `Customer ID`
),
labeled_orders AS (
    SELECT 
        a.`Customer ID`,
        a.order_month,
        f.first_month,
        CASE 
            WHEN a.order_month > f.first_month THEN 1
            ELSE 0
        END AS is_repeat
    FROM all_orders a
    JOIN first_order_month f ON a.`Customer ID` = f.`Customer ID`
)
SELECT 
    order_month,
    COUNT(DISTINCT `Customer ID`) AS total_customers,
    SUM(is_repeat) AS repeat_customers,
    ROUND(SUM(is_repeat) / COUNT(DISTINCT `Customer ID`) * 100, 2) AS repeat_purchase_rate_percentage
FROM labeled_orders
GROUP BY order_month
ORDER BY order_month;

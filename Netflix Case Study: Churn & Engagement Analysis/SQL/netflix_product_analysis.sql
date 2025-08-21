-- Data Cleaning & Transformation
-- 1. Handle Missing Values
SELECT 
    SUM(CASE WHEN `Customer Satisfaction Score (1-10)` IS NULL THEN 1 ELSE 0 END) AS null_satisfaction,
    SUM(CASE WHEN `Daily Watch Time (Hours)` IS NULL THEN 1 ELSE 0 END) AS null_watch_time,
    SUM(CASE WHEN `Engagement Rate (1-10)` IS NULL THEN 1 ELSE 0 END) AS null_engagement,
    SUM(CASE WHEN `Device Used Most Often` IS NULL THEN 1 ELSE 0 END) AS null_device,
    SUM(CASE WHEN `Genre Preference` IS NULL THEN 1 ELSE 0 END) AS null_genre,
    SUM(CASE WHEN Region IS NULL THEN 1 ELSE 0 END) AS null_region,
    SUM(CASE WHEN `Payment History (On-Time/Delayed)` IS NULL THEN 1 ELSE 0 END) AS null_payment,
    SUM(CASE WHEN `Subscription Plan` IS NULL THEN 1 ELSE 0 END) AS null_plan,
    SUM(CASE WHEN `Churn Status (Yes/No)` IS NULL THEN 1 ELSE 0 END) AS null_churn,
    SUM(CASE WHEN `Support Queries Logged` IS NULL THEN 1 ELSE 0 END) AS null_support,
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS null_age,
    SUM(CASE WHEN `Monthly Income ($)` IS NULL THEN 1 ELSE 0 END) AS null_income,
    SUM(CASE WHEN `Promotional Offers Used` IS NULL THEN 1 ELSE 0 END) AS null_promo,
    SUM(CASE WHEN `Number of Profiles Created` IS NULL THEN 1 ELSE 0 END) AS null_profiles
FROM netflix_product_analysis.netflix_product_analysis;

-- 2. Count Blank Values in All Columns
SELECT 
    SUM(CASE WHEN `Customer Satisfaction Score (1-10)` ='' THEN 1 ELSE 0 END) AS null_satisfaction,
    SUM(CASE WHEN `Daily Watch Time (Hours)` =''  THEN 1 ELSE 0 END) AS null_watch_time,
    SUM(CASE WHEN `Engagement Rate (1-10)` =''  THEN 1 ELSE 0 END) AS null_engagement,
    SUM(CASE WHEN `Device Used Most Often` =''  THEN 1 ELSE 0 END) AS null_device,
    SUM(CASE WHEN `Genre Preference` =''  THEN 1 ELSE 0 END) AS null_genre,
    SUM(CASE WHEN Region =''  THEN 1 ELSE 0 END) AS null_region,
    SUM(CASE WHEN `Payment History (On-Time/Delayed)` =''  THEN 1 ELSE 0 END) AS null_payment,
    SUM(CASE WHEN `Subscription Plan` =''  THEN 1 ELSE 0 END) AS null_plan,
    SUM(CASE WHEN `Churn Status (Yes/No)` =''  THEN 1 ELSE 0 END) AS null_churn,
    SUM(CASE WHEN `Support Queries Logged` is null  THEN 1 ELSE 0 END) AS null_support,
    SUM(CASE WHEN Age =''  THEN 1 ELSE 0 END) AS null_age,
    SUM(CASE WHEN `Monthly Income ($)` =''  THEN 1 ELSE 0 END) AS null_income,
    SUM(CASE WHEN `Promotional Offers Used` is null  THEN 1 ELSE 0 END) AS null_promo,
    SUM(CASE WHEN `Number of Profiles Created` =''  THEN 1 ELSE 0 END) AS null_profiles
FROM netflix_product_analysis.netflix_product_analysis;

-- 2. Check Duplicates
select `ï»¿Customer ID` , COUNT(*) AS dup_count from 
netflix_product_analysis.netflix_product_analysis
group by `ï»¿Customer ID`
having count(`ï»¿Customer ID`)>1;

-- Churn Flag (Yes/No → 1/0)
ALTER TABLE netflix_product_analysis.netflix_product_analysis ADD COLUMN Churn_Flag INT;

UPDATE netflix_product_analysis.netflix_product_analysis
SET Churn_Flag = CASE 
                   WHEN `Churn Status (Yes/No)` = 'Yes' THEN 1
                   ELSE 0
                 END;

-- b) AvgWatchPerProfile
ALTER TABLE netflix_product_analysis.netflix_product_analysis ADD COLUMN AvgWatchPerProfile DECIMAL(5,2);

UPDATE netflix_product_analysis.netflix_product_analysis
SET AvgWatchPerProfile = 
    CASE 
       WHEN `Number of Profiles Created` > 0 
       THEN `Daily Watch Time (Hours)` / `Number of Profiles Created`
       ELSE `Daily Watch Time (Hours)`
    END;
    
-- Income_Bracket (Low/Medium/High)
Alter TABLE netflix_product_analysis.netflix_product_analysis
add column Income_bracket varchar(10);

UPDATE netflix_product_analysis.netflix_product_analysis
set Income_bracket = case when `Monthly Income ($)` < 3000 then 'Low'
                          when `Monthly Income ($)` between 3000 and 7000 then 'Medium'
                          else 'High'
                          end;

-- Age_Group (Teen/Young Adult/Adult/Senior)
Alter table netflix_product_analysis.netflix_product_analysis
add column Age_group varchar(10);

update netflix_product_analysis.netflix_product_analysis
set Age_group = case when Age < 20 then 'Teen'
                     when Age between 20 and 35 then 'Young'
                     when Age between 36 and 55 then 'Adult'
                     else 'Senior'
                     end;

-- Exploratory Data Analysis (EDA)
-- 1. What’s the overall churn rate?
SELECT 
    round(SUM(CASE WHEN Churn_Flag = 1 THEN 1 ELSE 0 END) / COUNT(`ï»¿Customer ID`) * 100 , 2) AS churn_rate
FROM netflix_product_analysis.netflix_product_analysis;

-- Does satisfaction score correlate with churn?
SELECT
    (SUM(`Customer Satisfaction Score (1-10)` * Churn_Flag) - SUM(`Customer Satisfaction Score (1-10)`) * SUM(Churn_Flag) / COUNT(*))
    /
    (SQRT(SUM(POW(`Customer Satisfaction Score (1-10)`,2)) - POW(SUM(`Customer Satisfaction Score (1-10)`),2)/COUNT(*))
     * SQRT(SUM(POW(Churn_Flag,2)) - POW(SUM(Churn_Flag),2)/COUNT(*))) AS correlation
FROM
    netflix_product_analysis.netflix_product_analysis;

-- Do users with delayed payments churn more?
SELECT 
    `Payment History (On-Time/Delayed)`,
    COUNT(CASE WHEN Churn_Flag = 1 THEN 1 END) * 100/ COUNT(*) AS churn_rate
FROM netflix_product_analysis.netflix_product_analysis
GROUP BY `Payment History (On-Time/Delayed)`;

-- Which subscription plans have the highest churn?
SELECT 
    `Subscription Plan`,
    COUNT(CASE WHEN Churn_Flag = 1 THEN 1 END) AS churn_count,
    COUNT(*) AS total_customers,
    round((COUNT(CASE WHEN Churn_Flag = 1 THEN 1 END) / COUNT(*)) * 100) AS churn_rate_percent
FROM netflix_product_analysis.netflix_product_analysis
GROUP BY `Subscription Plan`
ORDER BY churn_count DESC;

-- Does higher watch time = lower churn?
SELECT
    (SUM(`Daily Watch Time (Hours)` * Churn_Flag) - SUM(`Daily Watch Time (Hours)`) * SUM(Churn_Flag) / COUNT(*))
    /
    (SQRT(SUM(POW(`Daily Watch Time (Hours)`,2)) - POW(SUM(`Daily Watch Time (Hours)`),2)/COUNT(*))
     * SQRT(SUM(POW(Churn_Flag,2)) - POW(SUM(Churn_Flag),2)/COUNT(*))) AS correlation
FROM
    netflix_product_analysis.netflix_product_analysis;

-- Do promotional offers improve retention?
SELECT 
    `Promotional Offers Used`,
    COUNT(CASE WHEN Churn_Flag = 1 THEN 1 END) AS churn_count,
    COUNT(*) AS total_customers,
    ROUND(
        COUNT(CASE WHEN Churn_Flag = 1 THEN 1 END) / COUNT(*) * 100, 2
    ) AS churn_rate_percent,
    ROUND(
        100 - (COUNT(CASE WHEN Churn_Flag = 1 THEN 1 END) / COUNT(*) * 100), 2
    ) AS retention_rate_percent
FROM netflix_product_analysis.netflix_product_analysis
GROUP BY `Promotional Offers Used`
ORDER BY retention_rate_percent desc;

-- Which regions/devices drive the highest engagement?
SELECT 
    `Genre Preference` AS genre,
    Region AS region,
    SUM(`Engagement Rate (1-10)`) AS total_engagement
FROM netflix_product_analysis.netflix_product_analysis
GROUP BY `Genre Preference`, Region
ORDER BY total_engagement DESC;

-- Do users with multiple profiles churn less?
SELECT 
    `Number of Profiles Created`,
    COUNT(CASE WHEN Churn_Flag = 1 THEN 1 END) AS churn_count,
    COUNT(`ï»¿Customer ID`) AS total_users,
    ROUND(COUNT(CASE WHEN Churn_Flag = 1 THEN 1 END)  *100 / COUNT(`ï»¿Customer ID`), 2) AS churn_rate
FROM netflix_product_analysis.netflix_product_analysis
GROUP BY `Number of Profiles Created`
ORDER BY `Number of Profiles Created`;

-- Is churn higher for specific genres (e.g., action vs drama)?
SELECT 
    `Genre Preference`,
    COUNT(CASE WHEN Churn_Flag = 1 THEN 1 END) AS churn_count,
    COUNT(`ï»¿Customer ID`) AS total_users,
    ROUND(COUNT(CASE WHEN Churn_Flag = 1 THEN 1 END) *100 / COUNT(`ï»¿Customer ID`), 2) AS churn_rate
FROM netflix_product_analysis.netflix_product_analysis
GROUP BY `Genre Preference`
ORDER BY churn_rate DESC;

-- Does monthly income affect churn?
SELECT
    (SUM(`Monthly Income ($)` * Churn_Flag) - SUM(`Monthly Income ($)`) * SUM(Churn_Flag) / COUNT(*))
    /
    (SQRT(SUM(POW(`Monthly Income ($)`,2)) - POW(SUM(`Monthly Income ($)`),2)/COUNT(*))
     * SQRT(SUM(POW(Churn_Flag,2)) - POW(SUM(Churn_Flag),2)/COUNT(*))) AS correlation
FROM
    netflix_product_analysis.netflix_product_analysis;

-- Churn rate by income group
SELECT 
    Income_bracket,
    COUNT(CASE WHEN Churn_Flag = 1 THEN 1 END) AS churn_count,
    COUNT(`ï»¿Customer ID`) AS total_users,
    ROUND(COUNT(CASE WHEN Churn_Flag = 1 THEN 1 END) * 100/ COUNT(`ï»¿Customer ID`), 2) AS churn_rate
FROM netflix_product_analysis.netflix_product_analysis
GROUP BY Income_bracket
ORDER BY churn_rate desc;

-- Do customers with longer subscription length churn less (loyalty vs churn)?
SELECT 
    (SUM(`Subscription Length (Months)` * Churn_Flag) - SUM(`Subscription Length (Months)`) * SUM(Churn_Flag) / COUNT(*))
    /
    (SQRT(SUM(POW(`Subscription Length (Months)`, 2)) - POW(SUM(`Subscription Length (Months)`), 2)/COUNT(*))
     * SQRT(SUM(POW(Churn_Flag, 2)) - POW(SUM(Churn_Flag), 2)/COUNT(*))) 
    AS correlation_subscription_churn
FROM netflix_product_analysis.netflix_product_analysis;

-- Churn rate by Subscription Length
SELECT 
    `Subscription Length (Months)`,
    COUNT(CASE WHEN Churn_Flag = 1 THEN 1 END) AS churn_count,
    COUNT(`ï»¿Customer ID`) AS total_users,
    ROUND(COUNT(CASE WHEN Churn_Flag = 1 THEN 1 END) / COUNT(`ï»¿Customer ID`), 2) AS churn_rate
FROM netflix_product_analysis.netflix_product_analysis
GROUP BY `Subscription Length (Months)`
ORDER BY churn_rate desc;

-- Which age groups have the highest churn or lowest satisfaction?
-- Create age groups and calculate churn rate and avg satisfaction
SELECT
    Age_group,
    COUNT(*) AS total_customers,
    SUM(Churn_Flag) AS churned_customers,
    ROUND(SUM(Churn_Flag)/COUNT(*)*100,2) AS churn_rate_percent,
    ROUND(AVG(`Customer Satisfaction Score (1-10)`),2) AS avg_satisfaction
FROM netflix_product_analysis.netflix_product_analysis
GROUP BY age_group
ORDER BY churn_rate_percent DESC;

-- How does engagement rate (1–10) vary across subscription plans and regions?
SELECT
    `Subscription Plan`,
    Region,
    ROUND(AVG(`Engagement Rate (1-10)`), 2) AS avg_engagement_rate,
    COUNT(*) AS num_customers
FROM netflix_product_analysis.netflix_product_analysis
GROUP BY `Subscription Plan`, Region
ORDER BY `Subscription Plan`, avg_engagement_rate DESC;

-- 1. Funnel Analysis: Subscription → Active → Engaged → Churned
--    Goal: See where users drop off in engagement.
-- Count of users at each stage
SELECT 
    COUNT(`ï»¿Customer ID`) AS Total_Users,
    SUM(CASE WHEN `Daily Watch Time (Hours)` > 0 THEN 1 ELSE 0 END) AS Active_Users,
    SUM(CASE WHEN `Engagement Rate (1-10)` >= 7 THEN 1 ELSE 0 END) AS Engaged_Users,
    SUM(CASE WHEN Churn_Flag = 1 THEN 1 ELSE 0 END) AS Churned_Users
FROM netflix_product_analysis.netflix_product_analysis;

-- 2. Cohort Retention Analysis
--    Goal: Group users by subscription length to see retention trends.
SELECT 
    `Subscription Length (Months)`,
    COUNT(`ï»¿Customer ID`) AS Total_Users,
    SUM(CASE WHEN Churn_Flag = 0 THEN 1 ELSE 0 END) AS Retained_Users,
    ROUND(SUM(CASE WHEN Churn_Flag = 0 THEN 1 ELSE 0 END)*100.0/COUNT(`ï»¿Customer ID`),2) AS Retention_Rate
FROM netflix_product_analysis.netflix_product_analysis
GROUP BY `Subscription Length (Months)`
ORDER BY Retention_Rate desc;

-- 3. User Segmentation
--    High-Value Users
SELECT *
FROM netflix_product_analysis.netflix_product_analysis
WHERE `Subscription Length (Months)` >= 12
  AND `Daily Watch Time (Hours)` >= 3
  AND `Number of Profiles Created` > 1;

--    At-Risk Users
SELECT *
FROM netflix_product_analysis.netflix_product_analysis
WHERE `Payment History (On-Time/Delayed)` = 'Delayed'
  AND `Customer Satisfaction Score (1-10)` <= 5
  AND `Support Queries Logged` > 2;

-- 4. Impact Analysis: Promotional Offers
-- Goal: Check if promo usage reduces churn
SELECT 
    `Promotional Offers Used`,
    COUNT(`ï»¿Customer ID`) AS Total_Users,
    SUM(Churn_Flag) AS Churned_Users,
    ROUND(SUM(Churn_Flag)*100.0/COUNT(`ï»¿Customer ID`),2) AS Churn_Rate
FROM netflix_product_analysis.netflix_product_analysis
GROUP BY `Promotional Offers Used`
order by Churn_Rate desc;

-- Churn reduction 
WITH churn_summary AS (
    SELECT
        CASE 
            WHEN `Promotional Offers Used` = 0 THEN 'No Promo'
            ELSE 'Used Promo'
        END AS Promo_Status,
        COUNT(`ï»¿Customer ID`) AS Total_Users,
        SUM(Churn_Flag) AS Churned_Users,
        ROUND(SUM(Churn_Flag)*100.0/COUNT(`ï»¿Customer ID`),2) AS Churn_Rate
    FROM netflix_product_analysis.netflix_product_analysis
    GROUP BY Promo_Status
)
SELECT 
    a.Promo_Status,
    a.Total_Users,
    a.Churned_Users,
    a.Churn_Rate,
    ROUND((b.Churn_Rate - a.Churn_Rate),2) AS Churn_Reduction_Percentage
FROM churn_summary a
CROSS JOIN churn_summary b
WHERE a.Promo_Status = 'Used Promo' 
  AND b.Promo_Status = 'No Promo';


-- 5. Device Usage Patterns
-- Goal: Identify device-specific churn or engagement issues
SELECT 
    `Device Used Most Often`,
    COUNT(`ï»¿Customer ID`) AS Total_Users,
    ROUND(AVG(`Daily Watch Time (Hours)`),2) AS Avg_Daily_Watch,
    ROUND(AVG(`Engagement Rate (1-10)`),2) AS Avg_Engagement,
    ROUND(SUM(Churn_Flag)*100.0/COUNT(`ï»¿Customer ID`),2) AS Churn_Rate
FROM netflix_product_analysis.netflix_product_analysis
GROUP BY `Device Used Most Often`;


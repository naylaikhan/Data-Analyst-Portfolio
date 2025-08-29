-- Data Cleaning
-- Null Values --
SELECT 
    SUM(CASE WHEN ï»¿ID IS NULL THEN 1 ELSE 0 END) AS null_ID,
    SUM(CASE WHEN Year_Birth IS NULL THEN 1 ELSE 0 END) AS null_Year_Birth,
    SUM(CASE WHEN Education IS NULL THEN 1 ELSE 0 END) AS null_Education,
    SUM(CASE WHEN Marital_Status IS NULL THEN 1 ELSE 0 END) AS null_Marital_Status,
    SUM(CASE WHEN Income IS NULL THEN 1 ELSE 0 END) AS null_Income,
    SUM(CASE WHEN Kidhome IS NULL THEN 1 ELSE 0 END) AS null_Kidhome,
    SUM(CASE WHEN Teenhome IS NULL THEN 1 ELSE 0 END) AS null_Teenhome,
    SUM(CASE WHEN Dt_Customer IS NULL THEN 1 ELSE 0 END) AS null_Dt_Customer,
    SUM(CASE WHEN Recency IS NULL THEN 1 ELSE 0 END) AS null_Recency,
    SUM(CASE WHEN MntWines IS NULL THEN 1 ELSE 0 END) AS null_MntWines,
    SUM(CASE WHEN MntFruits IS NULL THEN 1 ELSE 0 END) AS null_MntFruits,
    SUM(CASE WHEN MntMeatProducts IS NULL THEN 1 ELSE 0 END) AS null_MntMeatProducts,
    SUM(CASE WHEN MntFishProducts IS NULL THEN 1 ELSE 0 END) AS null_MntFishProducts,
    SUM(CASE WHEN MntSweetProducts IS NULL THEN 1 ELSE 0 END) AS null_MntSweetProducts,
    SUM(CASE WHEN MntGoldProds IS NULL THEN 1 ELSE 0 END) AS null_MntGoldProds,
    SUM(CASE WHEN NumDealsPurchases IS NULL THEN 1 ELSE 0 END) AS null_NumDealsPurchases,
    SUM(CASE WHEN NumWebPurchases IS NULL THEN 1 ELSE 0 END) AS null_NumWebPurchases,
    SUM(CASE WHEN NumCatalogPurchases IS NULL THEN 1 ELSE 0 END) AS null_NumCatalogPurchases,
    SUM(CASE WHEN NumStorePurchases IS NULL THEN 1 ELSE 0 END) AS null_NumStorePurchases,
    SUM(CASE WHEN NumWebVisitsMonth IS NULL THEN 1 ELSE 0 END) AS null_NumWebVisitsMonth,
    SUM(CASE WHEN AcceptedCmp3 IS NULL THEN 1 ELSE 0 END) AS null_AcceptedCmp3,
    SUM(CASE WHEN AcceptedCmp4 IS NULL THEN 1 ELSE 0 END) AS null_AcceptedCmp4,
    SUM(CASE WHEN AcceptedCmp5 IS NULL THEN 1 ELSE 0 END) AS null_AcceptedCmp5,
    SUM(CASE WHEN AcceptedCmp1 IS NULL THEN 1 ELSE 0 END) AS null_AcceptedCmp1,
    SUM(CASE WHEN AcceptedCmp2 IS NULL THEN 1 ELSE 0 END) AS null_AcceptedCmp2,
    SUM(CASE WHEN Complain IS NULL THEN 1 ELSE 0 END) AS null_Complain,
    SUM(CASE WHEN Z_CostContact IS NULL THEN 1 ELSE 0 END) AS null_Z_CostContact,
    SUM(CASE WHEN Z_Revenue IS NULL THEN 1 ELSE 0 END) AS null_Z_Revenue,
    SUM(CASE WHEN Response IS NULL THEN 1 ELSE 0 END) AS null_Response
FROM banking_campaign.banking_maketing_campaign;

-- Missing Values --
SELECT 
    SUM(CASE WHEN Education = '' OR Education IS NULL THEN 1 ELSE 0 END) AS blank_Education,
    SUM(CASE WHEN Marital_Status = '' OR Marital_Status IS NULL THEN 1 ELSE 0 END) AS blank_Marital_Status,
    SUM(CASE WHEN Dt_Customer = '' OR Dt_Customer IS NULL THEN 1 ELSE 0 END) AS blank_Dt_Customer,
    SUM(CASE WHEN Complain is null THEN 1 ELSE 0 END) AS blank_Complain,
    SUM(CASE WHEN Response is null OR Response IS NULL THEN 1 ELSE 0 END) AS blank_Response
FROM banking_campaign.banking_maketing_campaign;

-- Duplicate Values --
SELECT ï»¿ID, COUNT(*) AS duplicate_count
FROM banking_campaign.banking_maketing_campaign
GROUP BY ï»¿ID
HAVING COUNT(*) > 1;

-- Calculate and Add Age Column -- 
ALTER TABLE banking_campaign.banking_maketing_campaign
ADD COLUMN Age INT;

UPDATE banking_campaign.banking_maketing_campaign
SET Age = 2025 - Year_Birth;

-- Drop rows with unrealistic ages (e.g., Age < 18 or Age > 100)
DELETE FROM banking_campaign.banking_maketing_campaign
WHERE Age < 18 OR Age > 100;

-- Convert Dt_Customer → Customer Tenure 
SHOW COLUMNS FROM banking_campaign.banking_maketing_campaign LIKE 'Dt_Customer';

-- Convert to datetime format --
UPDATE banking_campaign.banking_maketing_campaign
SET Dt_Customer = STR_TO_DATE(Dt_Customer, '%d-%m-%Y');

ALTER TABLE banking_campaign.banking_maketing_campaign
MODIFY COLUMN Dt_Customer DATE;

-- Customer Tenure
ALTER TABLE banking_campaign.banking_maketing_campaign
ADD COLUMN Tenure_Years INT,
ADD COLUMN Tenure_Months INT;

UPDATE banking_campaign.banking_maketing_campaign
SET Tenure_Years = TIMESTAMPDIFF(YEAR, Dt_Customer, CURDATE()),
    Tenure_Months = TIMESTAMPDIFF(MONTH, Dt_Customer, CURDATE()) % 12;

-- Drop Constant Columns
ALTER TABLE banking_campaign.banking_maketing_campaign
DROP COLUMN Z_CostContact,
DROP COLUMN Z_Revenue;

-- Total Spend --
ALTER TABLE banking_campaign.banking_maketing_campaign
ADD COLUMN Total_Spend DECIMAL(10,2);

UPDATE banking_campaign.banking_maketing_campaign
SET Total_Spend = 
    MntWines + 
    MntFruits + 
    MntMeatProducts + 
    MntFishProducts + 
    MntSweetProducts + 
    MntGoldProds;

-- Total Purchases --
ALTER TABLE banking_campaign.banking_maketing_campaign
ADD COLUMN Total_Purchases INT;

UPDATE banking_campaign.banking_maketing_campaign
SET Total_Purchases = 
    NumDealsPurchases +
    NumWebPurchases +
    NumCatalogPurchases +
    NumStorePurchases;

-- Customer Type (Income Segment) --
ALTER TABLE banking_campaign.banking_maketing_campaign
ADD COLUMN Customer_Type VARCHAR(20);

UPDATE banking_campaign.banking_maketing_campaign
SET Customer_Type = CASE
    WHEN Income <= 20000 THEN 'Low-income'
    WHEN Income BETWEEN 20001 AND 40000 THEN 'Medium-income'
    WHEN Income > 40000 THEN 'High-income'
    ELSE 'Unknown'
END;

UPDATE banking_campaign.banking_maketing_campaign
SET Marital_Status = CASE
    WHEN Marital_Status IN ('Single', 'Alone') THEN 'Single'
    WHEN Marital_Status IN ('Married', 'Together') THEN 'Married'
    WHEN Marital_Status IN ('Divorced', 'Widow') THEN 'Divorced/Widowed'
    WHEN Marital_Status IN ('Absurd', 'YOLO') THEN 'Other'
END;


-- Family Size --
ALTER TABLE banking_campaign.banking_maketing_campaign
ADD COLUMN Family_Size INT;

UPDATE banking_campaign.banking_maketing_campaign
SET Family_Size = Kidhome + Teenhome +
    CASE 
        WHEN Marital_Status = 'Single' THEN 1
        WHEN Marital_Status = 'Married' THEN 2
        WHEN Marital_Status = 'Divorced/Widowed' THEN 1
        WHEN Marital_Status = 'Other' THEN 1  -- For Absurd/YOLO, assume 1 adult
        ELSE 1  -- safety fallback
    END;


-- Campaign Acceptance Rate --
ALTER TABLE banking_campaign.banking_maketing_campaign
ADD COLUMN Campaign_Acceptance_Rate DECIMAL(5,2);

UPDATE banking_campaign.banking_maketing_campaign
SET Campaign_Acceptance_Rate = 
    ((AcceptedCmp1 + AcceptedCmp2 + AcceptedCmp3 + AcceptedCmp4 + AcceptedCmp5) / 5) * 100;

## Exploratory Data Analysis (EDA)
### Customer Demographics
-- What is the age distribution of customers? (young vs. older customers)
SELECT 
    CASE 
        WHEN Age < 30 THEN 'Young (<30)'
        WHEN Age BETWEEN 30 AND 50 THEN 'Middle-aged (30-50)'
        ELSE 'Older (>50)'
    END AS Age_Group,
    COUNT(*) AS Num_Customers,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM banking_campaign.banking_maketing_campaign), 2) AS Percentage
FROM banking_campaign.banking_maketing_campaign
GROUP BY Age_Group
ORDER BY Num_Customers DESC;

-- How does education level relate to income and spending?
SELECT 
    Education,
    ROUND(AVG(Income), 2) AS Avg_Income,
    ROUND(AVG(Total_Spend), 2) AS Avg_Spending
FROM banking_campaign.banking_maketing_campaign
GROUP BY Education
ORDER BY Avg_Income DESC;

-- How does marital status impact spending and campaign acceptance?
SELECT 
    Marital_Status,
    ROUND(AVG(Total_Spend), 2) AS Avg_Spending,
    ROUND(AVG(Campaign_Acceptance_Rate), 2) AS Avg_Acceptance_Rate
FROM banking_campaign.banking_maketing_campaign
GROUP BY Marital_Status
ORDER BY Avg_Spending DESC;

-- Active Customers by Join Year
SELECT 
    YEAR(Dt_Customer) AS Join_Year,
    COUNT(*) AS Total_Customers,
    SUM(CASE 
        WHEN (NumDealsPurchases + NumWebPurchases + NumCatalogPurchases + NumStorePurchases) > 0 THEN 1
        ELSE 0
    END) AS Active_Customers,
    ROUND(SUM(CASE 
        WHEN (NumDealsPurchases + NumWebPurchases + NumCatalogPurchases + NumStorePurchases) > 0 THEN 1
        ELSE 0
    END) * 100.0 / COUNT(*), 2) AS Active_Percentage
FROM banking_campaign.banking_maketing_campaign
GROUP BY YEAR(Dt_Customer)
ORDER BY Join_Year;

-- 
SELECT 
    CASE
    WHEN TIMESTAMPDIFF(YEAR, Dt_Customer, CURDATE()) BETWEEN 10 AND 12 THEN '10–12 yrs'
    WHEN TIMESTAMPDIFF(YEAR, Dt_Customer, CURDATE()) BETWEEN 13 AND 15 THEN '13–15 yrs'
    WHEN TIMESTAMPDIFF(YEAR, Dt_Customer, CURDATE()) BETWEEN 16 AND 18 THEN '16–18 yrs'
    WHEN TIMESTAMPDIFF(YEAR, Dt_Customer, CURDATE()) BETWEEN 19 AND 21 THEN '19–21 yrs'
    ELSE '22+ yrs'
END AS Tenure_Group,
    COUNT(*) AS Total_Customers,
    SUM(CASE 
        WHEN (NumDealsPurchases + NumWebPurchases + NumCatalogPurchases + NumStorePurchases) > 0 THEN 1
        ELSE 0
    END) AS Active_Customers,
    ROUND(SUM(CASE 
        WHEN (NumDealsPurchases + NumWebPurchases + NumCatalogPurchases + NumStorePurchases) > 0 THEN 1
        ELSE 0
    END) * 100.0 / COUNT(*), 2) AS Active_Percentage
FROM banking_campaign.banking_maketing_campaign
GROUP BY Tenure_Group
ORDER BY FIELD(Tenure_Group, '10–12 yrs', '13–15 yrs', '16–18 yrs', '19–21 yrs' ,'22+ yrs');

### Spending Behavior
-- Which product categories contribute the most to total revenue?
SELECT Product_Category,
       Total_Revenue,
       ROUND(Total_Revenue * 100.0 / SUM(Total_Revenue) OVER(), 2) AS Revenue_Percentage
FROM (
    SELECT 'Wines' AS Product_Category, SUM(MntWines) AS Total_Revenue FROM banking_campaign.banking_maketing_campaign
    UNION ALL
    SELECT 'Fruits', SUM(MntFruits) FROM banking_campaign.banking_maketing_campaign
    UNION ALL
    SELECT 'Meat', SUM(MntMeatProducts) FROM banking_campaign.banking_maketing_campaign
    UNION ALL
    SELECT 'Fish', SUM(MntFishProducts) FROM banking_campaign.banking_maketing_campaign
    UNION ALL
    SELECT 'Sweets', SUM(MntSweetProducts) FROM banking_campaign.banking_maketing_campaign
    UNION ALL
    SELECT 'Gold', SUM(MntGoldProds) FROM banking_campaign.banking_maketing_campaign
) t
ORDER BY Total_Revenue DESC;

-- How does spending vary by age, income, and family size?
SELECT 
    CASE
        WHEN Age < 30 THEN '<30'
        WHEN Age BETWEEN 30 AND 45 THEN '30–45'
        WHEN Age BETWEEN 46 AND 60 THEN '46–60'
        ELSE '60+'
    END AS Age_Group,
    ROUND(AVG(MntWines + MntFruits + MntMeatProducts + 
              MntFishProducts + MntSweetProducts + MntGoldProds), 2) AS Avg_Spending
FROM banking_campaign.banking_maketing_campaign
GROUP BY Age_Group
ORDER BY Age_Group;

-- Do families with kids/teens spend more on certain products (e.g., sweets, meat)?
SELECT 
    CASE 
        WHEN Kidhome + Teenhome = 0 THEN 'No Kids/Teens'
        ELSE 'With Kids/Teens'
    END AS Family_Type,

    ROUND(AVG(MntSweetProducts),2) AS Avg_Sweets_Spending,
    ROUND(AVG(MntMeatProducts),2) AS Avg_Meat_Spending,
    ROUND(AVG(MntFruits),2) AS Avg_Fruits_Spending,
    ROUND(AVG(MntFishProducts),2) AS Avg_Fish_Spending,
    ROUND(AVG(MntWines),2) AS Avg_Wine_Spending,
    ROUND(AVG(MntGoldProds),2) AS Avg_Gold_Spending
FROM banking_campaign.banking_maketing_campaign
GROUP BY Family_Type;

-- What is the distribution of Total Spend across customers (low, medium, high spenders)?
WITH Spend_Percentiles AS (
    SELECT 
        Total_Spend,
        NTILE(3) OVER (ORDER BY Total_Spend) AS Spend_Tier
    FROM banking_campaign.banking_maketing_campaign
)
SELECT 
    CASE 
        WHEN Spend_Tier = 1 THEN 'Low Spender'
        WHEN Spend_Tier = 2 THEN 'Medium Spender'
        ELSE 'High Spender'
    END AS Spender_Category,
    COUNT(*) AS Customer_Count,
    ROUND(AVG(Total_Spend),2) AS Avg_Spend
FROM Spend_Percentiles
GROUP BY Spender_Category
ORDER BY Avg_Spend;

### Channel Effectiveness
-- Which purchase channel (Web, Store, Catalog, Deals) is most popular?
SELECT 
    'Web Purchases' AS Channel, SUM(NumWebPurchases) AS Total_Purchases
FROM banking_campaign.banking_maketing_campaign
UNION ALL
SELECT 
    'Store Purchases', SUM(NumStorePurchases)
FROM banking_campaign.banking_maketing_campaign
UNION ALL
SELECT 
    'Catalog Purchases', SUM(NumCatalogPurchases)
FROM banking_campaign.banking_maketing_campaign
UNION ALL
SELECT 
    'Deals Purchases', SUM(NumDealsPurchases)
FROM banking_campaign.banking_maketing_campaign
ORDER BY Total_Purchases DESC;

-- What is the relationship between Web Visits per Month and Web Purchases? (Are visits converting?)
SELECT 
    NumWebVisitsMonth,
    ROUND(AVG(NumWebPurchases), 2) AS Avg_Web_Purchases,
    COUNT(*) AS Customers
FROM banking_campaign.banking_maketing_campaign
GROUP BY NumWebVisitsMonth
ORDER BY NumWebVisitsMonth;

-- Do high spenders prefer in-store or online shopping?
SELECT 
    CASE 
        WHEN Total_Spend < 500 THEN 'Low'
        WHEN Total_Spend BETWEEN 500 AND 1500 THEN 'Medium'
        ELSE 'High'
    END AS Spender_Category,
    ROUND(AVG(NumWebPurchases), 2) AS Avg_Web,
    ROUND(AVG(NumStorePurchases), 2) AS Avg_Store,
    ROUND(AVG(NumCatalogPurchases), 2) AS Avg_Catalog,
    ROUND(AVG(NumDealsPurchases), 2) AS Avg_Deals
FROM banking_campaign.banking_maketing_campaign
GROUP BY Spender_Category
ORDER BY FIELD(Spender_Category, 'Low', 'Medium', 'High');

### Campaign Analysis
-- Which campaign (Cmp1–Cmp5) had the highest acceptance rate?
SELECT 
    'Cmp1' AS Campaign,
    ROUND(SUM(AcceptedCmp1) * 100.0 / COUNT(*), 2) AS Acceptance_Rate
FROM banking_campaign.banking_maketing_campaign
UNION ALL
SELECT 
    'Cmp2' AS Campaign,
    ROUND(SUM(AcceptedCmp2) * 100.0 / COUNT(*), 2) AS Acceptance_Rate
FROM banking_campaign.banking_maketing_campaign
UNION ALL
SELECT 
    'Cmp3' AS Campaign,
    ROUND(SUM(AcceptedCmp3) * 100.0 / COUNT(*), 2) AS Acceptance_Rate
FROM banking_campaign.banking_maketing_campaign
UNION ALL
SELECT 
    'Cmp4' AS Campaign,
    ROUND(SUM(AcceptedCmp4) * 100.0 / COUNT(*), 2) AS Acceptance_Rate
FROM banking_campaign.banking_maketing_campaign
UNION ALL
SELECT 
    'Cmp5' AS Campaign,
    ROUND(SUM(AcceptedCmp5) * 100.0 / COUNT(*), 2) AS Acceptance_Rate
FROM banking_campaign.banking_maketing_campaign
ORDER BY Acceptance_Rate DESC;

-- What % of customers accepted any campaign (Response)?
SELECT 
    ROUND(SUM(Response) * 100.0 / COUNT(*), 2) AS Overall_Acceptance_Percentage,
    SUM(Response) AS Accepted_Customers,
    COUNT(*) AS Total_Customers
FROM banking_campaign.banking_maketing_campaign;

-- Are certain age groups / income groups more likely to accept campaigns?
-- Age Groups
SELECT 
    CASE 
        WHEN Age < 30 THEN 'Young (<30)'
        WHEN Age BETWEEN 30 AND 45 THEN 'Adult (30–45)'
        WHEN Age BETWEEN 46 AND 60 THEN 'Mature (46–60)'
        ELSE 'Senior (60+)' 
    END AS Age_Group,
    COUNT(*) AS Total_Customers,
    SUM(Response) AS Accepted_Customers,
    ROUND(SUM(Response) * 100.0 / COUNT(*), 2) AS Acceptance_Rate
FROM banking_campaign.banking_maketing_campaign
GROUP BY Age_Group
ORDER BY Acceptance_Rate DESC;

-- Income Groups
SELECT 
    Customer_Type,
    COUNT(*) AS Total_Customers,
    SUM(Response) AS Accepted_Customers,
    ROUND(SUM(Response) * 100.0 / COUNT(*), 2) AS Acceptance_Rate
FROM banking_campaign.banking_maketing_campaign
GROUP BY Customer_Type
ORDER BY Acceptance_Rate DESC;

-- Does recency (last purchase) affect likelihood of campaign response?
SELECT 
    CASE 
        WHEN Recency <= 30 THEN 'Recent (0–30 days)'
        WHEN Recency BETWEEN 31 AND 90 THEN 'Moderate (31–90 days)'
        WHEN Recency BETWEEN 91 AND 180 THEN 'Stale (91–180 days)'
        ELSE 'Dormant (180+ days)' 
    END AS Recency_Group,
    COUNT(*) AS Total_Customers,
    SUM(Response) AS Accepted_Customers,
    ROUND(SUM(Response) * 100.0 / COUNT(*), 2) AS Acceptance_Rate
FROM banking_campaign.banking_maketing_campaign
GROUP BY Recency_Group
ORDER BY FIELD(Recency_Group, 'Recent (0–30 days)', 'Moderate (31–90 days)', 'Stale (91–180 days)', 'Dormant (180+ days)');

-- Which customer segments (from Step 3 features) responded best?
-- By Age Group
SELECT 
    CASE 
        WHEN Age < 30 THEN 'Young (<30)'
        WHEN Age BETWEEN 30 AND 50 THEN 'Middle-aged (30-50)'
        ELSE 'Older (50+)' 
    END AS Age_Group,
    COUNT(*) AS Total_Customers,
    SUM(Response) AS Responded,
    ROUND(SUM(Response) * 100.0 / COUNT(*), 2) AS Response_Rate
FROM banking_campaign.banking_maketing_campaign
GROUP BY Age_Group
ORDER BY Response_Rate DESC;
-- By Income Group
SELECT 
    Customer_Type,
    COUNT(*) AS Total_Customers,
    SUM(Response) AS Responded,
    ROUND(SUM(Response) * 100.0 / COUNT(*), 2) AS Response_Rate
FROM banking_campaign.banking_maketing_campaign
GROUP BY Customer_Type
ORDER BY Response_Rate DESC;
-- By Family Size
SELECT 
    Family_Size,
    COUNT(*) AS Total_Customers,
    SUM(Response) AS Responded,
    ROUND(SUM(Response) * 100.0 / COUNT(*), 2) AS Response_Rate
FROM banking_campaign.banking_maketing_campaign
GROUP BY Family_Size
ORDER BY Response_Rate DESC;
-- By Campaign Acceptance Rate
SELECT 
    ROUND(AVG(Campaign_Acceptance_Rate), 2) AS Avg_Acceptance_Rate,
    SUM(Response) AS Responded,
    COUNT(*) AS Total_Customers,
    ROUND(SUM(Response) * 100.0 / COUNT(*), 2) AS Response_Rate
FROM banking_campaign.banking_maketing_campaign;

### Customer Value
-- Who are the top 10% high-value customers (by spend)?
SELECT *
FROM (
    SELECT 
        ï»¿ID,
        (MntWines + MntFruits + MntMeatProducts + 
         MntFishProducts + MntSweetProducts + MntGoldProds) AS Total_Spend,
        NTILE(10) OVER (ORDER BY 
            (MntWines + MntFruits + MntMeatProducts + 
             MntFishProducts + MntSweetProducts + MntGoldProds) DESC
        ) AS Spend_Decile
    FROM banking_campaign.banking_maketing_campaign
) ranked
WHERE Spend_Decile = 1
ORDER BY Total_Spend DESC;

-- What is the distribution of campaign acceptance rate among high/low spenders?
WITH spend_segments AS (
    SELECT 
        ï»¿ID,
        (MntWines + MntFruits + MntMeatProducts + 
         MntFishProducts + MntSweetProducts + MntGoldProds) AS Total_Spend,
        NTILE(3) OVER (ORDER BY 
            (MntWines + MntFruits + MntMeatProducts + 
             MntFishProducts + MntSweetProducts + MntGoldProds)
        ) AS Spend_Tier
    FROM banking_campaign.banking_maketing_campaign
),
campaign_acceptance AS (
    SELECT 
        ï»¿ID,
        (AcceptedCmp1 + AcceptedCmp2 + AcceptedCmp3 + 
         AcceptedCmp4 + AcceptedCmp5 + Response) AS Total_Accepted
    FROM banking_campaign.banking_maketing_campaign
)
SELECT 
    CASE s.Spend_Tier
        WHEN 1 THEN 'Low Spenders'
        WHEN 2 THEN 'Medium Spenders'
        WHEN 3 THEN 'High Spenders'
    END AS Spend_Group,
    COUNT(*) AS Total_Customers,
    SUM(c.Total_Accepted) AS Total_Acceptances,
    ROUND(SUM(c.Total_Accepted) * 100.0 / COUNT(*), 2) AS Avg_Acceptance_per_Customer
FROM spend_segments s
JOIN campaign_acceptance c 
    ON s.ï»¿ID = c.ï»¿ID
GROUP BY s.Spend_Tier
ORDER BY s.Spend_Tier;

-- Do customers with longer tenure spend more or respond better?
WITH tenure_data AS (
    SELECT
        ï»¿ID,
        TIMESTAMPDIFF(YEAR, Dt_Customer, CURDATE()) AS Tenure_Years,
        (MntWines + MntFruits + MntMeatProducts + 
         MntFishProducts + MntSweetProducts + MntGoldProds) AS Total_Spend,
        (AcceptedCmp1 + AcceptedCmp2 + AcceptedCmp3 + 
         AcceptedCmp4 + AcceptedCmp5 + Response) AS Total_Accepted
    FROM banking_campaign.banking_maketing_campaign
)
SELECT
    CASE 
        WHEN Tenure_Years BETWEEN 0 AND 2 THEN '0-2 yrs'
        WHEN Tenure_Years BETWEEN 3 AND 5 THEN '3-5 yrs'
        WHEN Tenure_Years BETWEEN 6 AND 10 THEN '6-10 yrs'
        ELSE '10+ yrs'
    END AS Tenure_Group,
    COUNT(*) AS Total_Customers,
    ROUND(AVG(Total_Spend), 2) AS Avg_Spend,
    ROUND(SUM(Total_Accepted) * 100.0 / COUNT(*), 2) AS Avg_Acceptance_Rate
FROM tenure_data
GROUP BY Tenure_Group
ORDER BY Tenure_Group;

-- 
WITH customer_rfm AS (
    SELECT 
        ï»¿ID,
        Recency,   -- already calculated as days since last purchase
        (MntWines + MntFruits + MntMeatProducts + 
         MntFishProducts + MntSweetProducts + MntGoldProds) AS Total_Spend
    FROM banking_campaign.banking_maketing_campaign
)
SELECT 
    ï»¿ID,
    Recency,
    Total_Spend
FROM customer_rfm
WHERE Recency > 60           -- no purchase in last 2 months
  AND Total_Spend > (
        SELECT AVG(Total_Spend) 
        FROM customer_rfm
      )                      -- spent more than average historically
ORDER BY Recency DESC, Total_Spend DESC;

-- Which customer segments are least engaged?
WITH customer_summary AS (
    SELECT 
        ï»¿ID,
        Recency,
        (MntWines + MntFruits + MntMeatProducts +
         MntFishProducts + MntSweetProducts + MntGoldProds) AS Total_Spend,
        (NumDealsPurchases + NumWebPurchases + 
         NumCatalogPurchases + NumStorePurchases) AS Total_Purchases,
        (AcceptedCmp1 + AcceptedCmp2 + AcceptedCmp3 + 
         AcceptedCmp4 + AcceptedCmp5 + Response) AS Campaign_Accepted
    FROM banking_campaign.banking_maketing_campaign
)
SELECT 
    ï»¿ID,
    Recency,
    Total_Spend,
    Total_Purchases,
    Campaign_Accepted,
    CASE
        WHEN Total_Spend = 0 AND Campaign_Accepted = 0 THEN 'Dormant (never engaged)'
        WHEN Recency > 90 AND Total_Spend < (SELECT AVG(Total_Spend) FROM customer_summary)
             AND Campaign_Accepted = 0 THEN 'At Risk (inactive + low response)'
        WHEN Total_Spend < (SELECT AVG(Total_Spend) FROM customer_summary) 
             AND Campaign_Accepted = 0 THEN 'Low Value – Unresponsive'
        ELSE 'Other'
    END AS Engagement_Segment
FROM customer_summary
ORDER BY Engagement_Segment, Recency DESC;

-- Is there a group with high web visits but low purchases (indicating drop-offs)?
WITH stats AS (
    SELECT 
        AVG(NumWebVisitsMonth) AS avg_visits,
        AVG(NumWebPurchases) AS avg_purchases
    FROM banking_campaign.banking_maketing_campaign
),
customer_summary AS (
    SELECT 
        ï»¿ID,
        NumWebVisitsMonth,
        NumWebPurchases
    FROM banking_campaign.banking_maketing_campaign
)
SELECT 
    c.ï»¿ID,
    c.NumWebVisitsMonth,
    c.NumWebPurchases,
    CASE
        WHEN c.NumWebVisitsMonth > s.avg_visits 
             AND c.NumWebPurchases < s.avg_purchases
        THEN 'High Visits - Low Purchases'
        ELSE 'Other'
    END AS Web_Behavior
FROM customer_summary c, stats s
WHERE c.NumWebVisitsMonth > s.avg_visits
   OR c.NumWebPurchases < s.avg_purchases
ORDER BY c.NumWebVisitsMonth DESC, c.NumWebPurchases ASC;

### RFM Analysis
-- 1. Rank Customers into Quartiles (1–4)
-- Recency (R): Lower Recency → better (recent purchase → rank 4), higher Recency → rank 1
-- Frequency (F): Higher Total_Purchases → better → rank 4, lower → rank 1
-- Monetary (M): Higher Total_Spend → better → rank 4, lower → rank 1
SELECT
    ï»¿ID,
    
    -- Recency Quartile
    CASE
        WHEN Recency <= 10 THEN 4
        WHEN Recency <= 30 THEN 3
        WHEN Recency <= 60 THEN 2
        ELSE 1
    END AS R_Quartile,
    
    -- Frequency Quartile
    CASE
        WHEN Total_Purchases >= 20 THEN 4
        WHEN Total_Purchases >= 10 THEN 3
        WHEN Total_Purchases >= 5 THEN 2
        ELSE 1
    END AS F_Quartile,
    
    -- Monetary Quartile
    CASE
        WHEN Total_Spend >= 2000 THEN 4
        WHEN Total_Spend >= 1000 THEN 3
        WHEN Total_Spend >= 500 THEN 2
        ELSE 1
    END AS M_Quartile,
    
    -- Combine into RFM Score
    (CASE WHEN Recency <= 10 THEN 4
          WHEN Recency <= 30 THEN 3
          WHEN Recency <= 60 THEN 2
          ELSE 1 END * 100 +
     CASE WHEN Total_Purchases >= 20 THEN 4
          WHEN Total_Purchases >= 10 THEN 3
          WHEN Total_Purchases >= 5 THEN 2
          ELSE 1 END * 10 +
     CASE WHEN Total_Spend >= 2000 THEN 4
          WHEN Total_Spend >= 1000 THEN 3
          WHEN Total_Spend >= 500 THEN 2
          ELSE 1 END
    ) AS RFM_Score,
    
    -- Business-friendly Segment
    CASE
        WHEN (Recency <= 10 AND Total_Purchases >= 20 AND Total_Spend >= 2000) THEN 'Loyal High-Value'
        WHEN (Recency <= 30 AND Total_Purchases >= 10 AND Total_Spend >= 1000) THEN 'Potential'
        WHEN (Recency > 60 AND Total_Purchases < 5 AND Total_Spend < 500) THEN 'At Risk'
        ELSE 'Other'
    END AS Segment

FROM banking_campaign.banking_maketing_campaign
ORDER BY RFM_Score DESC;


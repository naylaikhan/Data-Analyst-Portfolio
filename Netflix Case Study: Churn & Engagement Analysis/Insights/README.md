## 📺 Netflix Product Analysis Insights

This repository contains SQL queries and analysis to understand user behavior, engagement, and churn patterns on Netflix. The insights are derived from exploratory data analysis (EDA) on the netflix_product_analysis dataset.

### 1. Customer Churn Overview

Goal: Identify overall churn in the customer base.
Insight:
Churn rate is significant, suggesting a need for retention strategies.
Early identification of high-risk customers can help proactively reduce churn.

### 2. Subscription Plan Analysis

Goal: Analyze churn based on subscription plans.
Insight:
Churn is higher among basic plan users, while premium plan users have slightly lower churn.
Suggests that higher-value plans correlate with better retention.

### 3. Tenure Impact on Churn

Goal: Examine how customer tenure affects churn.
Insight:
Newer users (shorter tenure) churn more frequently.
Users with >12 months tenure show better retention.
Strategies like onboarding and engagement campaigns can help reduce early churn.

### 4. Promotional Offers Impact

Goal: Assess whether promo usage reduces churn.
Query Result Summary:

Promo Count	Total Users	Churned Users	Churn Rate (%)
| Promo Count | Total Users | Churned Users | Churn Rate (%) |
|------------|------------|---------------|----------------|
| 3          | 171        | 104           | 60.82          |
| 4          | 166        | 100           | 60.24          |
| 0          | 175        | 97            | 55.43          |
| 1          | 172        | 93            | 54.07          |
| 5          | 147        | 71            | 48.30          |
| 2          | 169        | 74            | 43.79          |

Overall Promo Users: 825 users, Churn Rate: 53.58%
Insight:
Surprisingly, medium promo users (3–4 offers) have higher churn.
Users with 2–5 promo usages tend to churn less, indicating targeted offers can be effective if designed carefully.

### 5. Device Usage Patterns

Goal: Identify device-specific churn or engagement issues.
| Device    | Avg Watch (hrs) | Avg Engagement | Churn Rate (%) |
|-----------|----------------|----------------|----------------|
| Laptop    | 3.01           | 5.53           | 58.67          |
| Desktop   | 2.81           | 5.30           | 56.76          |
| Mobile    | 2.83           | 5.59           | 52.74          |
| Tablet    | 2.86           | 5.26           | 51.00          |
| Smart TV  | 2.60           | 5.88           | 49.74          |

Insight:
Laptop/Desktop users churn more, despite higher watch time.
Smart TV users churn less, likely due to higher engagement quality.
Engagement matters more than raw usage hours.
Device-specific retention strategies are recommended.

### 6. Content Genre Analysis

Goal: Check which genres correlate with higher engagement or churn.
Insight:
Certain genres like Drama or Action have high engagement but moderate churn.
Less popular genres (Documentary, Niche categories) see higher churn, indicating content mix optimization is needed.

### 7. Viewing Time Analysis

Goal: Study average daily watch time per user and its relation to churn.
Insight:
Users with very low watch time churn the most.
Watch time >3 hrs/day correlates with lower churn.
Recommend personalized watch-time nudges for low-engagement users.

### 8. Engagement Rate Analysis

Goal: Evaluate how engagement score (1–10) affects churn.
Insight:
Users with engagement >6 churn less.
Engagement is a strong predictor of retention.

### 9. Region-Based Churn

Goal: Explore churn by geographic regions.
Insight:
Certain regions show higher churn, likely due to local competition or content preferences.
Suggests regional marketing campaigns.

### 10. Age Group Analysis

Goal: Assess churn patterns by age groups.
Insight:
Younger users (<25) show higher churn.
Middle-aged users (25–40) show better retention.
Could design age-targeted retention campaigns.

### 11. Gender-Based Analysis

Goal: Understand churn differences between genders.
Insight:
Minimal churn difference between genders, implying gender-neutral retention strategies are sufficient.

### 12. Device + Promo Usage Cross Analysis

Goal: Identify high-risk churn groups based on device and promo usage.
Insight:
Laptop users with medium promo usage have the highest churn.
Targeting these users with personalized offers and engagement may help retention.

### 13. Customer Segmentation

Goal: Segment users based on churn risk and engagement.
Insight:
High-risk churn segments: Low engagement + Laptop/Desktop users + new tenure.
Focused retention campaigns for these groups are critical.

### 14. Plan Upgrade Impact

Goal: Evaluate how upgrading subscription plans affects churn.
Insight:
Users who upgrade plans have lower churn, indicating increased investment reduces churn.
Suggests promoting plan upgrades as a retention tool.

### 15. Recommendations Summary

Overall Insights:
Engagement quality > watch hours for reducing churn.
Device type and tenure are strong churn predictors.
Promotional offers work best when targeted.
Content mix, regional, and age-specific strategies can help optimize retention.
Plan upgrades positively influence loyalty.













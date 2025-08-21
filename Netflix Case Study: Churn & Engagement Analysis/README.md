# 📊 Netflix Case Study: Churn & Engagement Analysis
    End-to-End SQL + Power BI Project

  This project is a product analytics case study focused on churn, retention, and engagement patterns of Netflix users. 
  As a Data Analyst with 2+ years of experience (portfolio simulation), I designed this project to showcase the full analytics pipeline: from data cleaning in SQL to insight generation and dashboarding in Power BI.

## 📝 Project Overview

The project demonstrates the **end-to-end data pipeline**:
- Data Cleaning & Transformation (SQL)
- Exploratory Data Analysis (EDA)
- Product-Focused Analysis (Funnel, Cohorts, Segmentation, Impact Analysis)
- Dashboard Visualization (Power BI / Tableau)
- Actionable Insights & Recommendations

## 📂 Dataset
The dataset used is `Netflix_product_analysis.csv` (synthetic dataset).

### **Columns**
- `Customer_ID` – Unique user identifier  
- `Subscription_Length_Months` – Length of subscription  
- `Customer_Satisfaction_Score` (1–10)  
- `Daily_Watch_Time` (hours)  
- `Engagement_Rate` (1–10)  
- `Device_Used_Most_Often` (Mobile, TV, Tablet, etc.)  
- `Genre_Preference` (Action, Drama, Documentary, etc.)  
- `Region`  
- `Payment_History` (On-Time / Delayed)  
- `Subscription_Plan` (Basic, Standard, Premium)  
- `Churn_Status` (Yes/No)  
- `Support_Queries_Logged`  
- `Age`  
- `Monthly_Income ($)`  
- `Promotional_Offers_Used` (Yes/No)  
- `Number_of_Profiles_Created`

---

## 🔧 Data Cleaning & Transformation
Performed in **SQL**:
- Handled missing values (Income, Satisfaction Score)  
- Standardized categorical variables (Device, Payment History, Genre, Region)  
- **Feature Engineering**:
  - `Churn_Flag` → binary (1/0)  
  - `AvgWatchPerProfile = Daily_Watch_Time / Number_of_Profiles_Created`  
  - `Income_Bracket = Low / Medium / High`  
  - `Age_Group = Teen / Young Adult / Adult / Senior`  

Exported the final **cleaned dataset** as `netflix_product_analysis_cleaned.csv` for dashboard creation.

---

## 🔍 Exploratory Data Analysis (SQL)
Key questions explored:
1. What’s the overall churn rate?  
2. Do delayed payments correlate with higher churn?  
3. Which subscription plans have the highest churn?  
4. Does higher watch time = lower churn?  
5. Do promotional offers improve retention?  
6. Which regions/devices drive the highest engagement?  
7. Do users with multiple profiles churn less?  
8. Is churn higher for specific genres?  
9. Which age or income cohorts are most at risk?  
10. Do support queries indicate higher churn?  
---

## 🎯 Product-Focused Analysis
- **Funnel Analysis**: Subscription → Active → Engaged → Churned  
- **Cohort Retention**: Retention rates across subscription length  
- **Segmentation**:
  - High-value users (loyal, multiple profiles, high engagement)  
  - At-risk users (delayed payments, low satisfaction, frequent support queries)  
- **Impact Analysis**:
  - Promotional offers vs churn reduction  
  - Device usage patterns (Mobile vs TV vs Web)  
  - Genre preference impact on engagement & retention  

---

## 📊 Dashboard
Created in **Power BI**:
- **Churn Breakdown** by plan, region, and device  
- **Engagement Trends** (avg watch time, satisfaction vs churn)  
- **Retention Cohorts** based on subscription length  
- **Genre & Device Impact** on engagement  
- **Promotional Offers Effectiveness**  

---
## 🛠️ Tools & Technologies
- **SQL** (PostgreSQL / MySQL) → Data cleaning, transformation, EDA  
- **Python (optional)** → Export, further analysis  
- **Power BI / Tableau** → Dashboard visualization

---
## 📂 Project Structure

```bash
Netflix-Churn-Engagement-Analysis
├── data
│   ├── Netflix_product_analysis.csv              # Raw dataset
│   ├── netflix_product_analysis_cleaned.csv      # Cleaned + transformed dataset (with new features)
│
├── sql
│   ├── data_cleaning.sql                         # SQL queries for data cleaning & transformation
│   ├── eda_queries.sql                           # SQL queries for exploratory data analysis (EDA)
│   ├── product_analysis.sql                      # SQL queries for product-focused analysis (churn, cohorts, segmentation)
│
├── dashboard
│   ├── netflix_dashboard.pbix                    # Power BI dashboard (visualization & storytelling)
│
├── README.md                                     # Project documentation & insights

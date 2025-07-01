### Banking Customer Analytics Dashboard

Tools Used: Python, MySQL, Power BI

🔍 Project Overview
This end-to-end data analytics project focuses on analyzing customer transactions in the banking domain. The goal is to extract meaningful insights from raw customer and transaction data and visualize them using Power BI to support data-driven decision-making by bank stakeholders.

🎯 Objective
To analyze banking customers' transactional behavior, segment them based on value, and identify key business drivers such as:

Most valuable customers

High-value transaction types

Revenue and transaction volume trends

Branch-level and region-level performance

🛠 Tech Stack & Tools
Python: Data cleaning, transformation, feature engineering using Pandas

MySQL: Data extraction and structured querying

Power BI: Interactive dashboards with filters and KPIs

Jupyter Notebook: Exploratory Data Analysis (EDA)

🧾 Dataset Summary
Synthetic banking data containing:

Customer_ID, Account_No, Branch, Region, Transaction_Type, Transaction_Amount, Transaction_Date, Customer_Segment, etc.

🔧 Methodology
1. Data Preprocessing (Python)
Merged multiple CSVs into a master dataset

Cleaned null values and standardized column names

Extracted features: Transaction Month, Year, Day Name

Labeled high-value customers using amount thresholds

2. Database Creation (MySQL)
Structured tables: Customers, Transactions, Branches

Joined tables for enriched analysis using INNER JOIN, GROUP BY, CASE, and DATE functions

3. Exploratory Analysis
Transaction distribution by:

Region, Branch, Customer Type

Time (Month, Day of Week)

Transaction Type (Credit, Debit, etc.)

Identified seasonality, peak times, and high revenue zones

4. Power BI Dashboard Highlights
KPIs: Total Transactions, Revenue, Avg. Transaction Size

Region-wise & Branch-wise performance heatmaps

Segmentation of customers by value brackets

Drill-through and slicers for deep insights

💡 Key Business Insights
Top 10% of customers contribute over 60% of total revenue

West region branches outperformed others in transaction value

Credit card payments and mobile banking dominated in volume

Weekends showed lower transaction frequency but higher transaction values

✅ Impact
This project simulates how a real-world bank can:

Identify and retain high-value customers

Optimize branch operations

Align marketing with regional behaviors

Improve digital transaction efficiency

📁 Project Structure
pgsql
Copy
Edit
Banking-Analytics/
├── datasets/
│   └── customers.csv, transactions.csv
├── notebooks/
│   └── banking_analysis.ipynb
├── database/
│   └── create_tables.sql, queries.sql
├── powerbi/
│   └── banking_dashboard.pbix
├── screenshots/
│   └── dashboard_preview.png
└── README.md

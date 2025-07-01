### Sales Performance Dashboard – SQL, Excel, Power BI

🔍 Project Overview
Designed and developed a dynamic Sales Performance Dashboard to analyze sales trends, identify top-performing products and regions, and extract actionable business insights. The goal was to support strategic decision-making by visualizing KPIs and customer segments.

🎯 Objective
To analyze sales data and identify:

High-performing products and categories

Regional sales performance

Customer segment behavior

Delivery trends and operational bottlenecks

🛠 Tools Used
SQL – Data querying and aggregation

Excel – Data cleaning and transformation

Power BI – Interactive dashboard and visual storytelling

🧾 Dataset Description
The dataset included ~10,000 sales records with the following columns:

Order_ID, Order_Date, Ship_Date, Customer_ID, Segment, Region, Product_Name, Category, Sub-Category, Sales, etc.

🔑 Key Insights
📦 Top Products
Technology category accounted for 14.26% of total sales.

Sub-categories like Office Supplies and Phones had consistent demand across regions.

🌍 Regional Performance
West Region led with 31% of total sales;

California alone contributed 20% of the region’s revenue.

👥 Customer Segments
Consumer segment generated the highest revenue.

Corporate segment had higher profit margins.

📈 Sales Trends
Peak sales occurred in November and December (holiday season).

YoY growth of 18%, led by the Consumer segment.

🚚 Shipping Insights
Standard Class was the most used shipping mode (75%),

but Second Class showed better on-time delivery rates.

🧪 Methodology
🔹 Data Cleaning (Excel)
Removed duplicates using Order_ID

Standardized date formats (Order_Date, Ship_Date)

Created new fields:

Year, Month (from Order_Date)

Delivery Time = Ship_Date - Order_Date

🔹 Data Aggregation (SQL)
Top Products → SUM(Sales) GROUP BY Product_Name

Regional Sales → Aggregated by Region, State

Segment Analysis → Revenue + order count per Segment

YoY Growth → Used WINDOW functions for month-over-month comparisons

📊 Power BI Dashboard Features
📌 Executive Summary
KPIs for Total Sales, Total Orders, and Profit Margin

Slicers for dynamic filtering by Region and Segment

📈 Sales Trends
Monthly sales line chart with seasonal spike highlights

🗺 Regional Performance
Map visualization showing revenue distribution across states

🛍 Product Performance
Treemap by category and sub-category

Bar chart of top 10 products by revenue

👤 Customer Insights
Pie chart by segment revenue share

Table of top 5 customers by total spend

🚀 Business Impact
🧠 Strategic Decisions
Boost marketing in West Region & top cities like California

Run targeted Corporate promos during high sales periods

Prioritize inventory for high-demand sub-categories

⚙️ Operational Improvements
Shift more orders to Second Class Shipping for timely delivery

Design regional plans for underperforming areas (e.g., Central Region)

📌 Strategic Insights
Expand top-performing product lines

Retain high-value customers in the Consumer segment

🧾 Conclusion
This project demonstrates how effective use of SQL, Excel, and Power BI can unlock critical business insights. The resulting dashboard helped identify trends, optimize operations, and empower data-driven decision-making across departments.




# Speedy Express Logistics Performance & Operations Intelligence Dashboard

## 📌 Project Overview

Speedy Express Logistics is a comprehensive Power BI solution built using real operational logistics data to monitor and optimize end-to-end delivery performance.

This project simulates a real-world business scenario where leadership and operations teams require centralized visibility into:

• Order performance

• Hub efficiency

• Driver productivity

• Fleet utilization

• Delivery reliability

• Customer satisfaction

The dashboard transforms raw operational data into actionable insights that support strategic and operational decision-making.

## 🎯 Business Problem

Speedy Express Logistics operates multiple hubs, drivers, and vehicle types. However, the management team faced challenges such as:

• Lack of centralized performance visibility

• Difficulty tracking Month-over-Month growth

• Identifying hub capacity bottlenecks

• Understanding driver delay patterns

• Monitoring fleet reliability and breakdown risk

• Linking operational performance with customer satisfaction

This dashboard was designed to solve these challenges through structured data modeling and advanced KPI analytics.

## 🏗 Data Architecture & Modeling
🔹 Data Source

Real logistics operational dataset

Multi-table structure including Orders, Hubs, Drivers, Vehicles, and Date

🔹 Data Modeling Approach

Implemented Star Schema

Designed Fact & Dimension tables

Created relationships using proper cardinality

Built a dedicated Date table for time intelligence

🔹 Fact Tables

Orders

🔹 Dimension Tables

Hub

Driver

Vehicle

Date

This approach ensures scalability, optimized performance, and accurate time-based calculations.

📊 Dashboard Structure

The solution contains 4 interactive dashboards:
<img width="1293" height="727" alt="image" src="https://github.com/user-attachments/assets/0bbe0f89-e54c-448b-baa6-0fb09722ba4f" />
<img width="1305" height="733" alt="image" src="https://github.com/user-attachments/assets/968ea49f-fb48-4bb7-8d13-719978c14378" />
<img width="1300" height="728" alt="image" src="https://github.com/user-attachments/assets/a8bc5a13-e355-4c86-b86e-efcb3f097d7a" />
<img width="1305" height="732" alt="image" src="https://github.com/user-attachments/assets/58035ac0-b5c6-4ab6-a48f-91a47f35b2fb" />

### 1️⃣ Executive Overview Dashboard

Provides leadership-level summary KPIs with Month-over-Month comparison.

Core KPIs:
✔ Total Orders

Current Month Orders

Previous Month Orders

MoM Growth %

✔ On-Time Delivery Rate (%)

Current vs Previous Month

MoM Change %

✔ Customer Satisfaction (CSAT %)

Current vs Previous Month

MoM Change %

✔ Average Delivery Time (Hours)

Current vs Previous Month

MoM Change %

Business Value:
Enables leadership to quickly assess performance trends and operational health.

### 2️⃣ Hubs Overview Dashboard

Focuses on network efficiency and capacity planning.

Key Visuals:

Total Number of Hubs (KPI Card)

Orders Processed vs Hub Capacity (Clustered Column Chart)

Hub Performance Ranking (Ranked Bar Chart)

Hub Order Processing Time – Daily (Matrix)

Business Value:
Identifies overloaded hubs, underutilized capacity, and processing bottlenecks.

### 3️⃣ Drivers Overview Dashboard

Analyzes workforce productivity and performance.

Key Visuals:

Total Drivers (KPI)

Experience vs Rating (Scatter Plot)

Drivers with Most Delays (Bar Chart)

Driver Profile Summary

Hire Date

Years of Experience

Star Rating

Deliveries (Selected Month)

Monthly Trend of Orders (Line Chart)

Business Value:
Supports performance evaluation, training decisions, and workload balancing.

### 4️⃣ Vehicle & Fleet Overview Dashboard

Focuses on fleet health and reliability analytics.

Key Visuals:

Total Vehicles (KPI)

Active vs Inactive Vehicles (Donut Chart)

Orders by Vehicle Model (Bar Chart)

Vehicle Age vs Breakdown (Scatter Plot)

Breakdown by Vehicle Code (Bar Chart)

Breakdown by Vehicle Model (Bar Chart)

Orders by Vehicle Type (Donut Chart)

Business Value:
Supports preventive maintenance planning and fleet optimization.

## 📐 Key DAX Measures Implemented

This project uses advanced DAX for time intelligence and KPI calculations:

Month-over-Month Growth %

Previous Month Calculation

On-Time Delivery %

CSAT %

Average Delivery Time

Capacity Utilization %

Delay Count per Driver

Breakdown Rate

Time intelligence functions include:

CALCULATE()

PREVIOUSMONTH()

DATEADD()

DIVIDE()

Custom KPI variance logic

## 📈 Analytical Insights Generated

This dashboard helps answer business-critical questions such as:

Are orders growing month over month?

Which hubs are operating beyond capacity?

Do experienced drivers perform better?

Which vehicles have high breakdown frequency?

Is delivery speed impacting customer satisfaction?

## 📁 Repository Structure
```
Speedy-Express-Logistics-Analytics/
│
├── 📊 Speedy-Express-Logistics-Analytic.pbix
├── 📄 README.md
├── 📁 Dataset/
└── 📷 Dashboard-Screenshots/
```

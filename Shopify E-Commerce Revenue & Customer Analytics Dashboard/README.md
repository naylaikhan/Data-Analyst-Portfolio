# Shopify E-Commerce Revenue & Customer Analytics Dashboard
End-to-End Business Intelligence Project | Power BI | DAX | Data Modeling

## 📌 Project Overview

This project focuses on analyzing Shopify e-commerce sales data using Power BI to uncover actionable insights into:

Transaction performance

Customer purchasing behavior

Retention and lifetime value

Regional sales distribution

Product & payment performance

The goal was to design an interactive, business-ready dashboard that enables stakeholders to monitor revenue health, understand customer engagement patterns, and drive data-driven decision-making.

## 🎯 Business Objective

The primary objective of this project was to:

Evaluate overall sales performance

Understand customer loyalty & repeat behavior

Identify top-performing regions and cities

Analyze product category contribution

Discover preferred payment methods

## 📊 Key KPIs Implemented
1️⃣ Transaction Performance

Net Sales – Total revenue generated before tax

Total Quantity – Total units sold

Average Order Value (AOV) – Revenue per order (excluding tax)

Support dynamic KPI analysis through interactive selection

This dashboard is designed for business managers, marketing teams, and operations leaders to monitor and optimize performance.
2️⃣ Customer Purchase Behavior

Total Customers – Unique buyers

Single Order Customers

Repeat Customers

Repeat Rate (%)

Purchase Frequency
3️⃣ Retention & Customer Value

Customer Lifetime Value (LTV)

Repeat Rate

Purchase Frequency

These KPIs help evaluate long-term sustainability and customer loyalty.
## 🧠 Advanced Feature: Dynamic Measure Selector

A Measure Selector was implemented to dynamically switch visuals between:

Net Sales

Total Quantity

Total Customers

Repeat Customers

All charts respond dynamically based on the selected KPI, enabling flexible business analysis without changing pages.

## 📈 Dashboard Pages
<img width="1247" height="733" alt="image" src="https://github.com/user-attachments/assets/87a0af80-f07f-4dc3-95fa-59ebc4143a55" />
<img width="1247" height="730" alt="image" src="https://github.com/user-attachments/assets/33d5d4c3-61e8-4a58-ad9c-fcefb1f952d0" />

### 🔹 Page 1: Executive Overview (ERCF Analysis)
✔ KPI Cards

High-level performance indicators

✔ Sales Trend Analysis

Daily trend (Area Chart)

Hourly trend (Bar Chart)

Identify peak sales periods

✔ Regional Overview

Filled Map (Province-level performance)

Bubble/Density Map (City-level sales/customer distribution)

Top Cities Bar Chart (Sorted dynamically)

✔ Gateway Payment Analysis

Identify most & least used payment methods

Understand payment preference trends

✔ Product Type Analysis

Revenue contribution by product category

Engagement differences across product types

### 🔹 Page 2: Detailed Transaction View

Drill-through enabled

Order-level data visibility

Customer-level breakdown

Product type analysis at granular level

Validates aggregated metrics with raw data

This page allows business users to investigate trends behind summary KPIs.

## 🛠️ Technical Implementation
🔹 Steps Followed in Project

Requirement Gathering

Business Understanding

Data Walkthrough

Data Cleaning & Quality Checks

Data Modeling

Data Processing

DAX Calculations

Dashboard Design & Layout

Insight Generation

## 🧩 Data Modeling

Star-schema approach

Fact table: Transactions

Dimension tables: Customer, Product, Date, Location, Gateway

Relationships optimized for performance

Time intelligence enabled using Date table

## 🧮 Key DAX Calculations

Examples include:

Net Sales

Average Order Value

Repeat Customer Logic

Lifetime Value

Repeat Rate

Purchase Frequency

Dynamic KPI Measure Selector using SWITCH()

## 📌 Key Business Insights

Example insights generated from analysis:

Shopify Payments contribute the majority of revenue.

Running Shoes and Tennis Shoes drive the highest net sales.

Certain provinces show significantly higher customer density.

Sales peak during specific hours of the day.

A considerable percentage of customers are repeat buyers, indicating healthy retention.

(You can refine this section with your exact insights.)

## 💡 Tools & Technologies Used

Power BI

DAX

Data Modeling

Power Query

Data Cleaning Techniques

## 🚀 How to Use

Open the .pbix file in Power BI Desktop

Use slicers for:

Measure Selection

Gateway

Province

Drill-through to explore detailed transactions

Interact with maps and charts dynamically

## 📎 Repository Structure
<pre> ```bash Shopify-Ecommerce-Analytics/ |-- Shopify_ECommerce_Revenue_and_Customer_Analytics_Dashboard.pbix |-- README.md |-- Dataset/ | |-- shopify_sales_data.csv |-- Dashboard_Screenshots/ |-- Executive_Overview.png |-- Transaction_Details.png ``` </pre>


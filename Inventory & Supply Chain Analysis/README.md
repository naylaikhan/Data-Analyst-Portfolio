# 📦 SmartSupply 360 Supply Chain Operations Performance Dashboard

## 🔎 Project Summary

SmartSupply 360 is an end-to-end Supply Chain Analytics solution built in Power BI to evaluate supplier performance, procurement cost efficiency, product mix contribution, and quality metrics across multiple locations.

This project simulates a real-world operations environment where procurement teams, category managers, and leadership require centralized visibility into:

Supplier cost contribution

Lead time performance

Defect rate trends

Revenue distribution

SKU-level supply dynamics

Location-wise procurement patterns

The dashboard converts transactional procurement data into decision-ready business insights that enable cost optimization, supplier benchmarking, and operational efficiency improvements.

## 🎯 Business Objective

The core objective of this project was to design a reporting solution that answers:

Which suppliers are driving the highest procurement cost?

Are higher costs associated with better quality or faster lead time?

Which suppliers present quality risks?

How does product category performance vary across locations?

Is procurement spending aligned with revenue contribution?

Where can supplier consolidation or renegotiation improve margins?

## 📊 Dashboard Architecture

The solution is structured into two analytical layers:
<img width="1302" height="726" alt="image" src="https://github.com/user-attachments/assets/e5f6c3b2-b126-4a5c-ae00-1ba6aad7e26d" />
<img width="1302" height="728" alt="image" src="https://github.com/user-attachments/assets/79f00cf8-30b8-4963-8e59-8e394f72354f" />

### 1️⃣ Executive Overview – Leadership Dashboard

Designed for senior stakeholders to quickly monitor operational health.

Key KPIs:

Total Procurement Cost: 1.73M

Total Ordered Quantity: 10K

Average Lead Time: 28.71 days

Average Defect Rate: 3.09

Monthly Orders Overview

SKU Distribution Metrics

Insights Delivered:

Revenue contribution by supplier

Defect rate distribution by inspection outcome

SKU concentration by supplier

Supplier lead time benchmarking

Revenue by product type & city

Unit cost comparison across suppliers

This layer enables quick identification of cost-heavy suppliers and potential quality risks.

### 2️⃣ Supplier Performance Deep Dive – Operational Analytics

Designed for procurement and operations managers.

Advanced Analysis Included:

Supplier ranking by total cost contribution

Lead time benchmarking (best vs worst performer)

Monthly order performance ranking

Ordered Quantity vs Total Cost correlation analysis

Defect rate comparison by supplier

Product mix % contribution by supplier

Location-level cost distribution matrix

This page supports performance-based vendor evaluation and contract negotiation decisions.

### 📍 Geographical Coverage

Bangalore

Chennai

Delhi

Kolkata

Mumbai

### 🧴 Product Categories

Cosmetics

Haircare

Skincare

## 📈 Key Business Insights Identified

Certain suppliers contribute disproportionately to procurement cost without significant lead time advantage.

S5 and S4 show higher defect rates (~3.2), indicating potential quality monitoring gaps.

Revenue contribution varies significantly by location and product type.

Strong linear relationship observed between ordered quantity and total cost.

Product category mix differs significantly across suppliers, indicating dependency risk.

## 🧠 Analytical Techniques Applied

This project goes beyond basic reporting. It includes:

% Contribution Analysis

Dynamic Supplier Ranking (Top N Logic)

KPI Variance Benchmarking

Lead Time Performance Comparison

Correlation Analysis (Scatter Plot)

Multi-dimensional matrix reporting

Product Mix Contribution (% stacked logic)

Performance segmentation

## 🛠 Technical Implementation
Data Modeling

Designed using a Star Schema

Central Fact Table: Procurement Transactions

Dimension Tables:

Supplier

Product Type

Location

Date

Relationships optimized for performance and scalability.

## DAX Measures Implemented

Total Procurement Cost

Avg Lead Time

Avg Defect Rate

Monthly Orders

Supplier Ranking using RANKX

% Cost Contribution

% Ordered Quantity Contribution

Product Mix Percentage

KPI Aggregation Measures

## Data Transformation

Performed in Power Query:

Data cleaning

Null handling

Data type standardization

Derived columns (Cost calculations, KPI metrics)

Data validation checks

## 📊 Business Impact

If deployed in a real procurement function, this solution could:

Identify high-cost suppliers for renegotiation

Detect quality risk suppliers early

Optimize supplier allocation strategy

Reduce procurement cost leakage

Improve service-level consistency

Improve strategic sourcing decisions

📂 Repository Structure

SupplyChain-Performance-Analytics/
```
│
├── Supply_Chain_Operations_Dashboard.pbix
├── Dataset/
│   └── supply_chain_data.csv
│
└── README.md
```

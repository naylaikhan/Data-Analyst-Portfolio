# 📊 Credit Risk Analysis for Loan Default Prediction

## 🏆 Project Objective

Analyze credit card customer data to identify factors driving loan defaults and detect high-risk customer segments.
Outcome: Help organizations improve credit risk management, reduce financial losses, and optimize credit policies.

## 📂 Dataset Overview

25 variables: demographics, credit limits, repayment status, bill amounts, payment behavior.

Target Variable: default.payment.next.month

1 → Customer defaulted

0 → No default

## 📈 Key Analyses & Insights
### 1️⃣ Credit Limit (LIMIT_BAL) Distribution

Most customers: 50,000 NT dollars

Long-tail distribution: very few high-credit customers (>1,000,000 NT)
Insight: Risk mitigation should focus on low- to mid-income customers.

### 2️⃣ Age Distribution & Default Rates

Majority: 25–30 years

Lowest default rate: 30–45 years (20.75%)

Highest default rate: 60+ years (26.84%)

### 3️⃣ Average Payment Delay vs. Default

Majority (1,432 customers) have zero delay

Non-defaulters show higher average delay, indicating possible data scaling issues

### 4️⃣ Default Risk by Education

| Education Level | Default Rate |
| --------------- | ------------ |
| Graduate School | 19.23%       |
| University      | 44.86%       |
| High School     | 25.16%       |
| Others          | 0.47%        |

Insight: Prioritize educated customers; stricter checks for less educated groups.

### 5️⃣ Correlation

LIMIT_BAL vs. avg_pay_delay: +0.353

Interpretation: Higher credit limits mildly correlate with longer payment delays

### 6️⃣ High-Risk Segments
| Age Bucket | Education Level | Marital Status | Avg Payment Delay | Avg Credit Limit | Default Rate |
| ---------- | --------------- | -------------- | ----------------- | ---------------- | ------------ |
| 60+        | University      | Others         | 1,667             | 60,000 NT        | 100%         |
| <30        | Graduate School | Others         | 6,353             | 116,250 NT       | 50%          |

## 📊 Dashboard Insights

### Overall Summary

• Customers: 6,000 | Defaults: 1,284 | Default Rate: 21.4%

• Avg Credit Limit: 167,000 NT | Avg Payment Delay: 4,919

### Defaults by Gender

• Female: 54.67% | Male: 45.33%

### Defaults by Education

'• University: 44.86% | Graduate: 36.92% | High School: 17.76% | Others: 0.47%

### Defaults by Marital Status

• Single: 53.74% | Married: 43.93% | Others: 2.34%

### Age-wise Defaults: Peaks at 25–35 years

### Credit Limit Distribution: 
Most <200,000 NT; few >500,000 NT

### Monthly Default Trends: 
Slight increase May–September; repayment behavior predictive

### Combined Segmentation:

• Extreme risk: 60+ University, Others marital status → 100% default

• Younger <30 Graduate School, Others marital status → 50% default

## ✅ Recommendations

1. Data Quality: Investigate anomalies in avg_pay_delay & “Others” marital status

2. Predictive Modeling: Logistic Regression, Random Forest using key variables

3. Risk-Based Credit Policies: Define thresholds and approvals

4. Targeted Mitigation: Create repayment plans for high-risk groups

## ⚡ Conclusion

This analysis reveals behavioral, demographic, and financial patterns tied to loan defaults.
Actionable insights help organizations:

• Identify high-risk customers

• Prevent defaults

• Implement data-driven lending policies











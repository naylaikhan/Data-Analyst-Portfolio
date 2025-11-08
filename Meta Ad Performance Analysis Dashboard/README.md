# Meta Ad Performance Analysis Dashboard

## 🏢 Business Objective
The Meta Ad Performance Analysis Dashboard is designed to track and visualize the performance of Facebook and Instagram ad campaigns.
It enables marketing teams to:

• Identify the most effective advertising platform.
• Track ROI, reach, and engagement trends.
• Optimize budget allocation and target audience strategies.
• Understand user engagement patterns and conversion efficiency.

## 🖼️ Dashboard Preview

Here’s a quick look at the **Meta Ad Performance Analysis Dashboard** built in Power BI:
<img width="1182" height="762" alt="Facebook_analysis" src="https://github.com/user-attachments/assets/256efd4c-7589-42de-b9ef-6be3315a206f" />

<img width="1168" height="752" alt="Instagram_Analysis" src="https://github.com/user-attachments/assets/470bd7af-eb20-4ffa-804a-57b9c5be471f" />

## 📘 Project Scope
✅ In Scope:
Paid advertising campaigns on Facebook and Instagram only.

❌ Out of Scope:
• Other Meta platforms (Messenger, Audience Network).
• Organic (non-paid) engagement data.

## 📈 Key Performance Indicators (KPIs)
| KPI                          | Definition                                       | Formula                           | Purpose                   |
| ---------------------------- | ------------------------------------------------ | --------------------------------- | ------------------------- |
| **Impressions**              | Number of times ads were displayed.              | Count of event_type = Impression  | Measure reach             |
| **Clicks**                   | Number of user clicks on ads.                    | Count of event_type = Click       | Measure engagement intent |
| **Shares**                   | Number of times ads were shared.                 | Count of event_type = Share       | Viral engagement          |
| **Comments**                 | Number of user comments on ads.                  | Count of event_type = Comment     | User sentiment & feedback |
| **Purchases**                | Number of conversions (post-ad purchases).       | Count of event_type = Purchase    | Conversion tracking       |
| **Engagements**              | Total interactions (Clicks + Shares + Comments). | Clicks + Shares + Comments        | Engagement volume         |
| **CTR (Click-Through Rate)** | % of impressions that resulted in clicks.        | (Clicks ÷ Impressions) × 100      | Ad effectiveness          |
| **Engagement Rate**          | % of impressions that resulted in engagements.   | (Engagements ÷ Impressions) × 100 | Overall ad appeal         |
| **Conversion Rate**          | % of clicks that resulted in purchases.          | (Purchases ÷ Clicks) × 100        | Funnel efficiency         |
| **Purchase Rate**            | % of impressions that resulted in purchases.     | (Purchases ÷ Impressions) × 100   | Conversion from reach     |
| **Total Budget**             | Total ad spend.                                  | Sum(campaigns.total_budget)       | Cost analysis             |
| **Avg. Budget per Campaign** | Average budget allocation.                       | Total Budget ÷ Campaign Count     | Budget distribution       |

## 📊 Dashboard Visualizations
| Visualization               | Chart Type           | Description                                                | Key Insights                                             |
| --------------------------- | -------------------- | ---------------------------------------------------------- | -------------------------------------------------------- |
| **Target Gender**           | Donut Chart          | Performance split by gender (dynamic metric).              | Females drive 43% of engagements.                        |
| **Target Age Group**        | Bar Chart            | Engagement by age group (dynamic metric).                  | Peak engagement: 20–30 age range.                        |
| **Country Map**             | Map Visualization    | Performance by country (bubble size = metric value).       | Highest in US, India, Brazil, Germany, UK.               |
| **Calendar Month**          | Calendar Heatmap     | Monthly activity trends.                                   | Peak engagement on 19–21 & 25–27 June.                   |
| **Weekly Trend by Ad Type** | Stacked Column Chart | Weekly trend comparison across ad types.                   | Stable weekly performance.                               |
| **Hourly Trend**            | Area Chart           | Engagement by hour of day (0–23).                          | Highest activity during 15–20 hours (afternoon–evening). |
| **Ad Type vs Platform**     | Matrix               | Cross-tab comparison of performance by ad type & platform. | Video and Stories ads perform best.                      |

## 🧩 KPI Summary
| Metric                       | Value  | Observation                                     |
| ---------------------------- | ------ | ----------------------------------------------- |
| **Impressions**              | 216K   | Strong reach.                                   |
| **Clicks**                   | 25.4K  | High engagement intent.                         |
| **Engagements**              | 29K    | High overall engagement.                        |
| **CTR**                      | 11.76% | Excellent — well above industry average (1–2%). |
| **Engagement Rate**          | 13.56% | Strong audience connection.                     |
| **Conversion Rate**          | 5.21%  | Moderate — potential for optimization.          |
| **Purchase Rate**            | 0.61%  | Indicates lower funnel inefficiency.            |
| **Total Budget**             | 2.5M   | Significant ad spend across campaigns.          |
| **Avg. Budget per Campaign** | 50.7K  | Balanced distribution.                          |

## 💡 Dashboard Insights
1. Funnel Overview
• Strong Awareness & Engagement: High CTR (11.76%) and Engagement Rate (13.56%)
• Weak Conversion Efficiency: Purchase Rate (0.61%) indicates a drop from interest to purchase.
➡️ Action: Optimize landing pages, offers, and retargeting strategies.

2. Audience Targeting
• Best Performing Segment: Females aged 18–30
• Low Response: Users above 35 years
➡️ Recommendation: Focus campaigns on young female audiences.

3. Geographic Insights
• Top Countries: US, India, Brazil, Germany, UK
➡️ Action:
• Scale budget in India & US for high engagement.
• Target premium campaigns in Germany & UK for better conversions.

4. Ad Format Insights

| Ad Type  | CTR   | Conversion Rate | Engagement Rate |
|-----------|--------|----------------|-----------------|
| Carousel | 11.7% | 5.1% | 13.4% |
| Image | 11.7% | 4.9% | 13.5% |
| Stories | 11.8% | 5.2% | 13.6% |
| Video | **11.9%** | **5.2%** | **13.7%** |

**➡️ Recommendation:** Prioritize **Video** and **Stories** ads for best ROI.

5. Time-Based Trends
• Peak Hours: 3 PM – 8 PM → Best for scheduling ads.
• Peak Days: 19–21 & 25–27 June → Correlated with promotions/events.
➡️ Action: Use these time slots and event-based campaigns to maximize engagement.

## 🧭 Final Recommendations

• Improve conversion funnel – better landing page optimization & retargeting.
• Focus targeting on females aged 18–30, especially in India & Brazil.
• Prioritize Video and Stories ad formats.
• Run campaigns during afternoons & evenings.
• Optimize budget allocation to high-performing geographies and formats.

## ⚙️ Tech Stack

• Power BI – Dashboard visualization
• SQL – Data extraction and cleaning
• Excel / CSV – Data preparation and KPI calculations
• Meta Ads API (optional) – For campaign data ingestion

## 📁 Project Files

| File                       | Description                                              |
| -------------------------- | -------------------------------------------------------- |
| `Meta_Ad_Performance.pbix` | Power BI dashboard file                                  |
| `ad_events.csv`            | Raw event-level data (impressions, clicks, shares, etc.) |
| `ads.csv`                  | Ad metadata (ad type, platform, target age/gender)       |
| `users.csv`                | User data (country, demographics)                        |
| `BRD_Meta_Ad_Analysis.pdf` | Business requirements document                           |
| `README.md`                | Documentation (this file)                                |

## 🧩 How to Use

• Download or clone this repository.
• Open the .pbix file in Power BI Desktop.
• Connect your dataset or use the sample CSV files provided.
• Use the metric selection parameter to dynamically switch KPI visualizations.
• Explore insights by gender, age group, country, time, and ad type.



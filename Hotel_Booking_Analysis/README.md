### Hotel_Booking_Analysis_Dashboard

🎯 Project Overview
A comprehensive end-to-end Power BI dashboard built around hotel bookings data, focusing on clean insights and interactive visuals.

Scope:

• Data cleaning & transformation
• Data modeling (including date/calendar tables)
• Metrics calculation using DAX
• Advanced visualizations
• Multiple report pages for different analysis angle

📋 Dataset & Data Model

Data Source:
Historical hotel booking dataset (CSV/Excel, similar to Kaggle dataset)

Key Fields:

• Booking ID, Hotel, Booking Date, Arrival Date, Lead Time, Nights, Guests
• Distribution Channel, Customer Type, Country, Deposit Type
• Status (check-out or canceled), Revenue, ADR, RevPAR, etc.

Modeling:

• Cleaned via Power Query
• Calendar/Date table created for time intelligence
• Relationships between bookings table and Date table

📊 Core Metrics & DAX Measures
Typical DAX formulas include:

Total Bookings = DISTINCTCOUNT of Booking IDs
• Successful Bookings = COUNTROWS filtered on Canceled = 0
• Cancelled Bookings = COUNTROWS filtered on Canceled = 1
• Occupancy Rate = Successful Bookings ÷ Total Room Capacity
• ADR (Average Daily Rate), RevPAR
• Revenue Loss due to cancellations
• Weekly/monthly YoY or MoM comparisons

📈 Dashboards & Pages
The project consists of multiple report pages covering:

KPI Summary Dashboard
• Key metrics at a glance: Occupancy Rate, ADR, RevPAR, Total Revenue

Overview Dashboard
• Time trends in bookings & revenue
• Booking pattern by channel, guest country

Geographic Breakdown
• Top 5 countries by bookings/revenue, distribution via maps

Booking Channel & Customer Analysis
• Insights comparing direct vs OTA vs offline agents
• Corporate vs Transient analysis

Cancellation Analysis
• Cancellation trends, loss estimation, correlation with deposit & country

Operational Metrics
• Avg. length of stay, busiest months, resource allocation insights

🛠 Tools & Techniques
Power Query: Data cleaning (e.g., date/timestamp fixes, type corrections)
DAX: Advanced measures for KPIs and ratio calculations
Visualizations: Cards, line/bar charts, maps, slicers, tables. Possibly advanced visuals if installed

🔗 Business Insights & Recommendations
Based on the dashboard, the key recommendations include:

• Strengthen relationships with OTAs since they drive 80%+ bookings
• Require minimum 50% deposit to lower cancellation rates
• Target high-value markets (e.g., Portugal, UK, Germany, France, Spain)
• Run promotions like “stay 4 nights, pay for 3” to increase stay duration
• Staff up for peak seasons (peak check-ins in March–October; high check-outs in Oct–Nov)






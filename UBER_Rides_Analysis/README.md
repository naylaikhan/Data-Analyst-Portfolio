## 🚖 Uber Ride Data Analysis (2014–2015)


A comprehensive analysis of Uber ride data (2014–2015) exploring ride trends, peak hours, busiest locations, and active dispatching bases using Python for cleaning, visualization, and EDA.


### 📝 Project Overview

Uber is a leading ride-hailing platform. This analysis helps understand:

Monthly & weekly trends in ride demand

Hourly demand patterns

High-demand hotspots in the city

Most active dispatching bases

### 🗃 Dataset

uber-raw-data-*.csv (2014–2015): Pickup timestamps, location IDs, dispatch bases

Uber-Jan-Feb-FOIL.csv: Active vehicle & trip counts per base

### Key columns:

Column	Description
Dispatching_base_num	Dispatch base code
Pickup_date	Timestamp of pickup
Affiliated_base_num	Affiliated base code
locationID	Pickup location ID
Lat & Lon	Coordinates for mapping hotspots
Base	Dispatch base (2014–2015)
active_vehicles	Number of vehicles per base
trips	Number of trips per base per day
### ⚡ Key Steps
1. Data Cleaning

Removed duplicates & missing values

Converted timestamps to datetime format

2. Feature Engineering

Extracted Month, Day, Hour, Weekday

Aggregated data by time & location

3. Exploratory Data Analysis (EDA)

Peak months, weekdays, and hours

Most active dispatch bases

4. Spatial Analysis

Hotspot mapping with latitude/longitude

City-wide heatmaps for high-demand locations

### 🔧 Tools & Libraries
pip install pandas numpy matplotlib seaborn plotly chart_studio folium


Data manipulation: pandas, numpy

Visualization: matplotlib, seaborn, plotly, chart_studio

Mapping & heatmaps: folium

### 📊 Insights

Peak Month: June

Busiest Days: Saturdays & Fridays

Peak Hours: Evenings & late night (~23:00)

Top Dispatch Base: B02764

Hotspots: Midtown Manhattan, Lower Manhattan, parts of Brooklyn

🚀 How to Run
# Clone the repo
git clone <repo_url>
cd Uber-Data-Analysis/

# Install dependencies
pip install -r requirements.txt

# Open notebook
jupyter notebook Notebooks/Uber_Analysis.ipynb

### 🖼 Visualizations

Monthly ride trends

Weekday & hourly pickups

Dispatch base activity

Heatmaps of ride hotspots

### 📌 Conclusion

This analysis reveals Uber ride patterns for 2014–2015, helping identify peak periods, optimize driver allocation, and visualize city hotspots—valuable for data-driven decision-making.

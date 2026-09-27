# EdTech AI Operations & Business Impact Analysis

A portfolio data analysis project examining whether AI adoption is associated with meaningful changes in **business performance, learner outcomes, support operations, and instructor productivity** at an EdTech company.

> **⚠️ Data Disclosure**
>
> This project uses a **synthetically generated dataset** designed to simulate realistic EdTech operations across 5.5 years. The dataset intentionally includes data-quality issues such as invalid ranges, inconsistent categories, duplicates, and impossible values for cleaning practice.
>
> **The numbers and findings presented in this project are illustrative, not real company results.**
>
> The goal is to demonstrate an end-to-end analytical workflow that can transfer to real-world data:
>
> **Data Cleaning → Business Question Framing → Analysis → Statistical Validation → Interpretation → Business Recommendations**

---

## 📌 Business Question

> **As the company rolled out AI across content production, tutoring, and customer support, did it actually move the metrics that matter - revenue, retention, learner outcomes, and unit costs - or did it just add technology for its own sake?**

Every record in the dataset is tagged with an **AI Phase**:

* `Pre-AI`
* `AI Adoption`
* `Post-AI`

This allows before/after comparisons across five operational areas:

1. Business performance
2. Course & content operations
3. Customer support
4. Instructor productivity
5. Learner engagement & outcomes

---

## 🗂️ Project Structure

```text
EdTech-AI-Operations-Analysis/
│
├── notebooks/
│   ├── 01_data_cleaning.ipynb
│   └── 02_business_impact_analysis.ipynb
│
├── data/
│   ├── edtech_ai_operations_workbook.xlsx
│   └── edtech_ai_operations_workbook_cleaned.xlsx
│
├── dashboard/
│   └── PowerBI_dashboard.pbix
│
├── README.md
└── requirements.txt
```

### Notebook Overview

| Notebook                            | Purpose                                                                                                                                                                                 |
| ----------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `01_data_cleaning.ipynb`            | Loads and cleans the five raw datasets. Handles data types, duplicates, invalid ranges, inconsistent categories, impossible values, and missing data.                                   |
| `02_business_impact_analysis.ipynb` | Performs the core analysis, including AI adoption trends, phase-level comparisons, correlation analysis, dollar-impact translation, segment analysis, limitations, and recommendations. |
| `Power BI Dashboard`                | Optional interactive dashboard for exploring the same business metrics visually.                                                                                                        |

---

## 📊 Datasets

The project combines five operational datasets:

| Dataset             | Description                                                                                  |
| ------------------- | -------------------------------------------------------------------------------------------- |
| **Business KPIs**   | Monthly business performance, revenue, acquisition, retention, and cost metrics              |
| **Courses**         | Course categories, enrollments, AI-assisted content, and course performance                  |
| **Support Tickets** | Customer support volume, response time, resolution time, CSAT, escalations, and ticket costs |
| **Instructors**     | Instructor activity, AI-tool usage, content output, working hours, and ratings               |
| **Learners**        | Learner engagement, completion, churn, AI feature usage, support activity, and cost-to-serve |

---

## 🛠️ Tools & Technologies

### Programming & Analysis

* **Python**
* **Pandas**
* **NumPy**
* **Matplotlib**
* **Jupyter Notebook**

### Data Cleaning

The cleaning workflow includes:

* Data type conversion
* Duplicate detection and removal
* Range validation
* Logic validation
* Categorical standardization
* Missing-value auditing
* Outlier investigation
* Business-rule validation
* Documented cleaning decisions

### Analysis

The analysis includes:

* Pre-AI vs. Post-AI comparison
* AI adoption trend analysis
* Month-level correlation analysis
* Segment-level analysis
* Operational KPI analysis
* Dollar-impact translation
* Statistical validation
* Limitation analysis

---

# 🧹 Data Cleaning Approach

The raw dataset intentionally contains data-quality problems to simulate a real-world analytics environment.

Examples include:

* Inconsistent category names
* Duplicate records
* Negative values where they are not logically possible
* Percentages outside the `0–100%` range
* Invalid ratings
* Impossible response/resolution times
* Inconsistent Boolean values
* Mixed currency formats
* Missing values
* Extreme outliers

Rather than blindly deleting unusual values, the cleaning notebook evaluates each issue using **business logic and documented assumptions**.

The goal is to distinguish between:

> **A genuine unusual business event vs. a data-quality error.**

---

# 📈 Key Findings

> **Important:** All findings below are based on synthetic data and are intended for portfolio demonstration purposes only.

| Business Area                | Pre-AI → Post-AI |
| ---------------------------- | ---------------: |
| Monthly subscription revenue |         **+61%** |
| Support resolution time      |         **-60%** |
| Cost per support ticket      |         **-39%** |
| Learner completion rate      |         **+11%** |
| CSAT                         |       **+10.7%** |
| Customer acquisition cost    |         **-20%** |
| Instructor content output    |         **+37%** |

Instructor content output also increased while working hours decreased, alongside an improvement in learner ratings.

---

# 🔎 The Finding That Complicates the Story

One of the most important findings was not a positive KPI improvement.

While average support resolution time improved substantially:

> **Escalation rate increased from 13% to 21%.**

This creates an important operational question.

AI may be helping resolve routine support tickets faster while a growing proportion of more difficult tickets are being escalated.

Therefore, looking only at:

> **"Resolution time decreased by 60%"**

could give an incomplete picture of support performance.

This is why the analysis considers **multiple KPIs together rather than relying on a single headline metric.**

---

# 🧠 Analytical Approach

A major goal of this project is to avoid treating a simple Pre-AI vs. Post-AI comparison as proof of causation.

## 1. Before/After Comparison

The first layer compares major KPIs across:

```text
Pre-AI
   ↓
AI Adoption
   ↓
Post-AI
```

This provides a high-level view of how business metrics changed during the AI rollout.

However, this approach has an important limitation.

A multi-year dataset naturally contains:

* Business growth
* Seasonality
* Pricing changes
* Changes in customer mix
* Operational improvements
* Other technology changes

Therefore:

> **A KPI increasing after AI adoption does not automatically mean AI caused the increase.**

---

## 2. Month-Level Analysis

To stress-test the phase-level comparison, the project also examines relationships at the **monthly level**.

This helps determine whether observed relationships remain visible when moving from broad phase averages to a finer time grain.

---

## 3. Segment-Level Analysis

Where appropriate, the analysis also breaks results down by business or operational segment.

This helps identify whether an overall company-level result is consistent across segments or driven primarily by a subset of the business.

---

# 💰 Business Impact Translation

Percentage changes are useful, but business stakeholders often need the impact expressed in operational or financial terms.

Where appropriate, the analysis translates KPI changes into measures such as:

* Estimated revenue impact
* Support cost savings
* Cost per ticket
* Productivity improvement
* Changes in acquisition cost
* Changes in learner outcomes

This connects the technical analysis to the underlying business question.

---

# ⚠️ Limitations

The analysis is **correlational**, not causal.

### 1. No Control Group

There is no control group that continued operating without AI.

Therefore, AI's effect cannot be cleanly separated from:

* Natural business growth
* Pricing changes
* Seasonality
* Other operational improvements

### 2. Self-Selected AI Adoption

At the learner level, AI feature adoption is self-selected rather than randomized.

More engaged learners may be more likely to use AI features.

Therefore, differences between AI users and non-users may reflect **pre-existing differences between the groups**.

### 3. Correlation ≠ Causation

An association between AI adoption and improved performance does not establish that AI caused the improvement.

A stronger causal design would require something such as:

* A/B testing
* Controlled experimentation
* Staggered rollout
* Difference-in-differences
* Another appropriate quasi-experimental design

### 4. Missing CSAT Data

Approximately **30% of support tickets do not have a CSAT rating**.

These records were excluded from CSAT-specific analysis rather than being artificially imputed.

This avoids introducing fabricated signal into the analysis.

---

# 🎯 What This Project Demonstrates

This project is designed to demonstrate more than the ability to create charts or calculate percentages.

It demonstrates the ability to:

### 1. Start with a Business Question

Instead of beginning with:

> "What charts can I make?"

the analysis starts with:

> "Did AI adoption actually improve the business metrics that matter?"

### 2. Clean Messy Data

The dataset intentionally contains realistic data-quality problems.

The workflow identifies, validates, and documents those problems before analysis.

### 3. Question the First Result

A large improvement in resolution time looks positive.

But the increase in escalation rate provides an important counter-signal.

### 4. Avoid Overclaiming

The project explicitly distinguishes:

**Observed association**

from

**Proven causal impact**

### 5. Translate Analysis Into Business Meaning

The goal is not simply to report:

> "Metric X increased by 20%."

The goal is to ask:

> "What does this mean operationally, financially, and for management decisions?"

---

# 🔬 Recommended Future Analysis

If this were real company data, the next analytical step would be to strengthen causal inference.

Possible approaches include:

* A/B testing AI features
* Staggered AI rollout analysis
* Difference-in-differences
* Cohort analysis
* Pre/post analysis with matched comparison groups
* Regression models controlling for seasonality and business growth
* Learner-level adoption analysis
* Cost-benefit analysis of AI implementation

These methods could help distinguish **AI impact from general business trends**.

---

# ▶️ How to Reproduce

### Step 1 - Clone the Repository

```bash
git clone <your-repository-url>
cd EdTech-AI-Operations-Analysis
```

### Step 2 - Install Dependencies

```bash
pip install pandas numpy matplotlib openpyxl jupyter
```

Or:

```bash
pip install -r requirements.txt
```

### Step 3 - Run the Data Cleaning Notebook

Open:

```text
notebooks/01_data_cleaning.ipynb
```

Run the notebook from top to bottom.

This produces the cleaned workbook:

```text
data/edtech_ai_operations_workbook_cleaned.xlsx
```

### Step 4 - Run the Business Analysis Notebook

Open:

```text
notebooks/02_business_impact_analysis.ipynb
```

Make sure the notebook points to the cleaned workbook.

Then run the notebook from top to bottom.

---

# 📊 Power BI Dashboard

An optional Power BI dashboard can be used as a companion to the Python analysis.

The dashboard can provide interactive views of:

* Revenue trends
* AI adoption
* Support performance
* Escalation rates
* Learner outcomes
* Instructor productivity
* Cost metrics
* Pre-AI vs. Post-AI comparisons

**Power BI Dashboard:** *Link to be added*

---

# 📁 Repository Contents

```text
├── data/
│   ├── edtech_ai_operations_workbook.xlsx
│   └── edtech_ai_operations_workbook_cleaned.xlsx
│
├── notebooks/
│   ├── 01_data_cleaning.ipynb
│   └── 02_business_impact_analysis.ipynb
│
├── dashboard/
│   └── PowerBI_dashboard.pbix
│
├── README.md
└── requirements.txt
```

---

# 👩‍💻 About Me

I'm a **Data Analyst** interested in using data to solve business and operational problems.

This project was built to practice:

* Business problem framing
* Data cleaning
* Exploratory data analysis
* KPI analysis
* Statistical validation
* Operational analysis
* Data storytelling
* Communicating limitations honestly

The focus is not simply on finding positive results, but on understanding **what the data supports, what it does not support, and what additional analysis would be needed to make stronger decisions.**

Feel free to connect or open an issue if you'd like to discuss the methodology.

---

## ⭐ Key Takeaway

> **Good analytics is not about proving that an initiative worked. It is about finding what the data actually supports - including the results that complicate the story.**

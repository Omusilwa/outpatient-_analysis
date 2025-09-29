# Outpatient Gaps: Data Quality & Exploratory Data Analysis (EDA) Report

This project analyzes outpatient encounter data to identify operational gaps, access barriers, and care quality issues in a healthcare setting. The analysis highlights key gaps to watch out for, such as bottlenecks in wait times, equity disparities in access, treatment ineffectiveness signals like readmissions, and financial leakages from denialsy.

These can be communicated to stakeholders through concise reports, visual dashboards, and targeted presentations—focusing on metrics, visuals, and actionable recommendations to drive buy-in.

Using Python (Pandas, Plotly Express) and SQLite, we uncover actionable insights to improve patient access, reduce wait times, and enhance care continuity


📊 **Dataset**: [dataset](hospital_outpatient_raw.csv)

Mock outpatient encounter data (1000 post-dedup records) with fields like encounter date, wait time, no-show status, readmission flags, travel distance, residence type, income level, and payment outcomes.  

🔗 **Code**: [Jupiter Notebook](opd_eda.ipynb) | [SQL Script](Sql_Script.sql)

📈 **Visuals**: [Figures](Figures/)  

---

## Data Quality Summary
- **Total Encounters (post-dedup)**: 1,000
- **Rows Removed as Duplicates**: 20 (2% of raw data)
- **Missing Encounter Date**: 32.3% (action: impute or exclude based on analysis needs)
- **Other Missing Flags**: phone (e.g., 23.3% flagged), address (up to 6.3%), watch for biases in demographic analyses

**Gaps to Watch Out For**: High missingness in time-sensitive fields (e.g., encounter dates) can distort trend analyses; incomplete contact info may hide follow-up issues. Always validate data completeness before KPI calculations.

**Why It Matters**: Poor data quality amplifies gaps; deduplication and imputation ensure reliable insights for decision-making.

**Communication for Stakeholders**: Present as a simple table in reports/slides, with visuals like pie charts showing missingness percentages. Emphasize: *"This missing data could underrepresent rural patients, let's prioritize data capture audits."*

---

## Key Operational Gaps

Watch out for these common operational red flags: excessive wait times (>60 min, signaling staffing shortages), high no-show rates (indicating scheduling flaws), delayed results TAT (affecting care speed), and readmissions (pointing to discharge gaps)

| Metric                     | Value        | Insight                                     | Gap to watch for                      |
|----------------------------|--------------|---------------------------------------------|---------------------------------------|
| Median Wait Time           | 42 min       | Indicates scheduling or throughput issues   |Bottleneck in high-volume departments  |
| % Waits > 60 min           | 27.8%        | High breach rate flags bottleneck risks     |Overload triage or resource mismatch   |
| Overall No-Show Rate       | 16.2%        | Suggests access or engagement barriers      |Poor reminder, Contact info missing    |
| Readmissions within 30 Days| 18.0%        | Signals care continuity gaps                |Inadequeate follow-up protocol         |
| Median Results Turnaround  | 2 days       | Delays may impact timely clinical decisions |Lab/Imaging workflow ineffeciencies    |
| Payment Denial Rate        | 48%          | Major revenue leakage risk                  |Documentation or authorization errors  |

**Why It Matters**: These gaps erode efficiency, increase costs, and reduce patient trust. For example, long waits correlate with no-shows, creating a vicious cycle.

**Communication to Stakeholders**: Use tables like this in executive summaries or dashboards (e.g., Tableau). Highlight with color-coding (red for >20% thresholds). In presentations, say: *"Our 27.8% long-wait rate costs X hours weekly, here's how queue optimization can cut it by 15%."*

---

## Access & Equity Signals

Key gaps to monitor: Disparities in no-show rates by residence/income (equity issues), longer travel distances for rural patients (access barriers), and lower visit rates for low-literacy groups (communication gaps)

| Metric                     | Value        | Insight                                     |Gap to watch For                     |
|----------------------------|--------------|---------------------------------------------|-------------------------------------|
| Median Travel Distance     | 5.35 km      | Longer distances correlate with no-shows    | Rural transportation barriers       |
| No-Show Rate (Urban)       | 13.51%       | Lower than rural, but still significant     | Urban affordability or awareness gap|  
| No-Show Rate (Rural)       | 18.85%       | Access barriers (transport, distance)       | Geographical inequities             |
| No-Show (Low Income)       | 17.31%       | High than high-income (12.4%)               | Financial and literacy disperaty    |


**Why It Matters**: 
- Rural and low-income patients face disproportionate barriers, leading to unequal care access. Watch for correlations with language/literacy to spot underserved groups.

**Communication to Stakeholders**: Share via bar charts in reports, with side-by-side comparisons (urban vs. rural).*"In meetings, tie to ROI: "Addressing equity gaps could boost volume by 10% through better retention."*

---
## Treatment Effectiveness Gaps

Important gaps to track: High readmissions in vulnerable groups (e.g., chronic patients, infancy), low follow-up adherence (continuity issues), and procedure outcomes without diagnostics (quality risks).

  - **Readmission Rate by Chronic Count**: 22% for patients with 2+ conditions (vs. 12% for 0). Watch for chronic management failures.
  
  - **Follow-Up Days Median**: 7 days, but 25% exceed 14 days. Signals delayed care escalation.
  
  - **Readmissions without Labs/Imaging**: 20% higher when tests skipped. Potential diagnostic oversights.

**Why It Matters**: These gaps indicate ineffective treatments, leading to poorer outcomes and higher costs. Monitor by age/diagnosis for targeted interventions.

**Communication To Stakeholders**: Use grouped bar charts to show breakdowns (e.g., readmits by age). In reports: "18% readmission rate in infancy highlights pediatric gaps—recommend standardized follow-ups.

---
## Financial Gaps

Gaps to watch: High denial rates by payer/department (revenue risks), unpaid bills in self-pay groups (affordability issues), and correlations with low-income (equity-financial overlap).

  - **Denial Rate by Payer**: Self-pay at 55% (vs. private at 30%)—watch for documentation gaps.
  
  - **Unpaid Rate by Income**: Low-income at 52%—signals barriers to care continuity.
  
  - **Avg Billing Amount**: $85.20, with 40% denials in high-cost departments like Cardiology.

**Why It Matters**: Financial gaps strain sustainability; watch for trends in pending/denied statuses to prevent leakage.

**Communication to Stakeholders**: Present as pie charts in financial reviews, with denial breakdowns. Phrase as: "48% denials leak $X annually—pre-auth checks could recover 20%." Use dashboards for real-time tracking

---

## Visual Summaries

All visuals are generated in the Jupyter Notebook using Plotly Express for interactivity. 

Key examples

- **Wait Time Distribution**: [Horizontal Bar Chart](Figures/wait_time_distribution.png) – Shows right-skewed wait times, with a long tail beyond 60 min.
- **No-Show by Residence**: [Bar Chart](Figures/show_vs_no-show.png) – Higher no-show rates in rural areas.
- **Monthly Volume & No-Show**: [Line Plot](Figures/monthly_volume_noshow.png) – Tracks seasonal patterns in encounters and no-shows.
- **Wait by Department**: [Stacked Bar Chart](Figures/wait_by_department.png) – Identifies departments with excessive wait times.
- **Readmission by Age**: [Grouped Bar Chart](Figures/readmit_by_age.png) – Highlights infancy and older age groups at risk.

---

## Insights for Stakeholders

- **Throughput Bottlenecks**: Long waits (27.8% > 60 min) suggest scheduling inefficiencies. Consider queue redesign, fast-track protocols, or template optimization.
- **Access Barriers**: Rural (18.85%) and low-income (17.31%) no-show rates indicate transport and affordability issues. Explore SMS reminders, transport vouchers, or telehealth.
- **Care Continuity**: High readmission rates in infancy (18.0%) call for better discharge education and follow-up protocols.
- **Results Delays**: 2-day median turnaround time (TAT) risks delayed decisions. Streamline lab/imaging workflows with clear SLAs.
- **Revenue Leakage**: 48% payment denial rate signals documentation gaps. Strengthen pre-authorization and clinical documentation processes.

**Why It Matters**: Addressing these gaps improves patient experience, equity, and financial outcomes while reducing operational strain.

---

## Action Plan
1. **Set SLAs**: Target max wait ≤ 45 min, results TAT ≤ 24–48h.
2. **Access Interventions**: Deploy SMS reminders, dynamic overbooking, transport support for rural patients, and telehealth for long-distance cases.
3. **Care Continuity**: Standardize discharge checklists, schedule follow-ups pre-discharge, and implement nurse calls for high-risk patients within 72h.
4. **Revenue Integrity**: Enforce pre-authorization checks, improve clinical documentation, and establish a payer feedback loop.
5. **Monitoring**: Build a weekly KPI dashboard (Tableau) tracking wait > 60 min, no-show rate, readmission rate, denial rate, and TAT.

---


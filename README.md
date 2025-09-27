# Outpatient Gaps: Data Quality & Exploratory Data Analysis (EDA) Report

This project analyzes outpatient encounter data to identify operational gaps, access barriers, and care quality issues in a healthcare setting. Using Python (Pandas, Express, Plotly), we uncover actionable insights to improve patient access, reduce wait times, and enhance care continuity.

📊 **Dataset**: Mock outpatient encounter data (1000 post-dedup records) with fields like encounter date, wait time, no-show status, readmission flags, travel distance, residence type, income level, and payment outcomes.  
🔗 **Code**: [Jupyter Notebook](opd_eda.ipynb) |
📈 **Visuals**: [Figures](Figures/)  

---

## Data Quality Summary
- **Total Encounters (post-dedup)**: 1,000
- **Rows Removed as Duplicates**: 20 (2% of raw data)
- **Missing Encounter Date**: 32.3% (action: impute or exclude based on analysis needs)

**Why It Matters**: High missingness in encounter dates may skew time-based analyses (e.g., monthly trends). Deduplication ensures data integrity for accurate KPI tracking.

---

## Key Operational Gaps
| Metric                     | Value        | Insight                                      |
|----------------------------|--------------|---------------------------------------------|
| Median Wait Time           | 42.5 min     | Indicates scheduling or throughput issues   |
| % Waits > 60 min           | 27.8%        | High breach rate flags bottleneck risks     |
| Overall No-Show Rate       | 16.2%        | Suggests access or engagement barriers      |
| Readmissions within 30 Days| 18.0% (infancy) | Signals care continuity gaps             |
| Median Results Turnaround  | 2 days       | Delays may impact timely clinical decisions |
| Payment Denial Rate        | 48%          | Major revenue leakage risk                  |

**Why It Matters**: Long waits and high denial rates hurt patient satisfaction and financial stability. No-shows and readmissions point to access and care quality issues.

---

## Access & Equity Signals
| Metric                     | Value        | Insight                                      |
|----------------------------|--------------|---------------------------------------------|
| Median Travel Distance     | 5.35 km      | Longer distances correlate with no-shows    |
| No-Show Rate (Urban)       | 13.51%       | Lower than rural, but still significant     |
| No-Show Rate (Rural)       | 18.85%       | Access barriers (transport, distance)       |


**Why It Matters**: 
- Rural patients face disproportionate access barriers, requiring targeted interventions like transport support or telehealth.

---

## Visual Summaries
- **Wait Time Distribution**: [Horizontal Bar Chart](Figures/wait_time_distribution.png) – Shows right-skewed wait times, with a long tail beyond 60 min.
- **No-Show by Residence**: [Bar Chart](Figures/show_vs_no-show.png) – Higher no-show rates in rural areas.
- **Monthly Volume & No-Show**: [Line Plot](Figures/monthly_volume_noshow.png) – Tracks seasonal patterns in encounters and no-shows.
- **Wait by Department**: [Stacked Bar Chart](Figures/wait_by_department.png) – Identifies departments with excessive wait times.
- **Readmission by Age**: [Grouped Bar Chart](Figures/readmit_by_age.png) – Highlights infancy and older age groups at risk.

**How to Reproduce**: Run [outpatient_analysis](outpatient_analysis/opd_eda.ipynb) to generate plots using Pandas/Plotly Express.

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


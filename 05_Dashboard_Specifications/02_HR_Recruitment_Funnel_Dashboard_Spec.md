# Dashboard Specification 02: Recruitment Funnel & Talent Acquisition

**Domain**: Human Capital & Talent Acquisition  
**Primary Dataset**: `HR_Recruitment_Funnel.csv`  
**Canvas Resolution**: 16:9 (1920 x 1080 px or 1280 x 720 px standard)  
**Theme**: Modern Clean Corporate (Royal Indigo `#4338CA`, Cyan Accent `#06B6D4`, Emerald `#10B981`)

---

## 1. Top Executive KPI Ribbon (Y: 0 to 140 px)

| Visual # | Visual Type | Card Title / Metric | Primary Measure | Secondary Callout / Sub-label | Conditional Formatting |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **KPI-01** | Modern Card (New) | **Total Applications** | `[Total Applications]` | Total Pipeline Volume | Cool Grey |
| **KPI-02** | Modern Card (New) | **Total Candidates Hired** | `[Total Hired]` | Target Fulfillment | Emerald Green |
| **KPI-03** | Modern Card (New) | **End-to-End Funnel Conversion** | `[Overall Funnel Conversion Rate %]` | Ratio: `[Applicants Per Hire]` | Normal Blue |
| **KPI-04** | Modern Card (New) | **Offer Acceptance Rate (OAR)** | `[Offer Acceptance Rate %]` | Industry Benchmark: `> 80%` | Green if `>80%`, Red if `<70%` |
| **KPI-05** | Modern Card (New) | **Avg Time-to-Hire** | `[Avg Time to Hire (Days)]` | Target SLA: `30.0 Days` | Green if `<= 30`, Amber `31-35`, Red `>35` |
| **KPI-06** | Modern Card (New) | **Avg Cost Per Hire** | `[Cost Per Hire USD]` | Total Spend: `[Total Sourcing Cost USD]` | Slate Blue Currency |

---

## 2. Global Slicers & Filter Bar (Y: 150 to 220 px)

- **Slicer 1 (Date Range Slider)**: `Dim_Date[Date]` linked to `ApplicationDate`
- **Slicer 2 (Dropdown)**: `Department` (Sales, Research & Development, Human Resources)
- **Slicer 3 (Dropdown)**: `ApplicationSource` (LinkedIn, Indeed, Referral, Career Site, Agency, Campus)
- **Slicer 4 (Multi-select Buttons)**: `RecruiterName`

---

## 3. Core Visuals Grid (Y: 230 to 650 px)

### Visual 1: End-to-End Recruitment Conversion Funnel
- **Type**: Funnel Chart or Horizontal Bar Cascade
- **Category (Stages)**: `StageReached` (Sorted by `StageSortIndex`)
  1. `1. Applied` -> `[Total Applications]` (100%)
  2. `2. Screened` -> `[Screened Count]` (~55%)
  3. `3. Interviewed` -> `[Interviewed Count]` (~28%)
  4. `4. Offer Extended` -> `[Offers Extended Count]` (~10%)
  5. `5. Hired` -> `[Total Hired]` (~7.5%)
- **Values**: Headcount & Stage Conversion %
- **Data Labels**: Show both stage count and % of First Stage.
- **Key Insight**: Pinpoints exact drop-off stages in candidate progression.

### Visual 2: Time-to-Hire by Department & Job Role
- **Type**: Clustered Bar Chart with Reference Line
- **Y-Axis**: `JobRole`
- **X-Axis**: `[Avg Time to Hire (Days)]`
- **Constant Target Line**: `30 Days` (Dashed Red Line)
- **Data Labels**: Enabled, formatted as `0.0 Days`
- **Color Format**: Bars turning amber/red when exceeding the 30-day target threshold.
- **Key Insight**: Identifies whether senior technical roles or sales roles are lagging in interview-to-offer velocity.

### Visual 3: Sourcing Channel ROI & Cost-Per-Hire Matrix
- **Type**: Scatter Plot / Quadrant Bubble Chart
- **X-Axis**: `[Overall Funnel Conversion Rate %]` (Quality/Yield)
- **Y-Axis**: `[Cost Per Hire USD]` (Cost Efficiency)
- **Size**: `[Total Hired]` (Volume)
- **Legend**: `ApplicationSource`
- **Quadrant Lines**: X-Median and Y-Median reference lines
- **Key Insight**: Segregates high-yield, low-cost channels (e.g. Employee Referrals) from high-cost, moderate-yield channels (e.g. External Agencies).

---

## 4. Deep-Dive & Recruiter Operations (Y: 660 to 1040 px)

### Visual 4: Monthly Recruitment Velocity & Pipeline Trend
- **Type**: Area Chart / Line & Stacked Column
- **X-Axis**: `Dim_Date[Year-Month]` (Sorted by `YearMonthKey`)
- **Column Values**: `[Total Applications]`
- **Line Values (Secondary Axis)**: `[Total Hired]`, `[Avg Time to Hire (Days)]`
- **Key Insight**: Evaluates hiring seasonality, application spikes, and whether increased applicant volume causes time-to-hire bottlenecks.

### Visual 5: Recruiter Scorecard Table / Matrix
- **Type**: Formatted Matrix Table
- **Rows**: `RecruiterName`
- **Columns / Measures**:
  1. `[Total Applications]`
  2. `[Total Hired]`
  3. `[Overall Funnel Conversion Rate %]`
  4. `[Offer Acceptance Rate %]` (Data bars enabled)
  5. `[Avg Time to Hire (Days)]` (Conditional color: Green `< 28`, Red `> 34`)
  6. `[Avg Candidate Experience Score (1-5)]` (Star rating / numeric)
- **Key Insight**: Provides HR leadership with operational visibility into individual recruiter throughput and candidate satisfaction.


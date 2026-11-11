# Dashboard Specification 01: Employee Attrition Intelligence

**Domain**: Human Capital & Workforce Analytics  
**Primary Dataset**: `IBM_HR_Employee_Attrition.csv`  
**Canvas Resolution**: 16:9 (1920 x 1080 px or 1280 x 720 px standard)  
**Theme**: Modern Clean Corporate (Slate Navy `#0F172A`, Accent Blue `#2563EB`, Danger Coral `#DC2626`, Success Mint `#10B981`)

---

## 1. Top Executive KPI Ribbon (Y: 0 to 140 px)

| Visual # | Visual Type | Card Title / Metric | Primary Measure | Secondary Callout / Sub-label | Conditional Formatting |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **KPI-01** | Modern Card (New) | **Total Headcount** | `[Total Employees]` | Active: `[Active Employees]` | Neutral Slate |
| **KPI-02** | Modern Card (New) | **Attrition Count** | `[Attrition Count]` | Total Departures | Dark Orange / Coral |
| **KPI-03** | Modern Card (New) | **Attrition Rate %** | `[Attrition Rate %]` | Target SLA: `< 12.0%` | Rule: `<12%` Green, `12-18%` Amber, `>18%` Red |
| **KPI-04** | Modern Card (New) | **Avg Tenure of Leavers** | `[Avg Tenure of Leavers]` | vs Active: `[Avg Tenure of Active Staff]` | Amber if `< 3.0 Years` |
| **KPI-05** | Modern Card (New) | **High Flight Risk Staff** | `[High Risk Flight Count]` | Overtime + Low Job Sat + Early Tenure | Red Badge |
| **KPI-06** | Modern Card (New) | **Annual Cost of Attrition** | `[Estimated Annual Cost of Attrition]` | Based on 1.5x Annualized Payroll | Currency USD Format |

---

## 2. Global Slicers & Filter Bar (Y: 150 to 220 px)

- **Slicer 1 (Dropdown)**: `Department` (All, Research & Development, Sales, Human Resources)
- **Slicer 2 (Pill / Buttons)**: `OverTime` (All, Yes, No)
- **Slicer 3 (Tile / Hierarchy)**: `JobLevel` (Level 1 to 5)
- **Slicer 4 (Dropdown)**: `BusinessTravel` (Non-Travel, Travel_Rarely, Travel_Frequently)

---

## 3. Core Visuals Grid (Y: 230 to 650 px)

### Visual 1: Attrition Rate by Department & Job Role
- **Type**: Clustered Bar Chart or Horizontal Bar Chart
- **Y-Axis**: `Department`, `JobRole` (Expandable Drill-down hierarchy)
- **X-Axis**: `[Attrition Rate %]`
- **Data Labels**: Enabled, formatted as `0.0%`
- **Data Bar Color**: Conditional formatting based on `[Attrition Rate %]` (Gradient from `#93C5FD` to `#DC2626`)
- **Key Insight**: Identifies whether turnover is concentrated in Sales Representatives or Laboratory Technicians.

### Visual 2: Attrition Rate by Tenure Band & Years at Company
- **Type**: Clustered Column & Line Chart
- **X-Axis**: `TenureBand` (Sorted by `TenureBandSort`)
- **Column Values**: `[Total Employees]` (Headcount volume)
- **Line Values**: `[Attrition Rate %]`
- **Secondary Y-Axis**: Percentage scale (0% to 50%)
- **Key Insight**: Highlights the "Cliff Effect" where employees in the `0-1 Years` and `2-3 Years` bands experience the highest churn rate.

### Visual 3: Attrition Distribution by Salary Band
- **Type**: 100% Stacked Bar Chart
- **Y-Axis**: `SalaryBand` (Sorted by `SalaryBandSort`: `< $3,000` to `$12,000+`)
- **X-Axis**: `[Total Employees]`
- **Legend**: `Attrition` ("Yes", "No")
- **Color Palette**: "No" -> Slate Grey (`#94A3B8`), "Yes" -> Vibrant Crimson (`#DC2626`)
- **Key Insight**: Directly proves the correlation between entry-level compensation bands and employee resignation volume.

---

## 4. Deep-Dive & Root-Cause Matrix (Y: 660 to 1040 px)

### Visual 4: Overtime vs. Work-Life Balance Matrix
- **Type**: Heatmap Matrix Visual
- **Rows**: `OverTime` ("Yes", "No")
- **Columns**: `WorkLifeBalance` (1: Bad, 2: Good, 3: Better, 4: Best)
- **Values**: `[Attrition Rate %]`
- **Background Conditional Formatting**: High values highlighted in deep red.
- **Key Insight**: Shows that employees working OverTime with Work-Life Balance rated 1 have attrition exceeding 38%.

### Visual 5: Decomposition Tree - AI Root Cause Path
- **Type**: Power BI Native Decomposition Tree
- **Analyze**: `[Attrition Count]`
- **Explain By**:
  1. `Department`
  2. `OverTime`
  3. `SalaryBand`
  4. `JobSatisfaction`
  5. `YearsSinceLastPromotion`
- **User Action**: Interactive tree allowing executives to click through AI-ranked high-attrition branches.

---

## 5. Tooltip Page Specification: `Tooltip_EmployeeProfile`

- **Canvas Size**: Tooltip (320 x 240 px)
- **Visuals Included**:
  - Mini KPI: `Avg Monthly Income`
  - Mini Gauge: `Avg Job Satisfaction` (Target: 3.5 / 4.0)
  - Distance Metric: `Avg DistanceFromHome`
  - Promotion Gap: `Avg YearsSinceLastPromotion`


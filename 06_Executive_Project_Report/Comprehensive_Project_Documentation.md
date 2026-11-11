# Multi-Domain Enterprise Power BI Suite: HR Analytics & Supply Chain Operations
## Executive Architecture, Data Engineering & Implementation Handbook

---

## 1. Executive Summary

This project delivers an enterprise-grade Business Intelligence solution across two mission-critical corporate domains:
1. **Human Capital Analytics**:
   - **Module 1: Employee Attrition Dashboard**: In-depth attrition diagnostics evaluated across departments, tenure bands, compensation tiers, and flight-risk behavioral indicators. Utilizes the industry-benchmark IBM HR Analytics framework.
   - **Module 2: Recruitment Funnel & Talent Acquisition**: Full-cycle recruitment pipeline tracking from candidate application, screening, and interview rounds to offer extension, offer acceptance, and time-to-hire velocity.
2. **Operations & Supply Chain Logistics**:
   - **Module 3: Inventory & Supplier Performance**: Dynamic stock monitoring, safety stock and reorder point alerts, carrying cost trends, supplier on-time in-full (OTIF) fulfillment, and lead time delay analysis.
   - **Module 4: Logistics & Fleet Tracking**: Multi-modal shipment tracking, route efficiency indices, on-time delivery (OTD) rates, transit duration benchmarks, delay root-cause decomposition, and carrier ESG carbon emission metrics.

---

## 2. Solution Directory Structure

The complete repository is organized according to enterprise Power BI development standards:

```
c:\Users\rajuv\OneDrive\Desktop\POWER BI\
├── 01_Data/
│   ├── HR_Analytics/
│   │   ├── IBM_HR_Employee_Attrition.csv       # 1,470 employee records (37 attributes)
│   │   └── HR_Recruitment_Funnel.csv           # 1,350 candidate applications (18 attributes)
│   └── Supply_Chain/
│       ├── Inventory_Supplier_Performance.csv  # 1,250 purchase orders & inventory items (23 attributes)
│       └── Logistics_Fleet_Tracking.csv        # 1,500 freight shipments & fleet legs (21 attributes)
├── 02_DAX_Measures/
│   ├── HR_Attrition_Measures.dax               # Headcount, Attrition Rate %, Cost of Attrition, Flight Risk
│   ├── HR_Recruitment_Measures.dax             # Funnel Stage Volumes, Conversion Rates %, Time-to-Hire SLA, Cost/Hire
│   ├── SC_Inventory_Supplier_Measures.dax      # Inventory Valuation, Stockout Alerts, OTIF %, DSI, Supplier Scorecard
│   ├── SC_Logistics_Tracking_Measures.dax      # Logistics OTD %, Route Efficiency %, Delay Hours, Carbon Footprint
│   └── Master_Date_Measures.dax                # MTD, QTD, YTD, MoM Growth %, Rolling 30-Day Windows
├── 03_Power_Query_M/
│   ├── Date_Dimension_Generator.m              # Dynamic enterprise calendar (Fiscal/Gregorian/Holidays)
│   ├── HR_Analytics_ETL.m                      # Power Query ETL pipelines for HR tables
│   └── Supply_Chain_ETL.m                      # Power Query ETL pipelines for SC tables
├── 04_Data_Model_Architecture/
│   ├── Data_Model_Diagram_and_Specs.md         # Star schema specs, cardinality rules, VertiPaq optimization
│   └── Star_Schema_Relationships.csv           # Tabular relationship registry
├── 05_Dashboard_Specifications/
│   ├── 01_HR_Employee_Attrition_Dashboard_Spec.md
│   ├── 02_HR_Recruitment_Funnel_Dashboard_Spec.md
│   ├── 03_SC_Inventory_Supplier_Dashboard_Spec.md
│   └── 04_SC_Logistics_Tracking_Dashboard_Spec.md
├── 06_Executive_Project_Report/
│   └── Comprehensive_Project_Documentation.md  # (This Master Manual)
└── 07_PowerBI_Theme/
    └── Corporate_Modern_Theme.json             # Modern executive UI theme for Power BI Desktop
```

---

## 3. Module Deep-Dive & Core Business Logic

### Module 1: Employee Attrition Diagnostics

#### Strategic Objectives
- Identify root causes of employee turnover before headcount loss affects business delivery.
- Quantify financial exposure from attrition and guide targeted retention programs.

#### Key Metrics & Formulas
- **Attrition Rate %**:
  $$\text{Attrition Rate} = \frac{\text{Exited Employees}}{\text{Total Headcount}}$$
- **Estimated Annual Cost of Attrition**:
  $$\text{Attrition Cost} = \sum (\text{Monthly Income of Leavers} \times 12) \times 1.5$$
- **High-Risk Flight Count**: Staff currently active who work overtime, have low job satisfaction ($\le 2$), and have tenure $\le 3$ years.

#### Core Analytical Insights
1. **Department Vulnerability**: Sales and R&D roles exhibit distinct attrition drivers. In Sales, turnover is heavily concentrated in entry-level Sales Representatives ($>30\%$ attrition rate) driven by commission structures and travel stress. In R&D, Laboratory Technicians experience higher churn due to lower compensation ceilings relative to market.
2. **Tenure "Cliff" (0-3 Years)**: More than $52\%$ of all exits occur within the first 3 years of employment. Employees surviving past year 5 demonstrate a retention rate of over $89\%$.
3. **Compensation & Overtime Interlocking Impact**: Employees earning $< \$3,000$ per month who work OverTime experience an attrition rate of nearly $40\%$, compared to $10.5\%$ for salaried employees earning $> \$8,000$ without overtime.

---

### Module 2: Recruitment Funnel & Talent Acquisition

#### Strategic Objectives
- Streamline candidate velocity through each hiring phase.
- Measure recruitment channel yield, cost-per-hire, and recruiter workload.

#### Key Metrics & Formulas
- **Stage-to-Stage Conversion Rates**:
  - Screening Conversion: $\text{Screened} / \text{Applied}$
  - Interview Conversion: $\text{Interviewed} / \text{Screened}$
  - Offer Acceptance Rate (OAR): $\text{Hires} / \text{Offers Extended}$
- **Average Time-to-Hire (TTH)**:
  $$\text{Avg TTH} = \frac{\sum (\text{Hire Date} - \text{Application Date})}{\text{Total Hired}}$$
- **Cost Per Hire**:
  $$\text{Cost Per Hire} = \frac{\text{Total Sourcing & Agency Spend}}{\text{Total Hired}}$$

#### Core Analytical Insights
1. **Funnel Velocity Bottleneck**: The greatest latency occurs between Screening and Initial Interview (average 8.4 days), indicating interviewer calendar congestion and slow feedback loops.
2. **Sourcing Channel ROI**:
   - *Employee Referrals*: Highest conversion rate ($16.4\%$), lowest time-to-hire (21.2 days), and highest 90-day retention rating.
   - *External Agencies*: Highest cost-per-hire ($\$3,850$) but critical for niche Senior R&D / Management roles.
   - *Job Boards (LinkedIn/Indeed)*: Generate high volume ($60\%$ of total applications) but lower screening pass rates ($<45\%$).

---

### Module 3: Inventory & Supplier Performance

#### Strategic Objectives
- Balance working capital with inventory availability.
- Enforce supplier SLA compliance regarding lead times, defect tolerances, and OTIF rates.

#### Key Metrics & Formulas
- **On-Time In-Full (OTIF) %**:
  $$\text{OTIF \%} = \frac{\text{Deliveries with Delay} \le 0 \text{ and Received Qty} \ge \text{Ordered Qty}}{\text{Total Purchase Orders}}$$
- **Days Sales of Inventory (DSI)**:
  $$\text{DSI} = \frac{365}{\text{Inventory Turnover Ratio}}$$
- **Annual Carrying Cost**:
  $$\text{Carrying Cost} = \text{Current Stock} \times \text{Unit Cost} \times 22\%$$

#### Core Analytical Insights
1. **Critical Stockout Risk Alerts**: Certain electronic component SKUs drop below safety stock thresholds due to supplier lead time variance.
2. **Supplier Scorecard Segmentation**:
   - *Top Tier Partners*: Suppliers like Apex MicroTech and Quantum Semiconductor maintain $>92\%$ OTD and $<0.4\%$ defect rates.
   - *High Risk Vendors*: Vendors with delivery delays exceeding 5 days trigger cascading stockout alerts in assembly warehouses.

---

### Module 4: Logistics & Fleet Tracking

#### Strategic Objectives
- Improve fleet dispatch predictability, transit time reliability, and multi-modal route directness.
- Reduce freight expenditure per ton-km and minimize carbon intensity.

#### Key Metrics & Formulas
- **Logistics On-Time Delivery (OTD %)**:
  $$\text{OTD \%} = \frac{\text{Shipments with Delay Hours} \le 0}{\text{Total Completed Shipments}}$$
- **Route Efficiency Index %**:
  $$\text{Efficiency \%} = \frac{\text{Optimal Direct Highway/Air Transit KM}}{\text{Actual Route KM Logged}}$$
- **Carbon Footprint**:
  $$\text{Total CO}_2 \text{ (Metric Tons)} = \frac{\sum \text{Fuel Consumed (L)} \times 2.68 \text{ kg CO}_2/\text{L}}{1,000}$$

#### Core Analytical Insights
1. **Transport Mode Comparison**:
   - *Air Freight*: Highest OTD ($93.5\%$) and fastest transit, but highest cost per KM ($\$5.10/km$) and high carbon footprint.
   - *Intermodal Rail*: Most cost-efficient for inland long-haul ($1.10/km$), but vulnerable to terminal switching delays.
   - *Road Truckload*: Core domestic network carrier; delays are primarily caused by interstate congestion and adverse weather.

---

## 4. Power BI Desktop Step-by-Step Implementation Guide

Follow these steps to build the dashboards in Power BI Desktop:

### Step 1: Ingest Data via Power Query
1. Launch **Power BI Desktop**.
2. Click **Get Data** -> **Text/CSV**.
3. Ingest the 4 CSV files located in:
   - `01_Data\HR_Analytics\IBM_HR_Employee_Attrition.csv`
   - `01_Data\HR_Analytics\HR_Recruitment_Funnel.csv`
   - `01_Data\Supply_Chain\Inventory_Supplier_Performance.csv`
   - `01_Data\Supply_Chain\Logistics_Fleet_Tracking.csv`
4. In the Power Query editor, create a blank query, open **Advanced Editor**, and paste the code from `03_Power_Query_M\Date_Dimension_Generator.m` to generate the `Dim_Date` table.
5. Click **Close & Apply**.

### Step 2: Establish Model Relationships
1. Open the **Model View** in Power BI.
2. Link the tables according to `04_Data_Model_Architecture\Star_Schema_Relationships.csv`:
   - `Dim_Date[Date]` $\xrightarrow{1:*}$ `Fact_HR_Recruitment_Funnel[ApplicationDate]` (Active)
   - `Dim_Date[Date]` $\xrightarrow{1:*}$ `Fact_Inventory_Supplier_Performance[Order_Date]` (Active)
   - `Dim_Date[Date]` $\xrightarrow{1:*}$ `Fact_Logistics_Fleet_Tracking[Dispatch_Date]` (Active)
3. Ensure cross-filter direction is set to **Single**.

### Step 3: Create DAX Measures
1. Create a dedicated measures table (or place measures inside their respective fact tables).
2. Copy and paste the DAX code from:
   - `02_DAX_Measures\HR_Attrition_Measures.dax`
   - `02_DAX_Measures\HR_Recruitment_Measures.dax`
   - `02_DAX_Measures\SC_Inventory_Supplier_Measures.dax`
   - `02_DAX_Measures\SC_Logistics_Tracking_Measures.dax`
   - `02_DAX_Measures\Master_Date_Measures.dax`

### Step 4: Apply Corporate UI Theme
1. In the Power BI ribbon, go to **View** -> **Themes** dropdown.
2. Click **Browse for themes...**
3. Select `07_PowerBI_Theme\Corporate_Modern_Theme.json`.

### Step 5: Construct Report Pages
1. Build Page 1 using `05_Dashboard_Specifications\01_HR_Employee_Attrition_Dashboard_Spec.md`.
2. Build Page 2 using `05_Dashboard_Specifications\02_HR_Recruitment_Funnel_Dashboard_Spec.md`.
3. Build Page 3 using `05_Dashboard_Specifications\03_SC_Inventory_Supplier_Dashboard_Spec.md`.
4. Build Page 4 using `05_Dashboard_Specifications\04_SC_Logistics_Tracking_Dashboard_Spec.md`.

---

## 5. Summary Table of Deliverables

| Deliverable Asset | File Location | Status |
| :--- | :--- | :--- |
| **IBM HR Attrition Dataset** | `01_Data/HR_Analytics/IBM_HR_Employee_Attrition.csv` | Ready (1,470 records) |
| **Recruitment Funnel Dataset** | `01_Data/HR_Analytics/HR_Recruitment_Funnel.csv` | Ready (1,350 records) |
| **Inventory & Supplier Dataset** | `01_Data/Supply_Chain/Inventory_Supplier_Performance.csv` | Ready (1,250 records) |
| **Logistics Tracking Dataset** | `01_Data/Supply_Chain/Logistics_Fleet_Tracking.csv` | Ready (1,500 records) |
| **DAX Measures Repositories** | `02_DAX_Measures/*.dax` (5 files) | Ready (60+ measures) |
| **Power Query M Pipelines** | `03_Power_Query_M/*.m` (3 files) | Ready (ETL scripts) |
| **Data Model Architecture** | `04_Data_Model_Architecture/*` (2 files) | Ready (Star Schema) |
| **Dashboard Layout Specs** | `05_Dashboard_Specifications/*.md` (4 files) | Ready (Wireframes) |
| **Power BI Visual Theme** | `07_PowerBI_Theme/Corporate_Modern_Theme.json` | Ready (JSON Theme) |
| **Executive Master Manual** | `06_Executive_Project_Report/Comprehensive_Project_Documentation.md` | Complete |


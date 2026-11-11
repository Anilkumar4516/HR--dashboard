# Dashboard Specification 04: Logistics & Fleet Tracking

**Domain**: Operations, Transportation & Logistics  
**Primary Dataset**: `Logistics_Fleet_Tracking.csv`  
**Canvas Resolution**: 16:9 (1920 x 1080 px or 1280 x 720 px standard)  
**Theme**: Modern Clean Corporate (Dark Steel `#1E293B`, Transport Blue `#0284C7`, Alert Crimson `#E11D48`, Efficiency Emerald `#059669`)

---

## 1. Top Executive KPI Ribbon (Y: 0 to 140 px)

| Visual # | Visual Type | Card Title / Metric | Primary Measure | Secondary Callout / Sub-label | Conditional Formatting |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **KPI-01** | Modern Card (New) | **Total Shipments Completed** | `[Total Shipments]` | Total KM: `[Total Distance Traveled KM]` | Steel Blue |
| **KPI-02** | Modern Card (New) | **On-Time Delivery Rate (OTD)** | `[Logistics On-Time Rate (OTD %)]` | Target SLA: `90.0%` | Rule: `>=90%` Green, `80-89%` Amber, `<80%` Red |
| **KPI-03** | Modern Card (New) | **Avg Delivery Transit Time** | `[Avg Transit Duration (Hours)]` | In Days: `[Avg Transit Duration (Days)]` | Slate Blue |
| **KPI-04** | Modern Card (New) | **Avg Transit Delay (Late Legs)** | `[Avg Delay on Late Shipments (Hours)]` | Severe (>24h): `[Severe Delay Rate %]` | Amber / Red |
| **KPI-05** | Modern Card (New) | **Route Efficiency Index** | `[Avg Route Efficiency %]` | Target SLA: `90.0%` | Green if `>= 90%`, Red if `< 85%` |
| **KPI-06** | Modern Card (New) | **Total Freight Spend & Cost/KM** | `[Total Freight Spend USD]` | Rate: `[Avg Freight Cost Per KM USD]` | Currency USD |

---

## 2. Global Slicers & Filter Bar (Y: 150 to 220 px)

- **Slicer 1 (Date Range Slider)**: `Dim_Date[Date]` linked to `Dispatch_Date`
- **Slicer 2 (Pill / Buttons)**: `Transport_Mode` (Road, Air Freight, Intermodal Rail, Ocean Freight)
- **Slicer 3 (Dropdown)**: `Carrier_Name` (SwiftFreight, Apex, BlueSky, TransContinental, etc.)
- **Slicer 4 (Dropdown)**: `Origin_City` & `Destination_City`
- **Slicer 5 (Buttons)**: `Delivery_Status` (On-Time, Minor Delay, Moderate Delay, Severe Delay)

---

## 3. Core Visuals Grid (Y: 230 to 650 px)

### Visual 1: On-Time Delivery Rate & Delay Trends Over Time
- **Type**: Clustered Column and Line Chart
- **X-Axis**: `Dim_Date[Year-Month]` (Chronological)
- **Column Values**: `[Total Shipments]` (Volume)
- **Line Values (Secondary Axis)**: `[Logistics On-Time Rate (OTD %)]`
- **Reference Line**: Target OTD at `90.0%` (Dashed Green Line)
- **Key Insight**: Monitors monthly fleet delivery consistency against executive service level agreements.

### Visual 2: Route Efficiency & Delay Analysis by Transport Lane
- **Type**: Scatter Plot / Bubble Matrix
- **X-Axis**: `[Avg Route Efficiency %]` (80% to 100%)
- **Y-Axis**: `[Avg Delay Time (Hours)]`
- **Size**: `[Total Shipments]`
- **Legend**: `Transport_Mode`
- **Details**: `Route_Lane` (e.g., `Chicago, IL -> Los Angeles, CA`)
- **Key Insight**: Identifies bottleneck freight corridors that suffer from persistent congestion and low direct-route efficiency.

### Visual 3: Root-Cause Decomposition of Transit Delays
- **Type**: Horizontal Bar Chart / Pareto Chart
- **Y-Axis**: `Delay_Reason` (excluding "None (On-Time)")
- **X-Axis**: Count of Shipments / Total Delay Hours
- **Bar Color**: Gradient from Amber (`#F59E0B`) to Dark Crimson (`#991B1B`)
- **Data Labels**: Enabled (Hours & Share % of Delay)
- **Key Insight**: Isolates the primary causes of delays (e.g. Weather, Port Congestion, Customs Border Holds, Mechanical Failure).

---

## 4. Deep-Dive & Carrier Scorecard Matrix (Y: 660 to 1040 px)

### Visual 4: Geographic Origin-Destination Volume Map
- **Type**: Azure Map / Filled Map / Flow Map
- **Location**: `Origin_City` and `Destination_City`
- **Bubble Size**: `[Total Shipments]`
- **Color Saturation**: `[Logistics On-Time Rate (OTD %)]` (Green = High OTD, Red = Bottleneck Origin)
- **Tooltips**: Distance KM, Avg Transit Hours, Total Freight Spend USD.
- **Key Insight**: Visualizes supply network nodes and regional delivery performance.

### Visual 5: Carrier Balanced Scorecard
- **Type**: Formatted Matrix Table
- **Rows**: `Carrier_Name`, `Transport_Mode`
- **Columns / Measures**:
  1. `[Total Shipments]`
  2. `[Logistics On-Time Rate (OTD %)]` (In-cell data bar with color stop at 90%)
  3. `[Avg Transit Duration (Hours)]`
  4. `[Avg Delay Time (Hours)]`
  5. `[Avg Route Efficiency %]`
  6. `[Avg Freight Cost Per KM USD]`
  7. `[Avg Customer Delivery Rating (1-5)]`
  8. `[Total CO2 Emissions (MT)]` (Sustainability indicator)
- **Key Insight**: Used for quarterly carrier contract re-negotiations, 3PL benchmarking, and routing optimization.


# Dashboard Specification 03: Inventory & Supplier Performance

**Domain**: Operations & Supply Chain Management  
**Primary Dataset**: `Inventory_Supplier_Performance.csv`  
**Canvas Resolution**: 16:9 (1920 x 1080 px or 1280 x 720 px standard)  
**Theme**: Modern Clean Corporate (Deep Teal `#0D9488`, Amber Gold `#F59E0B`, Rose Red `#E11D48`, Navy `#1E293B`)

---

## 1. Top Executive KPI Ribbon (Y: 0 to 140 px)

| Visual # | Visual Type | Card Title / Metric | Primary Measure | Secondary Callout / Sub-label | Conditional Formatting |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **KPI-01** | Modern Card (New) | **Total Inventory Valuation** | `[Total Current Inventory Value USD]` | Active SKUs: `[Total Active SKUs]` | Slate Teal |
| **KPI-02** | Modern Card (New) | **Stockout Risk SKUs** | `[Critical Stockout SKUs Count]` | Risk %: `[Stockout Risk %]` | Red Alert Badge if `> 5` |
| **KPI-03** | Modern Card (New) | **Supplier On-Time Delivery** | `[Supplier On-Time Delivery Rate (OTD %)]` | Target SLA: `> 85.0%` | Green `>85%`, Amber `75-85%`, Red `<75%` |
| **KPI-04** | Modern Card (New) | **Avg Supplier Delivery Delay** | `[Avg Delay for Late Orders (Days)]` | Max Delay: `[Max Delivery Delay Observed (Days)]` | Days (Amber/Red) |
| **KPI-05** | Modern Card (New) | **OTIF Fulfillment Rate** | `[OTIF Rate %]` | On-Time In-Full Standard | Green `> 80%` |
| **KPI-06** | Modern Card (New) | **Annual Carrying Cost** | `[Total Annual Carrying Cost USD]` | Avg Turnover: `[Avg Inventory Turnover Ratio]` | Currency USD |

---

## 2. Global Slicers & Filter Bar (Y: 150 to 220 px)

- **Slicer 1 (Date Range Slider)**: `Dim_Date[Date]` linked to `Order_Date`
- **Slicer 2 (Dropdown)**: `Product_Category` (Electronics, Raw Materials, Mechanical Parts, Packaging, Sub-Assemblies)
- **Slicer 3 (Dropdown)**: `Warehouse_Location` (WH-North, WH-South, WH-East, WH-West, WH-Central)
- **Slicer 4 (Buttons)**: `Stock_Status` (Healthy Stock, Reorder Required, Critical Stockout Risk, Overstocked)

---

## 3. Core Visuals Grid (Y: 230 to 650 px)

### Visual 1: Stock Level Health & Replenishment Monitor
- **Type**: Clustered Column Chart with Dual Thresholds
- **X-Axis**: `SKU_Code` (Top 25 SKUs by Spend or Filtered by Critical Stock)
- **Y-Axis**: `Current_Stock_Level`
- **Line 1 (Safety Stock Target)**: `Safety_Stock_Level` (Dashed Amber Line)
- **Line 2 (Reorder Point)**: `Reorder_Point` (Solid Red Line)
- **Data Colors**: Bars conditionally formatted Red if `Current_Stock < Safety_Stock`.
- **Key Insight**: Instant operational alert for warehouse procurement officers on which specific SKUs need PO release immediately.

### Visual 2: Supplier Delivery Delays & Lead Time Analysis
- **Type**: Clustered Bar Chart (Horizontal)
- **Y-Axis**: `Supplier_Name`
- **X-Axis**: `[Avg Delay for Late Orders (Days)]`
- **Tooltip Values**: `[Supplier On-Time Delivery Rate (OTD %)]`, `[Supplier Defect Rate %]`, `[Total Procurement Spend USD]`
- **Data Bar Color**: Red for suppliers with delays `> 5 Days`.
- **Key Insight**: Ranks chronic late suppliers (e.g. Titan Heavy Castings, NexGen Optical Sensors) versus top-tier performers.

### Visual 3: Procurement Unit Cost Trends & Spend Over Time
- **Type**: Line and Stacked Area Chart
- **X-Axis**: `Dim_Date[Year-Month]`
- **Column Values**: `[Total Procurement Spend USD]` by `Product_Category`
- **Line Values (Secondary Axis)**: `[Weighted Avg Unit Cost USD]`
- **Key Insight**: Tracks inflationary raw material cost spikes and category spend inflation across fiscal quarters.

---

## 4. Deep-Dive & Supplier Performance Scorecard (Y: 660 to 1040 px)

### Visual 4: Delivery Delay Distribution by Status
- **Type**: Donut / Pie Chart
- **Legend**: `Delivery_Status`
  - Early
  - On-Time
  - Minor Delay (1-3 Days)
  - Moderate Delay (4-7 Days)
  - Critical Delay (>7 Days)
- **Values**: Count of POs / `[Total Purchase Orders]`
- **Slice Colors**: Early/On-Time (`#10B981`), Minor (`#FBBF24`), Moderate (`#F97316`), Critical (`#EF4444`).
- **Key Insight**: Shows aggregate operational delivery reliability across the global supply base.

### Visual 5: Master Supplier Performance Scorecard
- **Type**: Matrix Visual with In-Cell Conditional Formatting
- **Rows**: `Supplier_Name`
- **Columns / Measures**:
  1. `[Total Purchase Orders]`
  2. `[Total Procurement Spend USD]` (Currency formatted)
  3. `[Supplier On-Time Delivery Rate (OTD %)]` (Data bar: Green to Red)
  4. `[Avg Delay for Late Orders (Days)]`
  5. `[Supplier Defect Rate %]` (Conditional formatting: Red if `> 1.5%`)
  6. `[OTIF Rate %]`
  7. `[Supplier Risk Score (0-100)]` (KPI Icon / Rating)
- **Key Insight**: Executive review grid used in quarterly business reviews (QBR) to negotiate vendor contracts.


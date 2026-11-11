# Power BI Multi-Domain Analytics Suite
## HR Analytics & Operations/Supply Chain Intelligence

Welcome to the **Power BI Multi-Domain Analytics Suite**. This repository contains a production-ready Business Intelligence project built according to enterprise data architecture standards and modern CI/CD deployment principles.

---

## 📌 Project Overview & Scope

This project covers four core dashboards across two major business domains:

### 1. Human Resources Analytics
- **Employee Attrition Dashboard**: Diagnostics on attrition by department, tenure bands, and salary bands using the benchmark **IBM HR Analytics** dataset schema. Evaluates overtime impact, flight-risk scores, and financial cost of attrition.
- **Recruitment Funnel & Velocity**: Multi-stage candidate conversion tracking (Applications $\rightarrow$ Screening $\rightarrow$ Interviews $\rightarrow$ Offers $\rightarrow$ Hires), time-to-hire velocity SLAs, sourcing channel ROI, and recruiter performance.

### 2. Operations & Supply Chain
- **Inventory & Supplier Performance**: Real-time stock valuation, safety stock alerts, critical stockouts, supplier delivery delays, on-time in-full (OTIF) fulfillment rates, and procurement unit cost trends.
- **Logistics & Fleet Tracking**: Multi-modal shipment tracking (Road, Air, Rail, Ocean), route efficiency indices, transit delay root-cause analysis, on-time delivery (OTD) rates, and carrier carbon emissions (ESG).

---

## 📂 Repository File Structure

| Folder / File | Purpose & Contents |
| :--- | :--- |
| **`Multi_Domain_Analytics.pbip`** | **Native Power BI Project** file (Opens directly in Power BI Desktop) |
| **`Multi_Domain_Analytics.Dataset/`** | Tabular Object Model (`model.bim`) with tables, columns, relationships & measures |
| **`Multi_Domain_Analytics.Report/`** | Layout configurations (`report.json`) defining the 4 pages, cards, and visuals |
| **`01_Data/HR_Analytics/`** | Contains `IBM_HR_Employee_Attrition.csv` (1,470 rows) & `HR_Recruitment_Funnel.csv` (1,350 rows) |
| **`01_Data/Supply_Chain/`** | Contains `Inventory_Supplier_Performance.csv` (1,250 rows) & `Logistics_Fleet_Tracking.csv` (1,500 rows) |
| **`02_DAX_Measures/`** | 60+ modular DAX measures formatted with comments, variables, and error handling |
| **`03_Power_Query_M/`** | Power Query M scripts for dynamic calendar (`Dim_Date`) and automated ETL workflows |
| **`04_Data_Model_Architecture/`** | Star-schema dimensional model diagrams, relationship registry (`*.csv`), and VertiPaq performance rules |
| **`05_Dashboard_Specifications/`** | Visual wireframes, layout grids, chart types, axis mappings, and conditional formatting rules |
| **`06_Executive_Project_Report/`** | Comprehensive project manual, business problem statement, and executive insights |
| **`07_PowerBI_Theme/`** | `Corporate_Modern_Theme.json` — Custom Power BI color palette and styling |
| **`08_Automation_Scripts/`** | Generator scripts for synthetic data and model schemas |
| **`09_Deployment/`** | **Enterprise Deployment Suite**: PowerShell script, CI/CD pipelines, RLS definitions, and deployment handbook |
| **`Executive_Interactive_Dashboard_Suite.html`** | Standalone interactive HTML dashboard for immediate browser viewing |

---

## 🚀 Quick Start Guide (Build in Power BI Desktop)

### Option 1: Direct Open via Power BI Project (Instant Setup)
Simply double-click [`Multi_Domain_Analytics.pbip`](file:///c:/Users/rajuv/OneDrive/Desktop/POWER%20BI/Multi_Domain_Analytics.pbip). Power BI Desktop will natively load the 4 report pages, all 4 datasets, the data model, and all pre-configured DAX measures.

### Option 2: Step-by-Step Power BI Desktop Workflow
1. **Load Data**: Click **Get Data** $\rightarrow$ **Text/CSV**, and select the CSV files in `01_Data/`.
2. **Add Dynamic Calendar Table**: In Power Query Editor (**Transform Data**), create a **Blank Query**, open **Advanced Editor**, and paste the content of `03_Power_Query_M/Date_Dimension_Generator.m`. Rename it `Dim_Date`.
3. **Establish Relationships**: In **Model View**, link `Dim_Date[Date]` to `ApplicationDate`, `Order_Date`, and `Dispatch_Date` as specified in `04_Data_Model_Architecture/Star_Schema_Relationships.csv`.
4. **Import Theme**: Go to **View** $\rightarrow$ **Themes** $\rightarrow$ **Browse for themes...** and select `07_PowerBI_Theme/Corporate_Modern_Theme.json`.
5. **Add DAX Measures**: Copy and paste the measures from `02_DAX_Measures/` into each table.

---

## ☁️ Enterprise Cloud Deployment & CI/CD Pipelines

A complete deployment framework is provided in [`09_Deployment/`](file:///c:/Users/rajuv/OneDrive/Desktop/POWER%20BI/09_Deployment/):

1. **PowerShell Automation Script**:
   - [`09_Deployment/Deploy_To_PowerBI_Service.ps1`](file:///c:/Users/rajuv/OneDrive/Desktop/POWER%20BI/09_Deployment/Deploy_To_PowerBI_Service.ps1)
   - Automates workspace provisioning (`[DEV]`, `[TEST]`, `[PROD]`), artifact publishing, scheduled refreshes, and gateway bindings.
2. **Row-Level Security (RLS)**:
   - [`09_Deployment/Row_Level_Security_Roles.dax`](file:///c:/Users/rajuv/OneDrive/Desktop/POWER%20BI/09_Deployment/Row_Level_Security_Roles.dax)
   - Implements dynamic security for `HR_Department_Head`, `Recruitment_Manager`, `Warehouse_Manager`, and `Carrier_Partner`.
3. **Automated CI/CD Workflows**:
   - **GitHub Actions**: `.github/workflows/deploy-powerbi-github-actions.yml`
   - **Azure DevOps Pipeline**: `09_Deployment/CI_CD_Pipelines/azure-pipelines.yml`
4. **Deployment Guide**:
   - [`09_Deployment/PowerBI_Enterprise_Deployment_Guide.md`](file:///c:/Users/rajuv/OneDrive/Desktop/POWER%20BI/09_Deployment/PowerBI_Enterprise_Deployment_Guide.md)

---

## 🌐 Instant Interactive Browser Preview
Double-click [`Executive_Interactive_Dashboard_Suite.html`](Executive_Interactive_Dashboard_Suite.html) to open the interactive executive preview in your browser. You can navigate between all 4 dashboards, review the KPI cards, hover over conversion funnels, and examine the supplier and carrier scorecards.

$model = @{
    name = "Multi_Domain_Analytics"
    compatibilityLevel = 1567
    model = @{
        culture = "en-US"
        dataAccessOptions = @{
            legacyRedirects = $true
            returnErrorValuesAsNull = $true
        }
        defaultPowerBIDataSourceVersion = "powerBI_V3"
        sourceQueryCulture = "en-US"
        tables = @(
            @{
                name = "IBM_HR_Employee_Attrition"
                columns = @(
                    @{ name = "EmployeeNumber"; dataType = "int64"; isHidden = $false; sourceColumn = "EmployeeNumber" },
                    @{ name = "Age"; dataType = "int64"; sourceColumn = "Age" },
                    @{ name = "Attrition"; dataType = "string"; sourceColumn = "Attrition" },
                    @{ name = "BusinessTravel"; dataType = "string"; sourceColumn = "BusinessTravel" },
                    @{ name = "DailyRate"; dataType = "int64"; sourceColumn = "DailyRate" },
                    @{ name = "Department"; dataType = "string"; sourceColumn = "Department" },
                    @{ name = "DistanceFromHome"; dataType = "int64"; sourceColumn = "DistanceFromHome" },
                    @{ name = "Education"; dataType = "int64"; sourceColumn = "Education" },
                    @{ name = "EducationField"; dataType = "string"; sourceColumn = "EducationField" },
                    @{ name = "EmployeeCount"; dataType = "int64"; sourceColumn = "EmployeeCount" },
                    @{ name = "EnvironmentSatisfaction"; dataType = "int64"; sourceColumn = "EnvironmentSatisfaction" },
                    @{ name = "Gender"; dataType = "string"; sourceColumn = "Gender" },
                    @{ name = "HourlyRate"; dataType = "int64"; sourceColumn = "HourlyRate" },
                    @{ name = "JobInvolvement"; dataType = "int64"; sourceColumn = "JobInvolvement" },
                    @{ name = "JobLevel"; dataType = "int64"; sourceColumn = "JobLevel" },
                    @{ name = "JobRole"; dataType = "string"; sourceColumn = "JobRole" },
                    @{ name = "JobSatisfaction"; dataType = "int64"; sourceColumn = "JobSatisfaction" },
                    @{ name = "MaritalStatus"; dataType = "string"; sourceColumn = "MaritalStatus" },
                    @{ name = "MonthlyIncome"; dataType = "decimal"; formatString = "\$#,0"; sourceColumn = "MonthlyIncome" },
                    @{ name = "MonthlyRate"; dataType = "int64"; sourceColumn = "MonthlyRate" },
                    @{ name = "NumCompaniesWorked"; dataType = "int64"; sourceColumn = "NumCompaniesWorked" },
                    @{ name = "Over18"; dataType = "string"; sourceColumn = "Over18" },
                    @{ name = "OverTime"; dataType = "string"; sourceColumn = "OverTime" },
                    @{ name = "PercentSalaryHike"; dataType = "int64"; sourceColumn = "PercentSalaryHike" },
                    @{ name = "PerformanceRating"; dataType = "int64"; sourceColumn = "PerformanceRating" },
                    @{ name = "RelationshipSatisfaction"; dataType = "int64"; sourceColumn = "RelationshipSatisfaction" },
                    @{ name = "StandardHours"; dataType = "int64"; sourceColumn = "StandardHours" },
                    @{ name = "StockOptionLevel"; dataType = "int64"; sourceColumn = "StockOptionLevel" },
                    @{ name = "TotalWorkingYears"; dataType = "int64"; sourceColumn = "TotalWorkingYears" },
                    @{ name = "TrainingTimesLastYear"; dataType = "int64"; sourceColumn = "TrainingTimesLastYear" },
                    @{ name = "WorkLifeBalance"; dataType = "int64"; sourceColumn = "WorkLifeBalance" },
                    @{ name = "YearsAtCompany"; dataType = "int64"; sourceColumn = "YearsAtCompany" },
                    @{ name = "YearsInCurrentRole"; dataType = "int64"; sourceColumn = "YearsInCurrentRole" },
                    @{ name = "YearsSinceLastPromotion"; dataType = "int64"; sourceColumn = "YearsSinceLastPromotion" },
                    @{ name = "YearsWithCurrManager"; dataType = "int64"; sourceColumn = "YearsWithCurrManager" },
                    @{ name = "SalaryBand"; dataType = "string"; sourceColumn = "SalaryBand" },
                    @{ name = "TenureBand"; dataType = "string"; sourceColumn = "TenureBand" }
                )
                partitions = @(
                    @{
                        name = "IBM_HR_Employee_Attrition-Partition"
                        mode = "import"
                        source = @{
                            type = "m"
                            expression = @(
                                "let",
                                "    Source = Csv.Document(File.Contents(""C:\Users\rajuv\OneDrive\Desktop\POWER BI\01_Data\HR_Analytics\IBM_HR_Employee_Attrition.csv""),[Delimiter="","", Columns=37, Encoding=65001, QuoteStyle=QuoteStyle.None]),",
                                "    Promoted = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),",
                                "    Typed = Table.TransformColumnTypes(Promoted,{{""EmployeeNumber"", Int64.Type}, {""Age"", Int64.Type}, {""Attrition"", type text}, {""Department"", type text}, {""JobRole"", type text}, {""MonthlyIncome"", Currency.Type}, {""YearsAtCompany"", Int64.Type}, {""OverTime"", type text}, {""SalaryBand"", type text}, {""TenureBand"", type text}})",
                                "in",
                                "    Typed"
                            )
                        }
                    }
                )
                measures = @(
                    @{ name = "Total Employees"; expression = "COUNTROWS('IBM_HR_Employee_Attrition')" },
                    @{ name = "Active Employees"; expression = "CALCULATE(COUNTROWS('IBM_HR_Employee_Attrition'), 'IBM_HR_Employee_Attrition'[Attrition] = ""No"")" },
                    @{ name = "Attrition Count"; expression = "CALCULATE(COUNTROWS('IBM_HR_Employee_Attrition'), 'IBM_HR_Employee_Attrition'[Attrition] = ""Yes"")" },
                    @{ name = "Attrition Rate %"; expression = "DIVIDE([Attrition Count], [Total Employees], 0)"; formatString = "0.0%" },
                    @{ name = "Retention Rate %"; expression = "1 - [Attrition Rate %]"; formatString = "0.0%" },
                    @{ name = "Avg Tenure of Leavers"; expression = "CALCULATE(AVERAGE('IBM_HR_Employee_Attrition'[YearsAtCompany]), 'IBM_HR_Employee_Attrition'[Attrition] = ""Yes"")"; formatString = "0.0" },
                    @{ name = "Avg Monthly Income"; expression = "AVERAGE('IBM_HR_Employee_Attrition'[MonthlyIncome])"; formatString = "\$#,0" },
                    @{ name = "High Risk Flight Count"; expression = "CALCULATE(COUNTROWS('IBM_HR_Employee_Attrition'), 'IBM_HR_Employee_Attrition'[Attrition] = ""No"", 'IBM_HR_Employee_Attrition'[OverTime] = ""Yes"", 'IBM_HR_Employee_Attrition'[JobSatisfaction] <= 2, 'IBM_HR_Employee_Attrition'[YearsAtCompany] <= 3)" },
                    @{ name = "Estimated Annual Cost of Attrition"; expression = "CALCULATE(SUM('IBM_HR_Employee_Attrition'[MonthlyIncome]) * 12, 'IBM_HR_Employee_Attrition'[Attrition] = ""Yes"") * 1.5"; formatString = "\$#,0" }
                )
            },
            @{
                name = "HR_Recruitment_Funnel"
                columns = @(
                    @{ name = "CandidateID"; dataType = "string"; sourceColumn = "CandidateID" },
                    @{ name = "CandidateName"; dataType = "string"; sourceColumn = "CandidateName" },
                    @{ name = "RequisitionID"; dataType = "string"; sourceColumn = "RequisitionID" },
                    @{ name = "Department"; dataType = "string"; sourceColumn = "Department" },
                    @{ name = "JobRole"; dataType = "string"; sourceColumn = "JobRole" },
                    @{ name = "ApplicationSource"; dataType = "string"; sourceColumn = "ApplicationSource" },
                    @{ name = "RecruiterName"; dataType = "string"; sourceColumn = "RecruiterName" },
                    @{ name = "ApplicationDate"; dataType = "dateTime"; sourceColumn = "ApplicationDate" },
                    @{ name = "ScreeningDate"; dataType = "dateTime"; sourceColumn = "ScreeningDate" },
                    @{ name = "InterviewDate"; dataType = "dateTime"; sourceColumn = "InterviewDate" },
                    @{ name = "OfferDate"; dataType = "dateTime"; sourceColumn = "OfferDate" },
                    @{ name = "HireDate"; dataType = "dateTime"; sourceColumn = "HireDate" },
                    @{ name = "StageReached"; dataType = "string"; sourceColumn = "StageReached" },
                    @{ name = "StageStatus"; dataType = "string"; sourceColumn = "StageStatus" },
                    @{ name = "TimeToOfferDays"; dataType = "int64"; sourceColumn = "TimeToOfferDays" },
                    @{ name = "TimeToHireDays"; dataType = "int64"; sourceColumn = "TimeToHireDays" },
                    @{ name = "OfferAccepted"; dataType = "string"; sourceColumn = "OfferAccepted" },
                    @{ name = "CandidateExperienceRating"; dataType = "int64"; sourceColumn = "CandidateExperienceRating" },
                    @{ name = "RecruitmentCostUSD"; dataType = "decimal"; formatString = "\$#,0"; sourceColumn = "RecruitmentCostUSD" }
                )
                partitions = @(
                    @{
                        name = "HR_Recruitment_Funnel-Partition"
                        mode = "import"
                        source = @{
                            type = "m"
                            expression = @(
                                "let",
                                "    Source = Csv.Document(File.Contents(""C:\Users\rajuv\OneDrive\Desktop\POWER BI\01_Data\HR_Analytics\HR_Recruitment_Funnel.csv""),[Delimiter="","", Columns=18, Encoding=65001, QuoteStyle=QuoteStyle.None]),",
                                "    Promoted = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),",
                                "    Typed = Table.TransformColumnTypes(Promoted,{{""CandidateID"", type text}, {""Department"", type text}, {""JobRole"", type text}, {""ApplicationSource"", type text}, {""RecruiterName"", type text}, {""ApplicationDate"", type date}, {""StageReached"", type text}, {""StageStatus"", type text}, {""TimeToHireDays"", Int64.Type}, {""RecruitmentCostUSD"", Currency.Type}})",
                                "in",
                                "    Typed"
                            )
                        }
                    }
                )
                measures = @(
                    @{ name = "Total Applications"; expression = "COUNTROWS('HR_Recruitment_Funnel')" },
                    @{ name = "Screened Count"; expression = "CALCULATE(COUNTROWS('HR_Recruitment_Funnel'), 'HR_Recruitment_Funnel'[StageReached] IN {""2. Screened"", ""3. Interviewed"", ""4. Offer Extended"", ""5. Hired""})" },
                    @{ name = "Interviewed Count"; expression = "CALCULATE(COUNTROWS('HR_Recruitment_Funnel'), 'HR_Recruitment_Funnel'[StageReached] IN {""3. Interviewed"", ""4. Offer Extended"", ""5. Hired""})" },
                    @{ name = "Offers Extended Count"; expression = "CALCULATE(COUNTROWS('HR_Recruitment_Funnel'), 'HR_Recruitment_Funnel'[StageReached] IN {""4. Offer Extended"", ""5. Hired""})" },
                    @{ name = "Total Hired"; expression = "CALCULATE(COUNTROWS('HR_Recruitment_Funnel'), 'HR_Recruitment_Funnel'[StageReached] = ""5. Hired"")" },
                    @{ name = "Screening Rate %"; expression = "DIVIDE([Screened Count], [Total Applications], 0)"; formatString = "0.0%" },
                    @{ name = "Interview Conversion Rate %"; expression = "DIVIDE([Interviewed Count], [Screened Count], 0)"; formatString = "0.0%" },
                    @{ name = "Offer Acceptance Rate %"; expression = "DIVIDE([Total Hired], [Offers Extended Count], 0)"; formatString = "0.0%" },
                    @{ name = "Overall Funnel Conversion Rate %"; expression = "DIVIDE([Total Hired], [Total Applications], 0)"; formatString = "0.0%" },
                    @{ name = "Avg Time to Hire (Days)"; expression = "CALCULATE(AVERAGE('HR_Recruitment_Funnel'[TimeToHireDays]), 'HR_Recruitment_Funnel'[StageStatus] = ""Hired"")"; formatString = "0.0" },
                    @{ name = "Cost Per Hire USD"; expression = "DIVIDE(SUM('HR_Recruitment_Funnel'[RecruitmentCostUSD]), [Total Hired], 0)"; formatString = "\$#,0" }
                )
            },
            @{
                name = "Inventory_Supplier_Performance"
                columns = @(
                    @{ name = "PO_Number"; dataType = "string"; sourceColumn = "PO_Number" },
                    @{ name = "SKU_Code"; dataType = "string"; sourceColumn = "SKU_Code" },
                    @{ name = "Product_Category"; dataType = "string"; sourceColumn = "Product_Category" },
                    @{ name = "Supplier_ID"; dataType = "string"; sourceColumn = "Supplier_ID" },
                    @{ name = "Supplier_Name"; dataType = "string"; sourceColumn = "Supplier_Name" },
                    @{ name = "Supplier_Rating"; dataType = "double"; sourceColumn = "Supplier_Rating" },
                    @{ name = "Warehouse_Location"; dataType = "string"; sourceColumn = "Warehouse_Location" },
                    @{ name = "Order_Date"; dataType = "dateTime"; sourceColumn = "Order_Date" },
                    @{ name = "Promised_Delivery_Date"; dataType = "dateTime"; sourceColumn = "Promised_Delivery_Date" },
                    @{ name = "Actual_Delivery_Date"; dataType = "dateTime"; sourceColumn = "Actual_Delivery_Date" },
                    @{ name = "Delivery_Delay_Days"; dataType = "int64"; sourceColumn = "Delivery_Delay_Days" },
                    @{ name = "Delivery_Status"; dataType = "string"; sourceColumn = "Delivery_Status" },
                    @{ name = "Order_Quantity"; dataType = "int64"; sourceColumn = "Order_Quantity" },
                    @{ name = "Received_Quantity"; dataType = "int64"; sourceColumn = "Received_Quantity" },
                    @{ name = "Defect_Quantity"; dataType = "int64"; sourceColumn = "Defect_Quantity" },
                    @{ name = "Unit_Cost_USD"; dataType = "decimal"; formatString = "\$#,0.00"; sourceColumn = "Unit_Cost_USD" },
                    @{ name = "Total_PO_Spend_USD"; dataType = "decimal"; formatString = "\$#,0"; sourceColumn = "Total_PO_Spend_USD" },
                    @{ name = "Current_Stock_Level"; dataType = "int64"; sourceColumn = "Current_Stock_Level" },
                    @{ name = "Safety_Stock_Level"; dataType = "int64"; sourceColumn = "Safety_Stock_Level" },
                    @{ name = "Reorder_Point"; dataType = "int64"; sourceColumn = "Reorder_Point" },
                    @{ name = "Stock_Status"; dataType = "string"; sourceColumn = "Stock_Status" },
                    @{ name = "Annual_Carrying_Cost_USD"; dataType = "decimal"; formatString = "\$#,0"; sourceColumn = "Annual_Carrying_Cost_USD" },
                    @{ name = "Inventory_Turnover_Ratio"; dataType = "double"; sourceColumn = "Inventory_Turnover_Ratio" }
                )
                partitions = @(
                    @{
                        name = "Inventory_Supplier_Performance-Partition"
                        mode = "import"
                        source = @{
                            type = "m"
                            expression = @(
                                "let",
                                "    Source = Csv.Document(File.Contents(""C:\Users\rajuv\OneDrive\Desktop\POWER BI\01_Data\Supply_Chain\Inventory_Supplier_Performance.csv""),[Delimiter="","", Columns=23, Encoding=65001, QuoteStyle=QuoteStyle.None]),",
                                "    Promoted = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),",
                                "    Typed = Table.TransformColumnTypes(Promoted,{{""PO_Number"", type text}, {""SKU_Code"", type text}, {""Product_Category"", type text}, {""Supplier_Name"", type text}, {""Order_Date"", type date}, {""Delivery_Delay_Days"", Int64.Type}, {""Stock_Status"", type text}, {""Total_PO_Spend_USD"", Currency.Type}, {""Current_Stock_Level"", Int64.Type}, {""Unit_Cost_USD"", Currency.Type}})",
                                "in",
                                "    Typed"
                            )
                        }
                    }
                )
                measures = @(
                    @{ name = "Total Active SKUs"; expression = "DISTINCTCOUNT('Inventory_Supplier_Performance'[SKU_Code])" },
                    @{ name = "Total Current Inventory Value USD"; expression = "SUMX('Inventory_Supplier_Performance', 'Inventory_Supplier_Performance'[Current_Stock_Level] * 'Inventory_Supplier_Performance'[Unit_Cost_USD])"; formatString = "\$#,0" },
                    @{ name = "Critical Stockout SKUs Count"; expression = "CALCULATE(DISTINCTCOUNT('Inventory_Supplier_Performance'[SKU_Code]), 'Inventory_Supplier_Performance'[Stock_Status] = ""Critical Stockout Risk"")" },
                    @{ name = "Supplier On-Time Delivery Rate (OTD %)"; expression = "DIVIDE(CALCULATE(COUNTROWS('Inventory_Supplier_Performance'), 'Inventory_Supplier_Performance'[Delivery_Delay_Days] <= 0), COUNTROWS('Inventory_Supplier_Performance'), 0)"; formatString = "0.0%" },
                    @{ name = "Avg Delay for Late Orders (Days)"; expression = "CALCULATE(AVERAGE('Inventory_Supplier_Performance'[Delivery_Delay_Days]), 'Inventory_Supplier_Performance'[Delivery_Delay_Days] > 0)"; formatString = "0.0" },
                    @{ name = "OTIF Rate %"; expression = "DIVIDE(CALCULATE(COUNTROWS('Inventory_Supplier_Performance'), 'Inventory_Supplier_Performance'[Delivery_Delay_Days] <= 0, 'Inventory_Supplier_Performance'[Received_Quantity] >= 'Inventory_Supplier_Performance'[Order_Quantity]), COUNTROWS('Inventory_Supplier_Performance'), 0)"; formatString = "0.0%" },
                    @{ name = "Total Annual Carrying Cost USD"; expression = "SUM('Inventory_Supplier_Performance'[Annual_Carrying_Cost_USD])"; formatString = "\$#,0" }
                )
            },
            @{
                name = "Logistics_Fleet_Tracking"
                columns = @(
                    @{ name = "Shipment_ID"; dataType = "string"; sourceColumn = "Shipment_ID" },
                    @{ name = "Carrier_ID"; dataType = "string"; sourceColumn = "Carrier_ID" },
                    @{ name = "Carrier_Name"; dataType = "string"; sourceColumn = "Carrier_Name" },
                    @{ name = "Transport_Mode"; dataType = "string"; sourceColumn = "Transport_Mode" },
                    @{ name = "Origin_City"; dataType = "string"; sourceColumn = "Origin_City" },
                    @{ name = "Destination_City"; dataType = "string"; sourceColumn = "Destination_City" },
                    @{ name = "Distance_KM"; dataType = "int64"; sourceColumn = "Distance_KM" },
                    @{ name = "Dispatch_Timestamp"; dataType = "dateTime"; sourceColumn = "Dispatch_Timestamp" },
                    @{ name = "Planned_Delivery_Timestamp"; dataType = "dateTime"; sourceColumn = "Planned_Delivery_Timestamp" },
                    @{ name = "Actual_Delivery_Timestamp"; dataType = "dateTime"; sourceColumn = "Actual_Delivery_Timestamp" },
                    @{ name = "Transit_Duration_Hours"; dataType = "double"; sourceColumn = "Transit_Duration_Hours" },
                    @{ name = "Delay_Hours"; dataType = "double"; sourceColumn = "Delay_Hours" },
                    @{ name = "On_Time_Flag"; dataType = "int64"; sourceColumn = "On_Time_Flag" },
                    @{ name = "Delivery_Status"; dataType = "string"; sourceColumn = "Delivery_Status" },
                    @{ name = "Delay_Reason"; dataType = "string"; sourceColumn = "Delay_Reason" },
                    @{ name = "Route_Efficiency_Index_Pct"; dataType = "double"; sourceColumn = "Route_Efficiency_Index_Pct" },
                    @{ name = "Fuel_Consumption_Liters"; dataType = "double"; sourceColumn = "Fuel_Consumption_Liters" },
                    @{ name = "CO2_Emissions_KG"; dataType = "double"; sourceColumn = "CO2_Emissions_KG" },
                    @{ name = "Freight_Cost_USD"; dataType = "decimal"; formatString = "\$#,0"; sourceColumn = "Freight_Cost_USD" },
                    @{ name = "Cost_Per_KM_USD"; dataType = "decimal"; formatString = "\$#,0.00"; sourceColumn = "Cost_Per_KM_USD" },
                    @{ name = "Customer_Satisfaction_Score"; dataType = "int64"; sourceColumn = "Customer_Satisfaction_Score" }
                )
                partitions = @(
                    @{
                        name = "Logistics_Fleet_Tracking-Partition"
                        mode = "import"
                        source = @{
                            type = "m"
                            expression = @(
                                "let",
                                "    Source = Csv.Document(File.Contents(""C:\Users\rajuv\OneDrive\Desktop\POWER BI\01_Data\Supply_Chain\Logistics_Fleet_Tracking.csv""),[Delimiter="","", Columns=21, Encoding=65001, QuoteStyle=QuoteStyle.None]),",
                                "    Promoted = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),",
                                "    Typed = Table.TransformColumnTypes(Promoted,{{""Shipment_ID"", type text}, {""Carrier_Name"", type text}, {""Transport_Mode"", type text}, {""Distance_KM"", Int64.Type}, {""Transit_Duration_Hours"", type number}, {""Delay_Hours"", type number}, {""On_Time_Flag"", Int64.Type}, {""Freight_Cost_USD"", Currency.Type}, {""Customer_Satisfaction_Score"", Int64.Type}})",
                                "in",
                                "    Typed"
                            )
                        }
                    }
                )
                measures = @(
                    @{ name = "Total Shipments"; expression = "COUNTROWS('Logistics_Fleet_Tracking')" },
                    @{ name = "Logistics On-Time Rate (OTD %)"; expression = "DIVIDE(CALCULATE(COUNTROWS('Logistics_Fleet_Tracking'), 'Logistics_Fleet_Tracking'[On_Time_Flag] = 1), COUNTROWS('Logistics_Fleet_Tracking'), 0)"; formatString = "0.0%" },
                    @{ name = "Avg Transit Duration (Hours)"; expression = "AVERAGE('Logistics_Fleet_Tracking'[Transit_Duration_Hours])"; formatString = "0.0" },
                    @{ name = "Avg Route Efficiency %"; expression = "AVERAGE('Logistics_Fleet_Tracking'[Route_Efficiency_Index_Pct]) / 100"; formatString = "0.0%" },
                    @{ name = "Avg Freight Cost Per KM USD"; expression = "DIVIDE(SUM('Logistics_Fleet_Tracking'[Freight_Cost_USD]), SUM('Logistics_Fleet_Tracking'[Distance_KM]), 0)"; formatString = "\$#,0.00" },
                    @{ name = "Total CO2 Emissions (MT)"; expression = "DIVIDE(SUM('Logistics_Fleet_Tracking'[CO2_Emissions_KG]), 1000, 0)"; formatString = "#,0" }
                )
            }
        )
    }
}

$modelJson = $model | ConvertTo-Json -Depth 10
Set-Content -Path "Multi_Domain_Analytics.Dataset\model.bim" -Value $modelJson -Encoding UTF8
Write-Host "Created Multi_Domain_Analytics.Dataset\model.bim successfully."

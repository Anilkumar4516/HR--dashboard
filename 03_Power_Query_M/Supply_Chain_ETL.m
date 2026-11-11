// ===============================================================================
// POWER QUERY (M) SCRIPTS: SUPPLY CHAIN & LOGISTICS ETL PIPELINE
// Author: Power BI Solution Architecture
// ===============================================================================

// -------------------------------------------------------------------------------
// QUERY 1: Fact_Inventory_Supplier_Performance
// -------------------------------------------------------------------------------

let
    // 1. Ingest Data from CSV
    Source = Csv.Document(
        File.Contents("C:\Users\rajuv\OneDrive\Desktop\POWER BI\01_Data\Supply_Chain\Inventory_Supplier_Performance.csv"),
        [Delimiter=",", Columns=21, Encoding=65001, QuoteStyle=QuoteStyle.None]
    ),
    PromotedHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    
    // 2. Set Strict Data Types
    TypedData = Table.TransformColumnTypes(PromotedHeaders, {
        {"PO_Number", type text},
        {"SKU_Code", type text},
        {"Product_Category", type text},
        {"Supplier_ID", type text},
        {"Supplier_Name", type text},
        {"Supplier_Rating", type number},
        {"Warehouse_Location", type text},
        {"Order_Date", type date},
        {"Promised_Delivery_Date", type date},
        {"Actual_Delivery_Date", type date},
        {"Delivery_Delay_Days", Int64.Type},
        {"Delivery_Status", type text},
        {"Order_Quantity", Int64.Type},
        {"Received_Quantity", Int64.Type},
        {"Defect_Quantity", Int64.Type},
        {"Unit_Cost_USD", Currency.Type},
        {"Total_PO_Spend_USD", Currency.Type},
        {"Current_Stock_Level", Int64.Type},
        {"Safety_Stock_Level", Int64.Type},
        {"Reorder_Point", Int64.Type},
        {"Stock_Status", type text},
        {"Annual_Carrying_Cost_USD", Currency.Type},
        {"Inventory_Turnover_Ratio", type number}
    }),
    
    // 3. Add On-Time Delivery Flag
    AddOnTimeFlag = Table.AddColumn(TypedData, "Is_OnTime_Delivery", each if [Delivery_Delay_Days] <= 0 then 1 else 0, Int64.Type),
    
    // 4. Add In-Full Fulfillment Flag
    AddInFullFlag = Table.AddColumn(AddOnTimeFlag, "Is_InFull", each if [Received_Quantity] >= [Order_Quantity] then 1 else 0, Int64.Type),
    
    // 5. Add OTIF Flag (On-Time In-Full)
    AddOTIFFlag = Table.AddColumn(AddInFullFlag, "Is_OTIF", each if [Is_OnTime_Delivery] = 1 and [Is_InFull] = 1 then 1 else 0, Int64.Type)
in
    AddOTIFFlag



// -------------------------------------------------------------------------------
// QUERY 2: Fact_Logistics_Fleet_Tracking
// -------------------------------------------------------------------------------

let
    // 1. Ingest Data from CSV
    Source = Csv.Document(
        File.Contents("C:\Users\rajuv\OneDrive\Desktop\POWER BI\01_Data\Supply_Chain\Logistics_Fleet_Tracking.csv"),
        [Delimiter=",", Columns=20, Encoding=65001, QuoteStyle=QuoteStyle.None]
    ),
    PromotedHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    
    // 2. Set Strict Data Types
    TypedData = Table.TransformColumnTypes(PromotedHeaders, {
        {"Shipment_ID", type text},
        {"Carrier_ID", type text},
        {"Carrier_Name", type text},
        {"Transport_Mode", type text},
        {"Origin_City", type text},
        {"Destination_City", type text},
        {"Distance_KM", Int64.Type},
        {"Dispatch_Timestamp", type datetime},
        {"Planned_Delivery_Timestamp", type datetime},
        {"Actual_Delivery_Timestamp", type datetime},
        {"Transit_Duration_Hours", type number},
        {"Delay_Hours", type number},
        {"On_Time_Flag", Int64.Type},
        {"Delivery_Status", type text},
        {"Delay_Reason", type text},
        {"Route_Efficiency_Index_Pct", type number},
        {"Fuel_Consumption_Liters", type number},
        {"CO2_Emissions_KG", type number},
        {"Freight_Cost_USD", Currency.Type},
        {"Cost_Per_KM_USD", Currency.Type},
        {"Customer_Satisfaction_Score", Int64.Type}
    }),
    
    // 3. Extract Date Keys for Calendar Relationships
    AddDispatchDate = Table.AddColumn(TypedData, "Dispatch_Date", each DateTime.Date([Dispatch_Timestamp]), type date),
    AddActualDeliveryDate = Table.AddColumn(AddDispatchDate, "Actual_Delivery_Date", each DateTime.Date([Actual_Delivery_Timestamp]), type date),
    
    // 4. Add Route Lane Descriptor
    AddRouteLane = Table.AddColumn(AddActualDeliveryDate, "Route_Lane", each [Origin_City] & " -> " & [Destination_City], type text),
    
    // 5. Add Severely Delayed Flag (>24h delay)
    AddSevereDelayFlag = Table.AddColumn(AddRouteLane, "Is_Severe_Delay", each if [Delay_Hours] > 24 then 1 else 0, Int64.Type)
in
    AddSevereDelayFlag


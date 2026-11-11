// ===============================================================================
// POWER QUERY (M) SCRIPT: DYNAMIC DATE / CALENDAR DIMENSION TABLE
// Query Name: Dim_Date
// Description: Generates a complete enterprise calendar with Gregorian and Fiscal
// periods, day attributes, and custom sorting columns for Power BI.
// ===============================================================================

let
    // Configure date bounds (can be parameterized or auto-expanded)
    StartDate = #date(2024, 1, 1),
    EndDate = #date(2024, 12, 31),
    
    // Generate sequential list of dates
    DayCount = Duration.Days(Duration.From(EndDate - StartDate)) + 1,
    Source = List.Dates(StartDate, DayCount, #duration(1, 0, 0, 0)),
    TableFromList = Table.FromList(Source, Splitter.SplitByNothing(), {"Date"}, null, ExtraValues.Error),
    ChangedType = Table.TransformColumnTypes(TableFromList, {{"Date", type date}}),
    
    // Add Calendar Attributes
    AddYear = Table.AddColumn(ChangedType, "Year", each Date.Year([Date]), Int64.Type),
    AddMonthNum = Table.AddColumn(AddYear, "Month Number", each Date.Month([Date]), Int64.Type),
    AddMonthName = Table.AddColumn(AddMonthNum, "Month Name", each Date.MonthName([Date]), type text),
    AddMonthShort = Table.AddColumn(AddMonthName, "Month Short", each Text.Start([Month Name], 3), type text),
    AddYearMonthKey = Table.AddColumn(AddMonthShort, "YearMonthKey", each [Year] * 100 + [Month Number], Int64.Type),
    AddYearMonth = Table.AddColumn(AddYearMonthKey, "Year-Month", each [Month Short] & " " & Text.From([Year]), type text),
    
    // Quarters
    AddQuarterNum = Table.AddColumn(AddYearMonth, "Quarter Number", each Date.QuarterOfYear([Date]), Int64.Type),
    AddQuarter = Table.AddColumn(AddQuarterNum, "Quarter", each "Q" & Text.From([Quarter Number]), type text),
    AddYearQuarter = Table.AddColumn(AddQuarter, "Year-Quarter", each Text.From([Year]) & " Q" & Text.From([Quarter Number]), type text),
    
    // Weeks & Days
    AddDayOfMonth = Table.AddColumn(AddYearQuarter, "Day of Month", each Date.Day([Date]), Int64.Type),
    AddDayOfWeek = Table.AddColumn(AddDayOfMonth, "Day of Week Number", each Date.DayOfWeek([Date], Day.Monday) + 1, Int64.Type),
    AddDayName = Table.AddColumn(AddDayOfWeek, "Day Name", each Date.DayOfWeekName([Date]), type text),
    AddDayShort = Table.AddColumn(AddDayName, "Day Short", each Text.Start([Day Name], 3), type text),
    AddWeekOfYear = Table.AddColumn(AddDayShort, "Week of Year", each Date.WeekOfYear([Date]), Int64.Type),
    
    // Business Day Flags
    AddIsWeekend = Table.AddColumn(AddWeekOfYear, "IsWeekend", each if [Day of Week Number] >= 6 then true else false, type logical),
    AddIsWorkingDay = Table.AddColumn(AddIsWeekend, "IsWorkingDay", each if [IsWeekend] = false then true else false, type logical),
    
    // Fiscal Year & Quarter (Assuming Fiscal Year starts July 1st; easily customizable)
    AddFiscalMonth = Table.AddColumn(AddIsWorkingDay, "Fiscal Month Number", each if [Month Number] >= 7 then [Month Number] - 6 else [Month Number] + 6, Int64.Type),
    AddFiscalYear = Table.AddColumn(AddFiscalMonth, "Fiscal Year", each if [Month Number] >= 7 then "FY" & Text.End(Text.From([Year] + 1), 2) else "FY" & Text.End(Text.From([Year]), 2), type text),
    AddFiscalQuarter = Table.AddColumn(AddFiscalYear, "Fiscal Quarter", each "FQ" & Text.From(Number.RoundUp([Fiscal Month Number] / 3)), type text)
in
    AddFiscalQuarter


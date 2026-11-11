// ===============================================================================
// POWER QUERY (M) SCRIPTS: HR ANALYTICS ETL PIPELINE
// Author: Power BI Solution Architecture
// ===============================================================================

// -------------------------------------------------------------------------------
// QUERY 1: Fact_HR_Employee_Attrition
// -------------------------------------------------------------------------------
// Instructions: In Power BI Desktop -> Home -> Transform Data -> Advanced Editor
// Replace the script below with your file path if needed.

let
    // 1. Ingest Data from CSV
    Source = Csv.Document(
        File.Contents("C:\Users\rajuv\OneDrive\Desktop\POWER BI\01_Data\HR_Analytics\IBM_HR_Employee_Attrition.csv"),
        [Delimiter=",", Columns=37, Encoding=65001, QuoteStyle=QuoteStyle.None]
    ),
    PromotedHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    
    // 2. Set Strict Data Types
    TypedData = Table.TransformColumnTypes(PromotedHeaders, {
        {"EmployeeNumber", Int64.Type},
        {"Age", Int64.Type},
        {"Attrition", type text},
        {"BusinessTravel", type text},
        {"DailyRate", Int64.Type},
        {"Department", type text},
        {"DistanceFromHome", Int64.Type},
        {"Education", Int64.Type},
        {"EducationField", type text},
        {"EmployeeCount", Int64.Type},
        {"EnvironmentSatisfaction", Int64.Type},
        {"Gender", type text},
        {"HourlyRate", Int64.Type},
        {"JobInvolvement", Int64.Type},
        {"JobLevel", Int64.Type},
        {"JobRole", type text},
        {"JobSatisfaction", Int64.Type},
        {"MaritalStatus", type text},
        {"MonthlyIncome", Currency.Type},
        {"MonthlyRate", Int64.Type},
        {"NumCompaniesWorked", Int64.Type},
        {"Over18", type text},
        {"OverTime", type text},
        {"PercentSalaryHike", Int64.Type},
        {"PerformanceRating", Int64.Type},
        {"RelationshipSatisfaction", Int64.Type},
        {"StandardHours", Int64.Type},
        {"StockOptionLevel", Int64.Type},
        {"TotalWorkingYears", Int64.Type},
        {"TrainingTimesLastYear", Int64.Type},
        {"WorkLifeBalance", Int64.Type},
        {"YearsAtCompany", Int64.Type},
        {"YearsInCurrentRole", Int64.Type},
        {"YearsSinceLastPromotion", Int64.Type},
        {"YearsWithCurrManager", Int64.Type},
        {"SalaryBand", type text},
        {"TenureBand", type text}
    }),
    
    // 3. Add Attrition Numeric Flag (for high-speed aggregation)
    AddAttritionFlag = Table.AddColumn(TypedData, "AttritionFlag", each if [Attrition] = "Yes" then 1 else 0, Int64.Type),
    
    // 4. Add Salary Band Sort Index (to preserve visual order)
    AddSalaryBandSort = Table.AddColumn(AddAttritionFlag, "SalaryBandSort", each 
        if [SalaryBand] = "< $3,000" then 1
        else if [SalaryBand] = "$3,000 - $4,999" then 2
        else if [SalaryBand] = "$5,000 - $7,999" then 3
        else if [SalaryBand] = "$8,000 - $11,999" then 4
        else 5, Int64.Type),
        
    // 5. Add Tenure Band Sort Index
    AddTenureBandSort = Table.AddColumn(AddSalaryBandSort, "TenureBandSort", each
        if [TenureBand] = "0-1 Years (New Hire)" then 1
        else if [TenureBand] = "2-3 Years (Early)" then 2
        else if [TenureBand] = "4-6 Years (Mid-Tenure)" then 3
        else if [TenureBand] = "7-10 Years (Senior)" then 4
        else 5, Int64.Type)
in
    AddTenureBandSort



// -------------------------------------------------------------------------------
// QUERY 2: Fact_HR_Recruitment_Funnel
// -------------------------------------------------------------------------------

let
    // 1. Ingest Data from CSV
    Source = Csv.Document(
        File.Contents("C:\Users\rajuv\OneDrive\Desktop\POWER BI\01_Data\HR_Analytics\HR_Recruitment_Funnel.csv"),
        [Delimiter=",", Columns=18, Encoding=65001, QuoteStyle=QuoteStyle.None]
    ),
    PromotedHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    
    // 2. Set Strict Data Types
    TypedData = Table.TransformColumnTypes(PromotedHeaders, {
        {"CandidateID", type text},
        {"CandidateName", type text},
        {"RequisitionID", type text},
        {"Department", type text},
        {"JobRole", type text},
        {"ApplicationSource", type text},
        {"RecruiterName", type text},
        {"ApplicationDate", type date},
        {"ScreeningDate", type date},
        {"InterviewDate", type date},
        {"OfferDate", type date},
        {"HireDate", type date},
        {"StageReached", type text},
        {"StageStatus", type text},
        {"TimeToOfferDays", Int64.Type},
        {"TimeToHireDays", Int64.Type},
        {"OfferAccepted", type text},
        {"CandidateExperienceRating", Int64.Type},
        {"RecruitmentCostUSD", Currency.Type}
    }),
    
    // 3. Add Funnel Stage Sort Index (Ensures correct visual funnel ordering)
    AddStageSort = Table.AddColumn(TypedData, "StageSortIndex", each
        if [StageReached] = "1. Applied" then 1
        else if [StageReached] = "2. Screened" then 2
        else if [StageReached] = "3. Interviewed" then 3
        else if [StageReached] = "4. Offer Extended" then 4
        else if [StageReached] = "5. Hired" then 5
        else 6, Int64.Type),
        
    // 4. Add Candidate Hired Flag
    AddHiredFlag = Table.AddColumn(AddStageSort, "IsHired", each if [StageStatus] = "Hired" then 1 else 0, Int64.Type)
in
    AddHiredFlag


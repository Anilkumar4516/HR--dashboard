# Generate Data for Power BI Project
$random = New-Object System.Random(42)

# ==========================================
# 1. IBM HR EMPLOYEE ATTRITION DATASET
# ==========================================
Write-Host "Generating 1. IBM HR Employee Attrition..."
$departments = @("Research & Development", "Sales", "Human Resources")
$rolesByDept = @{
    "Research & Development" = @("Research Scientist", "Laboratory Technician", "Manufacturing Director", "Healthcare Representative", "Research Director", "Manager")
    "Sales" = @("Sales Executive", "Sales Representative", "Manager")
    "Human Resources" = @("Human Resources", "Manager")
}
$eduFields = @("Life Sciences", "Medical", "Marketing", "Technical Degree", "Human Resources", "Other")
$maritalStatuses = @("Single", "Married", "Divorced")
$travelTypes = @("Travel_Rarely", "Travel_Frequently", "Non-Travel")

$hrRecords = [System.Collections.Generic.List[PSObject]]::new()

for ($i = 1; $i -le 1470; $i++) {
    $age = $random.Next(20, 60)
    $gender = if ($random.NextDouble() -lt 0.60) { "Male" } else { "Female" }
    
    $dept = if ($random.NextDouble() -lt 0.65) { "Research & Development" } elseif ($random.NextDouble() -lt 0.85) { "Sales" } else { "Human Resources" }
    $roleList = $rolesByDept[$dept]
    $role = $roleList[$random.Next(0, $roleList.Length)]
    
    $jobLevel = switch ($role) {
        "Sales Representative" { 1 }
        "Laboratory Technician" { 1 }
        "Research Scientist" { if ($random.NextDouble() -lt 0.7) { 1 } else { 2 } }
        "Human Resources" { if ($random.NextDouble() -lt 0.6) { 1 } else { 2 } }
        "Sales Executive" { if ($random.NextDouble() -lt 0.5) { 2 } else { 3 } }
        "Healthcare Representative" { if ($random.NextDouble() -lt 0.4) { 2 } else { 3 } }
        "Manufacturing Director" { if ($random.NextDouble() -lt 0.5) { 2 } else { 3 } }
        "Research Director" { if ($random.NextDouble() -lt 0.6) { 4 } else { 5 } }
        "Manager" { if ($random.NextDouble() -lt 0.5) { 4 } else { 5 } }
        Default { 2 }
    }
    
    $baseIncome = switch ($jobLevel) {
        1 { $random.Next(2200, 3900) }
        2 { $random.Next(4000, 6800) }
        3 { $random.Next(7000, 11500) }
        4 { $random.Next(12000, 16500) }
        5 { $random.Next(17000, 19999) }
    }
    
    $monthlyIncome = $baseIncome
    $totalWorkingYears = [Math]::Max(1, [Math]::Min($age - 18, $jobLevel * 3 + $random.Next(1, 8)))
    $yearsAtCompany = [Math]::Min($totalWorkingYears, $random.Next(0, [Math]::Max(1, $totalWorkingYears - 1)))
    $yearsInCurrentRole = [Math]::Min($yearsAtCompany, $random.Next(0, [Math]::Max(1, [int]($yearsAtCompany * 0.8) + 1)))
    $yearsSinceLastPromotion = [Math]::Min($yearsInCurrentRole, $random.Next(0, [Math]::Max(1, [int]($yearsInCurrentRole * 0.6) + 1)))
    $yearsWithCurrManager = [Math]::Min($yearsInCurrentRole, $random.Next(0, [Math]::Max(1, $yearsInCurrentRole + 1)))
    
    $overTime = if ($random.NextDouble() -lt 0.28) { "Yes" } else { "No" }
    $businessTravel = if ($random.NextDouble() -lt 0.71) { "Travel_Rarely" } elseif ($random.NextDouble() -lt 0.65) { "Travel_Frequently" } else { "Non-Travel" }
    
    # Calculate Attrition probability based on realistic risk factors
    $attritionRisk = 0.08
    if ($overTime -eq "Yes") { $attritionRisk += 0.16 }
    if ($businessTravel -eq "Travel_Frequently") { $attritionRisk += 0.08 }
    if ($jobLevel -eq 1) { $attritionRisk += 0.10 }
    if ($yearsAtCompany -le 2) { $attritionRisk += 0.10 }
    if ($yearsSinceLastPromotion -ge 4) { $attritionRisk += 0.06 }
    if ($baseIncome -lt 3500) { $attritionRisk += 0.07 }
    
    $attrition = if ($random.NextDouble() -lt $attritionRisk) { "Yes" } else { "No" }
    
    # Salary Band helper
    $salaryBand = if ($monthlyIncome -lt 3000) { "< $3,000" } `
                  elseif ($monthlyIncome -lt 5000) { "$3,000 - $4,999" } `
                  elseif ($monthlyIncome -lt 8000) { "$5,000 - $7,999" } `
                  elseif ($monthlyIncome -lt 12000) { "$8,000 - $11,999" } `
                  else { "$12,000+" }
                  
    # Tenure Band helper
    $tenureBand = if ($yearsAtCompany -le 1) { "0-1 Years (New Hire)" } `
                  elseif ($yearsAtCompany -le 3) { "2-3 Years (Early)" } `
                  elseif ($yearsAtCompany -le 6) { "4-6 Years (Mid-Tenure)" } `
                  elseif ($yearsAtCompany -le 10) { "7-10 Years (Senior)" } `
                  else { "10+ Years (Veteran)" }

    $rec = [PSCustomObject]@{
        EmployeeNumber = $i
        Age = $age
        Attrition = $attrition
        BusinessTravel = $businessTravel
        DailyRate = $random.Next(102, 1499)
        Department = $dept
        DistanceFromHome = $random.Next(1, 30)
        Education = $random.Next(1, 6)
        EducationField = $eduFields[$random.Next(0, $eduFields.Length)]
        EmployeeCount = 1
        EnvironmentSatisfaction = $random.Next(1, 5)
        Gender = $gender
        HourlyRate = $random.Next(30, 101)
        JobInvolvement = $random.Next(1, 5)
        JobLevel = $jobLevel
        JobRole = $role
        JobSatisfaction = $random.Next(1, 5)
        MaritalStatus = $maritalStatuses[$random.Next(0, $maritalStatuses.Length)]
        MonthlyIncome = $monthlyIncome
        MonthlyRate = $random.Next(2094, 26999)
        NumCompaniesWorked = $random.Next(0, 10)
        Over18 = "Y"
        OverTime = $overTime
        PercentSalaryHike = $random.Next(11, 26)
        PerformanceRating = if ($random.NextDouble() -lt 0.85) { 3 } else { 4 }
        RelationshipSatisfaction = $random.Next(1, 5)
        StandardHours = 80
        StockOptionLevel = $random.Next(0, 4)
        TotalWorkingYears = $totalWorkingYears
        TrainingTimesLastYear = $random.Next(0, 7)
        WorkLifeBalance = $random.Next(1, 5)
        YearsAtCompany = $yearsAtCompany
        YearsInCurrentRole = $yearsInCurrentRole
        YearsSinceLastPromotion = $yearsSinceLastPromotion
        YearsWithCurrManager = $yearsWithCurrManager
        SalaryBand = $salaryBand
        TenureBand = $tenureBand
    }
    $hrRecords.Add($rec)
}

$hrRecords | Export-Csv -Path "01_Data\HR_Analytics\IBM_HR_Employee_Attrition.csv" -NoTypeInformation -Encoding UTF8
Write-Host "Created IBM HR Employee Attrition ($($hrRecords.Count) rows)."

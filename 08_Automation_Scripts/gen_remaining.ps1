$random = New-Object System.Random(1337)

# ==========================================
# 2. RECRUITMENT FUNNEL DATASET
# ==========================================
Write-Host "Generating 2. HR Recruitment Funnel..."
$firstNames = @("James", "Mary", "John", "Patricia", "Robert", "Jennifer", "Michael", "Linda", "William", "Elizabeth", "David", "Barbara", "Richard", "Susan", "Joseph", "Jessica", "Thomas", "Sarah", "Charles", "Karen", "Christopher", "Nancy", "Daniel", "Lisa", "Matthew", "Betty", "Anthony", "Margaret", "Mark", "Sandra", "Donald", "Ashley", "Steven", "Kimberly", "Paul", "Emily", "Andrew", "Donna", "Joshua", "Michelle", "Kenneth", "Carol", "Kevin", "Amanda", "Brian", "Melissa", "George", "Deborah", "Timothy", "Stephanie")
$lastNames = @("Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis", "Rodriguez", "Martinez", "Hernandez", "Lopez", "Gonzalez", "Wilson", "Anderson", "Thomas", "Taylor", "Moore", "Jackson", "Martin", "Lee", "Perez", "Thompson", "White", "Harris", "Sanchez", "Clark", "Ramirez", "Lewis", "Robinson", "Walker", "Young", "Allen", "King", "Wright", "Scott", "Torres", "Nguyen", "Hill", "Flores", "Green", "Adams", "Nelson", "Baker", "Hall", "Rivera", "Campbell", "Mitchell", "Carter", "Roberts")

$sources = @(
    @{ Name = "LinkedIn"; CostMin = 400; CostMax = 900; Weight = 0.35 },
    @{ Name = "Indeed"; CostMin = 250; CostMax = 600; Weight = 0.25 },
    @{ Name = "Employee Referral"; CostMin = 1000; CostMax = 1500; Weight = 0.15 },
    @{ Name = "Company Career Site"; CostMin = 100; CostMax = 250; Weight = 0.12 },
    @{ Name = "Recruitment Agency"; CostMin = 3000; CostMax = 5000; Weight = 0.08 },
    @{ Name = "University Campus"; CostMin = 300; CostMax = 800; Weight = 0.05 }
)

$recruiters = @("Sarah Jenkins", "Michael Chang", "Aisha Patel", "David Ross", "Elena Gomez")
$deptRoles = @{
    "Sales" = @("Sales Executive", "Sales Representative", "Sales Manager")
    "Research & Development" = @("Research Scientist", "Laboratory Technician", "Manufacturing Director", "Healthcare Representative", "Software Engineer", "Data Analyst")
    "Human Resources" = @("HR Specialist", "Talent Acquisition Lead", "HR Business Partner")
}

$recruitmentRecords = [System.Collections.Generic.List[PSObject]]::new()
$startDate = [DateTime]::Parse("2024-01-02")

for ($i = 1; $i -le 1350; $i++) {
    $candId = "CAND-$($i + 1000)"
    $candName = "$($firstNames[$random.Next(0, $firstNames.Length)]) $($lastNames[$random.Next(0, $lastNames.Length)])"
    
    # Dept & Role
    $deptRoll = $random.NextDouble()
    $dept = if ($deptRoll -lt 0.30) { "Sales" } elseif ($deptRoll -lt 0.85) { "Research & Development" } else { "Human Resources" }
    $roleList = $deptRoles[$dept]
    $role = $roleList[$random.Next(0, $roleList.Length)]
    $reqId = "REQ-2024-$($random.Next(101, 135))"
    
    # Source
    $srcRoll = $random.NextDouble()
    $accum = 0
    $chosenSrc = $sources[0]
    foreach ($s in $sources) {
        $accum += $s.Weight
        if ($srcRoll -le $accum) {
            $chosenSrc = $s
            break
        }
    }
    $recruiter = $recruiters[$random.Next(0, $recruiters.Length)]
    $cost = $random.Next($chosenSrc.CostMin, $chosenSrc.CostMax)
    
    # Application Date
    $appDate = $startDate.AddDays($random.Next(0, 270))
    $screenDate = $null
    $interviewDate = $null
    $offerDate = $null
    $hireDate = $null
    
    # Progression rates
    # Screened ~ 55%
    # Interviewed ~ 28% of total
    # Offer ~ 10% of total
    # Hired ~ 7.5% of total
    $passScreen = $random.NextDouble() -lt 0.55
    $passInterview = $passScreen -and ($random.NextDouble() -lt 0.50)
    $passOffer = $passInterview -and ($random.NextDouble() -lt 0.38)
    $acceptOffer = $passOffer -and ($random.NextDouble() -lt 0.78)
    
    $stageReached = "1. Applied"
    $stageStatus = "Application Rejected"
    $timeToHire = $null
    $timeToOffer = $null
    $offerAccepted = "N/A"
    
    if ($passScreen) {
        $stageReached = "2. Screened"
        $screenDate = $appDate.AddDays($random.Next(2, 6))
        $stageStatus = "Screening Rejected"
    }
    if ($passInterview) {
        $stageReached = "3. Interviewed"
        $interviewDate = $screenDate.AddDays($random.Next(5, 12))
        $stageStatus = "Interview Rejected"
    }
    if ($passOffer) {
        $stageReached = "4. Offer Extended"
        $offerDate = $interviewDate.AddDays($random.Next(4, 10))
        $timeToOffer = [int]($offerDate - $appDate).TotalDays
        if ($acceptOffer) {
            $stageReached = "5. Hired"
            $hireDate = $offerDate.AddDays($random.Next(10, 25))
            $stageStatus = "Hired"
            $offerAccepted = "Yes"
            $timeToHire = [int]($hireDate - $appDate).TotalDays
        } else {
            $stageStatus = "Offer Declined"
            $offerAccepted = "No"
        }
    }
    
    # Candidate feedback rating
    $expRating = if ($stageStatus -eq "Hired") { $random.Next(4, 6) } `
                 elseif ($stageReached -eq "4. Offer Extended") { $random.Next(3, 5) } `
                 elseif ($stageReached -eq "3. Interviewed") { $random.Next(2, 5) } `
                 else { $random.Next(1, 4) }

    $recruitmentRecords.Add([PSCustomObject]@{
        CandidateID = $candId
        CandidateName = $candName
        RequisitionID = $reqId
        Department = $dept
        JobRole = $role
        ApplicationSource = $chosenSrc.Name
        RecruiterName = $recruiter
        ApplicationDate = $appDate.ToString("yyyy-MM-dd")
        ScreeningDate = if ($screenDate) { $screenDate.ToString("yyyy-MM-dd") } else { "" }
        InterviewDate = if ($interviewDate) { $interviewDate.ToString("yyyy-MM-dd") } else { "" }
        OfferDate = if ($offerDate) { $offerDate.ToString("yyyy-MM-dd") } else { "" }
        HireDate = if ($hireDate) { $hireDate.ToString("yyyy-MM-dd") } else { "" }
        StageReached = $stageReached
        StageStatus = $stageStatus
        TimeToOfferDays = if ($timeToOffer) { $timeToOffer } else { "" }
        TimeToHireDays = if ($timeToHire) { $timeToHire } else { "" }
        OfferAccepted = $offerAccepted
        CandidateExperienceRating = $expRating
        RecruitmentCostUSD = $cost
    })
}

$recruitmentRecords | Export-Csv -Path "01_Data\HR_Analytics\HR_Recruitment_Funnel.csv" -NoTypeInformation -Encoding UTF8
Write-Host "Created HR Recruitment Funnel ($($recruitmentRecords.Count) rows)."

# ==========================================
# 3. INVENTORY & SUPPLIER PERFORMANCE
# ==========================================
Write-Host "Generating 3. Inventory and Supplier Performance..."
$categories = @("Electronics & Microchips", "Industrial Raw Materials", "Precision Mechanical Parts", "Packaging Solutions", "Sub-Assemblies")
$warehouses = @("WH-North (Chicago)", "WH-South (Dallas)", "WH-East (New Jersey)", "WH-West (Los Angeles)", "WH-Central (Atlanta)")

$suppliers = @(
    @{ ID="SUP-101"; Name="Apex MicroTech Ltd"; Cat="Electronics & Microchips"; BaseRating=4.6; DelayRisk=0.12; DefectBase=0.008 },
    @{ ID="SUP-102"; Name="Vanguard Industrial Alloys"; Cat="Industrial Raw Materials"; BaseRating=4.2; DelayRisk=0.22; DefectBase=0.015 },
    @{ ID="SUP-103"; Name="Precision Fasteners Corp"; Cat="Precision Mechanical Parts"; BaseRating=4.7; DelayRisk=0.08; DefectBase=0.005 },
    @{ ID="SUP-104"; Name="Global Eco-Packaging"; Cat="Packaging Solutions"; BaseRating=4.5; DelayRisk=0.10; DefectBase=0.006 },
    @{ ID="SUP-105"; Name="NexGen Optical Sensors"; Cat="Electronics & Microchips"; BaseRating=3.8; DelayRisk=0.30; DefectBase=0.024 },
    @{ ID="SUP-106"; Name="Starlight Polymer Solutions"; Cat="Packaging Solutions"; BaseRating=4.1; DelayRisk=0.18; DefectBase=0.012 },
    @{ ID="SUP-107"; Name="Titan Heavy Castings"; Cat="Precision Mechanical Parts"; BaseRating=3.5; DelayRisk=0.35; DefectBase=0.028 },
    @{ ID="SUP-108"; Name="Pinnacle Circuit Systems"; Cat="Sub-Assemblies"; BaseRating=4.8; DelayRisk=0.07; DefectBase=0.004 },
    @{ ID="SUP-109"; Name="Atlas Sheet Metal Works"; Cat="Industrial Raw Materials"; BaseRating=4.0; DelayRisk=0.20; DefectBase=0.018 },
    @{ ID="SUP-110"; Name="Quantum Semiconductor Inc"; Cat="Electronics & Microchips"; BaseRating=4.9; DelayRisk=0.05; DefectBase=0.003 },
    @{ ID="SUP-111"; Name="AeroTech Machining Ltd"; Cat="Sub-Assemblies"; BaseRating=4.3; DelayRisk=0.15; DefectBase=0.009 },
    @{ ID="SUP-112"; Name="OmniSeal Rubber & Gaskets"; Cat="Industrial Raw Materials"; BaseRating=3.9; DelayRisk=0.25; DefectBase=0.020 }
)

$invRecords = [System.Collections.Generic.List[PSObject]]::new()
$poStart = [DateTime]::Parse("2024-01-05")

for ($i = 1; $i -le 1250; $i++) {
    $poNum = "PO-2024-{0:D4}" -f $i
    $sup = $suppliers[$random.Next(0, $suppliers.Length)]
    $sku = "SKU-{0:D4}" -f ($random.Next(1001, 1120))
    $wh = $warehouses[$random.Next(0, $warehouses.Length)]
    
    $orderDate = $poStart.AddDays($random.Next(0, 280))
    $leadDays = $random.Next(10, 30)
    $promisedDate = $orderDate.AddDays($leadDays)
    
    # Delays
    $isDelayed = $random.NextDouble() -lt $sup.DelayRisk
    $delayDays = 0
    if ($isDelayed) {
        $delayDays = $random.Next(1, 16)
    } elseif ($random.NextDouble() -lt 0.15) {
        $delayDays = -$random.Next(1, 3) # Arrived early
    }
    $actualDate = $promisedDate.AddDays($delayDays)
    
    $deliveryStatus = if ($delayDays -lt 0) { "Early" } `
                      elseif ($delayDays -eq 0) { "On-Time" } `
                      elseif ($delayDays -le 3) { "Minor Delay (1-3 Days)" } `
                      elseif ($delayDays -le 7) { "Moderate Delay (4-7 Days)" } `
                      else { "Critical Delay (>7 Days)" }
                      
    $orderQty = $random.Next(50, 2500)
    # Delivery fulfillment
    $receivedPct = if ($random.NextDouble() -lt 0.05) { 0.85 + ($random.NextDouble() * 0.14) } else { 1.0 }
    $receivedQty = [int]($orderQty * $receivedPct)
    
    # Defects
    $defectPct = [Math]::Max(0.0, ($sup.DefectBase + ($random.NextDouble() * 0.015 - 0.005)))
    $defectQty = [int]($receivedQty * $defectPct)
    
    $unitCost = switch ($sup.Cat) {
        "Electronics & Microchips" { [Math]::Round(($random.NextDouble() * 300 + 45), 2) }
        "Industrial Raw Materials" { [Math]::Round(($random.NextDouble() * 60 + 12), 2) }
        "Precision Mechanical Parts" { [Math]::Round(($random.NextDouble() * 180 + 35), 2) }
        "Packaging Solutions" { [Math]::Round(($random.NextDouble() * 15 + 2.5), 2) }
        "Sub-Assemblies" { [Math]::Round(($random.NextDouble() * 550 + 120), 2) }
        Default { 50.0 }
    }
    
    $totalSpend = [Math]::Round($receivedQty * $unitCost, 2)
    
    # Stock calculations
    $safetyStock = [int]($orderQty * 0.35)
    $reorderPoint = [int]($safetyStock * 1.8)
    $currentStock = $random.Next([int]($safetyStock * 0.2), [int]($safetyStock * 2.8))
    
    $stockStatus = if ($currentStock -lt ($safetyStock * 0.5)) { "Critical Stockout Risk" } `
                   elseif ($currentStock -lt $reorderPoint) { "Reorder Required" } `
                   elseif ($currentStock -gt ($reorderPoint * 1.6)) { "Overstocked" } `
                   else { "Healthy Stock" }
                   
    $carryingCostAnnual = [Math]::Round($currentStock * $unitCost * 0.22, 2)
    $turnoverRatio = [Math]::Round(($random.NextDouble() * 7.5 + 3.5), 1)

    $invRecords.Add([PSCustomObject]@{
        PO_Number = $poNum
        SKU_Code = $sku
        Product_Category = $sup.Cat
        Supplier_ID = $sup.ID
        Supplier_Name = $sup.Name
        Supplier_Rating = [Math]::Round($sup.BaseRating + ($random.NextDouble() * 0.4 - 0.2), 1)
        Warehouse_Location = $wh
        Order_Date = $orderDate.ToString("yyyy-MM-dd")
        Promised_Delivery_Date = $promisedDate.ToString("yyyy-MM-dd")
        Actual_Delivery_Date = $actualDate.ToString("yyyy-MM-dd")
        Delivery_Delay_Days = $delayDays
        Delivery_Status = $deliveryStatus
        Order_Quantity = $orderQty
        Received_Quantity = $receivedQty
        Defect_Quantity = $defectQty
        Unit_Cost_USD = $unitCost
        Total_PO_Spend_USD = $totalSpend
        Current_Stock_Level = $currentStock
        Safety_Stock_Level = $safetyStock
        Reorder_Point = $reorderPoint
        Stock_Status = $stockStatus
        Annual_Carrying_Cost_USD = $carryingCostAnnual
        Inventory_Turnover_Ratio = $turnoverRatio
    })
}

$invRecords | Export-Csv -Path "01_Data\Supply_Chain\Inventory_Supplier_Performance.csv" -NoTypeInformation -Encoding UTF8
Write-Host "Created Inventory and Supplier Performance ($($invRecords.Count) rows)."

# ==========================================
# 4. LOGISTICS & FLEET TRACKING
# ==========================================
Write-Host "Generating 4. Logistics Fleet Tracking..."
$carriers = @(
    @{ ID="CAR-01"; Name="SwiftFreight Ground"; Mode="Road (Truckload)"; OnTimeRate=0.88; CostRate=1.85 },
    @{ ID="CAR-02"; Name="Apex Express Freight"; Mode="Road (Truckload)"; OnTimeRate=0.92; CostRate=2.10 },
    @{ ID="CAR-03"; Name="BlueSky Global Air Cargo"; Mode="Air Freight"; OnTimeRate=0.95; CostRate=5.40 },
    @{ ID="CAR-04"; Name="AeroFast Logistics"; Mode="Air Freight"; OnTimeRate=0.91; CostRate=4.80 },
    @{ ID="CAR-05"; Name="TransContinental Rail"; Mode="Intermodal Rail"; OnTimeRate=0.82; CostRate=1.15 },
    @{ ID="CAR-06"; Name="Pacific Rail Lines"; Mode="Intermodal Rail"; OnTimeRate=0.79; CostRate=1.05 },
    @{ ID="CAR-07"; Name="Oceanic Vanguard Lines"; Mode="Ocean Freight"; OnTimeRate=0.74; CostRate=0.65 },
    @{ ID="CAR-08"; Name="Atlantic Maritime Freight"; Mode="Ocean Freight"; OnTimeRate=0.72; CostRate=0.60 }
)

$cityRoutes = @(
    @{ Origin="Chicago, IL"; Dest="Dallas, TX"; Dist=1480 },
    @{ Origin="Atlanta, GA"; Dest="New York, NY"; Dist=1400 },
    @{ Origin="Los Angeles, CA"; Dest="Seattle, WA"; Dist=1820 },
    @{ Origin="Dallas, TX"; Dest="Miami, FL"; Dist=2100 },
    @{ Origin="Chicago, IL"; Dest="Los Angeles, CA"; Dist=3250 },
    @{ Origin="New York, NY"; Dest="London, UK"; Dist=5570 },
    @{ Origin="Los Angeles, CA"; Dest="Tokyo, Japan"; Dist=8800 },
    @{ Origin="Savannah, GA"; Dest="Rotterdam, NL"; Dist=6800 },
    @{ Origin="Houston, TX"; Dest="Denver, CO"; Dist=1650 },
    @{ Origin="Detroit, MI"; Dest="Toronto, Canada"; Dist=380 }
)

$delayReasons = @(
    "Severe Weather & Winter Storms",
    "Highway & Interstate Traffic Congestion",
    "Customs Border Clearance Hold",
    "Vehicle / Engine Mechanical Failure",
    "Port / Terminal Bottleneck & Congestion",
    "Warehouse Loading Dock Hold"
)

$logRecords = [System.Collections.Generic.List[PSObject]]::new()
$logStart = [DateTime]::Parse("2024-01-03 06:00:00")

for ($i = 1; $i -le 1500; $i++) {
    $shpId = "SHP-2024-{0:D4}" -f $i
    $route = $cityRoutes[$random.Next(0, $cityRoutes.Length)]
    
    # Filter carriers compatible with route distance
    $availableCarriers = if ($route.Dist -gt 5000) {
        $carriers | Where-Object { $_.Mode -in @("Air Freight", "Ocean Freight") }
    } else {
        $carriers | Where-Object { $_.Mode -ne "Ocean Freight" }
    }
    $carrier = $availableCarriers[$random.Next(0, $availableCarriers.Count)]
    
    $dist = $route.Dist + $random.Next(-30, 40)
    
    # Speed & Duration
    $avgSpeedKmh = switch ($carrier.Mode) {
        "Road (Truckload)" { 72.0 }
        "Air Freight" { 680.0 }
        "Intermodal Rail" { 48.0 }
        "Ocean Freight" { 34.0 }
    }
    
    $expectedHours = [Math]::Round(($dist / $avgSpeedKmh) * (1 + ($random.NextDouble() * 0.15 + 0.1)), 1)
    $dispatchDate = $logStart.AddDays($random.Next(0, 275)).AddHours($random.Next(1, 23))
    $plannedDelivery = $dispatchDate.AddHours($expectedHours)
    
    # On-Time vs Delayed
    $isOnTime = $random.NextDouble() -lt $carrier.OnTimeRate
    $delayHours = 0.0
    $delayReason = "None (On-Time)"
    
    if (-not $isOnTime) {
        $delayHours = switch ($carrier.Mode) {
            "Road (Truckload)" { [Math]::Round($random.NextDouble() * 16 + 2, 1) }
            "Air Freight" { [Math]::Round($random.NextDouble() * 12 + 1.5, 1) }
            "Intermodal Rail" { [Math]::Round($random.NextDouble() * 36 + 6, 1) }
            "Ocean Freight" { [Math]::Round($random.NextDouble() * 72 + 18, 1) }
        }
        $delayReason = $delayReasons[$random.Next(0, $delayReasons.Length)]
    }
    
    $actualDelivery = $plannedDelivery.AddHours($delayHours)
    $transitHours = [Math]::Round(($actualDelivery - $dispatchDate).TotalHours, 1)
    
    $delivStatus = if ($delayHours -le 0) { "On-Time" } `
                   elseif ($delayHours -le 6) { "Minor Delay (<6h)" } `
                   elseif ($delayHours -le 24) { "Moderate Delay (6-24h)" } `
                   else { "Severe Delay (>24h)" }
                   
    $routeEfficiency = [Math]::Round(98.5 - ($delayHours * 0.8) - ($random.NextDouble() * 4), 1)
    if ($routeEfficiency -lt 68.0) { $routeEfficiency = 68.0 }
    
    # Fuel & CO2
    $fuelEfficiencyKmPerL = switch ($carrier.Mode) {
        "Road (Truckload)" { 3.2 }
        "Air Freight" { 0.45 }
        "Intermodal Rail" { 8.5 }
        "Ocean Freight" { 18.0 }
    }
    $fuelLiters = [Math]::Round($dist / $fuelEfficiencyKmPerL, 1)
    $co2Kg = [Math]::Round($fuelLiters * 2.68, 1)
    
    # Freight Cost
    $freightCost = [Math]::Round($dist * $carrier.CostRate * (1 + ($random.NextDouble() * 0.1 - 0.05)), 2)
    $costPerKm = [Math]::Round($freightCost / $dist, 3)
    
    $custScore = if ($isOnTime) { $random.Next(4, 6) } `
                 elseif ($delayHours -le 6) { $random.Next(3, 5) } `
                 elseif ($delayHours -le 24) { $random.Next(2, 4) } `
                 else { $random.Next(1, 3) }

    $logRecords.Add([PSCustomObject]@{
        Shipment_ID = $shpId
        Carrier_ID = $carrier.ID
        Carrier_Name = $carrier.Name
        Transport_Mode = $carrier.Mode
        Origin_City = $route.Origin
        Destination_City = $route.Dest
        Distance_KM = $dist
        Dispatch_Timestamp = $dispatchDate.ToString("yyyy-MM-dd HH:mm")
        Planned_Delivery_Timestamp = $plannedDelivery.ToString("yyyy-MM-dd HH:mm")
        Actual_Delivery_Timestamp = $actualDelivery.ToString("yyyy-MM-dd HH:mm")
        Transit_Duration_Hours = $transitHours
        Delay_Hours = $delayHours
        On_Time_Flag = if ($isOnTime) { 1 } else { 0 }
        Delivery_Status = $delivStatus
        Delay_Reason = $delayReason
        Route_Efficiency_Index_Pct = $routeEfficiency
        Fuel_Consumption_Liters = $fuelLiters
        CO2_Emissions_KG = $co2Kg
        Freight_Cost_USD = $freightCost
        Cost_Per_KM_USD = $costPerKm
        Customer_Satisfaction_Score = $custScore
    })
}

$logRecords | Export-Csv -Path "01_Data\Supply_Chain\Logistics_Fleet_Tracking.csv" -NoTypeInformation -Encoding UTF8
Write-Host "Created Logistics Fleet Tracking ($($logRecords.Count) rows)."

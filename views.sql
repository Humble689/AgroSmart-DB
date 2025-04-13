USE smartAgro;

-- View 1: Farmer Farm Details
CREATE VIEW FarmerFarmDetails AS
SELECT 
    f.farmer_id,
    f.name AS farmer_name,
    f.contact_info,
    f.location AS farmer_location,
    f.farm_size,
    f.registration_date,
    fm.farm_id,
    fm.location AS farm_location,
    fm.size AS farm_size_hectares,
    fm.crop_id,
    fm.yield_estimate
FROM Farmers f
JOIN Farms fm ON f.farmer_id = fm.farmer_id;

-- View 2: Crop Market Information
CREATE VIEW CropMarketInfo AS
SELECT 
    c.crop_id,
    c.name AS crop_name,
    c.category,
    c.growth_duration,
    c.ideal_conditions,
    mp.price_per_kg,
    mp.date_recorded
FROM Crops c
LEFT JOIN Market_Prices mp ON c.crop_id = mp.crop_id;

-- View 3: Weather Impact Analysis
CREATE VIEW WeatherImpactAnalysis AS
SELECT 
    w.weather_id,
    w.location,
    w.date_recorded,
    w.temperature,
    w.rainfall,
    w.humidity,
    c.name AS crop_name,
    c.ideal_conditions
FROM Weather_Data w
JOIN Crops c ON w.location = c.ideal_conditions;

-- View 4: Supply Chain Summary
CREATE VIEW SupplyChainSummary AS
SELECT 
    scd.distribution_id,
    scd.crop_id,
    c.name AS crop_name,
    scd.quantity,
    scd.price_sold,
    scd.buyer_name,
    scd.date_of_sale,
    (scd.quantity * scd.price_sold) AS total_value
FROM Supply_Chain_Distribution scd
JOIN Crops c ON scd.crop_id = c.crop_id;

use smartAgro;

-- Farmers table constraints
ALTER TABLE Farmers
ADD CONSTRAINT chk_farm_size_positive CHECK (farm_size > 0);

-- Crops table constraints
ALTER TABLE Crops
ADD CONSTRAINT chk_growth_duration_positive CHECK (growth_duration > 0),
ADD CONSTRAINT chk_category_valid CHECK (category IN ('Vegetable', 'Fruit', 'Grain', 'Legume', 'Other'));

-- Farms table constraints
ALTER TABLE Farms
ADD CONSTRAINT chk_farms_size_positive CHECK (size > 0),
ADD CONSTRAINT chk_yield_estimate_positive CHECK (yield_estimate >= 0);

-- Market Prices table constraints
ALTER TABLE Market_Prices
ADD CONSTRAINT chk_price_positive CHECK (price_per_kg > 0);

-- Weather Data table constraints
ALTER TABLE Weather_Data
ADD CONSTRAINT chk_temperature_range CHECK (temperature BETWEEN -50 AND 50),
ADD CONSTRAINT chk_rainfall_positive CHECK (rainfall >= 0),
ADD CONSTRAINT chk_humidity_range CHECK (humidity BETWEEN 0 AND 100);

-- Supply Chain & Distribution table constraints
ALTER TABLE Supply_Chain_Distribution
ADD CONSTRAINT chk_quantity_positive CHECK (quantity > 0),
ADD CONSTRAINT chk_price_sold_positive CHECK (price_sold > 0);

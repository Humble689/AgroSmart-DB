USE SmartAgro;
-- Insert sample data into Farmers table
INSERT INTO Farmers (name, location, contact_info, farm_size, registration_date) VALUES
('Mark Travis', 'Nairobi, Kenya', 'mark.travis@email.com', 50.00, '2023-01-15'),
('ethan Smith', 'Kampala, Uganda', 'ethan.smith@email.com', 75.50, '2023-02-20'),
('Foden Johnson', 'Dar es Salaam, Tanzania', 'foden.j@email.com', 30.25, '2023-03-10'),
('Messi Williams', 'Kigali, Rwanda', 'messi.w@email.com', 45.75, '2023-04-05'),
('James Lebron', 'Addis Ababa, Ethiopia', 'james.b@email.com', 60.00, '2023-05-12');

-- Insert sample data into Crops table
INSERT INTO Crops (name, category, growth_duration, ideal_conditions) VALUES
('Maize', 'Grain', 120, 'Warm climate, well-drained soil, moderate rainfall'),
('Wheat', 'Grain', 150, 'Cool climate, fertile soil, moderate rainfall'),
('Rice', 'Grain', 100, 'Warm climate, flooded fields, high rainfall'),
('Beans', 'Legume', 90, 'Moderate climate, well-drained soil, regular rainfall'),
('Coffee', 'Other', 180, 'Tropical climate, rich soil, moderate rainfall');

-- Insert sample data into Farms table
INSERT INTO Farms (farmer_id, crop_id, location, size, yield_estimate) VALUES
(1, 1, 'Nairobi County', 20.00, 1000.00),
(1, 5, 'Nairobi County', 30.00, 500.00),
(2, 2, 'Kampala District', 40.00, 2000.00),
(3, 3, 'Dar es Salaam Region', 15.00, 750.00),
(4, 4, 'Kigali Province', 25.00, 800.00),
(5, 1, 'Addis Ababa Region', 35.00, 1750.00);

-- Insert sample data into Market Prices table
INSERT INTO Market_Prices (crop_id, location, price_per_kg, date_recorded) VALUES
(1, 'Nairobi Market', 2.50, '2023-06-01'),
(2, 'Kampala Market', 3.00, '2023-06-01'),
(3, 'Dar es Salaam Market', 2.75, '2023-06-01'),
(4, 'Kigali Market', 4.00, '2023-06-01'),
(5, 'Addis Ababa Market', 5.50, '2023-06-01');

-- Insert initial price history records
INSERT INTO Market_Price_History (
    market_id,
    crop_id,
    location,
    old_price,
    new_price,
    date_changed
) VALUES
(1, 1, 'Nairobi Market', 2.30, 2.50, '2023-05-15'),
(2, 2, 'Kampala Market', 2.80, 3.00, '2023-05-15'),
(3, 3, 'Dar es Salaam Market', 2.50, 2.75, '2023-05-15'),
(4, 4, 'Kigali Market', 3.80, 4.00, '2023-05-15'),
(5, 5, 'Addis Ababa Market', 5.20, 5.50, '2023-05-15');

-- Insert sample data into Weather Data table
INSERT INTO Weather_Data (location, temperature, rainfall, humidity, date_recorded) VALUES
('Nairobi', 25.50, 50.00, 65.00, '2023-06-01'),
('Kampala', 28.00, 60.00, 75.00, '2023-06-01'),
('Dar es Salaam', 30.00, 40.00, 70.00, '2023-06-01'),
('Kigali', 24.00, 55.00, 68.00, '2023-06-01'),
('Addis Ababa', 22.00, 45.00, 60.00, '2023-06-01');

-- Insert sample data into Supply Chain Distribution table
INSERT INTO Supply_Chain_Distribution (crop_id, farmer_id, buyer_name, quantity, price_sold, date_of_sale) VALUES
(1, 1, 'Nairobi Grain Co.', 500.00, 2.50, '2023-05-15'),
(5, 1, 'Coffee Export Ltd', 200.00, 5.50, '2023-05-20'),
(2, 2, 'Uganda Flour Mills', 1000.00, 3.00, '2023-05-18'),
(3, 3, 'Tanzania Rice Co.', 400.00, 2.75, '2023-05-22'),
(4, 4, 'Rwanda Beans Ltd', 300.00, 4.00, '2023-05-25'),
(1, 5, 'Ethiopia Grain Co.', 800.00, 2.50, '2023-05-28');

-- Active: 1744282774410@@127.0.0.1@3306@cs
USE SmartAgro;

-- Trigger 1: Update yield estimate based on weather conditions
DELIMITER //
CREATE TRIGGER update_yield_estimate
AFTER INSERT ON Weather_Data
FOR EACH ROW
BEGIN
    UPDATE Farms f
    SET f.yield_estimate = f.yield_estimate * 
        CASE 
            WHEN NEW.temperature BETWEEN 20 AND 30 AND NEW.rainfall BETWEEN 50 AND 200 THEN 1.1
            WHEN NEW.temperature BETWEEN 15 AND 35 AND NEW.rainfall BETWEEN 30 AND 300 THEN 1.0
            ELSE 0.9
        END
    WHERE f.location = NEW.location;
END //
DELIMITER ;

-- Trigger 2: Validate farm size against farmer's total farm size
DELIMITER //
CREATE TRIGGER validate_farm_size
BEFORE INSERT ON Farms
FOR EACH ROW
BEGIN
    DECLARE total_farm_size DECIMAL(10,2);
    DECLARE farmer_total_size DECIMAL(10,2);
    
    SELECT SUM(size) INTO total_farm_size
    FROM Farms
    WHERE farmer_id = NEW.farmer_id;
    
    SELECT farm_size INTO farmer_total_size
    FROM Farmers
    WHERE farmer_id = NEW.farmer_id;
    
    IF (total_farm_size + NEW.size) > farmer_total_size THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Farm size exceeds farmer total farm size';
    END IF;
END //
DELIMITER ;

-- Trigger 3: Maintain price history
DELIMITER //
CREATE TRIGGER maintain_price_history
BEFORE UPDATE ON Market_Prices
FOR EACH ROW
BEGIN
    INSERT INTO Market_Price_History (
        market_id,
        crop_id,
        location,
        old_price,
        new_price,
        date_changed
    )
    VALUES (
        OLD.market_id,
        OLD.crop_id,
        OLD.location,
        OLD.price_per_kg,
        NEW.price_per_kg,
        CURRENT_DATE
    );
END //
DELIMITER ;

-- Create Market_Price_History table for the trigger
CREATE TABLE IF NOT EXISTS Market_Price_History (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    market_id INT NOT NULL,
    crop_id INT NOT NULL,
    location VARCHAR(200) NOT NULL,
    old_price DECIMAL(10,2) NOT NULL,
    new_price DECIMAL(10,2) NOT NULL,
    date_changed DATE NOT NULL,
    FOREIGN KEY (market_id) REFERENCES Market_Prices(market_id),
    FOREIGN KEY (crop_id) REFERENCES Crops(crop_id)
);

-- Trigger 4: Validate supply chain quantities
DELIMITER //
CREATE TRIGGER validate_supply_quantity
BEFORE INSERT ON Supply_Chain_Distribution
FOR EACH ROW
BEGIN
    DECLARE available_yield DECIMAL(10,2);
    
    SELECT yield_estimate INTO available_yield
    FROM Farms
    WHERE farmer_id = NEW.farmer_id AND crop_id = NEW.crop_id;
    
    IF NEW.quantity > available_yield THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Supply quantity exceeds available yield';
    END IF;
END //
DELIMITER ;

-- Trigger 5: Validate contact information format
DELIMITER //
CREATE TRIGGER validate_contact_info
BEFORE INSERT ON Farmers
FOR EACH ROW
BEGIN
    -- Check if contact_info contains at least one @ symbol (email) or 10 digits (phone)
    IF NEW.contact_info NOT REGEXP '@|^[0-9]{10}$' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Contact information must be a valid email or 10-digit phone number';
    END IF;
END //
DELIMITER ;

-- Trigger 6: Validate dates are not in the future
DELIMITER //
CREATE TRIGGER validate_dates
BEFORE INSERT ON Weather_Data
FOR EACH ROW
BEGIN
    IF NEW.date_recorded > CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Date cannot be in the future';
    END IF;
END //
DELIMITER ;

-- Add the same date validation for other tables with dates
DELIMITER //
CREATE TRIGGER validate_market_dates
BEFORE INSERT ON Market_Prices
FOR EACH ROW
BEGIN
    IF NEW.date_recorded > CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Date cannot be in the future';
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER validate_supply_dates
BEFORE INSERT ON Supply_Chain_Distribution
FOR EACH ROW
BEGIN
    IF NEW.date_of_sale > CURDATE() THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Date cannot be in the future';
    END IF;
END //
DELIMITER ;

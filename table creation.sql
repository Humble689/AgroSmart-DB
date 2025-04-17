-- Active: 1744282774410@@127.0.0.1@3306@cs

create database SmartAgro;
use smartAgro;
CREATE TABLE Farmers (
    farmer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(200) NOT NULL,
    contact_info VARCHAR(100) NOT NULL,
    farm_size DECIMAL(10,2) NOT NULL,
    registration_date DATE NOT NULL
);

-- Create Crops table
CREATE TABLE Crops (
    crop_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    growth_duration INT NOT NULL, -- in days
    ideal_conditions TEXT NOT NULL
);

-- Create Farms table
CREATE TABLE Farms (
    farm_id INT PRIMARY KEY AUTO_INCREMENT,
    farmer_id INT NOT NULL,
    crop_id INT NOT NULL,
    location VARCHAR(200) NOT NULL,
    size DECIMAL(10,2) NOT NULL,
    yield_estimate DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (farmer_id) REFERENCES Farmers(farmer_id),
    FOREIGN KEY (crop_id) REFERENCES Crops(crop_id)
);

-- Create Market Prices table
CREATE TABLE Market_Prices (
    market_id INT PRIMARY KEY AUTO_INCREMENT,
    crop_id INT NOT NULL,
    location VARCHAR(200) NOT NULL,
    price_per_kg DECIMAL(10,2) NOT NULL,
    date_recorded DATE NOT NULL,
    FOREIGN KEY (crop_id) REFERENCES Crops(crop_id)
);

-- Create Weather Data table
CREATE TABLE Weather_Data (
    weather_id INT PRIMARY KEY AUTO_INCREMENT,
    location VARCHAR(200) NOT NULL,
    temperature DECIMAL(5,2) NOT NULL,
    rainfall DECIMAL(10,2) NOT NULL,
    humidity DECIMAL(5,2) NOT NULL,
    date_recorded DATE NOT NULL
);
 
-- Create Supply Chain & Distribution table
CREATE TABLE Supply_Chain_Distribution (
    distribution_id INT PRIMARY KEY AUTO_INCREMENT,
    crop_id INT NOT NULL,
    farmer_id INT NOT NULL,
    buyer_name VARCHAR(100) NOT NULL,
    quantity DECIMAL(10,2) NOT NULL,
    price_sold DECIMAL(10,2) NOT NULL,
    date_of_sale DATE NOT NULL,
    FOREIGN KEY (crop_id) REFERENCES Crops(crop_id),
    FOREIGN KEY (farmer_id) REFERENCES Farmers(farmer_id)
);

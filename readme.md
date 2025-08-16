# SmartAgro Database System

This project implements a comprehensive database system for agricultural management, focusing on farmers, crops, market prices, weather data, and supply chain distribution.
This project implements a comprehensive database system for agricultural management, focusing on farmers, crops, market prices, weather data, and supply chain distribution.

## Database Structure

The system consists of the following main tables:

1. **Farmers**
   - Stores information about registered farmers
   - Tracks farmer details, location, contact information, and farm size

2. **Crops**
   - Maintains crop information including name, category, growth duration, and ideal conditions

3. **Farms**
   - Links farmers with their crops
   - Tracks farm location, size, and yield estimates

4. **Market Prices**
   - Records current market prices for different crops
   - Tracks price history by location and date

5. **Weather Data**
   - Stores weather information including temperature, rainfall, and humidity
   - Tracks weather conditions by location and date

6. **Supply Chain & Distribution**
   - Manages crop distribution information
   - Tracks sales transactions between farmers and buyers

## Views

The database includes several views for data analysis:

1. **FarmerFarmDetails**
   - Combines farmer and farm information for comprehensive farmer profiles

2. **CropMarketInfo**
   - Provides market price information for different crops

3. **WeatherImpactAnalysis**
   - Analyzes weather conditions and their impact on crops

4. **SupplyChainSummary**
   - Summarizes supply chain transactions and calculates total values

## SQL Files

The project is organized into the following SQL files:

1. `table creation.sql`
   - Contains all table creation statements
   - Sets up the database structure

2. `constraints.sql`
   - Defines database constraints and relationships

3. `views.sql`
   - Implements database views for data analysis

4. `Roles and procedures.sql`
   - Contains stored procedures and role definitions

5. `triggers.sql`
   - Implements database triggers for automated actions

## Getting Started

1. Create the database:
   ```sql
   CREATE DATABASE SmartAgro;
   USE SmartAgro;
   ```

2. Execute the SQL files in the following order:
   - `table creation.sql`
   - `constraints.sql`
   - `views.sql`
   - `Roles and procedures.sql`
   - `triggers.sql`

## Features

- Comprehensive agricultural data management
- Market price tracking and analysis
- Weather impact analysis
- Supply chain management
- Automated triggers for data consistency
- Role-based access control
- Data analysis through views

## Requirements

- MySQL Server
- Basic understanding of SQL
- Database management tools (e.g., MySQL Workbench)

## Note

This database system is designed for agricultural management and can be extended with additional features as needed. The current implementation provides a solid foundation for tracking and analyzing agricultural data.

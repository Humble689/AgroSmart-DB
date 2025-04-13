use smartagro;

-- First, grant necessary privileges to the current user
GRANT CREATE USER, CREATE ROLE ON *.* TO CURRENT_USER;
GRANT ALL PRIVILEGES ON smartagro.* TO CURRENT_USER WITH GRANT OPTION;

-- Create roles for different user types
CREATE ROLE IF NOT EXISTS 'admin_role'@'localhost';
CREATE ROLE IF NOT EXISTS 'manager_role'@'localhost';
CREATE ROLE IF NOT EXISTS 'staff_role'@'localhost';
CREATE ROLE IF NOT EXISTS 'farmer_role'@'localhost';

-- Grant basic privileges to admin_role (full access)
GRANT ALL PRIVILEGES ON smartagro.* TO 'admin_role'@'localhost';

-- Grant privileges to manager_role
GRANT ALL PRIVILEGES ON smartagro.* TO 'manager_role'@'localhost';
-- Revoke sensitive operations from manager_role
REVOKE DELETE ON smartagro.* FROM 'manager_role'@'localhost';

-- Grant privileges to staff_role
GRANT ALL PRIVILEGES ON smartagro.* TO 'staff_role'@'localhost';
-- Revoke sensitive operations from staff_role
REVOKE DELETE ON smartagro.* FROM 'staff_role'@'localhost';

-- Grant privileges to farmer_role
GRANT ALL PRIVILEGES ON smartagro.* TO 'farmer_role'@'localhost';
-- Revoke sensitive operations from farmer_role
REVOKE DELETE ON smartagro.* FROM 'farmer_role'@'localhost';

-- Now set specific table permissions
-- For staff_role
GRANT SELECT ON smartagro.* TO 'staff_role'@'localhost';
GRANT INSERT, UPDATE ON smartagro.Market_Prices TO 'staff_role'@'localhost';
GRANT INSERT, UPDATE ON smartagro.Weather_Data TO 'staff_role'@'localhost';
GRANT INSERT, UPDATE ON smartagro.Supply_Chain_Distribution TO 'staff_role'@'localhost';

-- For farmer_role
GRANT SELECT, INSERT, UPDATE ON smartagro.Farmers TO 'farmer_role'@'localhost';
GRANT SELECT, INSERT, UPDATE ON smartagro.Farms TO 'farmer_role'@'localhost';
GRANT SELECT ON smartagro.Crops TO 'farmer_role'@'localhost';
GRANT SELECT ON smartagro.Market_Prices TO 'farmer_role'@'localhost';
GRANT SELECT, INSERT, UPDATE ON smartagro.Supply_Chain_Distribution TO 'farmer_role'@'localhost';

-- Create users and assign roles
CREATE USER IF NOT EXISTS 'admin_user'@'localhost' IDENTIFIED BY 'secure_password';
CREATE USER IF NOT EXISTS 'manager_user'@'localhost' IDENTIFIED BY 'secure_password';
CREATE USER IF NOT EXISTS 'staff_user'@'localhost' IDENTIFIED BY 'secure_password';
CREATE USER IF NOT EXISTS 'farmer_user'@'localhost' IDENTIFIED BY 'secure_password';

-- Assign roles to users
GRANT 'admin_role'@'localhost' TO 'admin_user'@'localhost';
GRANT 'manager_role'@'localhost' TO 'manager_user'@'localhost';
GRANT 'staff_role'@'localhost' TO 'staff_user'@'localhost';
GRANT 'farmer_role'@'localhost' TO 'farmer_user'@'localhost';

-- Set default roles
SET DEFAULT ROLE 'admin_role'@'localhost' TO 'admin_user'@'localhost';
SET DEFAULT ROLE 'manager_role'@'localhost' TO 'manager_user'@'localhost';
SET DEFAULT ROLE 'staff_role'@'localhost' TO 'staff_user'@'localhost';
SET DEFAULT ROLE 'farmer_role'@'localhost' TO 'farmer_user'@'localhost';

-- Create procedure to check user permissions
DELIMITER //
CREATE PROCEDURE check_user_permissions(IN p_username VARCHAR(255))
BEGIN
    SELECT 
        user,
        table_schema,
        table_name,
        privilege_type
    FROM information_schema.table_privileges
    WHERE grantee = CONCAT('\'', p_username, '\'@\'localhost\'');
END //
DELIMITER ;

-- Create procedure to modify user roles
DELIMITER //
CREATE PROCEDURE modify_user_role(
    IN p_username VARCHAR(255),
    IN p_new_role VARCHAR(255)
)
BEGIN
    -- Revoke all existing roles
    SET @revoke_sql = CONCAT('REVOKE ALL PRIVILEGES ON smartagro.* FROM \'', p_username, '\'@\'localhost\'');
    PREPARE stmt FROM @revoke_sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    
    -- Grant new role
    SET @grant_sql = CONCAT('GRANT \'', p_new_role, '\'@\'localhost\' TO \'', p_username, '\'@\'localhost\'');
    PREPARE stmt FROM @grant_sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    
    -- Set default role
    SET @set_role_sql = CONCAT('SET DEFAULT ROLE \'', p_new_role, '\'@\'localhost\' TO \'', p_username, '\'@\'localhost\'');
    PREPARE stmt FROM @set_role_sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //
DELIMITER ;
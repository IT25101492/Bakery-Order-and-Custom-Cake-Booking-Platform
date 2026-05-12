CREATE DATABASE IF NOT EXISTS bakery_db;
USE bakery_db;


CREATE TABLE IF NOT EXISTS customers (
    customer_id     INT AUTO_INCREMENT PRIMARY KEY,  
    username        VARCHAR(50)  NOT NULL UNIQUE,     
    email           VARCHAR(100) NOT NULL UNIQUE,     
    password        VARCHAR(255) NOT NULL,            
    phone_number    VARCHAR(20),                     
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP, 
    loyalty_points  INT DEFAULT 0,                    
    is_active       TINYINT(1) DEFAULT 1,
    delivery_address VARCHAR(200)             
);

CREATE TABLE IF NOT EXISTS admins (
    admin_id        INT AUTO_INCREMENT PRIMARY KEY,
    username        VARCHAR(50)  NOT NULL UNIQUE,
    email           VARCHAR(100) NOT NULL UNIQUE,
    password        VARCHAR(255) NOT NULL,
    phone_number    VARCHAR(20),
    admin_level     INT DEFAULT 1,                    
    department      VARCHAR(100) DEFAULT 'General',  
    last_login_time DATETIME,                        
    is_active       TINYINT(1) DEFAULT 1
);


INSERT INTO customers (username, email, password, phone_number, delivery_address, loyalty_points) VALUES
('john_doe',     'john.doe@email.com',     'Customer@123', '555-0101', '123 Maple Street, Springfield', 150),
('jane_smith',   'jane.smith@email.com',   'Customer@123', '555-0102', '456 Oak Avenue, Riverside',     200),
('bob_johnson',  'bob.johnson@email.com',  'Customer@123', '555-0103', '789 Pine Road, Lakewood',        50),
('alice_brown',  'alice.brown@email.com',  'Customer@123', '555-0104', '321 Elm Street, Greenfield',    300),
('charlie_davis','charlie.davis@email.com','Customer@123', '555-0105', '654 Cedar Lane, Hillside',       75),
('emma_wilson',  'emma.wilson@email.com',  'Customer@123', '555-0106', '987 Birch Blvd, Meadowview',    500),
('liam_moore',   'liam.moore@email.com',   'Customer@123', '555-0107', '147 Walnut Drive, Sunnyvale',   120),
('sophia_taylor','sophia.taylor@email.com','Customer@123', '555-0108', '258 Spruce Court, Clearwater',  250);


INSERT INTO admins (username, email, password, phone_number, admin_level, department) VALUES
('admin', 'admin@bakery.com', 'Admin@123', '555-0001', 2, 'Management');

ALTER TABLE customers
ADD delivery_address VARCHAR(200) NOT NULL;

SELECT * FROM customers

SELECT * FROM admins
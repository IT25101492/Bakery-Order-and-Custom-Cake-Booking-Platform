CREATE DATABASE IF NOT EXISTS bakery_db;
USE bakery_db;

-- USER MANAGEMENT TABLES
CREATE TABLE IF NOT EXISTS customers (
    customer_id      INT AUTO_INCREMENT PRIMARY KEY,
    username         VARCHAR(50)  NOT NULL UNIQUE,
    email            VARCHAR(100) NOT NULL UNIQUE,
    password         VARCHAR(255) NOT NULL,
    phone_number     VARCHAR(20),
    registration_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    loyalty_points   INT DEFAULT 0,
    is_active        TINYINT(1) DEFAULT 1,
    delivery_address VARCHAR(200) DEFAULT ''
);

CREATE TABLE IF NOT EXISTS admins (
    admin_id         INT AUTO_INCREMENT PRIMARY KEY,
    username         VARCHAR(50)  NOT NULL UNIQUE,
    email            VARCHAR(100) NOT NULL UNIQUE,
    password         VARCHAR(255) NOT NULL,
    phone_number     VARCHAR(20),
    admin_level      INT DEFAULT 1,
    department       VARCHAR(100) DEFAULT 'General',
    last_login_time  DATETIME,
    is_active        TINYINT(1) DEFAULT 1
);

-- PRODUCT MANAGEMENT TABLES 

CREATE TABLE IF NOT EXISTS products (
    product_id      INT NOT NULL AUTO_INCREMENT,
    name            VARCHAR(255),
    category        VARCHAR(255),
    price           DOUBLE NOT NULL,
    ingredients     VARCHAR(255),
    stock_quantity  INT DEFAULT 0,
    availability    TINYINT(1) DEFAULT 1,
    description     VARCHAR(255),
    product_type    VARCHAR(20) DEFAULT 'StandardCake',
    bread_type      VARCHAR(50) DEFAULT NULL,
    is_sweet        TINYINT(1) DEFAULT NULL,
    flavor          VARCHAR(50) DEFAULT NULL,
    cake_size       VARCHAR(20) DEFAULT NULL,
    PRIMARY KEY (product_id)
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

INSERT INTO products (name, category, price, ingredients, stock_quantity, availability, description, product_type, bread_type, flavor, cake_size) VALUES
('Chocolate Cake',   'Cake',   500.00, 'chocolate, flour, sugar, eggs',     12, 1, 'Rich chocolate layer cake',    'StandardCake', NULL, 0, 'Chocolate', 'Medium'),
('Butter Bread',     'Bread',  200.00, 'flour, butter, yeast, salt',       30, 1, 'Classic soft white bread',      'Bread',       'White', NULL, NULL),
('Sourdough Bread',  'Bread',  350.00, 'flour, water, sourdough starter',   15, 1, 'Artisan sourdough bread',       'Bread',       'Sourdough', NULL, NULL),
('Croissant',        'Pastry', 250.00, 'flour, butter, yeast',             20, 1, 'Flaky butter croissant',       'Pastry',      NULL, 1, NULL),
('Vanilla Cake',     'Cake',   600.00, 'vanilla, flour, sugar, cream',     10, 1, 'Classic vanilla celebration cake','StandardCake', NULL, 0, 'Vanilla', 'Large'),
('Danish Pastry',   'Pastry', 280.00, 'flour, butter, jam, cream cheese', 18, 1, 'Sweet fruit-filled Danish',     'Pastry',      NULL, 1, NULL),
('Whole Wheat Bread','Bread',  180.00, 'whole wheat flour, honey, yeast',  25, 1, 'Healthy whole wheat bread',     'Bread',       'Whole Wheat', NULL, NULL);

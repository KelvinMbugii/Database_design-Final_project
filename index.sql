-- Create Database Inventory
CREATE DATABASE inventory;

-- USE Database
USE inventory;

-- USERS Table
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('admin', 'staff', 'manager') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- SUPPLIERS Table
CREATE TABLE Suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    contact_email VARCHAR(100),
    phone_number VARCHAR(20),
    address TEXT
);

-- CATEGORIES Table
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT
);

-- PRODUCTS Table
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    category_id INT NOT NULL,
    supplier_id INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id),
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);


-- INVENTORY Table 
CREATE TABLE Inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL UNIQUE,
    quantity_in_stock INT NOT NULL,
    reorder_level INT NOT NULL,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- ORDERS Table
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('pending', 'shipped', 'delivered', 'cancelled') NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- ORDER_ITEMS Table 
CREATE TABLE Order_Items (
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    price_at_order DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- SHIPMENTS Table 
 CREATE TABLE Shipments (
    shipment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL UNIQUE,
    shipped_date DATE,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
 );



-- INSERTING Data
-- users table
INSERT INTO Users (username, email, password_hash, role)
VALUES
('admin1', 'admin1@example.com', 'hashed_password_1', 'admin'),
('manager1', 'manager1@example.com', 'hashed_password_2', 'manager'),
('staff1', 'staff1@example.com', 'hashed_password_3', 'staff');

-- suppliers table
 INSERT INTO Suppliers (name, contact_email, phone_number, address)
VALUES
('Global Tech Supplies', 'contact@globaltech.com', '123-456-7890', '123 Kenyatta Avenue, Nairobi'),
('Home Suplies Ltd.', 'support@homesuplies.com', '987-654-3210', '456 Moi Avenue, Nairobi');

-- categories table
INSERT INTO Categories (name, description)
VALUES
('Electronics', 'Devices, gadgets, and accessories'),
('Furniture', 'Home and office furniture');

-- products table
INSERT INTO Products (name, category_id, supplier_id, price, description)
VALUES
('Smartphone X100', 1, 1, 499.99, 'A smartphone with 128GB storage'),
('Office Chair Deluxe', 2, 2, 150.00, 'office chair with lumbar support');


-- inventory table
INSERT INTO Inventory (product_id, quantity_in_stock, reorder_level)
VALUES
(1, 50, 10),
(2, 20, 5); 

-- orders table
INSERT INTO Orders (user_id, status)
VALUES
(2, 'pending'),  
(3, 'shipped'); 

-- order_items table
INSERT INTO Order_Items (order_id, product_id, quantity, price_at_order)
VALUES
(1, 1, 2, 499.99),  
(2, 2, 1, 150.00);  

-- shipments table
INSERT INTO Shipments (order_id, shipped_date)
VALUES
(2, '2025-05-01'); 
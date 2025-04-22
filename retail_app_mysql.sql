DROP DATABASE IF EXISTS retail_app;
CREATE DATABASE retail_app;
USE retail_app;

-- Users
DROP TABLE IF EXISTS users;
CREATE TABLE users (
    user_id VARCHAR(255) PRIMARY KEY,
    user_password VARCHAR(255),
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email_id VARCHAR(255),
    sign_up_on DATE,
    contact VARCHAR(50),
    last_login TIMESTAMP
);

-- Employment types
DROP TABLE IF EXISTS employment_type;
CREATE TABLE employment_type (
    employment_type_id VARCHAR(255) PRIMARY KEY,
    employment_type VARCHAR(255),
    is_internal_employee TINYINT(1),
    is_admin TINYINT(1),
    vendor_name VARCHAR(255)
);

-- Employees
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    employee_id VARCHAR(255) PRIMARY KEY,
    employee_type VARCHAR(255),
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    registered_on DATE,
    email_id VARCHAR(255),
    contact VARCHAR(50),
    contract_expiry DATE,
    FOREIGN KEY (employee_type) REFERENCES employment_type (employment_type_id)
);

-- Payment
DROP TABLE IF EXISTS payment;
CREATE TABLE payment (
    payment_id VARCHAR(255) PRIMARY KEY,
    total_amount DECIMAL(10,2),
    paid_on TIMESTAMP,
    is_success TINYINT(1)
);

-- Orders
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    order_id VARCHAR(255) PRIMARY KEY,
    ordered_by VARCHAR(255),
    payment_id VARCHAR(255),
    is_delivered TINYINT(1),
    delivery_date DATE,
    delivered_by VARCHAR(255),
    FOREIGN KEY (ordered_by) REFERENCES users (user_id),
    FOREIGN KEY (payment_id) REFERENCES payment (payment_id),
    FOREIGN KEY (delivered_by) REFERENCES employees (employee_id)
);

-- Delivery stages
DROP TABLE IF EXISTS order_delivery;
CREATE TABLE order_delivery (
    row_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id VARCHAR(255),
    delivery_stage VARCHAR(255),
    FOREIGN KEY (order_id) REFERENCES orders (order_id)
);

-- Product catalog
DROP TABLE IF EXISTS product_items;
CREATE TABLE product_items (
    item_id VARCHAR(255) PRIMARY KEY,
    item_code VARCHAR(255),
    item_name VARCHAR(255),
    item_type VARCHAR(255),
    item_description TEXT,
    item_image JSON,
    sold_by VARCHAR(255),
    amount DECIMAL(10,2),
    discount DECIMAL(5,2),
    stock_count INT
);

-- Order items
DROP TABLE IF EXISTS order_items;
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    item_id VARCHAR(255),
    order_id VARCHAR(255),
    FOREIGN KEY (item_id) REFERENCES product_items (item_id),
    FOREIGN KEY (order_id) REFERENCES orders (order_id)
);

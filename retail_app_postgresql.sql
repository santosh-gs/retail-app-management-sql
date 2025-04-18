DROP SCHEMA IF EXISTS retail_app CASCADE;
CREATE SCHEMA IF NOT EXISTS retail_app;

-- Users table
DROP TABLE IF EXISTS retail_app.users;
CREATE TABLE IF NOT EXISTS retail_app.users (
    user_id TEXT PRIMARY KEY,
    user_password TEXT,
    first_name TEXT,
    last_name TEXT,
    email_id TEXT,
    sign_up_on DATE,
    contact TEXT,
    last_login TIMESTAMP
);

-- Employment types
DROP TABLE IF EXISTS retail_app.employment_type;
CREATE TABLE IF NOT EXISTS retail_app.employment_type (
    employment_type_id TEXT PRIMARY KEY,
    employment_type TEXT,
    is_internal_employee BOOLEAN,
    is_admin BOOLEAN,
    vendor_name TEXT
);

-- Employees
DROP TABLE IF EXISTS retail_app.employees;
CREATE TABLE IF NOT EXISTS retail_app.employees (
    employee_id TEXT PRIMARY KEY,
    employee_type TEXT REFERENCES retail_app.employment_type (employment_type_id),
    first_name TEXT,
    last_name TEXT,
    registered_on DATE,
    email_id TEXT,
    contact TEXT,
    contract_expiry DATE
);

-- Payment
DROP TABLE IF EXISTS retail_app.payment;
CREATE TABLE IF NOT EXISTS retail_app.payment (
    payment_id TEXT PRIMARY KEY,
    total_amount NUMERIC(10, 2), -- same as DECIMAL(10, 2)
    paid_on TIMESTAMP,
    is_success BOOLEAN
);

-- Orders
DROP TABLE IF EXISTS retail_app.orders;
CREATE TABLE IF NOT EXISTS retail_app.orders (
    order_id TEXT PRIMARY KEY,
    ordered_by TEXT REFERENCES retail_app.users (user_id),
    payment_id TEXT REFERENCES retail_app.payment (payment_id),
    is_delivered BOOLEAN,
    delivery_date DATE,
    delivered_by TEXT REFERENCES retail_app.employees (employee_id)
);

-- Order delivery stages
DROP TABLE IF EXISTS retail_app.order_delivery;
CREATE TABLE IF NOT EXISTS retail_app.order_delivery (
    row_id SERIAL PRIMARY KEY,
    order_id TEXT REFERENCES retail_app.orders (order_id),
    delivery_stage TEXT
);

-- Product catalog
DROP TABLE IF EXISTS retail_app.product_items;
CREATE TABLE IF NOT EXISTS retail_app.product_items (
    item_id TEXT PRIMARY KEY,
    item_code TEXT,
    item_name TEXT,
    item_type TEXT,
    item_description TEXT,
    item_image JSON,
    sold_by TEXT,
    amount NUMERIC(10, 2),
    discount NUMERIC(5, 2),
    stock_count INT
);

-- Order items
DROP TABLE IF EXISTS retail_app.order_items;
CREATE TABLE IF NOT EXISTS retail_app.order_items (
    order_item_id SERIAL PRIMARY KEY,
    item_id TEXT REFERENCES retail_app.product_items (item_id),
    order_id TEXT REFERENCES retail_app.orders (order_id)
);

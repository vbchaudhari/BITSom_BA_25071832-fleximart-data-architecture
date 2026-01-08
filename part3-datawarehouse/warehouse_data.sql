USE fleximart_dw;

-- =============================================
-- 1. Populating Date Dimension (30 Records)
-- =============================================
INSERT INTO dim_date VALUES 
(20240101, '2024-01-01', 'Monday', 1, 1, 'January', 'Q1', 2024, FALSE),
(20240102, '2024-01-02', 'Tuesday', 2, 1, 'January', 'Q1', 2024, FALSE),
(20240103, '2024-01-03', 'Wednesday', 3, 1, 'January', 'Q1', 2024, FALSE),
(20240104, '2024-01-04', 'Thursday', 4, 1, 'January', 'Q1', 2024, FALSE),
(20240105, '2024-01-05', 'Friday', 5, 1, 'January', 'Q1', 2024, FALSE),
(20240106, '2024-01-06', 'Saturday', 6, 1, 'January', 'Q1', 2024, TRUE),
(20240107, '2024-01-07', 'Sunday', 7, 1, 'January', 'Q1', 2024, TRUE),
(20240108, '2024-01-08', 'Monday', 8, 1, 'January', 'Q1', 2024, FALSE),
(20240109, '2024-01-09', 'Tuesday', 9, 1, 'January', 'Q1', 2024, FALSE),
(20240110, '2024-01-10', 'Wednesday', 10, 1, 'January', 'Q1', 2024, FALSE),
(20240111, '2024-01-11', 'Thursday', 11, 1, 'January', 'Q1', 2024, FALSE),
(20240112, '2024-01-12', 'Friday', 12, 1, 'January', 'Q1', 2024, FALSE),
(20240113, '2024-01-13', 'Saturday', 13, 1, 'January', 'Q1', 2024, TRUE),
(20240114, '2024-01-14', 'Sunday', 14, 1, 'January', 'Q1', 2024, TRUE),
(20240115, '2024-01-15', 'Monday', 15, 1, 'January', 'Q1', 2024, FALSE),
(20240116, '2024-01-16', 'Tuesday', 16, 1, 'January', 'Q1', 2024, FALSE),
(20240117, '2024-01-17', 'Wednesday', 17, 1, 'January', 'Q1', 2024, FALSE),
(20240118, '2024-01-18', 'Thursday', 18, 1, 'January', 'Q1', 2024, FALSE),
(20240119, '2024-01-19', 'Friday', 19, 1, 'January', 'Q1', 2024, FALSE),
(20240120, '2024-01-20', 'Saturday', 20, 1, 'January', 'Q1', 2024, TRUE),
(20240201, '2024-02-01', 'Thursday', 1, 2, 'February', 'Q1', 2024, FALSE),
(20240202, '2024-02-02', 'Friday', 2, 2, 'February', 'Q1', 2024, FALSE),
(20240203, '2024-02-03', 'Saturday', 3, 2, 'February', 'Q1', 2024, TRUE),
(20240204, '2024-02-04', 'Sunday', 4, 2, 'February', 'Q1', 2024, TRUE),
(20240205, '2024-02-05', 'Monday', 5, 2, 'February', 'Q1', 2024, FALSE),
(20240206, '2024-02-06', 'Tuesday', 6, 2, 'February', 'Q1', 2024, FALSE),
(20240207, '2024-02-07', 'Wednesday', 7, 2, 'February', 'Q1', 2024, FALSE),
(20240208, '2024-02-08', 'Thursday', 8, 2, 'February', 'Q1', 2024, FALSE),
(20240209, '2024-02-09', 'Friday', 9, 2, 'February', 'Q1', 2024, FALSE),
(20240210, '2024-02-10', 'Saturday', 10, 2, 'February', 'Q1', 2024, TRUE);

-- =============================================
-- 2. Populating Product Dimension (15 Records)
-- =============================================
INSERT INTO dim_product (product_id, product_name, category, subcategory, unit_price) VALUES 
('E001', 'Samsung Galaxy S24', 'Electronics', 'Smartphones', 80000.00),
('E002', 'iPhone 15 Pro', 'Electronics', 'Smartphones', 130000.00),
('E003', 'Dell XPS 13', 'Electronics', 'Laptops', 110000.00),
('E004', 'Sony WH-1000XM5', 'Electronics', 'Audio', 25000.00),
('E005', 'LG 55 Inch 4K TV', 'Electronics', 'Televisions', 55000.00),
('F001', 'Nike Air Max', 'Fashion', 'Footwear', 8000.00),
('F002', 'Adidas Ultraboost', 'Fashion', 'Footwear', 12000.00),
('F003', 'Levis 511 Jeans', 'Fashion', 'Clothing', 3500.00),
('F004', 'Zara Summer Dress', 'Fashion', 'Clothing', 4500.00),
('F005', 'Ray-Ban Aviator', 'Fashion', 'Accessories', 9000.00),
('H001', 'Dyson Vacuum Cleaner', 'Home', 'Appliances', 45000.00),
('H002', 'Philips Air Fryer', 'Home', 'Kitchen', 8000.00),
('H003', 'IKEA Sofa Set', 'Home', 'Furniture', 35000.00),
('H004', 'Milton Water Bottle', 'Home', 'Kitchen', 500.00),
('H005', 'Sleepwell Mattress', 'Home', 'Furniture', 15000.00);

-- =============================================
-- 3. Populating Customer Dimension (12 Records)
-- =============================================
INSERT INTO dim_customer (customer_id, customer_name, city, state, customer_segment) VALUES 
('C001', 'Rahul Sharma', 'Mumbai', 'Maharashtra', 'High Value'),
('C002', 'Priya Patel', 'Mumbai', 'Maharashtra', 'Medium Value'),
('C003', 'Amit Singh', 'Delhi', 'Delhi', 'Low Value'),
('C004', 'Neha Gupta', 'Delhi', 'Delhi', 'High Value'),
('C005', 'Vikram Reddy', 'Bangalore', 'Karnataka', 'High Value'),
('C006', 'Anjali Rao', 'Bangalore', 'Karnataka', 'Medium Value'),
('C007', 'Rohan Verma', 'Jaipur', 'Rajasthan', 'Low Value'),
('C008', 'Sita Devi', 'Jaipur', 'Rajasthan', 'Medium Value'),
('C009', 'Karan Johar', 'Mumbai', 'Maharashtra', 'High Value'),
('C010', 'Simran Kaur', 'Delhi', 'Delhi', 'Medium Value'),
('C011', 'Arjun Kapoor', 'Bangalore', 'Karnataka', 'Low Value'),
('C012', 'Meera Rajput', 'Jaipur', 'Rajasthan', 'Medium Value');

-- =============================================
-- 4. Populating Fact Sales (40 Transactions)
-- =============================================
-- Note: product_key 1 is Samsung (80k), 14 is Bottle (500)
-- Keys are matched to the Auto-Increment IDs generated above
INSERT INTO fact_sales (date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount) VALUES 
(20240101, 1, 1, 1, 80000.00, 0.00, 80000.00),
(20240101, 14, 2, 2, 500.00, 0.00, 1000.00),
(20240102, 6, 3, 1, 8000.00, 500.00, 7500.00),
(20240103, 3, 5, 1, 110000.00, 2000.00, 108000.00),
(20240105, 8, 7, 2, 3500.00, 0.00, 7000.00),
(20240106, 2, 4, 1, 130000.00, 5000.00, 125000.00), -- Weekend Sale
(20240106, 11, 9, 1, 45000.00, 0.00, 45000.00),
(20240107, 5, 1, 1, 55000.00, 1000.00, 54000.00),
(20240108, 12, 6, 1, 8000.00, 0.00, 8000.00),
(20240109, 15, 8, 1, 15000.00, 1500.00, 13500.00),
(20240110, 4, 10, 2, 25000.00, 0.00, 50000.00),
(20240112, 7, 11, 1, 12000.00, 0.00, 12000.00),
(20240113, 9, 12, 1, 9000.00, 500.00, 8500.00),
(20240114, 10, 2, 3, 4500.00, 0.00, 13500.00),
(20240115, 13, 5, 1, 35000.00, 2000.00, 33000.00),
(20240116, 1, 4, 1, 80000.00, 1000.00, 79000.00),
(20240117, 14, 3, 4, 500.00, 0.00, 2000.00),
(20240118, 6, 7, 1, 8000.00, 0.00, 8000.00),
(20240119, 2, 1, 1, 130000.00, 0.00, 130000.00),
(20240120, 3, 9, 1, 110000.00, 5000.00, 105000.00),
(20240201, 8, 2, 2, 3500.00, 200.00, 6800.00),
(20240201, 5, 5, 1, 55000.00, 0.00, 55000.00),
(20240202, 11, 6, 1, 45000.00, 1000.00, 44000.00),
(20240203, 15, 12, 1, 15000.00, 0.00, 15000.00),
(20240204, 1, 1, 1, 80000.00, 2000.00, 78000.00), -- Weekend Sale
(20240204, 7, 10, 2, 12000.00, 0.00, 24000.00),
(20240205, 12, 8, 1, 8000.00, 500.00, 7500.00),
(20240206, 4, 3, 1, 25000.00, 0.00, 25000.00),
(20240206, 9, 4, 1, 9000.00, 0.00, 9000.00),
(20240207, 13, 11, 1, 35000.00, 3000.00, 32000.00),
(20240207, 14, 7, 5, 500.00, 0.00, 2500.00),
(20240208, 6, 2, 1, 8000.00, 0.00, 8000.00),
(20240208, 2, 5, 1, 130000.00, 10000.00, 120000.00),
(20240209, 10, 6, 1, 4500.00, 0.00, 4500.00),
(20240209, 3, 9, 1, 110000.00, 0.00, 110000.00),
(20240210, 5, 1, 1, 55000.00, 500.00, 54500.00),
(20240210, 1, 8, 1, 80000.00, 0.00, 80000.00),
(20240210, 8, 12, 3, 3500.00, 0.00, 10500.00),
(20240210, 15, 4, 1, 15000.00, 1500.00, 13500.00),
(20240210, 11, 3, 1, 45000.00, 0.00, 45000.00);
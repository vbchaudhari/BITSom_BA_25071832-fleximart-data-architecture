# FlexiMart Database Schema Documentation

## 1. Entity-Relationship Description

### **ENTITY: customers**
* **Purpose:** Stores personal and contact details of registered customers.
* **Attributes:**
    * `customer_id`: Unique identifier (Primary Key, Auto-Increment).
    * `first_name`: Customer's first name.
    * `last_name`: Customer's last name.
    * `email`: Unique email address for contact.
    * `phone`: Standardized contact number (+91 format).
    * `city`: Customer's city of residence.
    * `registration_date`: Date when the customer registered.
* **Relationships:**
    * **One-to-Many (1:M):** One customer can place MANY orders. This is linked via `customer_id` in the `orders` table.

### **ENTITY: products**
* **Purpose:** Maintains the inventory of items available for sale.
* **Attributes:**
    * `product_id`: Unique identifier (Primary Key, Auto-Increment).
    * `product_name`: Name of the item.
    * `category`: Product category (e.g., Electronics, Fashion).
    * `price`: Current unit price of the product.
    * `stock_quantity`: Available stock count.
* **Relationships:**
    * **One-to-Many (1:M):** One product can appear in MANY order items across different orders.

### **ENTITY: orders**
* **Purpose:** Captures the header information for sales transactions.
* **Attributes:**
    * `order_id`: Unique transaction identifier (Primary Key).
    * `customer_id`: Foreign Key linking to the `customers` table.
    * `order_date`: The date the order was placed.
    * `total_amount`: Total value of the order.
    * `status`: Order status (e.g., Pending, Completed).
* **Relationships:**
    * **Many-to-One (M:1):** Many orders belong to ONE customer.
    * **One-to-Many (1:M):** One order contains MANY order items.

### **ENTITY: order_items**
* **Purpose:** Acts as a bridge table to store line-item details for each order.
* **Attributes:**
    * `order_item_id`: Unique ID for the line item (Primary Key).
    * `order_id`: Foreign Key linking to `orders`.
    * `product_id`: Foreign Key linking to `products`.
    * `quantity`: Number of units purchased.
    * `unit_price`: Price per unit at the time of purchase.
    * `subtotal`: Calculated total for this line item.

---

## 2. Normalization Explanation

The database design adheres to the **Third Normal Form (3NF)** to ensure data integrity and minimize redundancy.

**Why it is in 3NF:**

1.  **First Normal Form (1NF):** All tables have a primary key, and all columns contain atomic values. There are no repeating groups (e.g., we do not store a list of products in a single cell in the `orders` table; instead, we use the `order_items` table).
2.  **Second Normal Form (2NF):** The schema is in 1NF, and all non-key attributes are fully functionally dependent on the primary key. Since we use single-column surrogate keys (Auto-Increment IDs) for all tables, there are no partial dependencies that typically occur with composite keys.
3.  **Third Normal Form (3NF):** There are no transitive dependencies. Non-key attributes depend *only* on the primary key. For example, a customer's `city` depends only on `customer_id`. We do not store customer contact details in the `orders` table.

**Avoidance of Anomalies:**
* **Update Anomaly:** Since customer details (like `phone` or `city`) are stored only in the `customers` table, if a customer moves to a new city, we only update one record. We do not need to update every historical order they placed.
* **Insert Anomaly:** We can add a new product to the `products` table without waiting for someone to buy it. Similarly, we can register a customer without them placing an order immediately.
* **Delete Anomaly:** If we delete an order, we do not lose the customer's information or the product details, as they are stored in separate parent tables.

---

## 3. Sample Data Representation

**Table: customers**
| customer_id | first_name | last_name | email | city |
| :--- | :--- | :--- | :--- | :--- |
| 1 | Rahul | Sharma | rahul.sharma@gmail.com | Bangalore |
| 2 | Priya | Patel | priya.patel@yahoo.com | Mumbai |
| 3 | Amit | Kumar | C003@missing.com | Delhi |

**Table: products**
| product_id | product_name | category | price | stock_quantity |
| :--- | :--- | :--- | :--- | :--- |
| 1 | Galaxy S21 | Electronics | 45999.00 | 150 |
| 2 | Nike Shoes | Fashion | 3499.00 | 80 |
| 3 | MacBook Pro | Electronics | 120000.00 | 45 |

**Table: orders**
| order_id | customer_id | order_date | total_amount | status |
| :--- | :--- | :--- | :--- | :--- |
| 101 | 1 | 2024-01-15 | 45999.00 | Completed |
| 102 | 2 | 2024-01-16 | 5998.00 | Completed |

**Table: order_items**
| order_item_id | order_id | product_id | quantity | unit_price |
| :--- | :--- | :--- | :--- | :--- |
| 501 | 101 | 1 | 1 | 45999.00 |
| 502 | 102 | 2 | 2 | 2999.00 |
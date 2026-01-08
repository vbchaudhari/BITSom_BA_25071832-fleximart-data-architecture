# Star Schema Design Documentation

## Section 1: Schema Overview

I have designed a **Star Schema** for the FlexiMart data warehouse. This design has one central Fact table containing metrics and three connected Dimension tables containing details.

### **FACT TABLE: fact_sales**
* **Grain:** Line-item level (One row for every single product in an order).
* **Business Process:** It tracks the finalized sales transactions.
* **Measures (Numeric Facts):**
    * `quantity_sold`: How many items were purchased.
    * `unit_price`: The cost of one item at that time.
    * `discount_amount`: Any discount given on the item.
    * `total_amount`: Final calculation (Quantity × Price - Discount).
* **Foreign Keys:**
    * `date_key` (Links to dim_date)
    * `product_key` (Links to dim_product)
    * `customer_key` (Links to dim_customer)

### **DIMENSION TABLE: dim_date**
* **Purpose:** To filter and group sales by time (Yearly, Monthly, etc.).
* **Type:** Conformed Dimension.
* **Attributes:**
    * `date_key` (PK): A simple integer key (Format: YYYYMMDD, e.g., 20240115).
    * `full_date`: The actual date format (YYYY-MM-DD).
    * `day_of_week`: Name of the day (Monday, Tuesday).
    * `month`: Number 1-12.
    * `month_name`: January, February, etc.
    * `quarter`: Q1, Q2, Q3, Q4.
    * `year`: 2023, 2024, etc.
    * `is_weekend`: Boolean (True if Saturday/Sunday).

### **DIMENSION TABLE: dim_product**
* **Purpose:** Stores details about the items sold.
* **Attributes:**
    * `product_key` (PK): Surrogate Key (Auto-increment 1, 2, 3...).
    * `product_id`: Original ID from the source system (Natural Key).
    * `product_name`: Name of the product.
    * `category`: E.g., Electronics, Fashion.
    * `subcategory`: E.g., Laptops, Shoes.
    * `unit_price`: Current price listing.

### **DIMENSION TABLE: dim_customer**
* **Purpose:** Stores details about who bought the items.
* **Attributes:**
    * `customer_key` (PK): Surrogate Key (Auto-increment 1, 2, 3...).
    * `customer_id`: Original ID from source (Natural Key).
    * `customer_name`: Full name of the customer.
    * `city`: Customer's city.
    * `state`: Customer's state.
    * `segment`: Customer grouping (High/Medium/Low value).

---

## Section 2: Design Decisions

**1. Why this Granularity (Line-item level)?**
I chose the "Line Item" level instead of the "Order" level because it provides more detail. If a customer buys a Laptop and a Mouse in one order, storing it as one row would hide the details of the individual items. By storing one row per item, we can analyze which specific products are performing best, not just total order values.

**2. Why Surrogate Keys?**
I used Surrogate Keys (simple integers like 1, 2, 3) instead of Natural Keys (like C001, P001) for two reasons:
* **Performance:** Joining tables using simple numbers is faster than using text IDs.
* **Stability:** If the source system changes its ID format (e.g., from C001 to CUST-001), our warehouse won't break because we use our own internal keys.

**3. Drill-down and Roll-up Support**
This design makes analysis easy.
* **Drill-down:** We can start with "Yearly Sales" and drill down to "Quarterly," then "Monthly," and finally "Daily" sales using the `dim_date` hierarchy.
* **Roll-up:** We can easily sum up sales from "City" level to "State" level using the `dim_customer` table.

---

## Section 3: Sample Data Flow

Here is an example of how a single transaction moves from the source application to our data warehouse.

**Source Transaction:**
* **Order:** #101
* **Date:** 15th Jan 2024
* **Customer:** "John Doe" (ID: C001, City: Mumbai)
* **Product:** "Laptop" (ID: P005, Category: Electronics)
* **Qty:** 2
* **Price:** 50,000

**Becomes in Data Warehouse:**

**Table: fact_sales**
```json
{
  "sale_key": 500,
  "date_key": 20240115,
  "product_key": 5,
  "customer_key": 12,
  "quantity_sold": 2,
  "unit_price": 50000,
  "discount_amount": 0,
  "total_amount": 100000
}

Table: dim_date
{
  "date_key": 20240115,
  "full_date": "2024-01-15",
  "month_name": "January",
  "quarter": "Q1",
  "year": 2024,
  "is_weekend": false
}

Table: dim_product
{
  "product_key": 5,
  "product_id": "P005",
  "product_name": "Laptop",
  "category": "Electronics"
}

Table: dim_customer
{
  "customer_key": 12,
  "customer_id": "C001",
  "customer_name": "John Doe",
  "city": "Mumbai"
}
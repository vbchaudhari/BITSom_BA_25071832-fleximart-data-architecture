import pandas as pd
import mysql.connector
import re

# --- CONFIGURATION ---
DB_CONFIG = {
    'user': 'root',
    'password': 'xyz@2026',  
    'host': 'localhost',
    'database': 'fleximart'
}

def clean_phone(phone):
    if pd.isna(phone): return None
    clean = re.sub(r'[^\d+]', '', str(phone))
    if len(clean) == 10: return f"+91-{clean}"
    elif len(clean) > 10 and clean.startswith('91'): return f"+91-{clean[2:]}"
    elif len(clean) > 10 and clean.startswith('+91'): return f"+91-{clean[3:]}"
    elif len(clean) > 10 and clean.startswith('0'): return f"+91-{clean[1:]}"
    return clean

def run_etl():
    print("ETL Process Started...")
    
    # 1. EXTRACT
    try:
        df_customers = pd.read_csv('data/customers_raw.csv')
        df_products = pd.read_csv('data/products_raw.csv')
        df_sales = pd.read_csv('data/sales_raw.csv')
        print("Files read successfully.")
    except Exception as e:
        print(f"Error reading files: {e}")
        return

    # 2. TRANSFORM
    # Customers
    df_customers = df_customers.drop_duplicates(subset=['customer_id'], keep='first')
    df_customers['email'] = df_customers['email'].fillna(df_customers['customer_id'] + '@missing.com')
    df_customers['phone'] = df_customers['phone'].apply(clean_phone)
    df_customers['registration_date'] = pd.to_datetime(df_customers['registration_date'], errors='coerce').dt.strftime('%Y-%m-%d')

    # Products
    df_products['category'] = df_products['category'].str.strip().str.title()
    df_products = df_products.dropna(subset=['price'])
    df_products['stock_quantity'] = df_products['stock_quantity'].fillna(0).astype(int)

    # Sales (Updated Logic to fix Date Error)
    df_sales['transaction_date'] = pd.to_datetime(df_sales['transaction_date'], errors='coerce').dt.strftime('%Y-%m-%d')
    # Drop rows where Date, Customer ID, or Product ID is missing
    df_sales = df_sales.dropna(subset=['customer_id', 'product_id', 'transaction_date'])

    # 3. LOAD
    try:
        conn = mysql.connector.connect(**DB_CONFIG)
        cursor = conn.cursor()
        
        # ID Mapping Dictionaries
        cust_map = {}
        prod_map = {}

        print("Loading Customers...")
        for _, row in df_customers.iterrows():
            sql = "INSERT INTO customers (first_name, last_name, email, phone, city, registration_date) VALUES (%s, %s, %s, %s, %s, %s)"
            val = (row['first_name'], row['last_name'], row['email'], row['phone'], row['city'], row['registration_date'])
            cursor.execute(sql, val)
            cust_map[row['customer_id']] = cursor.lastrowid

        print("Loading Products...")
        for _, row in df_products.iterrows():
            sql = "INSERT INTO products (product_name, category, price, stock_quantity) VALUES (%s, %s, %s, %s)"
            val = (row['product_name'], row['category'], row['price'], row['stock_quantity'])
            cursor.execute(sql, val)
            prod_map[row['product_id']] = cursor.lastrowid

        print("Loading Orders & Items...")
        for _, row in df_sales.iterrows():
            db_cust_id = cust_map.get(row['customer_id'])
            db_prod_id = prod_map.get(row['product_id'])

            if db_cust_id and db_prod_id:
                # Insert into Orders
                sql_order = "INSERT INTO orders (customer_id, order_date, total_amount, status) VALUES (%s, %s, %s, %s)"
                total_amt = float(row['unit_price']) * int(row['quantity'])
                val_order = (db_cust_id, row['transaction_date'], total_amt, row['status'])
                cursor.execute(sql_order, val_order)
                
                new_order_id = cursor.lastrowid

                # Insert into Order Items
                sql_item = "INSERT INTO order_items (order_id, product_id, quantity, unit_price, subtotal) VALUES (%s, %s, %s, %s, %s)"
                val_item = (new_order_id, db_prod_id, row['quantity'], row['unit_price'], total_amt)
                cursor.execute(sql_item, val_item)

        conn.commit()
        print("Data Loaded Successfully! Check Workbench now.")
        
    except mysql.connector.Error as err:
        print(f"Database Error: {err}")
    finally:
        if conn.is_connected():
            cursor.close()
            conn.close()

if __name__ == "__main__":
    run_etl()
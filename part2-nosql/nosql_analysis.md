# NoSQL Justification Report for FlexiMart

## Section A: Limitations of RDBMS (MySQL)
The current relational database architecture faces significant challenges as FlexiMart expands into diverse product categories:

1.  **Sparse Tables & Attribute Variety:** In an RDBMS, every row in a table must follow the same schema. If we sell laptops (requiring 'RAM', 'Processor') and shoes (requiring 'Size', 'Material') in the same `products` table, we would need to create columns for all possible attributes. This leads to a "sparse" table where a laptop row has NULLs for shoe size, and a shoe row has NULLs for RAM. This wastes storage and makes the schema messy.
2.  **Schema Rigidity:** Adding a new product type (e.g., "Air Conditioners" with 'Tonnage') requires executing an `ALTER TABLE` command to add columns. In a production environment with millions of records, this operation locks the table, causing downtime and performance degradation.
3.  **Complex Review Storage:** Customer reviews are naturally "nested" data linked to a product. In SQL, we must store reviews in a separate table and use `JOIN` operations to retrieve a product with its reviews. As traffic grows, these joins become expensive and slow down page loads.

## Section B: NoSQL Benefits (MongoDB)
MongoDB is good for FlexiMart because it solves the problems we talked about.

1.  **Flexible Schema (Document Model):** MongoDB does not use strict tables. We can store every product differently using JSON documents. One document can have `{"ram": "16GB", "cpu": "M1"}` while another has `{"size": "10", "color": "Red"}`. There is no need to pre-define columns or handle NULL values for irrelevant attributes, making it perfect for a diverse catalog.
2.  **Embedded Documents:** Instead of a separate table, customer reviews can be stored directly inside the product document as an array (e.g., `"reviews": [{...}, {...}]`). This leverages "Data Locality"—a single read query fetches the product details AND all its reviews instantly, without needing expensive JOINs.
3.  **Horizontal Scalability (Sharding):** As the catalog grows to millions of products, a single SQL server may hit its limit (Vertical Scaling limit). MongoDB supports "Sharding" out of the box, allowing us to distribute data across multiple cheap servers (Horizontal Scaling) seamlessly to handle high traffic.

## Section C: Trade-offs (Disadvantages)
While MongoDB is suitable for the catalog, there are trade-offs compared to MySQL:

1.  **ACID Transactions:** MySQL guarantees strict ACID compliance (Atomicity, Consistency, Isolation, Durability) which is critical for financial transactions (e.g., billing and inventory deduction). While MongoDB supports transactions, they are more complex to implement and less performant than MySQL's native transaction handling.
2.  **Complex Analytical Queries:** If business analysts need to run complex queries involving multiple joins (e.g., "Find total sales revenue grouped by city and product category"), SQL is far more powerful and efficient. MongoDB's aggregation framework can do this, but it is often more complex to write and harder to optimize for deep analytics compared to SQL joins.
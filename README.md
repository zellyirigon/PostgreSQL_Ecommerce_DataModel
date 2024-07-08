# E-commerce Portal Data Model Implementation 🛒📊

## Overview ℹ️
This project involves designing and implementing a data model for an E-commerce Portal using PostgreSQL. The data model includes dimensions for customers, products, shipping details, dates, and a sales fact table.

## Files 📁
- **creation_schema_and_tables_dw**: Script to create the database schema with tables for dimensions (Customer, Product, Shipping, Date) and a Sales fact table.
- **script_customer**: Script to populate the Customer dimension table with fictitious data.
- **script_date**: Script to populate the Date dimension table with fictitious data.
- **script_products**: Script to populate the Product dimension table with fictitious data.
- **script_sales_table**: Script to populate the Sales fact table with fictitious data.
- **script_shipping_company**: Script to populate the Shipping dimension table with fictitious data.

## Usage 🚀
1. **Creating Schema**: Execute `creation_schema_and_tables_dw.sql` to create the database schema.
2. **Populating Data**: Use the respective scripts (`script_customer.sql`, `script_date.sql`, `script_products.sql`, `script_sales_table.sql`, `script_shipping_company.sql`) to populate the corresponding tables with fictitious data.
    ```sql
    -- Example:
    psql -U username -d database_name -a -f script_customer.sql
    ```
3. **Viewing Data**: Query the tables to view the populated data.
    ```sql
    SELECT * FROM dw.sales;
    ```

## Notes 📝
- This project is for educational purposes to demonstrate database design and ETL processes.
- Data generated is fictitious and intended solely for testing and learning.

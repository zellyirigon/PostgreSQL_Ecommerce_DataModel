<<<<<<< HEAD
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
=======
# E-commerce Portal Analysis using PostgreSQL 📊🛒

## Overview

Welcome to my personal project where I analyse an e-commerce portal using PostgreSQL. This project is part of my journey to achieve excellence in data science. The goal is to create a robust data model and perform insightful queries to derive meaningful insights about the e-commerce operations.

## Project Files 📂

Here is a brief overview of the SQL scripts used in this project:

1. **creation_schema_and_tables_dw.sql**: Script for creating the schema and tables for the data warehouse.
2. **queries_to_learn_sql.sql**: Collection of SQL queries to practice and learn various SQL functionalities.
3. **script_customer.sql**: Script to create and manage the customer table.
4. **script_products.sql**: Script to create and manage the products table.
5. **script_sales_table.sql**: Script to create and manage the sales table.
6. **script_shipping_company.sql**: Script to create and manage the shipping company table.

## Schema and Tables 🗂️

### 1. Creation of Schema and Tables

The `creation_schema_and_tables_dw.sql` file sets up the schema and tables required for the data warehouse. The tables include:
- Customers
- Products
- Sales
- Shipping Companies

### 2. Customer Table

The `script_customer.sql` file creates the `Customer` table, which stores information about customers including their ID, name, contact details, and address.

### 3. Products Table

The `script_products.sql` file creates the `Products` table, which stores details about the products available in the e-commerce portal such as product ID, name, description, and price.

### 4. Sales Table

The `script_sales_table.sql` file creates the `Sales` table, which records the sales transactions including sales ID, customer ID, product ID, quantity sold, sales date, and total amount.

### 5. Shipping Company Table

The `script_shipping_company.sql` file creates the `Shipping Company` table, which holds information about the shipping companies that deliver the products to customers.

## Learning SQL with Queries 📖

The `queries_to_learn_sql.sql` file contains a series of SQL queries designed to help me learn and practice different SQL operations such as:
- Selecting data
- Filtering results
- Joining tables
- Aggregating data
- Using subqueries

## How to Use This Project

1. **Set up PostgreSQL**: Ensure you have PostgreSQL installed on your system.
2. **Execute the Scripts**: Run the provided SQL scripts in the following order:
   - `creation_schema_and_tables_dw.sql`
   - `script_customer.sql`
   - `script_products.sql`
   - `script_sales_table.sql`
   - `script_shipping_company.sql`
3. **Practice SQL**: Use the `queries_to_learn_sql.sql` file to practice and enhance your SQL skills.

## Conclusion

This project is a comprehensive exercise in building and analysing an e-commerce portal using PostgreSQL. It demonstrates the fundamental skills required for data modeling, SQL querying, and data management. I look forward to expanding this project further and gaining deeper insights into e-commerce data analysis.

Feel free to explore the scripts and practice SQL! 😊 

**Date**: July 2024
>>>>>>> origin/master

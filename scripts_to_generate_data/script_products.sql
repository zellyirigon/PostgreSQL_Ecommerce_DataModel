-- Case Study 1 - Building and Implementing a Data Model for an E-commerce Portal
-- ETL Process of the Products Table

-- Create the Function
CREATE OR REPLACE FUNCTION dw.etl_products(num_products INTEGER)
RETURNS VOID AS $$
DECLARE
    i INTEGER := 1;
    product_name VARCHAR;
    product_description VARCHAR;
    product_price DECIMAL;
    product_category VARCHAR;
BEGIN
    WHILE i <= num_products LOOP
        product_name := 'Product ' || i::TEXT;
        product_description := 'Product Description ' || i::TEXT;
        product_price := ROUND((RANDOM() * 1000)::NUMERIC, 2); -- Price between 0.00 and 1000.00
        product_category := 'Category ' || ((i % 5) + 1)::TEXT; -- 5 different categories

        INSERT INTO dw.Product (Name, Description, Price, CategoryName)
        VALUES (product_name, product_description, product_price, product_category);

        i := i + 1;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Execute the Function
SELECT dw.etl_products(100);

-- View the data
SELECT * FROM dw.product;

-- Case Study 1 - Building and Implementing a Data Model for an E-commerce Portal
-- ETL Process of the Sales Table

-- Create the Function
CREATE OR REPLACE FUNCTION dw.etl_sales(num_sales INTEGER)
RETURNS VOID AS $$
DECLARE
    i INT := 1;
    customer_id INT;
    product_id INT;
    shipping_id INT;
    date_id INT;
    sold_quantity INT;
    revenue DECIMAL;
    shipping_cost DECIMAL;
BEGIN
    FOR i IN 1..num_sales LOOP
    
        -- Select random IDs from dimension tables
        SELECT INTO customer_id CustomerID FROM dw.Customer ORDER BY RANDOM() LIMIT 1;
        SELECT INTO product_id ProductID FROM dw.Product ORDER BY RANDOM() LIMIT 1;
        SELECT INTO shipping_id ShippingID FROM dw.Shipping ORDER BY RANDOM() LIMIT 1;
        SELECT INTO date_id DateID FROM dw.Date ORDER BY RANDOM() LIMIT 1;

        -- Generate fictitious data for other fields
        sold_quantity := TRUNC(RANDOM() * 100 + 1);
        revenue := sold_quantity * (RANDOM() * 100);
        shipping_cost := revenue * RANDOM() * 0.1;  -- Random shipping cost, up to 10% of the revenue

        INSERT INTO dw.Sales (CustomerID, ProductID, ShippingID, DateID, SoldQuantity, Revenue, ShippingCost)
        VALUES (customer_id, product_id, shipping_id, date_id, sold_quantity, revenue, shipping_cost);
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Execute the Function
SELECT dw.etl_sales(20000);

-- View the data
SELECT * FROM dw.sales;

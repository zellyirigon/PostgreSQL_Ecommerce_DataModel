-- Case Study 1 - Building and Implementing a Data Model for an E-commerce Portal
-- ETL Process of the Shipping Company Table

-- Create the Function
CREATE OR REPLACE FUNCTION dw.etl_shipping_company(shipping_num INTEGER)
RETURNS VOID AS $$
DECLARE
    i INTEGER := 1;
    shipping_name VARCHAR;
    shipping_city VARCHAR;
    shipping_country VARCHAR;
    shipping_place VARCHAR[] := ARRAY['São Paulo, Brazil', 'Rio de Janeiro, Brazil', 'New York, EUA', 'Los Angeles, EUA', 'Sydney, Australia', 'Auckland, New Zealand'];
BEGIN
    WHILE i <= shipping_num LOOP
        shipping_name := 'Distribuidor ' || i::TEXT;
        shipping_city := SPLIT_PART(shipping_place[(i - 1) % ARRAY_LENGTH(shipping_place, 1) + 1], ', ', 1);
        shipping_country := SPLIT_PART(shipping_place[(i - 1) % ARRAY_LENGTH(shipping_place, 1) + 1], ', ', 2);

        INSERT INTO dw.Shipping (ShippingName, ShippingCity, ShippingCountry)
        VALUES (shipping_name, shipping_city, shipping_country);

        i := i + 1;
    END LOOP;
END;
$$ LANGUAGE plpgsql;


-- Execute the Function
SELECT dw.etl_shipping_company(30);


-- View the data
SELECT * FROM dw.shipping;

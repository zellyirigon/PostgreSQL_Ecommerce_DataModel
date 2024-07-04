-- ETL Process of the Customer Table

-- Create the Function
CREATE OR REPLACE FUNCTION dw.etl_customer(customer_num INTEGER)
RETURNS VOID AS $$
DECLARE
    i INTEGER := 1;
    customer_name VARCHAR;
    customer_address VARCHAR;
    customer_city VARCHAR;
    customer_country VARCHAR;
    cities VARCHAR[] := ARRAY['Sydney, Australia', 'Nelson, New Zealand', 'Auckland, New Zealand', 'São Paulo, Brazil', 'Rio de Janeiro, Brazil', 'Salvador, Brazil'];
BEGIN
    WHILE i <= customer_num LOOP
        customer_name := 'Data Customer ' || i::TEXT;
        customer_address := 'Street ' || chr(trunc(65 + random()*25)::int) || ', ' || trunc(random()*1000)::text;
        customer_city := cities[1 + TRUNC(RANDOM() * (ARRAY_LENGTH(cities, 1) - 1))];

        -- Separating the city and the country
        customer_country := SPLIT_PART(customer_city, ', ', 2);
        customer_city := SPLIT_PART(customer_city, ', ', 1);

        INSERT INTO dw.Customer (Name, Address, CustomerCity, CustomerCountry)
        VALUES (customer_name, customer_address, customer_city, customer_country);

        i := i + 1;
    END LOOP;
END;
$$ LANGUAGE plpgsql;


-- Execute the Function
-- The number between parentheses means how many records I want to genenrate in the table
SELECT dw.etl_customer(550); 


-- View the data
SELECT * FROM dw.cliente ORDER BY clienteid ASC;
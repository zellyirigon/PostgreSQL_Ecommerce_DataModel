-- Case Study 1 - Building and Implementing a Data Model for an E-commerce Portal
-- ETL Process of the Data Table


-- Creates a Function
CREATE OR REPLACE FUNCTION dw.generate_dates()
RETURNS VOID AS $$
DECLARE
    cur_date DATE;
BEGIN
    cur_date := '2021-01-01'; -- start date

    WHILE cur_date <= '2024-12-31' LOOP
        INSERT INTO dw.Date (Date, Day, Month, Year, Weekday)
        VALUES (cur_date, EXTRACT(DAY FROM cur_date), EXTRACT(MONTH FROM cur_date), EXTRACT(YEAR FROM cur_date), TO_CHAR(cur_date, 'Day'));

        cur_date := cur_date + INTERVAL '1 day'; -- Increment one day
    END LOOP;
END;
$$ LANGUAGE plpgsql;


-- Executing a Function
SELECT dw.generate_dates();


-- Visualizing data
SELECT * FROM dw.date;
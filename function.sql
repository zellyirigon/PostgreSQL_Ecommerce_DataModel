-- Function
-- To generate reports from SGBD

--Crate the Function
CREATE OR REPLACE FUNCTION dw_fn_category_sales_report(CustomerName VARCHAR(255))
RETURNS TABLE(
	Category VARCHAR(255),
	TotalSales DECIMAL(10,2),
	Above60000 VARCHAR(5)
)
LANGUAGE plpgsql
AS $$
BEGIN
	-- Validate if the customername is the right format('Data Customer' followed by numbers)
	IF CustomerName ~ 'Data Customer [0-9]+' THEN
		RETURN QUERY
		SELECT
			p.CategoryName AS Category,
			SUM(s.revenue) AS TotalSales,
			CASE
				WHEN SUM(s.revenue) > 60000 THEN 'yes'::VARCHAR(5)
				ELSE 'no'::VARCHAR(5)
			END AS Above60000
		FROM
			dw.Sales s
		JOIN
			dw.Product p ON s.productid = p.productid
		JOIN
			dw.Customer c ON s.customerid = c.customerid
		WHERE
			c.Name = CustomerName
		GROUP BY
			p.CategoryName
		ORDER BY
			p.CategoryName;
	ELSE
		RAISE EXCEPTION 'The customer name is not in the expected format: ''Data Customer [0-9]+''';
	END IF;
END;
$$;

--Execute Function
SELECT * FROM dw_fn_category_sales_report('Data Customer 123');
SELECT * FROM dw_fn_category_sales_report('Data Customer 323');
SELECT * FROM dw_fn_category_sales_report('Data Customer');

-- Drop the existing function
DROP FUNCTION IF EXISTS dw_fn_category_sales_report(VARCHAR(255));
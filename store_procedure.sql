-- Create a table
CREATE TABLE IF NOT EXISTS dw.tb_sales_report_above_10000(
	Customer varchar(255),
	TotalRevenue Decimal (10, 2)
);

-- Stored Procedure to save in the table the customers that generated revenue above 10000
CREATE OR REPLACE PROCEDURE dw.sp_customer_sales_report()
LANGUAGE plpgsql --programming language from PostgreSQL
AS $$ -- open the block code
BEGIN --start logical code
	-- create a temporary table to store sales report
	CREATE TEMP TABLE IF NOT EXISTS temp_sales_report ON COMMIT DROP AS -- the table only exists during the procedure execution
	SELECT
		c.Name AS Customer,
		SUM(s.Revenue) AS TotalRevenue
	FROM
		dw.Sales s 
	JOIN
	    dw.Customer c ON s.customerid = c.customerid
	GROUP BY
	    c.Name
	ORDER BY
	    TotalRevenue DESC;

	-- Insert on the report table only the customers with revenue total bigger than 10000
	INSERT INTO dw.tb_sales_report_above_10000(Customer, TotalRevenue)
	SELECT
		Customer,
		TotalRevenue
	FROM
		temp_sales_report
	WHERE
		TotalRevenue > 10000;
END;
$$ -- close the code block

-- STORED PROCEDURE in SQL are precompiled sets of one or more SQL statements that are stored in the database itself. 
--Here's why they are useful and necessary:

--Modularity and Reusability: Stored procedures allow you to encapsulate complex SQL logic into a single unit. This makes your code modular, 
--easier to maintain, and promotes code reusability. Instead of writing the same SQL code repeatedly across different parts of your application, 
--you can call the stored procedure.

--Improved Performance: Stored procedures can improve performance because they are precompiled and stored in a compiled format in the database. 
--This reduces the overhead of repeatedly parsing and compiling SQL statements every time they are executed. Additionally, stored procedures can 
--reduce network traffic by executing multiple SQL statements within the database server itself.

--Enhanced Security: Stored procedures can help enhance security by allowing you to restrict direct access to tables. Instead of granting users 
--direct table access, you grant them access only to execute specific stored procedures. This allows you to control what data users can access and
--what operations they can perform on that data.

--Transaction Management: Stored procedures can include transaction management logic. This means you can wrap multiple SQL operations within a 
--single transaction, ensuring data integrity and consistency. If an error occurs within a transaction, you can roll back all changes made by the 
--stored procedure.

--Simplified Maintenance: When business logic changes, you only need to update the stored procedure itself rather than every part of your 
--application that uses that logic. This reduces the risk of inconsistency that might arise from updating multiple instances of the same logic 
--scattered throughout your codebase.

--Overall, stored procedures provide a structured and efficient way to manage and execute SQL code within a database environment, offering benefits
--in terms of performance, security, maintenance, and code organisation.







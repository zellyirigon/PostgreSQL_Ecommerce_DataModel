--(SQL Basic Level)

--List all Products
SELECT *
FROM dw.Product;

--List name, price and category
SELECT name, price, categoryname
FROM dw.Product
WHERE CategoryName = 'Category 2'

--Aggregation Functions using Alias (AS)
SELECT COUNT(price) AS Count,
		MIN(price) AS Mininum_Value, 
		SUM(price) AS Total, 
		Round(AVG(price),2) AS Average, 
		MAX(price) AS Maximun_Value
FROM dw.Product
WHERE CategoryName = 'Category 2';

--(SQL Intermediate Level)
-- List products from Category 2 and prices bigger than 350
SELECT name, price, categoryname
FROM dw.Product
WHERE CategoryName = 'Category 2' OR Price > 350;

--List products from Category 2 and prices bigger than 350 or only prices bigger than 350
SELECT name, price, categoryname
FROM dw.Product
WHERE (CategoryName ='Category 2' AND Price > 350) OR Price > 350;

-- List name, category and sold quantity for each product
SELECT p.name, p.categoryname, s.soldquantity 
FROM dw.Product p
JOIN dw.Sales s ON p.productid = s.productid;

--Join with 3 tables
--List name, category, sold quantity and sales date for each product
SELECT p.name, p.categoryname, s.soldquantity, d.date
FROM dw.Product p
JOIN dw.Sales s ON p.productid = s.productid
JOIN dw.Date d ON d.dateid = s.dateid;

-- Join with 4 tables
-- List name, category, sold quantity, sales date and country of the customer, for each product
SELECT p.name, p.categoryname, s.soldquantity, d.date, c.customercountry
FROM dw.Product p
JOIN dw.Sales s ON p.productid = s.productid
JOIN dw.Date d ON d.dateid = s.dateid
JOIN dw.Customer c ON c.customerid = s.customerid;
	
-- Join with 5 tables
-- List name, category, sold quantity, sales date, country of the customer and the shipping company, for each product	
SELECT p.name, p.categoryname, s.soldquantity, d.date, c.customercountry, sh.shippingname
FROM dw.Product p
JOIN dw.Sales s ON p.productid = s.productid
JOIN dw.Date d ON d.dateid = s.dateid
JOIN dw.Customer c ON c.customerid = s.customerid
JOIN dw.Shipping sh ON sh.shippingid = s.shippingid;

-- List name, category, sold quantity, sales date, country of the customer and the shipping company, for each product:
-- with category 2 and price bigger than 350 or price bigger than 350
SELECT p.name, p.price, p.categoryname, s.soldquantity, d.date, c.customercountry, sh.shippingname
FROM dw.Product p
JOIN dw.Sales s ON p.productid = s.productid
JOIN dw.Date d ON d.dateid = s.dateid
JOIN dw.Customer c ON c.customerid = s.customerid
JOIN dw.Shipping sh ON sh.shippingid = s.shippingid
WHERE (p.CategoryName ='Category 2' AND p.Price > 350) OR p.Price > 350;

--(SQL Advanced Level)
-- Price average by the product category
SELECT p.categoryname, ROUND(AVG(p.price),2) AS AVG_Price
FROM dw.Product p
GROUP BY p.categoryname; (--column-level aggregation)

-- Revenue average by the product category
SELECT p.categoryname, ROUND(AVG(s.revenue),2) AS AVG_Revenue
FROM dw.Product p
JOIN dw.Sales s ON p.productid = s.productid
GROUP BY p.categoryname;

-- Revenue sum by city of the customer
SELECT c.customercity, SUM(s.revenue), AS Revenue_Total
FROM dw.Customer c
JOIN dw.Sales s ON c.customerid = s.customerid
GROUP BY c.customercity;

--Revenue average by weekday, sorted by revenue and only to work days.
SELECT  d.weekday, ROUND(AVG(s.revenue),2) AS AVG_Revenue
FROM dw.Sales s
JOIN dw.Date d ON s.dateid = d.dateid
WHERE TRIM (d.weekday) NOT IN ('Sunday','Saturday') --TRIM -> remove space before and after the string
GROUP BY d.weekday
ORDER BY AVG_Revenue DESC;

-- Total sales and shipping cost by customer country and product category for the year 2024
SELECT c.customercountry, p.categoryname, SUM(s.shippingcost) AS Shipping_Cost, SUM(s.revenue) AS Revenue_Total
FROM dw.Product p
JOIN dw.Sales s ON p.productid = s.productid
JOIN dw.Customer c ON c.customerid = s.customerid
JOIN dw.Date d ON d.dateid = s.dateid
WHERE d.year = '2024'
GROUP BY c.customercountry, p.categoryname
ORDER BY c.customercountry, p.categoryname;

-- Minimum, maximum and average of the sold quantity by category and shipping name, for customers from Nelson and prices bigger than 350,
-- or prices bigger than 350, and for work days.
SELECT p.categoryname, sh.shippingname, 
	MIN(s.soldquantity) AS MIN_Sold_Qty, 
	MAX(s.soldquantity) AS MAX_Sold_Qty, 
	ROUND(AVG(s.soldquantity),2) AS AVG_Sold_Qty
FROM dw.Product p
JOIN dw.Sales s ON p.productid = s.productid
JOIN dw.Customer c ON c.customerid = s.customerid
JOIN dw.Shipping sh ON sh.shippingid = s.shippingid
JOIN dw.Date d ON d.dateid = s.dateid
WHERE((c.customercity = 'Nelson' AND p.price > 350) OR p.price > 350) 
	AND TRIM(d.weekday) NOT IN ('Saturday','Sunday')
GROUP BY p.categoryname, sh.shippingname
ORDER BY p.categoryname, sh.shippingname;

-- HAVING Clause -> Filter by the aggregation
-- Total sales and shipping cost by customer country and category product, for the year 2024, only if the total shipping cost is bigger than 30.000
SELECT  c.customercountry, p.categoryname,
	SUM(s.soldquantity)AS Total_Sales, 
	SUM(s.shippingcost)AS Total_Shipping_Cost
FROM dw.Product p
JOIN dw.Sales s ON p.productid =s.productid
JOIN dw.Date d ON d.dateid = s.dateid
JOIN dw.Customer c ON c.customerid = s.customerid
WHERE d.year ='2024'
GROUP BY p.categoryname, c.customercountry
HAVING SUM (s.shippingcost)>30000  
ORDER BY p.categoryname, c.customercountry;

-- To illustrate the use of a subquery in the context of this data model, I will create a query that identifies customers who have made 
-- purchases above the average. This query will calculate the total revenue per customer and then use a subquery to select only those 
-- customers whose total revenue is above the average.
SELECT c.name, SUM(s.revenue) AS Total_revenue
FROM dw.Sales s 
JOIN dw.Customer c ON s.customerid = c.customerid
GROUP BY c.name
	
-- Return only the customers who have made purchases above the average
HAVING SUM (s.revenue) > (
	
	-- Calc average revenue
	SELECT AVG(Total_revenue)
	FROM(
		-- Calc sum of revenue by customer
		SELECT SUM(s.revenue) AS Total_revenue
		FROM dw.Sales s
		GROUP BY s.customerid
	) AS Subquery
)
ORDER BY Total_revenue;

--Window Function (row-level aggregation)
-- Calculate the cumulative revenue total for each customer, ordered by the sale date.
SELECT c.name, d.date, s.revenue, SUM(s.revenue) OVER(PARTITION BY c.customerid ORDER BY d.date ASC) AS Cumulative_Total
FROM dw.Sales s
JOIN dw.Customer c ON s.customerid = c.customerid
JOIN dw.Date d ON s.dateid = d.dateid
ORDER BY
c.name,d.date;


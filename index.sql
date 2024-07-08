--Index - Generate gain performance

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

CREATE INDEX idx_date_year ON dw.Date(year);
CREATE INDEX idx_sales_customerid ON dw.Customer(customerid);
CREATE INDEX idx_sales_productid ON dw.Product(productid);
CREATE INDEX idx_sales_dateid ON dw.Date(dateid);

--Remove an Index
DROP INDEX dw.idx_sales_dateid;
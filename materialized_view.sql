-- Materialized View (MView)
CREATE MATERIALIZED VIEW dw.mv_sales_shipping_customer_category AS
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

--Consult MView
SELECT * FROM dw.mv_sales_shipping_customer_category;

--Update the data of the Mview
REFRESH MATERIALIZED VIEW dw.mv_sales_shipping_customer_category;
--DAwSQL Session -8 2021-08-07

--E-Commerce Project Solution



--1. Join all the tables and create a new table called combined_table. (market_fact, cust_dimen, orders_dimen, prod_dimen, shipping_dimen)





SELECT *
INTO
combined_table
FROM
(
SELECT 
cd.Cust_id, cd.Customer_Name, cd.Province, cd.Region, cd.Customer_Segment, 
mf.Ord_id, mf.Prod_id, mf.Sales, mf.Discount, mf.Order_Quantity, mf.Product_Base_Margin,
od.Order_Date, od.Order_Priority,
pd.Product_Category, pd.Product_Sub_Category,
sd.Ship_id, sd.Ship_Mode, sd.Ship_Date
FROM market_fact mf
INNER JOIN cust_dimen cd ON mf.Cust_id = cd.Cust_id
INNER JOIN orders_dimen od ON od.Ord_id = mf.Ord_id
INNER JOIN prod_dimen pd ON pd.Prod_id = mf.Prod_id
INNER JOIN shipping_dimen sd ON sd.Ship_id = mf.Ship_id
) A;


SELECT * 
FROM combined_table
ORDER BY Ord_id

--2. Find the top 3 customers who have the maximum count of orders.

SELECT  TOP 3 Cust_id, Customer_Name, COUNT(DISTINCT Ord_id) AS COUNT_ORDER
FROM combined_table
GROUP BY Cust_id, Customer_Name
ORDER BY 3 DESC

--3. Create a new column at combined_table as DaysTakenForDelivery 
--that contains the date difference of Order_Date and Ship_Date.

ALTER TABLE combined_table
ADD DaysTakenForDelivery INT

UPDATE combined_table
SET DaysTakenForDelivery=DATEDIFF(DAY,Order_Date,Ship_Date)
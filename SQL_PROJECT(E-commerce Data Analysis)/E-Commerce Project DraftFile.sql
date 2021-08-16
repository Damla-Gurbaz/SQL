

--DAwSQL Session -8 

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





--///////////////////////


--2. Find the top 3 customers who have the maximum count of orders.




SELECT TOP 3  Cust_id, count(Ord_id) AS total_ord
from combined_table
GROUP by Cust_id
ORDER by total_ord DESC



--/////////////////////////////////



--3.Create a new column at combined_table as DaysTakenForDelivery that contains the date difference of Order_Date and Ship_Date.
--Use "ALTER TABLE", "UPDATE" etc.
ALTER TABLE combined_table
ADD	DaysTakenForDelivery INT;

SELECT Order_Date, Ship_Date, DATEDIFF(day, Order_Date, Ship_Date) FROM combined_table
UPDATE combined_table
SET DaysTakenForDelivery = DATEDIFF(day, Order_Date, Ship_Date)

select * from combined_table

--////////////////////////////////////


--4. Find the customer whose order took the maximum time to get delivered.
--Use "MAX" or "TOP"


SELECT	Cust_id, Customer_Name, Order_Date, Ship_Date, DaysTakenForDelivery
FROM	combined_table
WHERE	DaysTakenForDelivery =(
								SELECT	MAX(DaysTakenForDelivery)
								FROM combined_table
								)
SELECT top 1 Customer_Name,Cust_id,DaysTakenForDelivery
FROM combined_table
order by DaysTakenForDelivery desc


--////////////////////////////////



--5. Count the total number of unique customers in January and how many of them came back every month over the entire year in 2011
--You can use such date functions and subqueries

SELECT MONTH(order_date) [MONTH], COUNT(DISTINCT cust_id) MONTHLY_NUM_OF_CUST
FROM	Combined_table A
WHERE
EXISTS
(
SELECT  Cust_id
FROM	combined_table B
WHERE	YEAR(Order_Date) = 2011
AND		MONTH (Order_Date) = 1
AND		A.Cust_id = B.Cust_id
)
AND	YEAR (Order_Date) = 2011
GROUP BY
MONTH(order_date)

--

select datename(Month,order_date) as month_name,Month(order_date) as month_number,  COUNT(distinct cust_id) as come_back 
from combined_table
where year(order_date ) = 2011 and 
cust_id in (
	select distinct Cust_id
	from combined_table
	where MONTH(Order_Date ) = 1
	and year(order_date ) = 2011)
group by datename(Month,order_date),Month(order_date)
order by Month(order_date)

--

WITH CUST_JAN AS(
SELECT DISTINCT Cust_id
FROM combined_table
WHERE MONTH(Order_Date)=01 AND YEAR(Order_Date)=2011)
SELECT DISTINCT [MONTH],COUNT(AA.Cust_id) OVER(PARTITION BY[MONTH])
FROM
(SELECT DISTINCT B.Cust_id,MONTH(B.Order_Date) AS [MONTH]
FROM CUST_JAN A
LEFT JOIN combined_table B
ON A.Cust_id=B.Cust_id
AND YEAR(B.Order_Date)='2011')AA





--////////////////////////////////////////////


--6. write a query to return for each user the time elapsed between the first purchasing and the third purchasing, 
--in ascending order by Customer ID
--Use "MIN" with Window Functions

select AA.Cust_id,AA.Customer_Name,AA.first_purc,AA.third_purc,DATEDIFF(day,AA.first_purc,AA.third_purc) time_elapsed
from
(SELECT Cust_id,Customer_Name,Order_Date as first_purc,
lead(Order_Date,2)over(partition by Cust_id order by Order_Date ASC) third_purc,
row_number() over(partition by Cust_id order by Order_Date ASC) row_each_cust
FROM combined_table)AA
where AA.row_each_cust='1'and AA.third_purc is not null and AA.first_purc is not null

select *
from shipping_dimen2

--//////////////////////////////////////

--7. Write a query that returns customers who purchased both product 11 and product 14, 
--as well as the ratio of these products to the total number of products purchased by the customer.
--Use CASE Expression, CTE, CAST AND such Aggregate Functions




--/////////////////



--CUSTOMER RETENTION ANALYSIS



--1. Create a view that keeps visit logs of customers on a monthly basis. (For each log, three field is kept: Cust_id, Year, Month)
--Use such date functions. Don't forget to call up columns you might need later.




--//////////////////////////////////


--2. Create a view that keeps the number of monthly visits by users. (Separately for all months from the business beginning)
--Don't forget to call up columns you might need later.






--//////////////////////////////////


--3. For each visit of customers, create the next month of the visit as a separate column.
--You can number the months with "DENSE_RANK" function.
--then create a new column for each month showing the next month using the numbering you have made. (use "LEAD" function.)
--Don't forget to call up columns you might need later.



--/////////////////////////////////



--4. Calculate the monthly time gap between two consecutive visits by each customer.
--Don't forget to call up columns you might need later.







--/////////////////////////////////////////


--5.Categorise customers using time gaps. Choose the most fitted labeling model for you.
--  For example: 
--	Labeled as churn if the customer hasn't made another purchase in the months since they made their first purchase.
--	Labeled as regular if the customer has made a purchase every month.
--  Etc.








--/////////////////////////////////////




--MONTH-W�SE RETENT�ON RATE


--Find month-by-month customer retention rate  since the start of the business.


--1. Find the number of customers retained month-wise. (You can use time gaps)
--Use Time Gaps





--//////////////////////


--2. Calculate the month-wise retention rate.

--Basic formula: o	Month-Wise Retention Rate = 1.0 * Total Number of Customers in The Previous Month / Number of Customers Retained in The Next Nonth

--It is easier to divide the operations into parts rather than in a single ad-hoc query. It is recommended to use View. 
--You can also use CTE or Subquery if you want.

--You should pay attention to the join type and join columns between your views or tables.







---///////////////////////////////////
--Good luck!
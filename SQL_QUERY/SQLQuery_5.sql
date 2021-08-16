--🔍 List customers who bought both 'Electric Bikes' and 'Comfort Bicycles' and 'Children Bicycles' in the same order.

SELECT	A.customer_id, A.first_name, A.last_name
FROM	sales.customers A, sales.orders B
WHERE	A.customer_id = B.customer_id
AND		B.order_id IN (
					SELECT	B.order_id
					FROM	production.products A, sales.order_items B
					WHERE	A.product_id = B.product_id
					AND		A.category_id = (
												SELECT	category_id
												FROM	production.categories
												WHERE	category_name = 'Electric Bikes'
											)
	INTERSECT
					SELECT	B.order_id
					FROM	production.products A, sales.order_items B
					WHERE	A.product_id = B.product_id
					AND		A.category_id = (
												SELECT	category_id
												FROM	production.categories
												WHERE	category_name = 'Comfort Bicycles'
											)
					INTERSECT
					SELECT	B.order_id
					FROM	production.products A, sales.order_items B
					WHERE	A.product_id = B.product_id
					AND		A.category_id = (
												SELECT	category_id
												FROM	production.categories
												WHERE	category_name = 'Children Bicycles'
											)
					)

--📌 DATE FUNCTIONS

--💊💡https://www.mssqltips.com/sqlservertip/1145/date-and-time-conversions-using-sql-server/

CREATE TABLE t_date_time (
	A_time time,
	A_date date,
	A_smalldatetime smalldatetime,
	A_datetime datetime,
	A_datetime2 datetime2,
	A_datetimeoffset datetimeoffset 
)                 
INSERT t_date_time (A_time,A_date,A_smalldatetime,A_datetime,A_datetime2,A_datetimeoffset)
VALUES
('12:00:00','2021-07-17','2021-07-17', '2021-07-17', '2021-07-17', '2021-07-17' )

--📍ayni tarihi yazdigimiz halde tanimlanan veri tipinin formatina uygun bir halde geldi degerlerimiz..--

SELECT *
FROM t_date_time

INSERT t_date_time (A_time) VALUES (TIMEFROMPARTS(12,0,0,0,0));

INSERT INTO t_date_time (A_date) VALUES (DATEFROMPARTS(2021,05,17));

SELECT CONVERT(VARCHAR,GETDATE(),6)

SELECT *
FROM t_date_time

INSERT INTO t_date_time (A_datetime) VALUES (DATETIMEFROMPARTS(2021,05,17,20,0,0,0));

INSERT INTO t_date_time (A_datetimeoffset) VALUES (DATETIMEOFFSETFROMPARTS(2021,05,17, 20,0,0,0, 2,0,0));


SELECT  A_date, 
        DATENAME(DW,A_date) [DAY],
        DAY(A_date) [DAY2],
        MONTH(A_date),
        YEAR(A_date),
        A_time,
        DATEPART(NANOSECOND,A_time),
        DATEPART(MONTH,A_date)

FROM t_date_time

SELECT  A_date,
        A_datetime,
        DATEDIFF(DAY,A_date,A_datetime)
FROM t_date_time



SELECT DATEDIFF (DAY, order_date, shipped_date), order_date, shipped_date
from sales.orders
where order_id = 1

SELECT DATEADD (D, 5, order_date), order_date 
FROM sales.orders
WHERE order_id = 1


SELECT	ISDATE( CAST (order_date AS nvarchar)), order_date
FROM	sales.orders
SELECT ISDATE ('1234568779')
SELECT ISDATE ('WHERE')
SELECT ISDATE ('2021-12-02')
SELECT ISDATE ('2021.12.02')
----------------------------
SELECT GETDATE()
SELECT CURRENT_TIMESTAMP
SELECT GETUTCDATE()
-------------------------
SELECT *
FROM	t_date_time
INSERT t_date_time
VALUES (GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE(),GETDATE())

--🔍Question: Create a new column that contains labels of the shipping speed of products.

--If the product has not been shipped yet, it will be marked as "Not Shipped",
--If the product was shipped on the day of order, it will be labeled as "Fast".
--If the product is shipped no later than two days after the order day, it will be labeled as "Normal"
--If the product was shipped three or more days after the day of order, it will be labeled as "Slow".


select *,
		CASE when order_status <> 4 THEN 'Not Shipped'
			 when order_date =shipped_date then 'FAST'
			 when DATEDIFF(DAY,order_date,shipped_date) between 1 and 2 then 'normal'
			 else 'slow'
			 end as ORDER_LABEL,
			 DATEDIFF (DAY, order_date, shipped_date) datedif
from sales.orders
order by datedif


------ CROSS JOIN ------
-- 🔍Write a query that returns all brand x category possibilities.

--Expected columns: brand_id, brand_name, category_id, category_name

SELECT *
FROM production.brands



SELECT *
FROM production.categories

--📌Bir tablonun bir  satirinin diger tablonun tum satirlari ile yapilan sorgulamasi icin Cross Join kullanabiliriz.--
--📌capraz sorgu!

SELECT *
FROM production.brands
CROSS JOIN production.categories
ORDER BY brand_id


-------------************-------------


--SELF JOIN
-- 🔍Write a query that returns the staffs with their managers.
--Expected columns: staff first name, staff last name, manager name

--📌 Staff tablosu kendi kendine bir iliski icerisinde..
--📌 Bunun anlami icinde ayni bilgileri tasiyan iki sutun var!!
--📌 staff_id=manager_id
--📌 Self Join de tablo kendisi ile birlestirilir..

SELECT *
FROM sales.staffs A, sales.staffs B
WHERE A.manager_id=B.staff_id


SELECT *
FROM sales.staffs



-------------************-------------


--GROUPING OPERATIONS

--HAVING
--📌 Having,Groupby+Aggregation islemi sonucu cikan tablo uzerinde filtreleme islemi yapmamizi sagliyor..--
--📌 Groupby olmadan Having kullanamayiz..Aggregation islemi yapmamiz gerekir.--

--📍 FROM ➜ WHERE ➜ GROUPBY ➜ SELECT(Agg bakiyor!) ➜ HAVING ➜ ORDER BY (islem siralamasi..)--

--📌 WHERE-HAVING FARKI
--Where,ana tabloya bir filtreleme yapiyor conditionlara gore
--Having,aggregation sonucu olusan tabloya filtreleme yapiyor..


--🔍Write a query that checks if any product id is repeated in more than one row in the products table.

SELECT	product_id, COUNT (*) AS CNT_PRODUCT
FROM	production.products
GROUP BY
		product_id
HAVING
		COUNT (*) > 1

--alternatif:

SELECT product_id, COUNT(product_id) AS CNT_PRODUCT
FROM production.products
GROUP BY product_id
HAVING  COUNT(product_id)>1


--📌Selectte yazdigimiz tum sutunlar Groupbyda da olmali--

--🔍 Write a query that returns category ids with a maximum list price above 4000 or a minimum list price below 500.

SELECT category_id,MIN(list_price) AS min_price, MAX(list_price) AS max_price
FROM production.products
GROUP BY category_id
HAVING MAX(list_price) > 4000 
OR MIN(list_price) < 500


--🔍 Find the average product prices of the brands.
--🔍 As a result of the query, the average prices should be displayed in descending order.

SELECT B.brand_name, AVG(list_price) AS avg_price
FROM production.products A, production.brands B 
WHERE A.brand_id=B.brand_id
GROUP BY B.brand_name
ORDER BY  avg_price DESC

--🔍 Write a query that returns the net price paid by the customer for each order. (Don't neglect discounts and quantities)
--🔍  Her bir siparis icin net odenen tutari bulacagiz..--


SELECT *, quantity * list_price * (1-discount) as net_value
FROM sales.order_items

SELECT order_id, SUM(quantity * list_price * (1-discount)) as net_value
FROM sales.order_items
GROUP BY order_id


-------------************-------------

--SUMMARY TABLE

--Copy an existing table to a new table.
--Don't need to create a new table before this process.

--SELECT * 
--INTO NEW_TABLE
--FROM SOURCE_TABLE
--WHERE ...




SELECT	C.brand_name as Brand, D.category_name as Category, B.model_year as Model_Year, 
		    ROUND (SUM (A.quantity * A.list_price * (1 - A.discount)), 0) total_sales_price
INTO 	sales.sales_summary

FROM	sales.order_items A, production.products B, production.brands C, production.categories D
WHERE	A.product_id = B.product_id
AND		B.brand_id = C.brand_id
AND		B.category_id = D.category_id
GROUP BY
		C.brand_name, D.category_name, B.model_year
   
SELECT *
FROM sales.sales_summary
ORDER BY 1,2,3
-------------************-------------

---GROUPING SETS---
--Group by altinda kullanilan bir arguman.
--Avantaji; birden fazla grouplama kombinasyonu yapmamizi sagliyor--

--1. Toplam sales miktarini hesaplayiniz.

SELECT SUM(total_sales_price)
FROM sales.sales_summary

--2. Markalarin toplam sales miktarini hesaplayiniz.

SELECT Brand, SUM(total_sales_price)
FROM sales.sales_summary
GROUP BY Brand

--3.Kategori bazinda yapilan toplam sales miktarini hesaplayiniz.

SELECT Category, SUM(total_sales_price)
FROM sales.sales_summary
GROUP BY Category


--4. Marka ve kategori kirilimindaki toplam sales miktarini hesaplayiniz

SELECT Brand, Category, SUM(total_sales_price)
FROM sales.sales_summary
GROUP BY Brand, Category

--👆 Yukarida ayri ayri yaptigimiz sorgulama kombinasyonlarini Grouping Sets ile tek bir kodda yapabiliriz.👇🏻


SELECT brand,category, SUM (total_sales_price)
FROM sales.sales_summary
GROUP BY
		GROUPING SETS (
						(Brand),
						(Category),
						(Brand,Category),
						()

						)
ORDER BY 1,2
;


-------------************-------------


--ROLLUP--

SELECT Brand, Category, SUM(total_sales_price)
FROM sales.sales_summary
GROUP BY 
	ROLLUP (Brand, Category)
ORDER BY 
		1,2


--CUBE--

SELECT Brand, Category, SUM(total_sales_price)
FROM sales.sales_summary
GROUP BY 
	CUBE (Brand, Category)
ORDER BY 
		1,2
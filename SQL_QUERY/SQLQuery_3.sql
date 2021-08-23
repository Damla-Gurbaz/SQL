--## SUBQUERY ##--


--📌 SELECT, dondurmek istedigimiz anlamina gelir..
  --tek bir satir ve sutun dondurmek zorunda.(bir deger)

--📌 FROM; da kullanildiginda bir toblo verir
--📌 WHERE; de kullanildiginda bir kosul,filtreleme verir..

--TYPES OF SUBQUERIES
  --📌 Single-row subqueries--> tek bir satir donduren
  --📌 Multiple-row subqueries --> birden cok satir donduren
  --📌 Correlated subqueries -->


--## PIVOT  ##--
--📌 Group by sonucu olusan satir bazli sonuc, Pivot ile sutun bazli olarak gelir..
--📌 Her bir kategoriyi sutuna cevirir..

--satir bazli👇🏻



SELECT Category, SUM(total_sales_price)
FROM sales.sales_summary
GROUP BY 
        Category,Model_Year
ORDER BY 1


--sutun bazli👇🏻
SELECT *
FROM
    (
    SELECT Category, total_sales_price
    FROM sales.sales_summary
    ) A 
PIVOT 
(
SUM(total_sales_price)
FOR Category
IN (
    [Children Bicycles],
    [Comfort Bicycles],
    [Cruisers Bicycles],
    [Cyclocross Bicycles],
    [Electric Bikes],
    [Mountain Bikes],
    [Road Bikes]
    )
) AS PIVOT_TABLE

--sutun bazli👇🏻


SELECT *
FROM
    (
    SELECT Category,Model_Year, total_sales_price
    FROM sales.sales_summary
    ) A 
PIVOT 
(
SUM(total_sales_price)
FOR Category
IN (
    [Children Bicycles],
    [Comfort Bicycles],
    [Cruisers Bicycles],
    [Cyclocross Bicycles],
    [Electric Bikes],
    [Mountain Bikes],
    [Road Bikes]
    )
) AS PIVOT_TABLE



------ SINGLE ROW SUBQUERIES ------

--🔍 Bring all the personnels from the store that Kali	Vargas works

SELECT *
FROM sales.staffs
WHERE store_id =(
            SELECT store_id
            FROM sales.staffs
            WHERE first_name='Kali'
            AND last_name='Vargas'
            )


--🔍 List the staff that Venita Daniel is the manager of.
SELECT *
FROM sales.staffs
WHERE manager_id=(
                SELECT staff_id
                FROM sales.staffs
                WHERE first_name='Venita'
                AND last_name='Daniel'  
)



SELECT *
FROM sales.staffs A, sales.staffs B 
WHERE A.manager_id = B.staff_id
AND B.first_name= 'Venita' AND b.last_name='Daniel'


--🔍 Write a query that returns customers in the city where the 'Rowlett Bikes' store is located.


SELECT *
FROM sales.customers
WHERE city = (
            SELECT  city
            FROM sales.stores
            WHERE store_name='Rowlett Bikes'
            ) 



--🔍 List bikes that are more expensive than the 'Trek CrossRip - 2018' bike.


SELECT A.product_id, A.product_name, A.model_year, A.list_price, B.brand_name, C.category_name
FROM production.products A, production.brands B, production.categories C 
WHERE A.brand_id = B.brand_id
AND A.category_id=C.category_id
AND list_price > (
                    SELECT list_price
                    FROM production.products
                    WHERE product_name= 'Trek CrossRip+ - 2018')



--🔍 List customers who orders previous dates than Arla Ellis.


SELECT A.first_name, A.last_name, B.order_date
FROM sales.customers A, sales.orders B 
WHERE B.order_date < (
                    SELECT order_date
                    FROM sales.customers A, sales.orders B
                    WHERE  A.customer_id = B.customer_id
                    AND A.first_name= 'Arla' AND last_name='Ellis' 
                    )



------ MULTIPLE-ROW SUBQUERIES ------

--📌 IN, NOT IN, ANY, ALL


--🔍 List order dates for customers residing in the Holbrook city.

SELECT order_date
FROM sales.orders
WHERE customer_id IN (
                    SELECT customer_id
                    FROM sales.customers
                    WHERE city = 'Holbrook'
                    )



--with NOT IN

SELECT order_date
FROM sales.orders
WHERE customer_id NOT IN (
                    SELECT customer_id
                    FROM sales.customers
                    WHERE city = 'Holbrook'
                    )



--🔍 List products in categories other than Cruisers Bicycles, Mountain Bikes, or Road Bikes.


SELECT product_name, list_price, model_year
FROM production.products
WHERE category_id NOT IN (
                            SELECT category_id
                            FROM production.categories
                            WHERE category_name IN ('Cruisers Bicycles', 'Mountain Bikes','Road Bikes')
                            )

AND model_year = 2016



--🔍 Elektrikli bisikletlerden daha pahali olan bisikletleri listeleyin

SELECT *
FROM production.products
WHERE list_price > ALL (
                        SELECT B.list_price
                        FROM production.categories A, production.products B
                        WHERE a.category_id=b.category_id
                        AND category_name = 'Electric Bikes'  
                        )


--🔍 List bikes that cost more than any electric bikes.

SELECT *
FROM production.products
WHERE list_price > ANY (
                        SELECT B.list_price
                        FROM production.categories A, production.products B
                        WHERE a.category_id=b.category_id
                        AND category_name = 'Electric Bikes'  
                        )



------ CORRELATED SUBQUERIES ------

--EXISTS / NOT EXISTS
--📌 Subquery icinde donen degerleri, ana queryde karsilanip karsilanmadigina bakar..

--Write a query that returns State where 'Trek Remedy 9.8 - 2017' product is not ordered

SELECT	DISTINCT STATE
FROM	sales.customers
WHERE	state NOT IN (
                    SELECT	 D.STATE
                    FROM	production.products A, sales.order_items B, sales.orders C, sales.customers D
                    WHERE	A.product_id = B.product_id
                    AND		B.order_id = C.order_id
                    AND		C.customer_id = D.customer_id
                    AND		A.product_name = 'Trek Remedy 9.8 - 2017'
                    )


SELECT	DISTINCT STATE
FROM	sales.customers X
WHERE	NOT EXISTS		(
							SELECT	1
							FROM	production.products A, sales.order_items B, sales.orders C, sales.customers D
							WHERE	A.product_id = B.product_id
							AND		B.order_id = C.order_id
							AND		C.customer_id = D.customer_id
							AND		A.product_name = 'Trek Remedy 9.8 - 2017'
							AND		X.STATE = D.STATE
							)



---------- VIEWS ----------


--📌 Subqueryler,Viewler ayni amaca hizmet eder.Tablolari rahat okuyabilmemizi saglarlar.
--📌 ayrica performansi artirirlar
--📌 tablolari daraltirlar.
--📌 Views; tek bir tabloda yapacagimiz islemleri, asamalara bolerek yapmamizi saglar ,boylece hizimizi-

---------- CTE ----------

--📌 Common Table Expression; Subquery mantigi,subqueryde icerde bir tablo ile ilgileniyorduk,CTE yi yukariya yaziyoruz..

--📌 Ilgilendigim tabloyu 'with' ile yukariya yaziyorum..

--📌 Ordinary
--📌 Recursive



--📌 Create a view that contains orders details for each customer

-- 📍 Views lerin avantaji; ana tablo guncellendikce view tablosuda otomatik olarak guncellenmesi..


CREATE VIEW SUMMARY_VIEW AS
SELECT	first_name, last_name, order_date, product_name, model_year,
		quantity, list_price, final_price
FROM
		(
		SELECT	A.first_name, A.last_name, B.order_date, D.product_name, D.model_year,
				C.quantity, C.list_price, C.list_price * (1-C.discount) final_price
		FROM	sales.customers A, sales.orders B, sales.order_items C, production.products D
		WHERE	A.customer_id = B.customer_id AND
				B.order_id = C.order_id AND
				C.product_id = D.product_id 
		) A
;



SELECT *
FROM SUMMARY_VIEW




--TEMPORARY TABLE

SELECT	first_name, last_name, order_date, product_name, model_year,
		quantity, list_price, final_price
INTO	#SUMMARY_TABLE
FROM	(
		SELECT	A.first_name, A.last_name, B.order_date, D.product_name, D.model_year,
				C.quantity, C.list_price, C.list_price * (1-C.discount) final_price
		FROM	sales.customers A, sales.orders B, sales.order_items C, production.products D
		WHERE	A.customer_id = B.customer_id AND
				B.order_id = C.order_id AND
				C.product_id = D.product_id 
		) A
;

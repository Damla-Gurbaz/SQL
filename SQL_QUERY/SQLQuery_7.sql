--ürünlerin stock sayılarını bulunuz


SELECT	product_id, SUM(quantity)
FROM	production.stocks
GROUP BY product_id
SELECT	product_id
FROM	production.stocks
GROUP BY product_id
ORDER BY 1
SELECT	*, SUM(quantity) OVER (PARTITION BY product_id)
FROM	production.stocks
SELECT	DISTINCT product_id, SUM(quantity) OVER (PARTITION BY product_id)
FROM	production.stocks


-- Markalara göre ortalama bisiklet fiyatlarını hem Group By hem de Window Functions ile hesaplayınız.

SELECT	brand_id, AVG(list_price) avg_price
FROM	production.products
GROUP BY brand_id
SELECT	DISTINCT brand_id, AVG(list_price) OVER (PARTITION BY brand_id) avg_price
FROM	production.products
 


-- 1. ANALYTIC AGGREGATE FUNCTIONS --
-- MIN() -MAX() - AVG() - SUM() - COUNT()


--1. Tüm bisikletler arasında en ucuz bisikletin fiyatı

SELECT	DISTINCT MIN(list_price) OVER() cheapest_bike
FROM	production.products;


--2. Herbir kategorideki en ucuz bisikletin fiyatı

SELECT	DISTINCT category_id, MIN (list_price) OVER (PARTITION BY category_id)
FROM	production.products

--3. Products tablosunda toplam kaç faklı bisikletin bulunduğu

SELECT	DISTINCT COUNT (product_id) OVER () NUM_OF_BIKE
FROM	production.products

--Order_items tablosunda toplam kaç farklı bisiklet olduğu

SELECT DISTINCT COUNT(product_id) OVER() order_num_of_bike
FROM sales.order_items
SELECT DISTINCT COUNT(product_id) OVER() order_num_of_bike
FROM (
		SELECT DISTINCT product_id
		FROM sales.order_items
	) A
SELECT COUNT (DISTINCT product_id)
FROM sales.order_items


--📌4. Herbir kategoride toplam kaç farklı bisikletin bulunduğu


SELECT	DISTINCT category_id,
		COUNT(product_id) OVER(PARTITION BY category_id) num_of_bike_by_cat
FROM	production.products
ORDER BY category_id
;


--📌5. Herbir kategorideki herbir markada kaç farklı bisikletin bulunduğu
SELECT	DISTINCT 
		category_id, brand_id,
		COUNT(product_id) OVER(PARTITION BY category_id, brand_id) num_of_bike_by_cat_brand
FROM	production.products
ORDER BY category_id, brand_id
;


--Can we calculate how many different brands are in each category in this query with WF?


SELECT DISTINCT category_id, count (brand_id) over (partition by category_id)
FROM
(
SELECT	DISTINCT category_id, brand_id
FROM	production.products
) A

--OR

--📌Order tablosuna aşağıdaki gibi yeni bir sütun ekleyiniz:
--1. Herbir personelin bir önceki satışının sipariş tarihini yazdırınız (LAG fonksiyonunu kullanınız)

SELECT	category_id, count (DISTINCT brand_id)
FROM	production.products
GROUP BY category_id

select  *, 
        Lag(order_date,1) over (partition by staff_id order by order_date, order_id ) prev_ord_date
from sales.orders

--Order tablosuna aşağıdaki gibi yeni bir sütun ekleyiniz:
--2. Herbir personelin bir sonraki satışının sipariş tarihini yazdırınız (LEAD fonksiyonunu kullanınız)

SELECT	*,
		LEAD(order_date, 1) OVER (PARTITION BY staff_id ORDER BY Order_date, order_id) prev_ord_date
FROM	sales.orders

SELECT	*,
		LEAD(order_date, 2) OVER (PARTITION BY staff_id ORDER BY Order_date, order_id) prev_ord_date
FROM	sales.orders

--🔍 Window Frame --

SELECT category_id, product_id,
		COUNT (*) OVER () TOTAL_ROW
from	production.products


SELECT  DISTINCT category_id, product_id,
		COUNT (*) OVER () TOTAL_ROW,
		COUNT (*) OVER (PARTITION BY category_id) num_of_row,
		COUNT (*) OVER (PARTITION BY category_id ORDER BY product_id) num_of_row
from	production.products


SELECT	category_id,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) prev_with_current
from	production.products

SELECT	category_id,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) current_with_following
from	production.products



SELECT	category_id,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) current_with_following
from	production.products
ORDER BY	category_id, product_id


SELECT	category_id,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) current_with_following
from	production.products
ORDER BY	category_id, product_id

SELECT	category_id,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) current_with_following
from	production.products
ORDER BY	category_id, product_id


SELECT	category_id,
		COUNT(*) OVER(PARTITION BY category_id ORDER BY product_id ROWS BETWEEN 2 PRECEDING AND 3 FOLLOWING) current_with_following
from	production.products
ORDER BY	category_id, product_id



--1. Tüm bisikletler arasında en ucuz bisikletin adı (FIRST_VALUE fonksiyonunu kullanınız)

SELECT	FIRST_VALUE(product_name) OVER ( ORDER BY list_price)
FROM	production.products

--ürünün yanına list price' ını nasıl eklersiniz?

SELECT	 DISTINCT FIRST_VALUE(product_name) OVER ( ORDER BY list_price) , min (list_price) over ()
FROM	production.products

--📌2. Herbir kategorideki en ucuz bisikletin adı (FIRST_VALUE fonksiyonunu kullanınız)

select distinct category_id, FIRST_VALUE(product_name) over (partition by category_id order by list_price)
from production.products



select distinct category_id, LAST_VALUE(product_name) over (partition by category_id order by list_price)
from production.products

--1. Tüm bisikletler arasında en ucuz bisikletin adı (LAST_VALUE fonksiyonunu kullanınız)
SELECT	DISTINCT
		FIRST_VALUE(product_name) OVER ( ORDER BY list_price),
		LAST_VALUE(product_name) OVER (	ORDER BY list_price desc ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
FROM	production.products



SELECT	category_id, list_price,
		ROW_NUMBER () OVER (PARTITION BY category_id ORDER BY list_price) ROW_NUM,
		RANK () OVER (PARTITION BY category_id ORDER BY list_price) RANK_NUM,
		DENSE_RANK () OVER (PARTITION BY category_id ORDER BY list_price) DENSE_RANK_NUM
FROM	production.products

SELECT	category_id, list_price,
		ROW_NUMBER () OVER (PARTITION BY category_id ORDER BY list_price) ROW_NUM,
		RANK () OVER (PARTITION BY category_id ORDER BY list_price) RANK_NUM,
		DENSE_RANK () OVER (PARTITION BY category_id ORDER BY list_price) DENSE_RANK_NUM,
		ROUND (CUME_DIST () OVER (PARTITION BY category_id ORDER BY list_price) , 2 ) CUM_DIST,
		ROUND (PERCENT_RANK () OVER (PARTITION BY category_id ORDER BY list_price) , 2 ) PERCENT_RNK
FROM	production.products





--4. Herbir kategori içinde bisikletierin fiyatlarına göre bulundukları yüzdelik dilimleri yazdırınız. (CUME_DIST fonksiyonunu kullanınız)

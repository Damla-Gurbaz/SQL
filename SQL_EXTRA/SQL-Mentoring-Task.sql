--📍 What is the sales quantity of product according to the brands and sort them highest-lowest 

SELECT A.brand_id, COUNT(order_id) as sales_amount
FROM production.products A, sales.order_items B
WHERE A.product_id = B.product_id
GROUP BY A.brand_id
ORDER BY sales_amount DESC


--📍 Select the top 5 most expensive products 

SELECT TOP 5 product_name, list_price
FROM production.products
ORDER BY list_price DESC

--📍 What are the categories that each brand has 

SELECT A.brand_id, B.category_name, COUNT(b.category_id)
FROM production.products A, production.categories B 
WHERE A.category_id = B.category_id
GROUP BY A.brand_id, B.category_name
ORDER BY A.brand_id




SELECT TOP 1 A.brand_id,COUNT(b.category_id)
FROM production.products A, production.categories B 
WHERE A.category_id = B.category_id
GROUP BY A.brand_id
ORDER BY COUNT(b.category_id) DESC


SELECT  TOP 1 A.category_id,COUNT(A.brand_id)
FROM production.products A, production.categories B 
WHERE A.category_id = B.category_id
GROUP BY A.category_id
ORDER BY COUNT(A.brand_id) DESC



--📍 Select the avg prices according to brands and categories 

SELECT C.brand_name, B.category_name, AVG(list_price) AS average_price 
FROM production.products A, production.categories B, production.brands C
WHERE A.category_id = B.category_id
AND A.brand_id = C.brand_id
GROUP BY C.brand_name, B.category_name
ORDER BY C.brand_name

--📍 Select the annual amount of product produced according to brands

SELECT C.brand_id, SUM(A.quantity)
FROM production.stocks A, production.products B, production.brands C
WHERE B.product_id = A.product_id
AND B.brand_id = C.brand_id
GROUP BY C.brand_id
ORDER BY C.brand_id

--📍 Select the store which has the most sales quantity in 2016 

SELECT TOP 1 A.store_id,B.store_name,B.[state],B.city, COUNT(order_id) AS total_sales
FROM sales.orders A, sales.stores B 
WHERE A.store_id = B.store_id
AND A.order_date LIKE '%2016%'
GROUP BY A.store_id, B.store_name,B.[state],B.city
ORDER BY total_sales DESC

--📍 Select the store which has the most sales amount in 2016 



SELECT top 1 store_id, SUM(B.list_price) AS total_sales
FROM sales.orders A, sales.order_items B 
WHERE A.order_id = B.order_id
AND order_date LIKE '%2016%'
GROUP BY store_id
ORDER by total_sales DESC



--📍 Select the personnel which has the most sales amount in 2016

SELECT TOP 1 A.staff_id,B.first_name+' '+B.last_name AS staff_name, COUNT(order_id) as total_sales
FROM sales.orders A, sales.staffs B 
WHERE A.staff_id = B.staff_id
AND order_date LIKE '%2016%'
GROUP BY A.staff_id, B.first_name, B.last_name
ORDER BY total_sales DESC


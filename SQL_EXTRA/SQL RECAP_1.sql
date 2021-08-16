--🔍 1. All the cities in the Texas and the numbers of customers in each city.---

SELECT city, COUNT(customer_id) as 'number_of_customers'
FROM sales.customers
WHERE [state]='TX'
GROUP BY city
ORDER BY city

--🔍 2. All the cities in the California which has more than 5 customer, by showing the cities which have more customers first.---

SELECT city, COUNT(customer_id) as number_of_customers
FROM sales.customers
WHERE [state]='CA'
GROUP BY city
HAVING COUNT(customer_id) > 5
ORDER BY number_of_customers DESC


--🔍 3. The top 10 most expensive products--


SELECT Top 10 product_name, list_price
FROM production.products
ORDER by list_price DESC


--🔍 4. Product name and list price of the products whic are located in the store id 2 and the quantity is greater than 25------

SELECT B.product_name, B.list_price
FROM production.stocks A, production.products B
WHERE A.product_id = B.product_id
AND  store_id = 2
AND quantity > 25
ORDER BY B.product_name 


--🔍 5. Find the customers who locate in the same zip code--

select zip_code,first_name, last_name  from sales.customers 
intersect 
select zip_code,first_name, last_name from sales.customers

SELECT a.zip_code,
a.first_name+' '+a.last_name as customer1,
b.first_name+' '+b.last_name as customer2

FROM sales.customers as  a, sales.customers b 
WHERE a.customer_id > b.customer_id
AND a.zip_code = b.zip_code
ORDER BY zip_code,
customer1,
customer2


--🔍 6. Return first name, last name, e-mail and phone number of the customers--

SELECT first_name+' '+last_name AS 'full name' , email, COALESCE(phone, 'n/a') phone
FROM sales.customers

--🔍 7. Find the sales order of the customers who lives in Houston order by order date--


SELECT B.order_id, B.order_date, A.customer_id
FROM sales.customers A, sales.orders B
WHERE A.customer_id = B.customer_id
AND city = 'Houston'
ORDER BY B.order_date


SELECT order_id, order_date,customer_id
FROM sales.orders
WHERE customer_id in (
SELECT customer_id
FROM sales.customers
WHERE city = 'Houston')
ORDER BY order_date


--🔍 8. Find the products whose list price is greater than the average list price of all products with the Electra or Heller --

select distinct product_name, list_price
from production.products
where list_price > (select avg(p.list_price)
					from production.products p
					inner join production.brands b
					on b.brand_id = p.brand_id
					where b.brand_name = 'Electra' or b.brand_name = 'Heller')
order by list_price



--🔍 9. Find the products that have no sales --

SELECT product_id 
FROM production.products
WHERE product_id NOT IN (
                        SELECT product_id
                        FROM sales.order_items
                        )


SELECT product_id
FROM production.products
EXCEPT
SELECT product_id
FROM sales.order_items

--🔍 10. Return the average number of sales orders in 2017 sales--


SELECT AVG(A.sales_amounts) AS 'Average Number of Sales'
FROM (
    SELECT COUNT(order_id) sales_amounts
    FROM sales.orders
    WHERE order_date LIKE '%2017%' 
    GROUP BY staff_id
    ) as A


--🔍 11-By using view get the sales by staffs and years using the AVG() aggregate function:

select s.first_name, s.last_name, year(o.order_date) as year, avg((i.list_price-i.discount)*i.quantity) as avg_amount
from sales.staffs s
inner join sales.orders o
on s.staff_id=o.staff_id
inner join sales.order_items i
on o.order_id=i.order_id
group by s.first_name, s.last_name, year(o.order_date)
order by first_name, last_name, year(o.order_date)

CREATE VIEW sales.staff_sales (
        first_name, 
        last_name,
        year, 
        avg_amount
)
AS 
    SELECT 
        first_name,
        last_name,
        YEAR(order_date),
        AVG(list_price * quantity) as avg_amount
    FROM
        sales.order_items i
    INNER JOIN sales.orders o
        ON i.order_id = o.order_id
    INNER JOIN sales.staffs s
        ON s.staff_id = o.staff_id
    GROUP BY 
        first_name, 
        last_name, 
        YEAR(order_date);
--------------
SELECT  
    * 
FROM 
    sales.staff_sales
ORDER BY 
	first_name,
	last_name,
	year;

--📌 the following statement returns all the cites of customers located in California and the number of customers in each city.

SELECT city, COUNT(*)
FROM sales.customers
WHERE [state]='CA'
GROUP BY city
HAVING COUNT(*)>10
ORDER BY city


--

SELECT city, COUNT(customer_id)
FROM sales.customers
WHERE [state]='CA'
GROUP BY city
HAVING COUNT(*)>10
ORDER BY city

--Sort a result set by an expression--
--📌 The following statement uses the LEN() function in the ORDER BY clause to retrieve a customer list sorted by the length of the first name.

SELECT first_name, last_name
FROM sales.customers
ORDER BY LEN(first_name) DESC

--Sort by ordinal positions of columns--

SELECT first_name, last_name
FROM sales.customers
ORDER BY 2,1


--SQL Server OFFSET and FETCH examples--

SELECT product_name, list_price
FROM production.products
ORDER BY list_price, product_name
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY

--SQL Server SELECT TOP examples--

SELECT TOP 10
    product_name, list_price
FROM production.products
ORDER BY list_price DESC

SELECT TOP 1 PERCENT
    product_name, list_price
FROM production.products
ORDER BY list_price DESC

SELECT TOP 3 WITH TIES
    product_name, list_price
FROM production.products
ORDER BY list_price DESC

--📌 SQL Server SELECT DISTINCT examples--

SELECT DISTINCT city
FROM sales.customers
ORDER BY city


SELECT DISTINCT city, [state]
FROM sales.customers
ORDER BY city,[state]


SELECT DISTINCT phone
FROM sales.customers
ORDER BY phone

--📌 WHERE-Finding rows with the value between two values--

SELECT product_id, product_name, category_id, model_year, list_price
FROM production.products
WHERE list_price BETWEEN 1899.00 AND 1999.99
ORDER BY list_price DESC

--📌 WHERE-Finding rows that have a value in a list of values--

SELECT
    product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM
    production.products
WHERE
    list_price IN (299.99, 369.99, 489.99)
ORDER BY
    list_price DESC;

--📌 WHERE-Finding rows whose values contain a string--

SELECT
    product_id,
    product_name,
    category_id,
    model_year,
    list_price
FROM production.products
WHERE product_name LIKE '%Cruiser%'
ORDER BY list_price

--📌 IS NULL

SELECT customer_id, first_name, last_name, phone
FROM sales.customers
WHERE phone = NULL
ORDER BY first_name, last_name

SELECT customer_id, first_name, last_name, phone
FROM sales.customers
WHERE phone IS NULL
ORDER BY first_name, last_name

SELECT customer_id, first_name, last_name, phone
FROM sales.customers
WHERE phone IS NOT NULL
ORDER BY first_name, last_name



--📌 Using the AND operator with other logical operators--



SELECT
    *
FROM
    production.products
WHERE
    brand_id = 1
    OR brand_id = 2
    AND list_price > 1000
ORDER BY
    brand_id DESC;

--🔴 koşulda hem OR hem de AND operatörlerini kullandık. Her zaman olduğu gibi, SQL Server önce AND operatörünü değerlendirdi. Bu nedenle sorgu, marka kimliği iki ve liste fiyatı 1.000'den 
--büyük veya marka kimliği bir olan ürünleri aldı.

SELECT
    *
FROM
    production.products
WHERE
    (brand_id = 1 OR brand_id = 2)
    AND list_price > 1000
ORDER BY
    brand_id;

--📌 BETWEEN--

SELECT
    order_id,
    customer_id,
    order_date,
    order_status
FROM
    sales.orders
WHERE
    order_date BETWEEN '20170115' AND '20170117'
ORDER BY
    order_date;

--📌 LIKE--

--The pattern _u%

--The first underscore character ( _) matches any single character.
--The second letter u matches the letter u exactly
--The third character % matches any sequence of characters

SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    last_name LIKE '[YZ]%'
ORDER BY
    last_name;

----

SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    last_name LIKE '[A-C]%'
ORDER BY
    first_name;

----

SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    last_name LIKE '[^A-X]%'
ORDER BY
    last_name;
-----

SELECT
    customer_id,
    first_name,
    last_name
FROM
    sales.customers
WHERE
    first_name NOT LIKE 'A%'
ORDER BY
    first_name;


--SQL Server LIKE with ESCAPE example--

--
SELECT
    feedback_id,
    comment
FROM
    sales.feedbacks
WHERE 
   comment LIKE '%30!%%' ESCAPE '!';--


--🔍 More SQL Server inner join examples
SELECT
    product_name,
    category_name,
    brand_name,
    list_price
FROM
    production.products p
    INNER JOIN production.categories c ON c.category_id = p.category_id
    INNER JOIN production.brands b ON b.brand_id = p.brand_id
ORDER BY
    product_name DESC;


--🔍 More SQL Server Left join examples

SELECT
    p.product_name,
    o.order_id,
    i.item_id,
    o.order_date
FROM
    production.products p
	LEFT JOIN sales.order_items i
		ON i.product_id = p.product_id
	LEFT JOIN sales.orders o
		ON o.order_id = i.order_id
ORDER BY
    order_id;


--🔍 query finds the products that belong to the order id 100

SELECT
    product_name,
    order_id
FROM
    production.products p
LEFT JOIN sales.order_items o 
   ON o.product_id = p.product_id
WHERE order_id = 100
ORDER BY
    order_id;



SELECT
    p.product_id,
    product_name,
    order_id
FROM
    production.products p
    LEFT JOIN sales.order_items o 
         ON o.product_id = p.product_id AND 
            o.order_id = 100
ORDER BY
    order_id DESC;


--SELF JOIN


SELECT
    c1.city,
	c1.first_name + ' ' + c1.last_name customer_1,
    c2.first_name + ' ' + c2.last_name customer_2
FROM
    sales.customers c1
INNER JOIN sales.customers c2 ON c1.customer_id <> c2.customer_id
AND c1.city = c2.city
WHERE c1.city = 'Albany'
ORDER BY
	c1.city,
    customer_1,
    customer_2;


--query returns the number of customers by state and city

SELECT
    city,
    state,
    COUNT (customer_id) customer_count
FROM
    sales.customers
GROUP BY
    state,
    city
ORDER BY
    city,
    state;


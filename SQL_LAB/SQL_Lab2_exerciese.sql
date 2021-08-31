--Select the customers who have purchased both Children Bicycle and Comfort Bicycle in a single order. 
--(expected columns: Customer id, first name, last name, order id)

SELECT	E.Customer_id, first_name, last_name, D.order_id,category_name,
		
		
FROM	produc
tion.categories A,
		production.products B,
		sales.order_items C,
		sales.orders D,
		sales.customers E
WHERE	A.category_id = B.category_id AND
		B.product_id = C.product_id AND
		C.order_id = D.order_id AND
		D.customer_id = E.customer_id
AND		A.category_name IN ('Children Bicycles', 'Comfort Bicycles')
ORDER BY 4

SELECT E.customer_id, E.first_name, E.last_name, D.order_id
FROM production.categories AS A,
	 production.products AS B,
	 sales.order_items AS C,
	 sales.orders AS D,
	 sales.customers AS E
WHERE A.category_id = B.category_id AND
	  B.product_id = C.product_id AND
	  C.order_id = D.order_id AND
	  D.customer_id = E.customer_id
AND   A.category_name = 'Children Bicycles'
INTERSECT
SELECT E.customer_id, E.first_name, E.last_name, D.order_id
FROM production.categories AS A,
	 production.products AS B,
	 sales.order_items AS C,
	 sales.orders AS D,
	 sales.customers AS E
WHERE A.category_id = B.category_id AND
	  B.product_id = C.product_id AND
	  C.order_id = D.order_id AND
	  D.customer_id = E.customer_id
AND   A.category_name ='Comfort Bicycles'



SELECT	E.customer_id, E.first_name,E.last_name, D.order_id
FROM	production.categories A,
		production.products B,
		sales.order_items C,
		sales.orders D,
		sales.customers E
WHERE	A.category_id = B.category_id AND
		B.product_id = C.product_id AND
		C.order_id = D.order_id AND
		D.customer_id = E.customer_id
AND		A.category_name = 'Children Bicycles'
INTERSECT
SELECT	E.customer_id, E.first_name,E.last_name, D.order_id
FROM	production.categories A,
		production.products B,
		sales.order_items C,
		sales.orders D,
		sales.customers E
WHERE	A.category_id = B.category_id AND
		B.product_id = C.product_id AND
		C.order_id = D.order_id AND
		D.customer_id = E.customer_id
AND		A.category_name = 'Comfort Bicycles'


Send a message to class-chat-tr

SELECT CU.customer_id,first_name,last_name,O.order_id, 
        SUM(IIF(CA.category_name='Children Bicycles', 1,0)) as IsChild,
        SUM(IIF(CA.category_name='Comfort Bicycles', 1,0)) as IsComfort
FROM sales.customers CU, sales.orders O, sales.order_items OI, production.products P, production.categories CA
WHERE CA.category_id=P.category_id 
    AND P.product_id=OI.product_id
    AND OI.order_id=O.order_id
    AND O.customer_id=CU.customer_id
    AND CA.category_name IN ('Comfort Bicycles', 'Children Bicycles')
GROUP BY CU.customer_id,first_name,last_name,O.order_id
HAVING
		SUM(IIF(CA.category_name='Children Bicycles', 1,0))>0 AND
		SUM(IIF(CA.category_name='Comfort Bicycles', 1,0)) >0
ORDER BY 1

















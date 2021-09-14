SELECT LEN(123456789)
SELECT LEN(' DAMLA ')

SELECT LEN('"WELCOME"')


SELECT CHARINDEX('C', 'CHARACTER')  --C kacinci karakter,soldan baslar ilk buldugumuzun lokasyonunu getirir..
SELECT CHARINDEX('C', 'CHARACTER', 2) --2.karakterden itibaren aramaya basla
SELECT CHARINDEX('CT', 'CHARACTER')

SELECT PATINDEX('R', 'CHARACTER')

SELECT PATINDEX('%R', 'CHARACTER')

SELECT PATINDEX('%R%', 'CHARACTER')

SELECT PATINDEX('r', 'CHARACTER')

SELECT PATINDEX('%A____', 'CHARACTER') --Adan sonraki 4 karakteride getir.

SELECT LEFT('CHARaCTER', 3)


SELECT LEFT(' CHARaCTER', 3)--Bosluguda sayiyor

SELECT RIGHT('CHARaCTER', 3)

SELECT SUBSTRING('CHARaCTER', 3,5)-- 3 DEN ITIBAREN 5 KARAKTER AL

SELECT SUBSTRING('CHARCTER', 0,5)

SELECT LOWER('CHARaCTER')

SELECT UPPER('character')

SELECT VALUE 
FROM string_split('John,Sarah,Jack', ',')

SELECT VALUE 
FROM string_split('John/Sarah/Jack', '/')

SELECT VALUE 
FROM string_split('John//Sarah//Jack', '/')

SELECT UPPER(LEFT('character',1))+RIGHT('character', LEN('character')-1)

select TRIM(' CHARACTER ')

select TRIM(' CHARA  CTER ')

SELECT REPLACE('CHARACTER', 'RAC', '')


SELECT REPLACE('CHARACTER', 'RAC', '/')

SELECT STR (1234.573,6,2 )

SELECT STR (1234.573,7,1 )


SELECT 'JACK'+'_'+'10'

SELECT 'JACK'+'_'+STR(10,2)

SELECT CAST(123456 AS CHAR(6))

SELECT CAST(123456 AS VARCHAR(10))

SELECT CAST(123456 AS CHAR(6)) + ' '+ 'CHris'

select CAST (GETDATE() AS DATE)



SELECT CONVERT(INT, 30.30)
SELECT CONVERT(float, 30.30)

SELECT first_name
FROM sales.customers

select nullif(first_name, 'Debra')
FROM sales.customers

select COUNT(nullif(first_name, 'Debra'))
FROM sales.customers

SELECT ROUND(432.45678,2)

SELECT ROUND(432.45678,1)

SELECT ROUND(432.45678,3,0)

SELECT  SUM(case when PATINDEX( '%yahoo%', email)>0 then 1
else 0 end ) NUM_OF_domain
FROM sales.customers

select count(email)
from sales.customers
where email like '%yahoo%'

SELECT left(email,CHARINDEX('.',email)-1)
from sales.customers


select *,coalesce(phone,email) as contact
from sales.customers


select street, case 
when SUBSTRING(street,3,1) is null  then NULL
WHEN SUBSTRING(street,3,1) =
ELSE SUBSTRING(street,3,1)
from sales.customers
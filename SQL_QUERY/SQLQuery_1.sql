--###-- INNER JOIN--###--

--❗️en yaygın JOIN türüdür. İki veya daha fazla tablodan ortak sütunlardaki değerleri temel alarak yeni bir sonuç tablosu oluşturur. 
--❗️INNER JOIN, yalnızca belirtilen birleştirme koşullarını karşılayan birleştirilmiş satırları içeren bir tablo döndürür.

-- urunleri kategori isimleri ile birlikte listeleyin--

SELECT A.product_id,product_name, B.category_name
FROM production.products AS A
INNER JOIN production.categories AS B
ON A.category_id= B.category_id

-- calisanlari magaza bilgileri ile birlikte getiriniz--
SELECT A.first_name, A.last_name, B.store_name
FROM sales.staffs as A 
INNER JOIN sales.stores as B 
ON A.store_id=B.store_id

--*--Alternatif bir cozum--*--🎯👇🏻

SELECT Top 20 B.first_name, B.last_name, A.store_name
FROM sales.stores A, sales.staffs B
WHERE A.store_id=B.store_id



--###-- LEFT JOIN--###--
--soldaki tablonun tüm kayıtları ve sağdaki tablonun ortak kayıtları sorguda döndürülür. 
--JOIN işlemi sırasında sağdaki tabloda eşleşen satır bulunamazsa, bu değerler NULL olarak atanır.

-- urunleri kategori isimleri ile birlikte listeleyin-- LEFT JOIN ILE!!

SELECT A.product_id,product_name, B.category_name
FROM production.products A
LEFT JOIN production.categories B
ON A.category_id = B.category_id

-- product id'si 310 dan buyuk olan tum urunleri stock bilgisi ile birlikte dondurun--

SELECT *                            --LEFT JOIN ILE--(ORTAK OLMAYAN SATIRLARI NULL OLARAK GETIRDI.)
from production.products A
LEFT JOIN production.stocks B 
ON A.product_id = B.product_id
WHERE A.product_id > 310

--

SELECT *                             --INNER JOIN ILE--(ORTAK OLMAYAN SATIRLARI GETIRMEDI.)
from production.products A
INNER JOIN production.stocks B 
ON A.product_id = B.product_id
WHERE A.product_id > 310

-- product id'si 310 dan buyuk olan tum urunleri stock bilgisi ile birlikte dondurun----RIGHT JOIN ILE--

SELECT *                            
from production.stocks A
RIGHT JOIN production.products B 
ON A.product_id = B.product_id
WHERE B.product_id > 310


-- personellerin yaptigi satislari raporla--

select *
from sales.staffs --10

SELECT COUNT (DISTINCT staff_id)  --6  --DISTINCT;birbirinden farkli(unique) satirlari sayar!--
from sales.orders

SELECT *
FROM sales.staffs A
LEFT JOIN sales.orders B
ON A.staff_id=B.staff_id

--Alternatif cozum--
SELECT *
FROM sales.orders A
RIGHT JOIN sales.staffs B
ON A.staff_id=B.staff_id

--SELECT COUNT(DISTINCT (staff_id)) FROM sales.orders-- -->bu kullanimada asina olmak gerekebilir--


--Urunlerin siparis ve stock bilgisi--

SELECT  B.product_id, B.store_id, B.quantity, A.product_id, A.list_price, A.order_id
FROM sales.order_items A  
FULL OUTER JOIN production.stocks B 
ON A.product_id=B.product_id
ORDER BY A.product_id

--CROSS JOIN:--
--SQL'de, CROSS JOIN, ilk tablonun her satırını ikinci tablonun her satırıyla birleştirmek için kullanılır. 
--Birleştirilmiş tablolardan satır kümelerinin Kartezyen çarpımını döndürdüğü için Kartezyen birleştirme olarak da bilinir.


--SELF JOIN--
--Kendi kendine JOIN, bir tablonun kendi sütunları arasındaki bazı ilişkilere dayalı olarak kendisine katıldığı bir düzenli birleştirme durumudur. --
--Kendi kendine katılma, INNER JOIN veya LEFT JOIN yan tümcesini kullanır ve sorgu içindeki tabloya farklı adlar atamak için bir tablo diğer adı kullanılır.--

--FULL OUTER JOIN--
--her iki tablodaki tüm satırları döndürür. Çıktı tablosu, NULL veri içeren satırları içerecektir,--
--bu nedenle hiçbir şey dışarıda bırakılmaz. NULL değerler, tablolardaki eksik verileri tespit etmek için önemli olabilir. --
--FULL OUTER JOIN, katılmak istediğiniz tablolardaki satır sayısına bağlı olarak büyük veri kümeleri oluşturacaktır.--

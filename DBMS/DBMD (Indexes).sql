

--Bu tablo i�in ayr� bir database olu�turman�z daha uygun olacakt�r.
--Index' in faydalar�n�n daha belirgin olarak g�r�lmesi i�in bu �ekilde bir tablo olu�turulmu�tur.

--�nce tablonun �at�s�n� olu�turuyoruz.


create table website_visitor 
(
visitor_id int,
first_name varchar(50),
last_name varchar(50),
phone_number bigint,
city varchar(50)
);


--Tabloya rastgele veri at�yoruz konumuz haricindedir, �imdilik varl���n� bilmeniz yeterli.


DECLARE @i int = 1
DECLARE @RAND AS INT
WHILE @i<200000
BEGIN
	SET @RAND = RAND()*81
	INSERT website_visitor
		SELECT @i , 'visitor_name' + cast (@i as varchar(20)), 'visitor_surname' + cast (@i as varchar(20)),
		5326559632 + @i, 'city' + cast(@RAND as varchar(2))
	SET @i +=1
END;



--Tabloyu kontrol ediniz.

SELECT top 10*
FROM
website_visitor



--�statistikleri (Process ve time) a��yoruz, bunu a�mak zorunda de�ilsiniz sadece yap�lan i�lemlerin detay�n� g�rmek i�in a�t�k.
SET STATISTICS IO on
SET STATISTICS TIME on



--herhangi bir index olmadan visitor_id' ye �art verip t�m tabloyu �a��r�yoruz


SELECT *
FROM
website_visitor
where
visitor_id = 100

--execution plan' a bakt���n�zda Table Scan yani t�m tabloyu teker teker t�m de�erlere bakarak arad���n� g�receksiniz.



--Visitor_id �zerinde bir index olu�turuyoruz

Create CLUSTERED INDEX CLS_INX_1 ON website_visitor (visitor_id);


--visitor_id' ye �art verip sadece visitor_id' yi �a��r�yoruz



SELECT visitor_id
FROM
website_visitor
where
visitor_id = 100


--execution plan' a bakt���n�zda Clustered index seek
--yani sadece clustered index' te aran�lan de�eri B-Tree y�ntemiyle bulup getirdi�ini g�r�yoruz.



--visitor_id' ye �art verip t�m tabloyu �a��r�yoruz

SELECT *
FROM
website_visitor
where
visitor_id = 100

--execution plan' a bakt���n�zda Clustered index seek yapt���n� g�r�yoruz.
--Clustered index tablodaki t�m bilgileri leaf node'larda saklad��� i�in ayr�ca bir yere gitmek ihtiyac� olmadan
--primary key bilgisiyle (clustered index) t�m bilgileri getiriyor.
------------------------------


--Peki farkl� bir s�tuna �art verirsek;


SELECT first_name
FROM
website_visitor
where
first_name = 'visitor_name17'


--Execution Plan' da G�r�lece�i �zere Clustered Index Scan yap�yor.
--Dikkat edin Seek de�il Scan. Arad���m�z s�tuna ait de�eri clustered index' in leaf page' lerinde tutulan bilgilerde ar�yor
--Tabloda arar gibi, index yokmu��as�na.


--Yukar�daki gibi devaml� sorgu at�lan non-key bir attribute s�z konusu ise;
--Bu �ekildeki s�tunlara clustered index tan�mlayamayaca��m�z i�in NONCLUSTERED INDEX tan�mlamam�z gerekiyor.

--Non clustered index tan�mlayal�m ad s�tununa
CREATE NONCLUSTERED INDEX ix_NoN_CLS_1 ON website_visitor (first_name);


--Ad s�tununa �art verip kendisini �a��ral�m:

SELECT first_name
FROM
website_visitor
where
first_name = 'visitor_name17'


--Execution Plan' da G�r�lece�i �zere �zere ayn� yukar�da visitor id'de oldu�u gibi index seek y�ntemiyle verileri getirdi.
--Tek fark NonClustered indexi kulland�.


--Peki ad s�tunundan ba�ka bir s�tun daha �a��r�rsak ne olur?
--G�nl�k hayatta da ad ile genellikle soyad� birlikte sorgulan�r.


SELECT first_name, last_name
FROM
website_visitor
where
first_name = 'visitor_name17'


--Execution Plan' da G�r�lece�i �zere burada ad ismine verdi�imiz �art i�in NonClustered index seek kulland�,
--Sonras�nda soyad bilgisini de getirebilmek i�in Clustered index e Key lookup yapt�.
--Yani clustered index' e gidip sorgulanan ad' a ait primary key' e ba�vurdu
--Sonras�nda farkl� yerlerden getirilen bu iki bilgiyi Nested Loops ile birle�tirdi.


--Bir sorgunun en performansl� hali idealde Sorgu costunun %100 Index Seek y�ntemi ile getiriliyor olmas�d�r!


--�u demek oluyor ki, bu da tam olarak performans iste�imizi kar��lamad�, daha performansl� bir index olu�turabilirim.

--Burada yapabilece�im, ad s�tunu ile devaml� olarak birlikte sorgulama yapt���m s�tunlara INCLUDE INDEX olu�turma i�lemidir.
--Bunun �al��ma mant���;
--NonClustered index' te leaf page lerde sadece nonclustered index olu�turulan s�tunun ve primary keyinin bilgisi tutulmaktayd�.
--Include index olu�turuldu�unda verilen s�tun bilgileri bu leaf page lere eklenmesi ve ad ile birlikte kolayca getirilmesi ama�lanm��t�r.


--Include indexi olu�tural�m:
Create unique NONCLUSTERED INDEX ix_NoN_CLS_2 ON website_visitor (first_name) include (last_name)


--ad ve soyad� ad s�tununa �art vererek birlikte �a��ral�m
SELECT first_name, last_name
FROM
website_visitor
where
first_name = 'visitor_name17'

--Execution Plan' da G�r�lece�i �zere sadece Index Seek ile sonucu getirmi� oldu.


--soyad s�tununa �art verip sadece kendisini �a��rd���m�zda 
--Kendisine tan�ml� �zel bir index olmad��� i�in Index seek yapamad�, ad s�tunun indexinde t�m de�erlere teker teker bakarak
--Yani Scan y�ntemiyle sonucu getirdi.

SELECT last_name
FROM
website_visitor
where
last_name = 'visitor_surname10'

--Execution Plan' da G�r�lece�i �zere bize bir index tavsiyesi veriyor.

--�yi �al��malar dilerim.
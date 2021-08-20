

CREATE DATABASE Library1;

Use Library1;


--Create Two Schemas
CREATE SCHEMA Book;
---
CREATE SCHEMA Person;



--create Book.Book table
CREATE TABLE [Book].[Book](
	[Book_ID] [int] PRIMARY KEY NOT NULL,
	[Book_Name] [nvarchar](50) NULL
	);


--create Book.Author table

CREATE TABLE [Book].[Author](
	[Author_ID] [int],
	[Author_Name] [nvarchar](50) NULL
	);



--create Book.Book_Author table

CREATE TABLE Book.Book_Author
(
Book_ID INT PRIMARY KEY,
Author_ID INT NOT NULL
);



--create Publisher Table

CREATE TABLE [Book].[Publisher](
	[Publisher_ID] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[Publisher_Name] [nvarchar](100) NULL
	);



--create Book_Publisher table
CREATE TABLE [Book].[Book_Publisher](
	[Book_ID] [int] PRIMARY KEY NOT NULL,
	[Publisher_ID] [int] NOT NULL
	)

--create Person.Person table

CREATE TABLE [Person].[Person](
	[Person_ID] [bigint] PRIMARY KEY NOT NULL,
	[Person_Name] [nvarchar](50) NULL,
	[Person_Surname] [nvarchar](50) NULL
	);


--create Person.Person_Book table

CREATE TABLE [Person].[Person_Book](
	[Person_ID] [bigint] NOT NULL,
	[Book_ID] [int] NOT NULL
	);

---create Person_Mail table

CREATE TABLE [Person].[Person_Mail](
	[Mail_ID] [int] Primary Key identity(1,1) NOT NULL,
	[E_Mail] [text] NOT NULL,
	[Person_ID] [bigint] NOT NULL 
	);



--cretae Person.Person_Phone table

CREATE TABLE [Person].[Person_Phone](
	[Phone_Number] [bigint] PRIMARY KEY NOT NULL,
	[Person_ID] [bigint] NOT NULL	
	);



--Tablolar� yukar�daki �ekilde �ncelikle create edip devam ediniz.
--A�a��da DML komutlar�n� �rneklendirip tablo constraintlerini sonradan tan�mlayaca��z. 
--�rnek olarak insert etti�imiz verileri sonradan silece�iz. 




----------INSERT

----!!! ilgili kolonun �zelliklerine ve k�s�tlar�na uygun veri girilmeli !!!


-- Insert i�lemi yapaca��n�z tablo s�tunlar�n� a�a��daki gibi parantez i�inde belirtebilirsiniz.
-- Bu kullan�mda sadece belirtti�iniz s�tunlara de�er girmek zorundas�n�z. S�tun s�ras� �nem arz etmektedir.

INSERT INTO Person.Person (Person_ID, Person_Name, Person_Surname) VALUES (75056659595,'Zehra', 'Tekin')

INSERT INTO Person.Person (Person_ID, Person_Name) VALUES (889623212466,'Kerem')


--E�er bir tablodaki t�m s�tunlara insert etmeyecekseniz, se�ti�iniz s�tunlar�n haricindeki s�tunlar Nullable olmal�.
--E�er Not Null constrainti uygulanm�� s�tun varsa hata verecektir.

--A�a��da Person_Surname s�tununa de�er girilmemi�tir. 
--Person_Surname s�tunu Nullable oldu�u i�in Person_Surname yerine Null de�er atayarak i�lemi tamamlar.

INSERT INTO Person.Person (Person_ID, Person_Name) VALUES (78962212466,'Kerem')

--Insert edece�im de�erler tablo k�s�tlar�na ve s�tun veri tiplerine uygun olmazsa a�a��daki gibi i�lemi ger�ekle�tirmez.


--Insert keywordunden sonra Into kullanman�za gerek yoktur.
--Ayr�ca A�a��da oldu�u gibi insert etmek istedi�iniz s�tunlar� belirtmeyebilirsiniz. 
--Buna ra�men s�tun s�ras�na ve yukar�daki kurallara dikkat etmelisiniz.
--Bu kullan�mda tablonun t�m s�tunlar�na insert edilece�i farz edilir ve sizden t�m s�tunlar i�in de�er ister.

INSERT Person.Person VALUES (15078893526,'Mert','Yeti�')

--E�er de�eri bilinmeyen s�tunlar varsa bunlar yerine Null yazabilirsiniz. 
--Tabiki Null yazmak istedi�iniz bu s�tunlar Nullable olmal�d�r.

INSERT Person.Person VALUES (55556698752, 'Esra', Null)



--Ayn� anda birden fazla kay�t insert etmek isterseniz;

INSERT Person.Person VALUES (35532888963,'Ali','Tekin');-- T�m tablolara de�er atanaca�� varsay�lm��t�r.
INSERT Person.Person VALUES (88232556264,'Metin','Sakin')


--Ayn� tablonun ayn� s�tunlar�na bir�ok kay�t insert etmek isterseniz a�a��daki syntax� kullanabilirsiniz.
--Burada dikkat edece�iniz di�er bir konu Mail_ID s�tununa de�er atanmad���d�r.
--Mail_ID s�tunu tablo olu�turulurken identity olarak tan�mland��� i�in otomatik artan de�erler i�erir.
--Otomatik artan bir s�tuna de�er insert edilmesine izin verilmez.

INSERT INTO Person.Person_Mail (E_Mail, Person_ID) 
VALUES ('zehtek@gmail.com', 75056659595),
	   ('meyet@gmail.com', 15078893526),
	   ('metsak@gmail.com', 35532558963)

--Yukar�daki syntax ile a�a��daki fonksiyonlar� �al��t�rd���n�zda,
--Yapt���n�z son insert i�leminde tabloya eklenen son kayd�n identity' sini ve tabloda etkilenen kay�t say�s�n� getirirler.
--Not: fonksiyonlar� teker teker �al��t�r�n.

SELECT @@IDENTITY--last process last identity number
SELECT @@ROWCOUNT--last process row count



--A�a��daki syntax ile farkl� bir tablodaki de�erleri daha �nceden olu�turmu� oldu�unuz farkl� bir tabloya insert edebilirsiniz.
--S�tun s�ras�, tipi, constraintler ve di�er kurallar yine �nemli.

select * into Person.Person_2 from Person.Person-- Person_2 �eklinde yedek bir tablo olu�turun


INSERT Person.Person_2 (Person_ID, Person_Name, Person_Surname)
SELECT * FROM Person.Person where Person_name like 'M%'


--A�a��daki syntaxda g�rece�iniz �zere hi�bir de�er belirtilmemi�. 
--Bu �ekilde tabloya tablonun default de�erleriyle insert i�lemi yap�lacakt�r.
--Tabiki s�tun constraintleri buna elveri�li olmal�. 

INSERT Book.Publisher
DEFAULT VALUES



--update



--Update i�leminde ko�ul tan�mlamaya dikkat ediniz. E�er herhangi bir ko�ul tan�mlamazsan�z 
--S�tundaki t�m de�erlere de�i�iklik uygulanacakt�r.



UPDATE Person.Person_2 SET Person_Name = 'Default_Name'--buray� �al��t�rmadan �nce yukar�daki scripti �al��t�r�n

--Where ile ko�ul vererek 88963212466 Person_ID ' ye sahip ki�inin ad�n� Can �eklinde g�ncelliyoruz.
--Ki�inin �nceki Ad� Kerem' di.

UPDATE Person.Person_2 SET Person_Name = 'Can' WHERE Person_ID = 78962212466


select * from Person.Person_2




--Join ile update

----A�a��da Person_2 tablosunda person id' si 78962212466 olan �ahs�n (yukar�daki �ah�s) ad�n�,
----As�l tablomuz olan Person tablosundaki haliyle de�i�tiriyoruz.
----Bu i�lemi yaparken iki tabloyu Person_ID �zerinden Join ile birle�tiriyoruz
----Ve kaynak tablodaki Person_ID' ye istedi�imiz �art� veriyoruz.

UPDATE Person.Person_2 SET Person_Name = B.Person_Name 
FROM Person.Person_2 A Inner Join Person.Person B ON A.Person_ID=B.Person_ID
WHERE B.Person_ID = 78962212466


--Subquery ile Update

--A�a��da Person_2 tablosundaki bir ismin de�erini bir sorgu neticesinde gelen bir de�ere e�itleme i�lemi yap�lmaktad�r.

UPDATE Person.Person_2 SET Person_Name = (SELECT Person_Name FROM Person.Person where Person_ID = 78962212466) WHERE Person_ID = 78962212466



---
----delete


--Delete' nin ne anlama geldi�ini art�k biliyor olmal�s�n�z.
--Delete kullan�m�nda, Delete ile t�m verilerini sildi�iniz bir tabloya yeni bir kay�t ekledi�inizde,
--E�er tablonuzda otomatik artan bir identity s�tunu var ise eklenen yeni kayd�n identity'si, 
--silinen son kayd�n identity'sinden sonra devam edecektir.


--�rne�in a�a��da otomatik artan bir identity primary keye sahip Book.Publisher tablosuna �rnek olarak veri ekleniyor.

insert Book.Publisher values ('�� Bankas� K�lt�r Yay�nc�l�k'), ('Can Yay�nc�l�k'), ('�leti�im Yay�nc�l�k')


--Delete ile Book.Publisher tablosunun i�i tekrar bo�alt�l�yor.

Delete from Book.Publisher 

--kontrol
select * from Book.Publisher 

--Book.Publisher tablosuna yeni bir veri insert ediliyor
insert Book.Publisher values ('Paris')

--Tekrar kontrol etti�imizde yeni insert edilen kayd�n identity'sinin eski tablodaki s�radan devam etti�i g�r�lecektir.
select * from Book.Publisher



---/////////////////////////////

--//////////////////////////////


--Buradan sonraki k�s�mda Constraint ve Alter Table �rnekleri yap�lacakt�r.
--Yapaca��m�z i�lemlerin tutarl� olmas� i�in �ncelikle yukar�da �rnek olarak veri insert etti�imiz tablolar�m�z� bo�altal�m.


DROP TABLE Person.Person_2;--Art�k ihtiyac�m�z yok.

TRUNCATE TABLE Person.Person_Mail;
TRUNCATE TABLE Person.Person;
TRUNCATE TABLE Book.Publisher;






--ALTER TABLE

SELECT Person_Name, Person_Surname INTO Sample_Person FROM Person.Person


SP_Rename 'dbo.Sample_Person', 'Person_New'

sp_rename 'Person_New.Person_Name', 'First_Name', 'Column'


---------Book tablomuz bir primary key' e sahip


---------Author

--Author tablomuza primary key atamam�z gerekli, ��nk� olu�tururken atanmam��


ALTER TABLE Book.Author ADD CONSTRAINT pk_author PRIMARY KEY (Author_ID)

Alter table Book.Author alter column Author_ID int not null


---------Book_Author tablosuna foreign key constraint eklemeliyiz


ALTER TABLE Book.Book_Author ADD CONSTRAINT FK_Author FOREIGN KEY (Author_ID) REFERENCES Book.Author (Author_ID)
ON UPDATE NO ACTION
ON DELETE NO ACTION


ALTER TABLE Book.Book_Author ADD CONSTRAINT FK_Book2 FOREIGN KEY (Book_ID) REFERENCES Book.Book (Book_ID)
ON UPDATE NO ACTION
ON DELETE CASCADE


--Publisher tablosu normal.


--Book_Publisher tablosuna iki tane Foreign key constraint eklememiz gerekiyor.


ALTER TABLE Book.Book_Publisher ADD CONSTRAINT FK_Publisher FOREIGN KEY (Publisher_ID) REFERENCES Book.Publisher (Publisher_ID)

ALTER TABLE Book.Book_Publisher ADD CONSTRAINT FK_Book FOREIGN KEY (Book_ID) REFERENCES Book.Book (Book_ID)

--Person.Person tablosundaki Person_ID s�tununa 11 haneli olmas� gerekti�i i�in check constraint ekleyelim.


Alter table Person.Person add constraint FK_PersonID_check Check (Person_ID between 9999999999 and 99999999999)

--Alttaki constraint' te check ile bir fonksiyonun do�rulanma durumunu sorguluyoruz.
--Fonksiyon ger�ek hayatta kullan�lan TC kimlik no algoritmas�n� �al��t�r�yor.
--Yap�lan check kontrolu bu fonksiyonun s�zgecinden ge�iyor, e�er ID numaras� fonksiyona uyuyorsa fonksiyon 1 de�eri �retiyor ve
--i�lem ger�ekle�tiriliyor. Fonksiyon 0 de�erini �retirse bu ID numaras�n�n istenen ko�ullar� sa�lamad��� anlam�na geliyor ve 
--��lem yap�lm�yor.
--Fonksiyonu �al��t�rabilmeniz i�in fonksiyonu bu database alt�nda create etmeniz gerekmektedir.
--Fonksiyonun scriptini ayr�ca g�nderece�im.

Alter table Person.Person add constraint FK_PersonID_check2 Check (dbo.KIMLIKNO_KONTROL(Person_ID) = 1)


--Person_Book 

--Person_Book tablosuna Composite bir primary key eklememiz gerekmektedir.
--sonras�nda iki ID s�tununa Foreign key constraint tan�mlamlayal�m.


Alter table Person.Person_Book add constraint PK_Person Primary Key (Person_ID,Book_ID)


Alter table Person.Person_Book add constraint FK_Person1 Foreign key (Person_ID) References Person.Person(Person_ID)

Alter table Person.Person_Book add constraint FK_Book1 Foreign key (Book_ID) References Book.Book(Book_ID)


---------Person.Person_Phone

--Person_Phone tablosuna person_ID i�in foreign key constraint olu�turmam�z gerekli.

Alter table Person.Person_Phone add constraint FK_Person3 Foreign key (Person_ID) References Person.Person(Person_ID)

--Phone_Number i�in check...

Alter table Person.Person_Phone add constraint FK_Phone_check Check (Phone_Number between 999999999 and 9999999999)

--

-------------Person.Person_Mail i�in Foreign key tan�mlamam�z gerekli

Alter table Person.Person_Mail add constraint FK_Person4 Foreign key (Person_ID) References Person.Person(Person_ID)


---Bu a�amada Database diagram�n�z� �izip t�m tablolar aras�ndaki ba�lant�lar�n olu�tu�undan emin olman�z� bekliyorum.


--Insert i�lemlerini size b�rak�yorum, hata alarak, constraintlerin ne anlama geldi�ini kendiniz tecr�be ederek yapman�z daha de�erli.












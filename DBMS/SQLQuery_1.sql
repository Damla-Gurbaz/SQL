CREATE DATABASE Library1;
Use Library1;
--Create Two Schemas
CREATE SCHEMA Book;
---
CREATE SCHEMA Person;
--create Book.Book table
CREATE TABLE Book.Book
(
	[Book_ID] [int] PRIMARY KEY NOT NULL,
	[Book_Name] [nvarchar](50) NULL
);
--create Book.Author table
CREATE TABLE Book.Author
(
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
CREATE TABLE [Book].[Publisher]
(
	[Publisher_ID] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[Publisher_Name] [nvarchar](100) NULL
	);
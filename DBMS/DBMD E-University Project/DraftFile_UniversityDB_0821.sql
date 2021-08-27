

--DBMD LECTURE
--UNIVERSITY DATABASE PROJECT 

use eUniversity

--CREATE DATABASE


--//////////////////////////////


--CREATE TABLES 


CREATE TABLE Region
(
Region_ID INT IDENTITY(1,1), 
Region_name VARCHAR(MAX),
PRIMARY KEY (Region_ID)
);


---


CREATE TABLE Staff
(
Staff_ID INT IDENTITY NOT NULL,
Firstname VARCHAR(MAX),
Lastname VARCHAR(MAX),
PRIMARY KEY (Staff_ID)
);

---


ALTER TABLE Staff  ADD CONSTRAINT Region FOREIGN KEY (Region_ID) REFERENCES Region (Region_ID)


----
CREATE TABLE Course
(
Course_ID INT IDENTITY(1,1),
Title VARCHAR(MAX),
Credit INT,
PRIMARY KEY (Course_ID)
);
----

CREATE TABLE Student
(
StudentID INT IDENTITY(1,1) ,
Firstname VARCHAR(MAX),
Lastname VARCHAR(MAX),
Register_date DATE,
Region_ID INT,
Staff_ID INT,
PRIMARY KEY (StudentID),
FOREIGN KEY (Region_ID) REFERENCES Region (Region_ID),
FOREIGN KEY (Staff_ID) REFERENCES Staff (Staff_ID)
);

----

CREATE TABLE Enrollment
(
STUDENTID INT,
Course_ID INT,
PRIMARY KEY (StudentID, Course_ID),
FOREIGN KEY (StudentID) REFERENCES Student (StudentID),
FOREIGN KEY (Course_ID) REFERENCES Course (Course_ID)
)

-----

CREATE TABLE StaffCourse
(
Staff_ID INT,
Course_ID INT,
PRIMARY KEY (Staff_ID, Course_ID),
FOREIGN KEY (Staff_ID) REFERENCES Staff (Staff_ID),
FOREIGN KEY (Course_ID) REFERENCES Course (Course_ID)
)

-----




--Make sure you add the necessary constraints.
--You can define some check constraints while creating the table, but some you must define later with the help of a scalar-valued function you'll write.
--Check whether the constraints you defined work or not.
--Import Values (Use the Data provided in the Github repo). 
--You must create the tables as they should be and define the constraints as they should be. 
--You will be expected to get errors in some points. If everything is not as it should be, you will not get the expected results or errors.
--Read the errors you will get and try to understand the cause of the errors.



--////////////////////


--CONSTRAINTS

--1. Students are constrained in the number of courses they can be enrolled in at any one time. 
--	 They may not take courses simultaneously if their combined points total exceeds 180 points.









--------///////////////////


--2. The student's region and the counselor's region must be the same.









--///////////////////////////////



------ADDITIONALLY TASKS



--1. Test the credit limit constraint.






--//////////////////////////////////

--2. Test that you have correctly defined the constraint for the student counsel's region. 






--/////////////////////////


--3. Try to set the credits of the History course to 20. (You should get an error.)





--/////////////////////////////

--4. Try to set the credits of the Fine Arts course to 30.(You should get an error.)





--////////////////////////////////////

--5. Debbie Orange wants to enroll in Chemistry instead of German. (You should get an error.)








--//////////////////////////


--6. Try to set Tom Garden as counsel of Alec Hunter (You should get an error.)





--/////////////////////////

--7. Swap counselors of Ursula Douglas and Bronwin Blueberry.






--///////////////////


--8. Remove a staff member from the staff table.
--	 If you get an error, read the error and update the reference rules for the relevant foreign key.





 




















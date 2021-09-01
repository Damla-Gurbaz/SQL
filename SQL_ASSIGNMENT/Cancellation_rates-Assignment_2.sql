
IF OBJECT_ID('[dbo].[Asignment2]', 'U') IS NOT NULL
DROP TABLE [dbo].[Asignment2]
GO

CREATE TABLE [dbo].[Asignment2]
(
    [User_id] INT , 
    [Action] NVARCHAR(50) ,
    [date] DATE 
  
);
GO

--##########################--

INSERT INTO [dbo].[Asignment2]
( 
 [User_id], [Action], [date]
)
VALUES
( 
 1, 'Start', '1-1-20'
),
( 
 1, 'Cancel', '1-2-20'
),
( 
 2, 'Start', '1-3-20'
),
(    
 2, 'Publish', '1-4-20'
),
( 
 3, 'Start', '1-5-20'
),
(
 3, 'Cancel', '1-6-20'
),
( 
 1, 'Start', '1-7-20'
),
(
 1, 'Publish', '1-8-20'
)

GO


--##########################--



WITH T1 AS
(
    SELECT User_id, COUNT([Action]) as start_number
    FROM Asignment2
    where [Action]='Start'
    group by User_id
),
T2 AS
(
    SELECT User_id,COUNT([Action]) as cancel_number
    FROM Asignment2
    where [Action]='Cancel'
    group by User_id
),
T3 AS
(
    SELECT User_id, COUNT([Action]) as publish_number
    FROM Asignment2
    where [Action]='Publish'
    group by User_id
)
SELECT 
        t1.User_id,
        ISNULL(CAST((T2.cancel_number*1.0/T1.start_number) AS DECIMAL (15,1) ),0) as Cancel_rate,
        ISNULL( CAST((T3.publish_number*1.0/T1.start_number)AS DECIMAL (15,1) ),0) as publish_rate
from t1
LEFT JOIN T2
ON T1.User_id=T2.User_id
LEFT JOIN T3
ON T1.User_id =T3.User_id
GROUP by T1.User_id, T2.cancel_number,T1.start_number,T3.publish_number

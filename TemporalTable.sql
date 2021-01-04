
CREATE TABLE [dbo].[TempCustomer](
	[Id] [int] NOT NULL,
	[Code] [varchar](18) NOT NULL,
	[CustType] [char](1) NOT NULL,
	[Name] [varchar](65) NULL,
)
GO

INSERT INTO TempCustomer
SELECT * 
FROM Customer
GO

DROP TABLE Customer
GO

CREATE TABLE [dbo].[Customer](
	[Id] [int] NOT NULL IDENTITY(1,1) PRIMARY KEY CLUSTERED,
	[Code] [varchar](18) NOT NULL,
	[CustType] [char](1) NOT NULL,
	[Name] [varchar](65) NULL,
	SysStartTime DATETIME2 GENERATED ALWAYS AS ROW START NOT NULL,
	SysEndTime DATETIME2 GENERATED ALWAYS AS ROW END NOT NULL,
	PERIOD FOR SYSTEM_TIME (SysStartTime,SysEndTime)
)
WITH (SYSTEM_VERSIONING = ON ( 
		HISTORY_TABLE = dbo.Customer_History,
		HISTORY_RETENTION_PERIOD = 1 MONTHS
	)
)
GO

SET IDENTITY_INSERT Customer ON
INSERT INTO Customer (Id, Code, CustType, [Name])
SELECT Id,  Code, CustType, [Name]
FROM TempCustomer
SET IDENTITY_INSERT Customer OFF

SELECT *
FROM Customer_History

UPDATE Customer SET [Name] = 'VW World' WHERE Id = 3
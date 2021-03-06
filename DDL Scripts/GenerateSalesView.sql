USE [AdventureWorks2014]
GO

/****** Object:  View [dbo].[v_SalesByProductByCategory]    Script Date: 11/12/2016 2:14:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(select * FROM sys.views where name = 'v_SalesByProductByCategory')
		DROP VIEW v_SalesByProductByCategory;
GO
CREATE VIEW [dbo].[v_SalesByProductByCategory]
AS
SELECT        sh.SalesOrderID, sh.RevisionNumber, sh.OrderDate, sh.ShipDate, sd.SalesOrderDetailID, sd.CarrierTrackingNumber, sd.OrderQty, sd.SpecialOfferID, sd.UnitPrice, sd.UnitPriceDiscount, sd.LineTotal, 
                         sd.ModifiedDate, pr.ProductID, pr.Name AS Product, pr.ProductNumber, pr.ListPrice, ps.ProductSubcategoryID, ps.Name AS ProductSubCategory, pc.ProductCategoryID, pc.Name AS ProductCategory, 
                         CASE WHEN month(sh.ShipDate) <= 6 THEN (year(sh.ShipDate)) ELSE year(sh.ShipDate) + 1 END AS finYear, 
                         sh.SalesOrderNumber
FROM            Sales.SalesOrderHeader AS sh LEFT OUTER JOIN
                         Sales.SalesOrderDetail AS sd ON sh.SalesOrderID = sd.SalesOrderID LEFT OUTER JOIN
                         Production.Product AS pr ON sd.ProductID = pr.ProductID LEFT OUTER JOIN
                         Production.ProductSubcategory AS ps ON pr.ProductSubcategoryID = ps.ProductSubcategoryID LEFT OUTER JOIN
                         Production.ProductCategory AS pc ON ps.ProductCategoryID = pc.ProductCategoryID  
GO

IF EXISTS (SELECT * FROM sys.database_principals WHERE name = N'NT AUTHORITY\NETWORK SERVICE') 
DROP USER [NT AUTHORITY\NETWORK SERVICE]
Go
CREATE USER [NT AUTHORITY\NETWORK SERVICE] FOR LOGIN [NT AUTHORITY\NETWORK SERVICE]
Go
EXEC sp_addrolemember N'db_datareader', N'NT AUTHORITY\NETWORK SERVICE'
GO


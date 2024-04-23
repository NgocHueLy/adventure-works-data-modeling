-------------------- dim_product
-- 1. query to check which type of JOIN should be performed


SELECT 
	COUNT (1)
FROM Production.Product;
-- output: 504

SELECT
	COUNT(1)
FROM Production.Product p
LEFT JOIN Production.ProductSubcategory ps
ON p.ProductSubcategoryID = ps.ProductSubcategoryID;
-- output: 504

SELECT
	COUNT(1)
FROM Production.Product p
JOIN Production.ProductSubcategory ps
ON p.ProductSubcategoryID = ps.ProductSubcategoryID;
-- output: 295

-- use LEFT JOIN to keep all the products from Product table

SELECT DISTINCT Status
FROM Sales.SalesOrderHeader;

SELECT COUNT(1)
FROM sales.Customer c LEFT JOIN Person.Person p
ON c.PersonID = p.BusinessEntityID;
-- output: IN, SC
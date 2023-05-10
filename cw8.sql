--1.Wykorzystuj¹c wyra¿enie CTE zbuduj zapytanie, które znajdzie informacje na temat stawki pracownika oraz jego danych,
--a nastêpnie zapisze je do tabeli tymczasowej TempEmployeeInfo. Rozwi¹¿ w oparciu o AdventureWorks.

WITH TempEmployeeInfo (FirstName, MiddleName, LastName, JobTitle, BirthDate, Gender, HireDate, MaritalStatus, Rate)
AS
 (
	SELECT FirstName, MiddleName, LastName, JobTitle, BirthDate, Gender, HireDate, MaritalStatus, Rate FROM HumanResources.Employee AS e
	JOIN HumanResources.EmployeePayHistory AS p
	ON e.BusinessEntityID = p.BusinessEntityID
	JOIN Person.Person AS pr
	ON e.BusinessEntityID = pr.BusinessEntityID
 )
 SELECT * FROM TempEmployeeInfo;

--2.Uzyskaj informacje na temat przychodów ze sprzeda¿y wed³ug firmy i kontaktu (za pomoc¹ CTE i bazy AdventureWorksL). 

WITH Temp ( CompanyContact , Revenue)
AS
(
	SELECT CONCAT( c.CompanyName,' (',c.FirstName, ' ',c.LastName,')' ), s.TotalDue  FROM SalesLT.Customer as c
	JOIN SalesLT.SalesOrderHeader as s
	ON c.CustomerID = s.CustomerID
)
SELECT * FROM Temp
ORDER BY CompanyContact;

--3.Napisz zapytanie, które zwróci wartoœæ sprzeda¿y dla poszczególnych kategorii produktów.Wykorzystaj CTE i bazê AdventureWorksLT.

WITH Temp_1 ( Category , SalesValue)
AS
(
	SELECT pc.Name AS Category, ROUND(sd.UnitPrice*sd.OrderQty,2) AS SalesValue FROM SalesLT.Product as p
	JOIN SalesLT.ProductCategory as pc
	ON pc.ProductCategoryID = p.ProductCategoryID
	JOIN SalesLT.SalesOrderDetail as sd
	ON sd.ProductID = p.ProductID


)

SELECT Category, sum(SalesValue) FROM Temp_1
GROUP BY Category
ORDER BY Category


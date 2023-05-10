--1.Wykorzystuj�c wyra�enie CTE zbuduj zapytanie, kt�re znajdzie informacje na temat stawki pracownika oraz jego danych,
--a nast�pnie zapisze je do tabeli tymczasowej TempEmployeeInfo. Rozwi�� w oparciu o AdventureWorks.

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

--2.Uzyskaj informacje na temat przychod�w ze sprzeda�y wed�ug firmy i kontaktu (za pomoc� CTE i bazy AdventureWorksL). 

WITH Temp ( CompanyContact , Revenue)
AS
(
	SELECT CONCAT( c.CompanyName,' (',c.FirstName, ' ',c.LastName,')' ), s.TotalDue  FROM SalesLT.Customer as c
	JOIN SalesLT.SalesOrderHeader as s
	ON c.CustomerID = s.CustomerID
)
SELECT * FROM Temp
ORDER BY CompanyContact;

--3.Napisz zapytanie, kt�re zwr�ci warto�� sprzeda�y dla poszczeg�lnych kategorii produkt�w.Wykorzystaj CTE i baz� AdventureWorksLT.

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


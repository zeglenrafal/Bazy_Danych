--1.Napisz procedurę wypisującą do konsoli ciąg Fibonacciego. Procedura musi przyjmować jako
--argument wejściowy liczbę n. Generowanie ciągu Fibonacciego musi zostać
--zaimplementowane jako osobna funkcja, wywoływana przez procedurę.


CREATE FUNCTION dbo.fibonaccif(@k INT, @m INT)
RETURNS INT
AS
BEGIN
	RETURN @k+@m;
END;
SELECT dbo.fibonaccif(4,5)



CREATE PROCEDURE dbo.fibonaccip(@N INT)
AS
DECLARE @tmp INT= 0;
DECLARE @i INT = 0;
BEGIN
	WHILE @i<@N 
	BEGIN
		PRINT(dbo.fibonaccif(@tmp,@tmp+1));
		SET @tmp=@tmp+1;
		SET @i=@i+1
	END
END
EXEC dbo.fibonaccip @N = 8


USE AdventureWorks2019
GO

-- 2. Napisz trigger DML, który po wprowadzeniu danych do tabeli Personszmodyfikuje nazwisko tak, aby by³o napisane du¿ymi literami. 

SELECT * FROM Person.Person
SELECT UPPER(Person.LastName) FROM Person.Person

CREATE TRIGGER Person.To_Upper
ON Person.Person
AFTER INSERT, UPDATE 
AS
BEGIN
UPDATE Person.Person SET Person.LastName = UPPER(Person.LastName)
END

INSERT INTO Person.Person (BusinessEntityID,PersonType,NameStyle,Title,FirstName,MiddleName,LastName) VALUES (20778,'IN',0,NULL,'Janusz','Karol','Opryskiwacz');
GO

SELECT * FROM Person.Person;

-- 3. Przygotuj trigger ‘taxRateMonitoring’, który wyœwietli komunikat o b³êdzie, je¿eli nast¹pi zmiana wartoœci w polu ‘TaxRate’o wiêcej ni¿ 30%.

SELECT * FROM Sales.SalesTaxRate;

CREATE TRIGGER Sales.taxRateMonitoring
ON Sales.SalesTaxRate
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
DECLARE @Change INT, @TaxRate INT
SELECT @TaxRate = TaxRate FROM deleted
SELECT @Change = TaxRate FROM inserted
IF @Change > @TaxRate*1.3 OR @Change < @TaxRate*0.7
PRINT 'Blad zmieniono wartosc TaxRate o wiecej niz 30%'
END
DROP TRIGGER Sales.taxRateMonitoring

UPDATE Sales.SalesTaxRate SET TaxRate =  10.00 WHERE SalesTaxRateID = 1;
UPDATE Sales.SalesTaxRate SET TaxRate =  25.00 WHERE SalesTaxRateID = 1;
UPDATE Sales.SalesTaxRate SET TaxRate =  6.00 WHERE SalesTaxRateID = 1;
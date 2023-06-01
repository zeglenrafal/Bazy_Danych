﻿-- Zad. 1. 
-- Napisz zapytanie, które wykorzystuje transakcję (zaczyna ją), a następnie aktualizuje cenę produktu
--o ProductID równym 680 w tabeli Production.Product o 10% i następnie zatwierdza transakcję.
SELECT * FROM Production.Product WHERE ProductID = 680

BEGIN TRANSACTION
UPDATE Production.Product SET ListPrice = 1.1*ListPrice WHERE ProductID = 680;
COMMIT TRANSACTION;

-- Zad. 2.
-- Napisz zapytanie, które zaczyna transakcję, usuwa produkt o ProductID równym 707 z tabeli Production.Product, ale następnie wycofuje transakcję.
SELECT * FROM Production.Product WHERE ProductID = 707;

BEGIN TRANSACTION
	EXEC sp_msforeachtable 
	'ALTER TABLE ? NOCHECK CONSTRAINT all';

	DELETE FROM Production.Product WHERE ProductID = 707;

ROLLBACK TRANSACTION

-- Zad. 3. 
-- Napisz zapytanie, które zaczyna transakcję, dodaje nowy produkt do tabeli Production.Product, a następnie zatwierdza transakcję.

SELECT * FROM Production.Product

BEGIN TRANSACTION
	
	SET IDENTITY_INSERT Production.Product ON;
	INSERT INTO Production.Product(ProductID,Name,ProductNumber,MakeFlag,FinishedGoodsFlag,SafetyStockLevel,ReorderPoint,StandardCost,ListPrice,DaysToManufacture,SellStartDate)
	VALUES (1000,'NowyProdukt','asdaasd',0,1,2,3,4,5,6,'2023-06-01 02:30:40.500');
	SET IDENTITY_INSERT Production.Product OFF;

COMMIT TRANSACTION

-- Zad.4.
-- Napisz zapytanie, które zaczyna transakcję i aktualizuje StandardCost wszystkich produktów w tabeli Production.Product o 10%, jeżeli suma wszystkich
-- StandardCost po aktualizacji nie przekracza 50000. W przeciwnym razie zapytanie powinno wycofać transakcję.

	BEGIN TRANSACTION
	
	UPDATE Production.Product SET StandardCost = 1.1*StandardCost;
	DECLARE @suma FLOAT;
	SELECT @suma = SUM(StandardCost) FROM Production.Product;

	IF (@suma <= 50000)
	BEGIN
		COMMIT TRANSACTION;
	END
	ELSE
	BEGIN
		PRINT('Nie wykonano');
		ROLLBACK TRANSACTION;
	END

	SELECT * FROM Production.Product 
-- Zad. 5. 
-- Napisz zapytanie SQL, które zaczyna transakcję i próbuje dodać nowy produkt do tabeli Production.Product. Jeśli ProductNumber już istnieje w tabeli, zapytanie powinno wycofać transakcję.

	BEGIN TRANSACTION

	IF NOT EXISTS(SELECT 1 FROM Production.Product WHERE ProductNumber = 'RZ-1234')
	BEGIN
		SET IDENTITY_INSERT Production.Product ON;
		INSERT INTO Production.Product(ProductID,Name,ProductNumber,MakeFlag,FinishedGoodsFlag,SafetyStockLevel,ReorderPoint,StandardCost,ListPrice,DaysToManufacture,SellStartDate)
		VALUES (1001,'NowyProdukt1','RZ-1234',0,1,2,3,4,5,6,'2023-06-01 02:30:40.500');
		SET IDENTITY_INSERT Production.Product OFF;
		COMMIT TRANSACTION
	END
	ELSE
		BEGIN
		PRINT 'Nie mozna wykonac, produkt o takim ProductNumber juz istnieje'
		ROLLBACK TRANSACTION
	END
	

-- Zad. 6.
-- Napisz zapytanie SQL, które zaczyna transakcję i aktualizuje wartość OrderQty dla każdego zamówienia w tabeli Sales.SalesOrderDetail. Jeżeli którykolwiek z zamówień ma OrderQty równą 0, zapytanie powinno wycofać transakcję.

SELECT * FROM Sales.SalesOrderDetail;

BEGIN TRANSACTION
	IF ((SELECT MIN(OrderQty) FROM Sales.SalesOrderDetail) != 0 )
	BEGIN
		UPDATE Sales.SalesOrderDetail SET OrderQty = OrderQty + 1;
		COMMIT TRANSACTION;
	END
	ELSE
	BEGIN
		PRINT 'Nie mozna wykonac';
		ROLLBACK TRANSACTION;
	END
	UPDATE Sales.SalesOrderDetail SET OrderQty = 0 WHERE ProductID = 777;
-- Zad. 7.
-- Napisz zapytanie SQL, które zaczyna transakcję i usuwa wszystkie produkty, których StandardCost jest wyższy niż średni koszt wszystkich produktów w tabeli
-- Production.Product. Jeżeli liczba produktów do usunięcia przekracza 10, zapytanie powinno wycofać transakcję

SELECT * FROM Production.Product 

	BEGIN TRANSACTION
	
	EXEC sp_msforeachtable 
	'ALTER TABLE ? NOCHECK CONSTRAINT all';
	DECLARE @srednia FLOAT;
	DECLARE @usuniete INT;
	SET @srednia = (SELECT AVG(StandardCost) FROM Production.Product);
	SET @usuniete = (SELECT COUNT(*) FROM Production.Product WHERE StandardCost > @srednia);
	DELETE FROM Production.Product WHERE StandardCost > @srednia;
	PRINT(@srednia);
	PRINT(@usuniete);
	IF ( @usuniete < 10 )
	BEGIN
		COMMIT TRANSACTION;
	END
	ELSE
	BEGIN
		PRINT 'Nie mozna wykonac';
		ROLLBACK TRANSACTION;
	END

	
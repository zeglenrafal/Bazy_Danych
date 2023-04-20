-- 1. Tworzenie nowej bazy danych firma

CREATE DATABASE firma;

-- 2. Tworzenie nowego schematu

CREATE SCHEMA rozliczenia;

-- 3. Dodawanie tabel
-- 3a,b,c

CREATE TABLE rozliczenia.pracownicy (

	id_pracownika INT PRIMARY KEY,
	imie VARCHAR(30) NOT NULL,
	nazwisko VARCHAR(30) NOT NULL,
	adres VARCHAR(255) NOT NULL,
	telefon CHAR(9) NOT NULL,

);
CREATE TABLE rozliczenia.godziny (

	id_godziny INT PRIMARY KEY,
	_data DATE NOT NULL,
	liczba_godzin INT NOT NULL,
	id_pracownika INT NOT NULL,
	

);	

CREATE TABLE rozliczenia.premie (

	id_premii INT PRIMARY KEY,
	rodzaj VARCHAR(30) NULL,
	kwota MONEY NOT NULL,
	

);

CREATE TABLE rozliczenia.pensje (

	id_pensji INT PRIMARY KEY,
	stanowisko VARCHAR(30) NOT NULL,
	kwota MONEY NOT NULL,
	id_premii INT NOT NULL,
	

);		
-- 3d.

ALTER TABLE rozliczenia.pensje ADD FOREIGN KEY (id_premii) REFERENCES rozliczenia.premie (id_premii);
ALTER TABLE rozliczenia.godziny ADD FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy (id_pracownika);

-- 4. Wype³nianie tabel rekordami

INSERT INTO rozliczenia.pracownicy VALUES (1, 'Maciej', 'Pies', '£¹czna 43, 68-213 Lipinki £u¿yckie', '123456789')
INSERT INTO rozliczenia.pracownicy VALUES (2, 'Monika', 'Kot', 'Królewska 57/3, 30-081 Kraków', '1234444569')
INSERT INTO rozliczenia.pracownicy VALUES (3, 'Marcin', 'Dubiel', 'Z³ota 59, 00-120 Warszawa', '166666789')
INSERT INTO rozliczenia.pracownicy VALUES (4, 'Mariola', 'Papuga', 'Wieniawskiego 59, 35-330 Rzeszów', '333445789')
INSERT INTO rozliczenia.pracownicy VALUES (5, 'Marek', 'Krzes³o', 'Stefana ¯eromskiego 23, 81-346 Gdynia', '444456789')
INSERT INTO rozliczenia.pracownicy VALUES (6, 'Marzena', 'Polak', 'Al. Marsza³ka Józefa Pi³sudskiego 22, 90-051 £ódŸ', '125654649')
INSERT INTO rozliczenia.pracownicy VALUES (7, 'Marian', 'Kornik', 'Kaszubska 5, 42-202 Czêstochowa', '122565789')
INSERT INTO rozliczenia.pracownicy VALUES (8, 'Maria', 'Dulska', 'Szkolna 17, 15-640 Bia³ystok', '122344389')
INSERT INTO rozliczenia.pracownicy VALUES (9, 'Mateusz', 'Poniedzia³ek', 'Zielona 12, 39-120 Sêdziszów Ma³opolski', '656456789')
INSERT INTO rozliczenia.pracownicy VALUES (10, 'Magdalena', 'Pastora³ka', 'Œrodkowa 3, 33-100 Tarnów', '121232789')

--Wyswietlanie, sprawdzanie, czy wype³niono poprawnie
SELECT * FROM rozliczenia.pracownicy;

INSERT INTO rozliczenia.godziny VALUES (1, '2023-04-15', 8, 1)
INSERT INTO rozliczenia.godziny VALUES (2, '2023-04-15', 8, 2)
INSERT INTO rozliczenia.godziny VALUES (3, '2023-04-15', 8, 3)
INSERT INTO rozliczenia.godziny VALUES (4, '2023-04-16', 4, 4)
INSERT INTO rozliczenia.godziny VALUES (5, '2023-04-16', 8, 5)
INSERT INTO rozliczenia.godziny VALUES (6, '2023-04-16', 8, 6)
INSERT INTO rozliczenia.godziny VALUES (7, '2023-04-17', 8, 7)
INSERT INTO rozliczenia.godziny VALUES (8, '2023-04-18', 8, 8)
INSERT INTO rozliczenia.godziny VALUES (9, '2023-04-18', 4, 9)
INSERT INTO rozliczenia.godziny VALUES (10, '2023-04-18', 8, 10)

SELECT * FROM rozliczenia.godziny;

INSERT INTO rozliczenia.premie VALUES (1, 'Premia regulaminowa', 1000)
INSERT INTO rozliczenia.premie VALUES (2, 'Premia zespo³owa', 1100)
INSERT INTO rozliczenia.premie VALUES (3, 'Premia motywacyjna', 700)
INSERT INTO rozliczenia.premie VALUES (4, NULL, 2400)
INSERT INTO rozliczenia.premie VALUES (5, NULL, 300)
INSERT INTO rozliczenia.premie VALUES (6, 'Premia prowizyjna', 550)
INSERT INTO rozliczenia.premie VALUES (7, 'Premia uznaniowa', 500)
INSERT INTO rozliczenia.premie VALUES (8, NULL, 369)
INSERT INTO rozliczenia.premie VALUES (9, 'Premia wynikowa', 800)
INSERT INTO rozliczenia.premie VALUES (10, 'Premia indywidualna ', 2650)

SELECT * FROM rozliczenia.premie;

INSERT INTO rozliczenia.pensje VALUES (1, 'asystentka/asystent', 4120, 1)
INSERT INTO rozliczenia.pensje VALUES (2, 'asystentka/asystent', 4120, 2)
INSERT INTO rozliczenia.pensje VALUES (3, 'recepcjonistka/recepcjonista', 3600, 3)
INSERT INTO rozliczenia.pensje VALUES (4, 'recepcjonistka/recepcjonista', 3600, 4)
INSERT INTO rozliczenia.pensje VALUES (5, 'fakturzysta/fakturzystka', 4230 , 5)
INSERT INTO rozliczenia.pensje VALUES (6, 'fakturzysta/fakturzystka', 4230 , 6)
INSERT INTO rozliczenia.pensje VALUES (7, 'pracownik fizyczny', 3690, 7)
INSERT INTO rozliczenia.pensje VALUES (8, 'pracownik fizyczny', 3690, 8)
INSERT INTO rozliczenia.pensje VALUES (9, 'kierownik dzia³u administracji', 6860, 9)
INSERT INTO rozliczenia.pensje VALUES (10, 'kierownik biura', 7830, 10)

SELECT * FROM rozliczenia.pensje;

-- 5. Wyswietl nazwiska pracowników i ich adresy

SELECT nazwisko, adres FROM  rozliczenia.pracownicy;

--6. Konwertacja daty tak, aby wyœwietlana informacja jaki to jest dzieñ tygodnia i jaki miesi¹c
 
SELECT DATEPART ( dw , _data ), DATEPART ( mm , _data ) FROM rozliczenia.godziny;

--7.  Zmiana nazwy atrybutu kwota z tabeli pensji oraz dodanie nowej 

--ALTER TABLE rozliczenia.premie CHANGE kwota kwota_brutto MONEY NOT NULL;
--ALTER TABLE rozliczenia.premie RENAME COLUMN kwota TO kwota_brutto;   
--SELECT kwota AS kwota_brutto FROM rozliczenia.pensje; 

sp_rename 'rozliczenia.pensje.kwota', 'kwota_brutto', 'COLUMN';

SELECT * FROM rozliczenia.pensje;

ALTER TABLE rozliczenia.pensje ADD kwota_netto AS (pensje.kwota_brutto - pensje.kwota_brutto*0.23);
ALTER TABLE rozliczenia.pensje DROP COLUMN kwota_netto









CREATE DATABASE firma1
    
--COMMENT ON DATABASE firma1 IS 'Firma ksiegowosc';

CREATE SCHEMA ksiegowosc;

--COMMENT ON SCHEMA ksiegowosc IS 'Schemat Ksiêgowoœci';

CREATE TABLE ksiegowosc.pracownicy
	(
		id_pracownika INT PRIMARY KEY,
		imie VARCHAR(30) NOT NULL,
		nazwisko VARCHAR(30) NOT NULL,
		adres VARCHAR(255) NOT NULL,
		telefon CHAR(9) NULL
	);
    
	EXEC sp_addextendedproperty
		@name ='Opis tabeli',
		@value ='Tabela zawierajaca dane pracownikow',
		@level0type = 'SCHEMA',
		@level0name = 'ksiegowosc',
		@level1type = 'TABLE',
		@level1name = 'pracownicy';



CREATE TABLE ksiegowosc.godziny
	(
		id_godziny INT PRIMARY KEY,
		_data DATE NOT NULL,
		liczba_godzin FLOAT NOT NULL,
		id_pracownika INT NOT NULL
	);

	EXEC sp_addextendedproperty
		@name ='Opis tabeli',
		@value ='Tabela zawierajaca dane dotycz¹ace godzin przepracowanych przez pracownikow',
		@level0type = 'SCHEMA',
		@level0name = 'ksiegowosc',
		@level1type = 'TABLE',
		@level1name = 'godziny';

CREATE TABLE ksiegowosc.pensja 
	(
	id_pensji INT PRIMARY KEY,
	stanowisko VARCHAR(30) NOT NULL,
	kwota MONEY NOT NULL
	);

	EXEC sp_addextendedproperty
		@name ='Opis tabeli',
		@value ='Tabela zawierajaca dane dotyczace pensji',
		@level0type = 'SCHEMA',
		@level0name = 'ksiegowosc',
		@level1type = 'TABLE',
		@level1name = 'pensja';

CREATE TABLE ksiegowosc.premia
	(
		id_premii INT PRIMARY KEY,
		rodzaj VARCHAR(30) NULL,
		kwota MONEY NULL
	);

	EXEC sp_addextendedproperty
		@name ='Opis tabeli',
		@value ='Tabela zawierajaca dane dotyczace premii',
		@level0type = 'SCHEMA',
		@level0name = 'ksiegowosc',
		@level1type = 'TABLE',
		@level1name = 'premia';


CREATE TABLE ksiegowosc.wynagrodzenie
	(
		id_wynagrodzenia INT PRIMARY KEY,
		_data DATE NOT NULL,
		id_pracownika INT NOT NULL,
		id_godziny INT NOT NULL,
		id_pensji INT NOT NULL,
		id_premii INT NOT NULL
	);

	EXEC sp_addextendedproperty
		@name ='Opis tabeli',
		@value ='Tabela zawierajaca wynagrodzenia pracownikow',
		@level0type = 'SCHEMA',
		@level0name = 'ksiegowosc',
		@level1type = 'TABLE',
		@level1name = 'wynagrodzenie';

ALTER TABLE ksiegowosc.Godziny ADD FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);
ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);
ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY (id_godziny) REFERENCES ksiegowosc.godziny(id_godziny);
ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY (id_pensji) REFERENCES ksiegowosc.pensja(id_pensji);
ALTER TABLE ksiegowosc.wynagrodzenie ADD FOREIGN KEY (id_premii) REFERENCES ksiegowosc.premia(id_premii);
	



INSERT INTO ksiegowosc.pracownicy VALUES (1,'Maksymilian','Rze¿ucha','Œw. Floriana 7/30, 30-072 Zblitowska Góra','123456789');
INSERT INTO ksiegowosc.pracownicy VALUES (2,'Antoni','Jab³onski','Klasztorna 16, 12-032 Czestochowa', '234423154');
INSERT INTO ksiegowosc.pracownicy VALUES (3,'Ariana','Grandówna','Polna 3, 23-542 £êko³ody', '233343154');
INSERT INTO ksiegowosc.pracownicy VALUES (4,'Antonina','Krzy¿','£abêdziowa 13, 22-532 Sanok', '233344354');
INSERT INTO ksiegowosc.pracownicy VALUES (5,'Jacek','Motyl','Sudecka 12, 56-332 Rzeszów', '232343354');
INSERT INTO ksiegowosc.pracownicy VALUES (6,'Joanna','Kalafior','Sucka 13, 51-322 Suwa³ki', '238888354');
INSERT INTO ksiegowosc.pracownicy VALUES (7,'Anatol','Kamieñ','Kamienna 15, 65-123 Skar¿ysko-Kamienna', '237769764');
INSERT INTO ksiegowosc.pracownicy VALUES (8,'Karolina','Marchewka','Marchewkowa 4, 11-312 Pcim', '211118354');
INSERT INTO ksiegowosc.pracownicy VALUES (9,'Anastazja','Wykwintna','Informowana 6/9, 65-222 Sosnowiec', '238123454');
INSERT INTO ksiegowosc.pracownicy VALUES (10,'Atanazy','Niezaszybki','Jêdrzejowa 32, 72-342 Malbork', '231233004');
SELECT * FROM ksiegowosc.pracownicy;


INSERT INTO ksiegowosc.Godziny VALUES (1,'2023-03-02',160,1),
(2,'2023-03-02',200,2),
(3,'2023-03-02',180,3),
(4,'2023-03-03',180,4),
(5,'2023-04-02',180,5),
(6,'2023-04-02',162,6),
(7,'2023-04-03',165.5,7),
(8,'2023-04-03',190,8),
(9,'2023-04-03',160,9),
(10,'2023-04-03',171,10); 

SELECT * FROM ksiegowosc.Godziny  ORDER BY _data DESC;

INSERT INTO ksiegowosc.premia VALUES
	(1, 'Swiateczna', 100),
	(2, 'Motywacyjna 1', 200),
	(3, 'Uznaniowa', 300),
	(4, NULL, NULL),
	(5, 'Motywacyjna 2', 400),
	(6, 'Zespolowa', 500),
	(7, 'Zas³ugowa', 600),
	(8, 'Uznaniowa 2', 700),
	(9, 'Motywacyjna 3', 800),
	(10, 'Indywidualna', 900);

SELECT * FROM ksiegowosc.premia;


INSERT INTO ksiegowosc.pensja VALUES
	(1, 'Sta¿ysta', 800),
	(2, 'Analityk', 1500),
	(3, 'Ksiêgowy', 3000),
	(4, 'Fakturzysta/Fakturzystka', 3000),
	(5, 'Analityk', 10000),
	(6, 'Ksiêgowy', 15000),
	(7, 'Ksiêgowy', 18000),
	(8, 'kierownik', 20000),
	(9, 'kierownik', 25000),
	(10, 'kierownik', 27000);
	
	
SELECT * FROM ksiegowosc.pensja;

INSERT INTO ksiegowosc.wynagrodzenie VALUES
	(1, '2023-04-10', 1, 1, 1, 1),
	(2, '2023-04-12', 2, 2, 2, 2),
	(3, '2023-04-12', 3, 3, 3, 3),
	(4, '2023-04-14', 4, 4, 4, 4),
	(5, '2023-04-13', 5, 5, 5, 5),
	(6, '2023-04-13', 6, 6, 6, 6),
	(7, '2023-04-12', 7, 7, 7, 4),
	(8, '2023-04-15', 8, 8, 8, 4),
	(9, '2023-04-15', 9, 9, 9, 9),
	(10, '2023-04-12', 10, 10, 10, 10);
	
SELECT * FROM ksiegowosc.wynagrodzenie;
DROP TABLE ksiegowosc.pracownicy
--6

--a) Wyœwietl tylko id pracownika oraz jego nazwisko.

SELECT id_pracownika, nazwisko FROM ksiegowosc.pracownicy;

--b) Wyœwietl id pracowników, których p³aca jest wiêksza ni¿ 1000.

SELECT pracownik.id_pracownika FROM ksiegowosc.pracownicy AS pracownik
INNER JOIN ksiegowosc.wynagrodzenie as w
ON pracownik.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.pensja AS p
ON w.id_pensji = p.id_pensji
WHERE p.kwota > 1000;

--c) Wyœwietl id pracowników nieposiadaj¹cych premii,których p³aca jest wiêksza ni¿ 2000.

SELECT pracownik.id_pracownika FROM ksiegowosc.pracownicy AS pracownik
INNER JOIN ksiegowosc.wynagrodzenie as wynagrodzenia
ON pracownik.id_pracownika = wynagrodzenia.id_pracownika
INNER JOIN ksiegowosc.pensja AS pensje
ON wynagrodzenia.id_pensji = pensje.id_pensji
INNER JOIN ksiegowosc.premia as premie
ON wynagrodzenia.id_premii= premie.id_premii
WHERE pensje.kwota > 2000 AND premie.kwota IS NULL;

--d) Wyœwietl pracowników, których pierwsza litera imienia zaczyna siê na literê ‘J’. 

SELECT id_pracownika,imie,nazwisko,adres,telefon FROM ksiegowosc.pracownicy WHERE ksiegowosc.pracownicy.imie LIKE 'J%'

--e) Wyœwietl pracowników, których nazwisko zawiera literê ‘n’ oraz imiê koñczy siê na literê ‘a’.

SELECT id_pracownika,imie,nazwisko,adres,telefon FROM ksiegowosc.pracownicy WHERE ksiegowosc.pracownicy.imie LIKE '%a' AND ksiegowosc.pracownicy.nazwisko LIKE '%n%'

--f) Wyœwietl imiê i nazwisko pracowników oraz liczbê ich nadgodzin, przyjmuj¹c, i¿ standardowy czas pracy to 160 h miesiêcznie.

SELECT pracownik.imie, pracownik.nazwisko, 
CASE WHEN (godzina.liczba_godzin > 160) 
THEN (godzina.liczba_godzin-160) END
AS Liczba_nadgodzin
FROM ksiegowosc.pracownicy AS pracownik
INNER JOIN ksiegowosc.wynagrodzenie AS wynagrodzenia
ON pracownik.id_pracownika = wynagrodzenia.id_pracownika
INNER JOIN ksiegowosc.godziny as godzina
ON wynagrodzenia.id_godziny = godzina.id_godziny;

--g) Wyœwietl imiê i nazwisko pracowników, których pensja zawiera siê w przedziale 1500 – 3000 PLN.

SELECT imie, nazwisko FROM ksiegowosc.pracownicy AS pracownik
INNER JOIN ksiegowosc.wynagrodzenie AS w
ON pracownik.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.pensja AS p
ON p.id_pensji = w.id_pensji
WHERE p.kwota BETWEEN 1500 AND 3000; 

--h)Wyœwietl imiê i nazwisko pracowników, którzy pracowali w nadgodzinach i nie otrzymali premii.

SELECT pracownik.imie, pracownik.nazwisko FROM ksiegowosc.pracownicy AS pracownik
INNER JOIN ksiegowosc.wynagrodzenie AS w
ON pracownik.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.godziny AS g
ON w.id_godziny = g.id_godziny
INNER JOIN ksiegowosc.premia AS pr
ON pr.id_premii = w.id_premii
WHERE g.liczba_godzin > 160 AND pr.kwota IS NULL;

--i) Uszereguj pracowników wed³ug pensji

SELECT pracownik.id_pracownika,imie, nazwisko,p.kwota FROM ksiegowosc.pracownicy AS pracownik
INNER JOIN ksiegowosc.wynagrodzenie as w
ON pracownik.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.pensja AS p
ON w.id_pensji = p.id_pensji
ORDER BY p.kwota ASC; 

--j) Uszereguj pracowników wed³ug pensji i premii malej¹co

SELECT pracownik.id_pracownika,imie, nazwisko, p.kwota, ISNULL(pr.kwota,0) FROM ksiegowosc.pracownicy AS pracownik
INNER JOIN ksiegowosc.wynagrodzenie as w
ON pracownik.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.pensja AS p
ON w.id_pensji = p.id_pensji
INNER JOIN ksiegowosc.premia as pr
ON w.id_premii= pr.id_premii
ORDER BY  p.kwota DESC, pr.kwota DESC;

--Wersja dla pensji i kwoty jako sumy
SELECT pracownik.id_pracownika,imie, nazwisko, (p.kwota+ISNULL(pr.kwota,0)) as pensja_i_premia FROM ksiegowosc.pracownicy AS pracownik
INNER JOIN ksiegowosc.wynagrodzenie as w
ON pracownik.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.pensja AS p
ON w.id_pensji = p.id_pensji
INNER JOIN ksiegowosc.premia as pr
ON w.id_premii= pr.id_premii
ORDER BY  pensja_i_premia DESC;

--k) Zlicz i pogrupuj pracowników wed³ug pola ‘stanowisko'

SELECT p.stanowisko,COUNT(p.stanowisko) AS liczba_pracownikow FROM ksiegowosc.pracownicy as pracownik
INNER JOIN ksiegowosc.wynagrodzenie AS w
ON pracownik.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.pensja AS p 
ON p.id_pensji = w.id_pensji
GROUP BY p.stanowisko;

--l) Policz œredni¹, minimaln¹ i maksymaln¹ p³acê dla stanowiska ‘kierownik’ (je¿eli takiego nie masz, to przyjmij dowolne inne).

SELECT avg(p.kwota) AS srednia, min(p.kwota) AS minimalna, max(p.kwota) AS maksymalna FROM ksiegowosc.wynagrodzenie AS w
INNER JOIN ksiegowosc.pensja AS p 
ON p.id_pensji = w.id_pensji
WHERE p.stanowisko = 'kierownik'

--m) Policz sumê wszystkich wynagrodzeñ.

SELECT SUM(pr.kwota+p.kwota) AS suma_wynagrodzen FROM ksiegowosc.pracownicy AS pracownik
INNER JOIN ksiegowosc.wynagrodzenie AS w
on pracownik.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.pensja AS p 
ON p.id_pensji = w.id_pensji
INNER JOIN ksiegowosc.premia AS pr 
ON pr.id_premii = w.id_premii;

--n) Policz sumê wynagrodzeñ w ramach danego stanowiska.

SELECT p.stanowisko, SUM(ISNULL(pr.kwota,0)+p.kwota) AS suma_wynagrodzen FROM ksiegowosc.pracownicy AS pracownik
INNER JOIN ksiegowosc.wynagrodzenie AS w
on pracownik.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.pensja AS p 
ON p.id_pensji = w.id_pensji
INNER JOIN ksiegowosc.premia AS pr 
ON pr.id_premii = w.id_premii
GROUP BY p.stanowisko;

-- wersja sama pensja

SELECT p.stanowisko, SUM(p.kwota) AS suma_wynagrodzen FROM ksiegowosc.pracownicy AS pracownik
INNER JOIN ksiegowosc.wynagrodzenie AS w
on pracownik.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.pensja AS p 
ON p.id_pensji = w.id_pensji
GROUP BY p.stanowisko;

--o)Wyznacz liczbê premii przyznanych dla pracowników danego stanowiska.

SELECT p.stanowisko, COUNT(pr.id_premii) AS liczba_premii FROM ksiegowosc.pracownicy AS pracownik
INNER JOIN ksiegowosc.wynagrodzenie AS w
on pracownik.id_pracownika = w.id_pracownika
INNER JOIN ksiegowosc.pensja AS p 
ON p.id_pensji = w.id_pensji
INNER JOIN ksiegowosc.premia AS pr 
ON pr.id_premii = w.id_premii
GROUP BY p.stanowisko;

--p) Usuñ wszystkich pracowników maj¹cych pensjê mniejsz¹ ni¿ 1200 z³.

EXEC sp_MSForEachTable
'ALTER TABLE ? NOCHECK CONSTRAINT ALL'
GO
DELETE pracownik 
FROM ksiegowosc.pracownicy pracownik
LEFT OUTER JOIN ksiegowosc.wynagrodzenie w
ON pracownik.id_pracownika = w.id_pracownika
LEFT OUTER JOIN ksiegowosc.pensja p
ON w.id_pensji = p.id_pensji
WHERE p.kwota < 1200;
GO
SELECT * FROM ksiegowosc.pracownicy
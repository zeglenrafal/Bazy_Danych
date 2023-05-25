CREATE DATABASE GEO;
USE GEO;
CREATE TABLE GeoEon
(
	id_eon INT PRIMARY KEY,
    nazwa_eon varchar(30)
);
CREATE TABLE GeoEra(
	id_era INT PRIMARY KEY,
    id_eon INT REFERENCES GeoEon(id_eon),
    nazwa_era varchar(30)
);
CREATE TABLE GeoOkres(
	id_okres INT primary KEY,
    id_era INT REFERENCES GeoEra(id_era),
    nazwa_okres varchar(30)
);
CREATE TABLE GeoEpoka(
	id_epoka INT primary KEY,
    id_okres INT REFERENCES GeoOkres(id_okres),
    nazwa_epoka varchar(30)
);
CREATE TABLE GeoPietro(
	id_pietro INT NOT NULL primary KEY,
    id_epoka INT REFERENCES GeoEpoka(id_epoka),
    nazwa_pietro varchar(30)
);

INSERT INTO GeoEon VALUES (1,'FANEROZOIK');

INSERT INTO GeoEra VALUES (1,1,'Paleozoik'),
(2,1,'Mezozoik'),
(3,1,'Kenozoik');

INSERT INTO GeoOkres VALUES (1,1,'Dewon'),
(2,1,'Karbon'),
(3,1,'Perm'),
(4,2,'Trias'),
(5,2,'Jura'),
(6,2,'Kreda'),
(7,3,'Paleogen'),
(8,3,'Neogen'),
(9,3,'Czwartorzed');

INSERT INTO GeoEpoka VALUES (1,1,'Dolny'),
(2,1,'Srodkowy'),
(3,1,'Gorny'),
(4,2,'Dolny'),
(5,2,'Gorny'),
(6,3,'Dolny'),
(7,3,'Gorny'),
(8,4,'Dolna'),
(9,4,'Srodkowa'),
(10,4,'Gorna'),
(11,5,'Dolna'),
(12,5,'Srodkowa'),
(13,5,'Gorna'),
(14,6,'Dolna'),
(15,6,'Gorna'),
(16,7,'Paleocen'),
(17,7,'Eocen'),
(18,7,'Oligocen'),
(19,8,'Miocen'),
(20,8,'Pliocen'),
(21,9,'Plejstocen'),
(22,9,'Halocen');


INSERT INTO GeoPietro VALUES (1,1,'Lochkow'),
(2,1,'Prag'),
(3,1,'Ems'),
(4,2,'Eifel'),
(5,2,'Żywet'),
(6,3,'Fran'),
(7,3,'Famen'),
(8,4,'Turnej'),
(9,4,'Wizen'),
(10,4,'Serpuchow'),
(11,5,'Baszkir'),
(12,5,'Moskow'),
(13,5,'Kasimow'),
(14,5,'Gzel'),
(15,6,'Assel'),
(16,6,'Sakmar'),
(17,6,'Artinsk'),
(18,6,'Kungur'),
(19,7,'Road'),
(20,7,'Word'),
(21,7,'Kapitan'),
(22,8,'Wucziaping'),
(23,8,'Czangsing'),
(24,9,'Ind'),
(25,9,'Olenek'),
(26,10,'Anizyk'),
(27,10,'Ladyn'),
(28,11,'Karnik'),
(29,11,'Noryk'),
(30,11,'Retyk'),
(31,12,'Hettang'),
(32,12,'Synemur'),
(33,12,'Pliensbach'),
(34,12,'Toark'),
(35,13,'Aalen'),
(36,13,'Bajos'),
(37,13,'Baton'),
(38,13,'Kelowej'),
(39,14,'Oksford'),
(40,14,'Kimeryd'),
(41,14,'Tyton'),
(42,15,'Berrias'),
(43,15,'Walanzyn'),
(44,15,'Hoteryw'),
(45,15,'Barrem'),
(46,15,'Apt'),
(47,15,'Alb'),
(48,16,'Eifel'),
(49,16,'Cenoman'),
(50,16,'Turon'),
(51,16,'Koniak'),
(52,16,'Santon'),
(53,16,'Kampan'),
(54,16,'Mastrycht'),
(55,17,'Dan'),
(56,17,'Zeland'),
(57,17,'Tanet'),
(58,18,'Iprez'),
(59,18,'Lutet'),
(60,18,'Barton'),
(61,18,'Priabon'),
(62,19,'Rupel'),
(63,19,'Szat'),
(64,20,'Akwitan'),
(65,20,'Burdygal'),
(66,20,'Lang'),
(67,20,'Serrawal'),
(68,20,'Torton'),
(69,20,'Messyn'),
(70,21,'Zankl'),
(71,21,'Piacent'),
(72,22,'Gelas'),
(73,22,'Kalabr'),
(74,22,'Chiban'),
(75,22,'Pozny[b]'),
(76,23,'Grenland'),
(77,23,'Northgrip'),
(78,23,'Megalaj');

DROP DATABASE IF EXISTS GEO;





-- Forma zdenormalizowana
CREATE TABLE GeoTabela AS (SELECT * FROM GeoPietro NATURAL JOIN GeoEpoka NATURAL
JOIN GeoOkres NATURAL JOIN GeoEra NATURAL JOIN GeoEon );

CREATE TABLE dziesiec(
	cyfra int,
	bit int
 );
INSERT INTO dziesiec VALUES
	(0, 1),
	(1, 1),
	(2, 1),
	(3, 1),
	(4, 1),
	(5, 1),
	(6, 1),
	(7, 1),
	(8, 1),
	(9, 1);
    
CREATE TABLE milion(
	liczba int,
	cyfra int, 
	bit int
);

INSERT INTO milion SELECT a1.cyfra +10* a2.cyfra +100*a3.cyfra + 1000*a4.cyfra
+ 10000*a5.cyfra + 100000*a6.cyfra AS liczba , a1.cyfra AS cyfra, a1.bit AS bit
FROM dziesiec a1, dziesiec a2, dziesiec a3, dziesiec a4, dziesiec a5, dziesiec a6;

CREATE UNIQUE INDEX liczba_idx ON milion (liczba);
CREATE UNIQUE INDEX id_pietro_idx ON GeoTabela (id_pietro);
CREATE UNIQUE INDEX id_eon_idx ON GeoEon (id_eon);
CREATE UNIQUE INDEX id_era_idx ON GeoEra (id_era);
CREATE UNIQUE INDEX id_okres_idx ON GeoOkres (id_okres);
CREATE UNIQUE INDEX id_epoka_idx ON GeoEpoka (id_epoka);
CREATE UNIQUE INDEX id_pietroG_idx ON GeoPietro (id_pietro);


SHOW PROFILES;
SET profiling = 1;

-- Zapytanie 1 złączenie syntetycznej tablicy miliona wyników ztabelą geochronologiczną w postaci zdenormalizowane
SELECT COUNT(*) FROM Milion INNER JOIN GeoTabela ON (mod(Milion.liczba,68)=(GeoTabela.id_pietro));


-- Zapytanie 2 złączenie syntetycznej tablicy miliona wyników ztabelą geochronologiczną w postaci znormalizowanej, reprezentowaną przez złączenia pięciu tabel
SELECT COUNT(*) FROM Milion INNER JOIN  GeoPietro  ON (mod(Milion.liczba,68)=GeoPietro.id_pietro) NATURAL JOIN GeoEpoka NATURAL JOIN GeoOkres NATURAL JOIN GeoEra NATURAL JOIN GeoEon;


-- Zapytanie 3 złączenie syntetycznej tablicy miliona wyników ztabelą geochronologiczną w postaci zdenormalizowanej, przy czym złączenie jest wykonywane poprzez zagnieżdżenie skorelowane

SELECT COUNT(*) FROM Milion WHERE mod(Milion.liczba,68)= (SELECT id_pietro FROM GeoTabela   WHERE mod(Milion.liczba,68)=(id_pietro));

-- Zapytanie 4 


SELECT COUNT(*) FROM milion WHERE mod(milion.liczba,68)
IN (SELECT geopietro.id_pietro FROM geopietro
NATURAL JOIN geoepoka NATURAL JOIN
geookres NATURAL JOIN geoera NATURAL JOIN geoeon);

-- Dodanie indeksow do reszty argumentow

CREATE UNIQUE INDEX milion_idx ON milion (cyfra,bit);


CREATE UNIQUE INDEX GeoTabela_idx ON GeoTabela (id_eon,id_era,id_okres,id_epoka,id_pietro,nazwa_pietro,nazwa_epoka,nazwa_okres,nazwa_era,nazwa_eon);


select * from GeoPietro;
CREATE UNIQUE INDEX nazwa_eon_idx ON GeoEon (nazwa_eon);

CREATE UNIQUE INDEX era_idx ON GeoEra (id_eon,nazwa_era);

CREATE UNIQUE INDEX okres_idx ON GeoOkres (id_era,nazwa_okres);

CREATE UNIQUE INDEX epoka_idx ON GeoEpoka (id_okres,nazwa_epoka);

CREATE UNIQUE INDEX pietroG_idx ON GeoPietro (id_epoka,nazwa_pietro);
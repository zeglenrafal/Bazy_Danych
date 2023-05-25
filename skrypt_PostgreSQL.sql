-- Database: geo

-- DROP DATABASE IF EXISTS geo;

CREATE DATABASE geo
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Polish_Poland.1250'
    LC_CTYPE = 'Polish_Poland.1250'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
	
CREATE SCHEMA GEO1;
	
CREATE TABLE GEO1.GeoEon
(
	id_eon INT PRIMARY KEY,
    nazwa_eon varchar(30)
);
CREATE TABLE GEO1.GeoEra(
	id_era INT PRIMARY KEY,
    id_eon INT REFERENCES GEO1.GeoEon(id_eon),
    nazwa_era varchar(30)
);
CREATE TABLE GEO1.GeoOkres(
	id_okres INT primary KEY,
    id_era INT REFERENCES GEO1.GeoEra(id_era),
    nazwa_okres varchar(30)
);
CREATE TABLE GEO1.GeoEpoka(
	id_epoka INT primary KEY,
    id_okres INT REFERENCES GEO1.GeoOkres(id_okres),
    nazwa_epoka varchar(30)
);
CREATE TABLE GEO1.GeoPietro(
	id_pietro INT NOT NULL primary KEY,
    id_epoka INT REFERENCES GEO1.GeoEpoka(id_epoka),
    nazwa_pietro varchar(30)
);

INSERT INTO GEO1.GeoEon VALUES (1,'FANEROZOIK');

INSERT INTO GEO1.GeoEra VALUES (1,1,'Paleozoik'),
(2,1,'Mezozoik'),
(3,1,'Kenozoik');

INSERT INTO GEO1.GeoOkres VALUES (1,1,'Dewon'),
(2,1,'Karbon'),
(3,1,'Perm'),
(4,2,'Trias'),
(5,2,'Jura'),
(6,2,'Kreda'),
(7,3,'Paleogen'),
(8,3,'Neogen'),
(9,3,'Czwartorzed');

INSERT INTO GEO1.GeoEpoka VALUES (1,1,'Dolny'),
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


INSERT INTO GEO1.GeoPietro VALUES (1,1,'Lochkow'),
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


DROP DATABASE IF EXISTS GEO;





-- Forma zdenormalizowana
CREATE TABLE GEO1.GeoTabela AS (SELECT * FROM GEO1.GeoPietro NATURAL JOIN GEO1.GeoEpoka NATURAL
JOIN GEO1.GeoOkres NATURAL JOIN GEO1.GeoEra NATURAL JOIN GEO1.GeoEon );

CREATE TABLE GEO1.dziesiec(
	cyfra int,
	bit int
 );
INSERT INTO GEO1.dziesiec VALUES
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
    
CREATE TABLE GEO1.milion(
	liczba int,
	cyfra int, 
	bit int
);

INSERT INTO GEO1.milion SELECT a1.cyfra +10* a2.cyfra +100*a3.cyfra + 1000*a4.cyfra
+ 10000*a5.cyfra + 100000*a6.cyfra AS liczba , a1.cyfra AS cyfra, a1.bit AS bit
FROM GEO1.dziesiec a1, GEO1.dziesiec a2, GEO1.dziesiec a3, GEO1.dziesiec a4, GEO1.dziesiec a5, GEO1.dziesiec a6;

CREATE UNIQUE INDEX liczba_idx ON GEO1.milion (liczba);
CREATE UNIQUE INDEX id_pietro_idx ON GEO1.GeoTabela (id_pietro);
CREATE UNIQUE INDEX id_eon_idx ON GEO1.GeoEon (id_eon);
CREATE UNIQUE INDEX id_era_idx ON GEO1.GeoEra (id_era);
CREATE UNIQUE INDEX id_okres_idx ON GEO1.GeoOkres (id_okres);
CREATE UNIQUE INDEX id_epoka_idx ON GEO1.GeoEpoka (id_epoka);
CREATE UNIQUE INDEX id_pietroG_idx ON GEO1.GeoPietro (id_pietro);	

-- Zapytanie 1 złączenie syntetycznej tablicy miliona wyników ztabelą geochronologiczną w postaci zdenormalizowane

SELECT COUNT(*) FROM GEO1.milion INNER JOIN GEO1.GeoTabela ON (mod(GEO1.milion.liczba,68)=(GEO1.GeoTabela.id_pietro));

-- Zapytanie 2 złączenie syntetycznej tablicy miliona wyników ztabelą geochronologiczną w postaci znormalizowanej, reprezentowaną przez złączenia pięciu tabel

SELECT COUNT(*) FROM GEO1.milion INNER JOIN  GEO1.GeoPietro  ON (mod(GEO1.milion.liczba,68)=GEO1.GeoPietro.id_pietro) NATURAL JOIN GEO1.GeoEpoka NATURAL JOIN GEO1.GeoOkres NATURAL JOIN GEO1.GeoEra NATURAL JOIN GEO1.GeoEon;

-- Zapytanie 3 złączenie syntetycznej tablicy miliona wyników ztabelą geochronologiczną w postaci zdenormalizowanej, przy czym złączenie jest wykonywane poprzez zagnieżdżenie skorelowane

SELECT COUNT(*) FROM GEO1.milion WHERE mod(GEO1.milion.liczba,68)= (SELECT id_pietro FROM GEO1.GeoTabela   WHERE mod(GEO1.milion.liczba,68)=(id_pietro));




SELECT COUNT(*) FROM GEO1.milion WHERE mod(GEO1.milion.liczba,68)
IN (SELECT GEO1.GeoPietro.id_pietro FROM GEO1.GeoPietro
NATURAL JOIN GEO1.GeoEpoka NATURAL JOIN
GEO1.GeoOkres NATURAL JOIN GEO1.GeoEra NATURAL JOIN GEO1.GeoEon);

-- Dodanie indeksow do reszty argumentow

CREATE UNIQUE INDEX milion_idx ON GEO1.milion (cyfra,bit);


CREATE UNIQUE INDEX GeoTabela_idx ON GEO1.GeoTabela (id_eon,id_era,id_okres,id_epoka,id_pietro,nazwa_pietro,nazwa_epoka,nazwa_okres,nazwa_era,nazwa_eon);


select * from GeoPietro;
CREATE UNIQUE INDEX nazwa_eon_idx ON GEO1.GeoEon (nazwa_eon);

CREATE UNIQUE INDEX era_idx ON GEO1.GeoEra (id_eon,nazwa_era);

CREATE UNIQUE INDEX okres_idx ON GEO1.GeoOkres (id_era,nazwa_okres);

CREATE UNIQUE INDEX epoka_idx ON GEO1.GeoEpoka (id_okres,nazwa_epoka);

CREATE UNIQUE INDEX pietroG_idx ON GEO1.GeoPietro (id_epoka,nazwa_pietro);
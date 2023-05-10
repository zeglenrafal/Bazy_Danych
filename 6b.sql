-- a) Zmodyfikuj numer telefonu w tabeli pracownicy, dodaj�c do niego kierunkowy dla Polski w nawiasie (+48)


ALTER TABLE ksiegowosc.pracownicy ALTER COLUMN telefon VARCHAR(19);

SELECT * FROM ksiegowosc.pracownicy; 

UPDATE ksiegowosc.pracownicy
SET telefon = CONCAT('(+48)', telefon);


-- b) Zmodyfikuj atrybut telefon w tabeli pracownicy tak, aby numer oddzielony by� my�lnikami wg wzoru: �555-222-333� 
--SELECT  CONCAT( SUBSTRING(telefon, 1, 8),'-', SUBSTRING(telefon,10,3),'-',SUBSTRING(telefon,14,3) ) FROM ksiegowosc.pracownicy (test)
UPDATE ksiegowosc.pracownicy
SET telefon =  CONCAT( SUBSTRING(telefon, 1, 8),'-', SUBSTRING(telefon,10,3),'-',SUBSTRING(telefon,14,3) )

--c) Wy�wietl dane pracownika, kt�rego nazwisko jest najd�u�sze, u�ywaj�c du�ych liter

SELECT upper(id_pracownika) AS id_pracownika ,upper(imie) AS imie,upper(nazwisko) AS nazwisko ,upper(adres) AS adres, upper(telefon) AS telefon FROM ksiegowosc.pracownicy 
WHERE id_pracownika = 10
ORDER BY len(nazwisko);

--d) Wy�wietl dane pracownik�w i ich pensje zakodowane przy pomocy algorytmu md5
ALTER TABLE ksiegowosc.pensja ALTER COLUMN kwota VARCHAR(10);
SELECT HASHBYTES('MD5', pracownik.imie) AS imie, HASHBYTES('MD5', pracownik.nazwisko) AS nazwisko,
HASHBYTES('MD5', pracownik.adres) AS adres, HASHBYTES('MD5', pracownik.telefon) AS telefon, HASHBYTES('MD5', p.kwota) AS kwota
FROM ksiegowosc.pracownicy AS pracownik
JOIN ksiegowosc.wynagrodzenie AS w 
ON pracownik.id_pracownika = w.id_pracownika 
JOIN ksiegowosc.pensja AS p 
ON p.id_pensji = w.id_pensji;

--f) Wy�wietl pracownik�w, ich pensje oraz premie. Wykorzystaj z��czenie lewostronne.


SELECT pracownik.id_pracownika, pracownik.imie, pracownik.nazwisko , pracownik.adres, pracownik.telefon , p.kwota, pr.kwota
FROM ksiegowosc.pracownicy AS pracownik
LEFT JOIN ksiegowosc.wynagrodzenie AS w 
ON pracownik.id_pracownika = w.id_pracownika 
LEFT JOIN ksiegowosc.pensja AS p 
ON p.id_pensji = w.id_pensji
LEFT JOIN ksiegowosc.premia AS pr 
ON pr.id_premii = w.id_pensji;



--g) wygeneruj raport (zapytanie), kt�re zwr�ci w wyniki tre�� wg poni�szego szablonu:


SELECT CONCAT('Pracownik ' , pracownik.imie , ' ' , pracownik.nazwisko ,', w dniu ',   FORMAT(g._data, 'd', 'de-de'),' otrzyma� pensj� ca�kowit� na kwot� ', p.kwota+ISNULL(pr.kwota,0)+ CASE WHEN g.liczba_godzin <= 160 THEN 0 ELSE (g.liczba_godzin-160)*40 END, ' z�, gdzie
wynagrodzenie zasadnicze wynosi�o: ', p.kwota,' z�, premia: ',isnull(pr.kwota,0),' z�, nadgodziny: ', CASE WHEN g.liczba_godzin <= 160 THEN 0 ELSE (g.liczba_godzin-160)*40 END,' z�' ) AS raport FROM ksiegowosc.pracownicy AS pracownik 
JOIN ksiegowosc.wynagrodzenie AS w 
ON pracownik.id_pracownika = w.id_pracownika 
JOIN ksiegowosc.godziny AS g 
ON pracownik.id_pracownika = g.id_pracownika 
JOIN ksiegowosc.pensja AS p 
ON p.id_pensji = w.id_pensji
JOIN ksiegowosc.premia AS pr 
ON pr.id_premii = w.id_pensji;



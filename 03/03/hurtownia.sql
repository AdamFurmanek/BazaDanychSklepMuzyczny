--pokazuje jaki odsetek rodzaju stanowi konkretny instrument
SELECT DISTINCT hurtownia_egzemplarz.rodzaj_instrumentu rodzaj , hurtownia_egzemplarz.nazwa_instrumentu nazwa , 100*ROUND(COUNT(hurtownia_egzemplarz.id) OVER (PARTITION BY rodzaj_instrumentu, nazwa_instrumentu)/COUNT(hurtownia_egzemplarz.id) OVER (PARTITION BY rodzaj_instrumentu),2) udzial_procentowy
FROM hurtownia_egzemplarz
ORDER BY Rodzaj, Udzial_procentowy;

--pokazuje procentowy udzial miast klientow ktorzy kupowali w miastach oddzialow
SELECT DISTINCT hurtownia_egzemplarz.miasto_sprzedazy miasto_sprzedazy , hurtownia_egzemplarz.miasto_klienta miasto_klienta , 100*ROUND(COUNT(hurtownia_egzemplarz.id) OVER (PARTITION BY miasto_sprzedazy, miasto_klienta)/COUNT(hurtownia_egzemplarz.id) OVER (PARTITION BY miasto_sprzedazy),2) udzial_procentowy
FROM hurtownia_egzemplarz
ORDER BY Miasto_sprzedazy, Udzial_procentowy;

--pokazuje procentowy udzial miesiecy w sprzedazy rocznej
SELECT DISTINCT EXTRACT(YEAR FROM hurtownia_data_sprzedazy.data) rok , EXTRACT(MONTH FROM hurtownia_data_sprzedazy.data) miesiac , 100*ROUND(COUNT(hurtownia_egzemplarz.id) OVER (PARTITION BY EXTRACT(YEAR FROM hurtownia_data_sprzedazy.data), EXTRACT(MONTH FROM hurtownia_data_sprzedazy.data))/COUNT(hurtownia_egzemplarz.id) OVER (PARTITION BY EXTRACT(YEAR FROM hurtownia_data_sprzedazy.data)),2) udzial_procentowy
FROM hurtownia_egzemplarz, hurtownia_data_sprzedazy
WHERE hurtownia_data_sprzedazy.id=hurtownia_egzemplarz.id_data_sprzedazy
ORDER BY rok, miesiac, Udzial_procentowy;

--pokazuje procentowy udzial miast w danych platnosciach
SELECT DISTINCT hurtownia_egzemplarz.platnosc platnosc , hurtownia_egzemplarz.miasto_sprzedazy miasto_sprzedazy , 100*ROUND(COUNT(hurtownia_egzemplarz.id) OVER (PARTITION BY platnosc, miasto_sprzedazy)/COUNT(hurtownia_egzemplarz.id) OVER (PARTITION BY platnosc),2) udzial_procentowy
FROM hurtownia_egzemplarz
ORDER BY platnosc, Udzial_procentowy;

--pokazuje procentowy udzial platnosci dla danych miast
SELECT DISTINCT  hurtownia_egzemplarz.miasto_sprzedazy miasto_sprzedazy, hurtownia_egzemplarz.platnosc platnosc, 100*ROUND(COUNT(hurtownia_egzemplarz.id) OVER (PARTITION BY miasto_sprzedazy,platnosc)/COUNT(hurtownia_egzemplarz.id) OVER (PARTITION BY miasto_sprzedazy),2) udzial_procentowy
FROM hurtownia_egzemplarz
ORDER BY miasto_sprzedazy, Udzial_procentowy;
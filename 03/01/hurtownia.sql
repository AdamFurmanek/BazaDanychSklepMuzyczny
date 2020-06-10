--ile sprzedano jakich instrumentow i jakiego rodzaju
SELECT NVL(hurtownia_egzemplarz.rodzaj_instrumentu, '------RAZEM------') "Rodzaj", NVL(hurtownia_egzemplarz.nazwa_instrumentu, '------RAZEM------') "Instrument",COUNT(hurtownia_egzemplarz.id) "Sprzedano"
FROM hurtownia_egzemplarz
GROUP BY ROLLUP(hurtownia_egzemplarz.rodzaj_instrumentu, hurtownia_egzemplarz.nazwa_instrumentu);

--ile sprzedano w jakim miescie i klientom jakich miast
SELECT NVL(hurtownia_egzemplarz.miasto_sprzedazy, '------RAZEM------') "Miasto sprzedazy", NVL(hurtownia_egzemplarz.miasto_klienta, '------RAZEM------') "Miasto klienta",COUNT(hurtownia_egzemplarz.id) "Sprzedano"
FROM hurtownia_egzemplarz
GROUP BY ROLLUP(hurtownia_egzemplarz.miasto_sprzedazy, hurtownia_egzemplarz.miasto_klienta);

--ile sprzedano w jakim roku i jakim miesiacu
SELECT NVL(TO_CHAR(EXTRACT(YEAR FROM hurtownia_data_sprzedazy.data)), '------RAZEM------') "Rok", NVL(TO_CHAR(EXTRACT(MONTH FROM hurtownia_data_sprzedazy.data)), '------RAZEM------') "Miesiac",COUNT(hurtownia_egzemplarz.id) "Sprzedano"
FROM hurtownia_egzemplarz, hurtownia_data_sprzedazy
WHERE hurtownia_data_sprzedazy.id=hurtownia_egzemplarz.id_data_sprzedazy
GROUP BY ROLLUP(EXTRACT(YEAR FROM hurtownia_data_sprzedazy.data), (EXTRACT(MONTH FROM hurtownia_data_sprzedazy.data)));

--ile sprzedano w jakim oddziale
SELECT NVL(hurtownia_oddzial.nazwa, '------RAZEM------') "Oddzial",COUNT(hurtownia_egzemplarz.id) "Sprzedano"
FROM hurtownia_egzemplarz, hurtownia_oddzial
WHERE hurtownia_oddzial.id=hurtownia_egzemplarz.id_oddzial
GROUP BY ROLLUP(hurtownia_oddzial.nazwa);

--ile wydano na insturmenty i od jakiego producenta
SELECT NVL(hurtownia_producent.nazwa, '------RAZEM------') "Producent",SUM(hurtownia_egzemplarz.koszt) "Wydano"
FROM hurtownia_egzemplarz, hurtownia_producent
WHERE hurtownia_producent.id=hurtownia_egzemplarz.id_producent
GROUP BY ROLLUP(hurtownia_producent.nazwa);
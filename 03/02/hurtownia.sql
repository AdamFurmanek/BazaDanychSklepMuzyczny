--ile kupil jaki klient
SELECT hurtownia_klient.imie, hurtownia_klient.nazwisko, Kupiono FROM hurtownia_klient,
(SELECT NVL(TO_CHAR(hurtownia_egzemplarz.id_klient), '------RAZEM------') Klient, COUNT(hurtownia_egzemplarz.id) Kupiono
FROM hurtownia_egzemplarz
GROUP BY CUBE(TO_CHAR(hurtownia_egzemplarz.id_klient)))
WHERE Klient=TO_CHAR(hurtownia_klient.id);

--ile sprzedano przy jakim zamowieniu
SELECT NVL(TO_CHAR(hurtownia_egzemplarz.numer_zamowienia), '------RAZEM------') "Zamowienie", COUNT(hurtownia_egzemplarz.id) "Sprzedano"
FROM hurtownia_egzemplarz
GROUP BY CUBE(TO_CHAR(hurtownia_egzemplarz.numer_zamowienia));

--ile sprzedano w jakich miesiacach i jakich dniach
SELECT NVL(TO_CHAR(EXTRACT(MONTH FROM hurtownia_data_sprzedazy.data)), '------RAZEM------') "Miesiac", NVL(TO_CHAR(EXTRACT(DAY FROM hurtownia_data_sprzedazy.data)), '------RAZEM------') "Dzien",COUNT(hurtownia_egzemplarz.id) "Sprzedano"
FROM hurtownia_egzemplarz, hurtownia_data_sprzedazy
WHERE hurtownia_data_sprzedazy.id=hurtownia_egzemplarz.id_data_sprzedazy
GROUP BY CUBE(EXTRACT(MONTH FROM hurtownia_data_sprzedazy.data), (EXTRACT(DAY FROM hurtownia_data_sprzedazy.data)));

--ile kupil klient z jakiego miasta i jaka platnoscia
SELECT NVL(hurtownia_egzemplarz.miasto_klienta, '------RAZEM------') "Miasto klienta", NVL(hurtownia_egzemplarz.platnosc, '------RAZEM------') "Platnosc",COUNT(hurtownia_egzemplarz.id) "Kupiono"
FROM hurtownia_egzemplarz
GROUP BY CUBE(hurtownia_egzemplarz.miasto_klienta, hurtownia_egzemplarz.platnosc);

--ile wydali klienci, jaka platnoscia i z jakiego miasta
SELECT NVL(hurtownia_egzemplarz.platnosc, '------RAZEM------') "Platnosc", NVL(hurtownia_egzemplarz.miasto_klienta, '------RAZEM------') "Miasto klienta", SUM(hurtownia_egzemplarz.koszt) "Zysk"
FROM hurtownia_egzemplarz
GROUP BY CUBE(hurtownia_egzemplarz.platnosc, hurtownia_egzemplarz.miasto_klienta);
SELECT osoba.imie, osoba.nazwisko, Kupiono FROM osoba,
(SELECT osoba.id Osobaid,COUNT(egzemplarz.id) Kupiono
FROM egzemplarz, zamowienie, klient, osoba
WHERE egzemplarz.id_zamowienie=zamowienie.id AND zamowienie.id_klient=klient.id AND klient.id_osoba=osoba.id
GROUP BY CUBE(osoba.id))
WHERE osoba.id=Osobaid;

SELECT NVL(TO_CHAR(zamowienie.id), '------RAZEM------') "Zamowienie", COUNT(egzemplarz.id) "Sprzedano"
FROM zamowienie, egzemplarz
WHERE egzemplarz.id_zamowienie=zamowienie.id
GROUP BY CUBE(TO_CHAR(zamowienie.id));

SELECT NVL(TO_CHAR(EXTRACT(MONTH FROM zamowienie.data)), '------RAZEM------') "Miesiac", NVL(TO_CHAR(EXTRACT(DAY FROM zamowienie.data)), '------RAZEM------') "Dzien",COUNT(egzemplarz.id) "Sprzedano"
FROM egzemplarz, zamowienie
WHERE egzemplarz.id_zamowienie=zamowienie.id
GROUP BY CUBE(EXTRACT(MONTH FROM zamowienie.data), (EXTRACT(DAY FROM zamowienie.data)));

SELECT NVL(adres.miasto, '------RAZEM------') "Miasto klienta", NVL(platnosc.nazwa, '------RAZEM------') "Platnosc",COUNT(egzemplarz.id) "Kupiono"
FROM egzemplarz, zamowienie, platnosc, klient, osoba, adres
WHERE egzemplarz.id_zamowienie=zamowienie.id AND zamowienie.id_platnosc=platnosc.id AND zamowienie.id_klient=klient.id AND klient.id_osoba=osoba.id AND osoba.id_adres=adres.id
GROUP BY CUBE(adres.miasto, platnosc.nazwa);

SELECT NVL(platnosc.nazwa, '------RAZEM------') "Platnosc", NVL(adres.miasto, '------RAZEM------') "Miasto klienta", COUNT(egzemplarz.id) "Kupiono"
FROM egzemplarz, zamowienie, platnosc, klient, osoba, adres
WHERE egzemplarz.id_zamowienie=zamowienie.id AND zamowienie.id_platnosc=platnosc.id AND zamowienie.id_klient=klient.id AND klient.id_osoba=osoba.id AND osoba.id_adres=adres.id
GROUP BY CUBE(platnosc.nazwa, adres.miasto);
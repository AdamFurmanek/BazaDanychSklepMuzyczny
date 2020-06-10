SELECT NVL(rodzaj.nazwa, '------RAZEM------') "Rodzaj", NVL(instrument.nazwa, '------RAZEM------') "Instrument",COUNT(egzemplarz.id) "Sprzedano"
FROM egzemplarz, instrument, rodzaj
WHERE egzemplarz.id_instrument=instrument.id AND instrument.id_rodzaj=rodzaj.id
GROUP BY ROLLUP(rodzaj.nazwa, instrument.nazwa);

SELECT NVL(a1.miasto, '------RAZEM------') "Miasto sprzedazy", NVL(a2.miasto, '------RAZEM------') "Miasto klienta",COUNT(egzemplarz.id) "Sprzedano"
FROM egzemplarz, oddzial, adres a1, zamowienie, klient, osoba, adres a2
WHERE egzemplarz.id_oddzial=oddzial.id AND oddzial.id_adres=a1.id AND egzemplarz.id_zamowienie=zamowienie.id AND zamowienie.id_klient=klient.id AND klient.id_osoba=osoba.id AND osoba.id_adres=a2.id
GROUP BY ROLLUP(a1.miasto, a2.miasto);

SELECT NVL(TO_CHAR(EXTRACT(YEAR FROM zamowienie.data)), '------RAZEM------') "Rok", NVL(TO_CHAR(EXTRACT(MONTH FROM zamowienie.data)), '------RAZEM------') "Miesiac",COUNT(egzemplarz.id) "Sprzedano"
FROM egzemplarz, zamowienie
WHERE egzemplarz.id_zamowienie=zamowienie.id
GROUP BY ROLLUP(EXTRACT(YEAR FROM zamowienie.data), (EXTRACT(MONTH FROM zamowienie.data)));

SELECT NVL(oddzial.nazwa, '------RAZEM------') "Oddzial",COUNT(egzemplarz.id) "Sprzedano"
FROM egzemplarz, oddzial
WHERE oddzial.id=egzemplarz.id_oddzial
GROUP BY ROLLUP(oddzial.nazwa);

SELECT NVL(producent.nazwa, '------RAZEM------') "Producent",SUM(egzemplarz.koszt) "Wydano"
FROM egzemplarz, producent
WHERE producent.id=egzemplarz.id_producent
GROUP BY ROLLUP(producent.nazwa);
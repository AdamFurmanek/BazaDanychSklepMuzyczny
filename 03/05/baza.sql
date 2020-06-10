SELECT osoba.imie,osoba.nazwisko,adres.numer,kupil, RANK() OVER (ORDER BY kupil DESC) AS ranking
FROM klient,osoba,adres,
(SELECT DISTINCT klient.id klientid, COUNT(egzemplarz.id) OVER (PARTITION BY klient.id) kupil
FROM egzemplarz, zamowienie, klient
WHERE egzemplarz.id_zamowienie=zamowienie.id AND zamowienie.id_klient=klient.id)
WHERE klientid=klient.id AND klient.id_osoba=osoba.id AND osoba.id_adres=adres.id;

SELECT osoba.imie,osoba.nazwisko,adres.numer,adres.miasto,sprzedal, RANK() OVER (ORDER BY sprzedal DESC) AS ranking
FROM pracownik, osoba, adres,
(SELECT DISTINCT pracownik.id pracownikid, COUNT(egzemplarz.id) OVER (PARTITION BY pracownik.id) sprzedal
FROM egzemplarz,oddzial,pracownik
WHERE egzemplarz.id_oddzial=oddzial.id AND pracownik.id_oddzial=oddzial.id)
WHERE pracownikid=pracownik.id AND pracownik.id_osoba=osoba.id AND osoba.id_adres=adres.id;

SELECT instrument, sprzedano, RANK() OVER (ORDER BY sprzedano DESC) AS ranking FROM
(SELECT DISTINCT instrument.nazwa instrument, COUNT(egzemplarz.id) OVER (PARTITION BY instrument.nazwa) sprzedano
FROM egzemplarz,instrument
WHERE egzemplarz.id_instrument=instrument.id);

SELECT platnosc, uzyto, RANK() OVER (ORDER BY uzyto DESC) AS ranking FROM
(SELECT DISTINCT platnosc.nazwa platnosc, COUNT(egzemplarz.id) OVER (PARTITION BY platnosc.nazwa) uzyto
FROM egzemplarz,zamowienie,platnosc
WHERE egzemplarz.id_zamowienie=zamowienie.id AND zamowienie.id_platnosc=platnosc.id);

SELECT oddzial.nazwa, adres.numer, sprzedano, RANK() OVER (ORDER BY sprzedano DESC) AS ranking
FROM oddzial, adres,
(SELECT DISTINCT oddzial.id oddzialid, COUNT(egzemplarz.id) OVER (PARTITION BY oddzial.id) sprzedano
FROM egzemplarz, oddzial
WHERE egzemplarz.id_oddzial=oddzial.id)
WHERE oddzialid=oddzial.id AND oddzial.id_adres=adres.id;
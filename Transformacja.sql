define sciezka = 'D:'
set sqlformat csv

--hurtownia oddzial
spool &&sciezka\\Oddzial.csv;
SELECT oddzial.id, nazwa, numer
FROM oddzial, adres
WHERE oddzial.id_adres=adres.id;
spool off;
--hurtownia pracownik
spool &&sciezka\\Pracownik.csv;
SELECT pracownik.id, imie, nazwisko, miasto, numer
FROM pracownik, osoba, adres
WHERE pracownik.id_osoba=osoba.id AND osoba.id_adres=adres.id;
spool off;
--hurtownia klient
spool &&sciezka\\Klient.csv;
SELECT klient.id, imie, nazwisko, numer
FROM klient, osoba, adres
WHERE klient.id_osoba=osoba.id AND osoba.id_adres=adres.id;
spool off;
--hurtownia data produkcji
spool &&sciezka\\Data_produkcji.csv;
SELECT MAX(id), data_produkcji
FROM egzemplarz
GROUP BY data_produkcji;
spool off;
--hurtownia producent
spool &&sciezka\\Producent.csv;
SELECT producent.id, nazwa, miasto, numer
FROM producent, adres
WHERE producent.id_adres=adres.id;
spool off;
--hurtownia data sprzedazy
spool &&sciezka\\Data_sprzedazy.csv;
SELECT MAX(id), data
FROM zamowienie
GROUP BY data;
spool off;
--hurtownia egzemplarz
spool &&sciezka\\Egzemplarz.csv;
SELECT egzemplarz.id id, oddzial.id id_oddzial, pracownik.id id_pracownik, klient.id id_klient, id_data_produkcji, producent.id id_producent, id_data_sprzedazy, adres1.miasto miasto_klienta, adres2.miasto miasto_sprzedazy, rodzaj.nazwa rodzaj_instrumentu, platnosc.nazwa platnosc, instrument.nazwa nazwa_instrumentu, zamowienie.id numer_zamowienia
FROM egzemplarz, zamowienie, platnosc, klient, oddzial, pracownik, instrument, rodzaj, producent, adres adres1, adres adres2, osoba,
        (SELECT MAX(id) AS id_data_produkcji, data_produkcji data_produkcji2
        FROM egzemplarz
        GROUP BY data_produkcji),
        (SELECT MAX(id) AS id_data_sprzedazy, data data2
        FROM zamowienie
        GROUP BY data)
WHERE egzemplarz.id_zamowienie=zamowienie.id AND zamowienie.id_platnosc=platnosc.id AND zamowienie.id_klient=klient.id
AND egzemplarz.id_oddzial=oddzial.id AND pracownik.id_oddzial=oddzial.id
AND egzemplarz.id_instrument=instrument.id AND instrument.id_rodzaj=rodzaj.id
AND egzemplarz.id_producent=producent.id
AND egzemplarz.data_produkcji=data_produkcji2
AND zamowienie.data=data2
AND adres1.id=osoba.id_adres
AND osoba.id=klient.id_osoba
AND adres2.id=oddzial.id_adres;
spool off;


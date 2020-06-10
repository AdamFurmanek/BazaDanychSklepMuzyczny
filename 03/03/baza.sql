SELECT DISTINCT rodzaj.nazwa , instrument.nazwa , 100*ROUND(COUNT(egzemplarz.id) OVER (PARTITION BY rodzaj.nazwa, instrument.nazwa)/COUNT(egzemplarz.id) OVER (PARTITION BY rodzaj.nazwa),2) udzial_procentowy
FROM egzemplarz, instrument, rodzaj
WHERE egzemplarz.id_instrument=instrument.id AND instrument.id_rodzaj=rodzaj.id
ORDER BY rodzaj.nazwa, Udzial_procentowy;

SELECT DISTINCT a2.miasto miasto_sprzedazy , a1.miasto miasto_klienta , 100*ROUND(COUNT(egzemplarz.id) OVER (PARTITION BY a2.miasto, a1.miasto)/COUNT(egzemplarz.id) OVER (PARTITION BY a2.miasto),2) udzial_procentowy
FROM egzemplarz, zamowienie, klient, osoba, adres a1, oddzial, adres a2
WHERE egzemplarz.id_zamowienie=zamowienie.id AND zamowienie.id_klient=klient.id AND klient.id_osoba=osoba.id AND osoba.id_adres=a1.id AND egzemplarz.id_oddzial=oddzial.id AND oddzial.id_adres=a2.id
ORDER BY Miasto_sprzedazy, Udzial_procentowy;

SELECT DISTINCT EXTRACT(YEAR FROM zamowienie.data) rok , EXTRACT(MONTH FROM zamowienie.data) miesiac , 100*ROUND(COUNT(egzemplarz.id) OVER (PARTITION BY EXTRACT(YEAR FROM zamowienie.data), EXTRACT(MONTH FROM zamowienie.data))/COUNT(egzemplarz.id) OVER (PARTITION BY EXTRACT(YEAR FROM zamowienie.data)),2) udzial_procentowy
FROM egzemplarz, zamowienie
WHERE egzemplarz.id_zamowienie=zamowienie.id
ORDER BY rok, miesiac, Udzial_procentowy;

SELECT DISTINCT platnosc.nazwa platnosc, adres.miasto miasto_sprzedazy , 100*ROUND(COUNT(egzemplarz.id) OVER (PARTITION BY platnosc.nazwa, adres.miasto)/COUNT(egzemplarz.id) OVER (PARTITION BY platnosc.nazwa),2) udzial_procentowy
FROM egzemplarz, zamowienie, platnosc, oddzial, adres
WHERE egzemplarz.id_zamowienie=zamowienie.id AND zamowienie.id_platnosc=platnosc.id AND egzemplarz.id_oddzial=oddzial.id AND oddzial.id_adres=adres.id
ORDER BY platnosc, Udzial_procentowy;

SELECT DISTINCT adres.miasto miasto_sprzedazy, platnosc.nazwa platnosc, 100*ROUND(COUNT(egzemplarz.id) OVER (PARTITION BY adres.miasto, platnosc.nazwa)/COUNT(egzemplarz.id) OVER (PARTITION BY adres.miasto),2) udzial_procentowy
FROM egzemplarz, zamowienie, platnosc, oddzial, adres
WHERE egzemplarz.id_zamowienie=zamowienie.id AND zamowienie.id_platnosc=platnosc.id AND egzemplarz.id_oddzial=oddzial.id AND oddzial.id_adres=adres.id
ORDER BY miasto_sprzedazy, Udzial_procentowy;
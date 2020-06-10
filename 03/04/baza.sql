SELECT DISTINCT EXTRACT(YEAR FROM zamowienie.data) rok, EXTRACT(MONTH FROM zamowienie.data) miesiac, SUM(egzemplarz.cena) OVER (PARTITION BY EXTRACT(YEAR FROM zamowienie.data) ORDER BY EXTRACT(MONTH FROM zamowienie.data) RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) zysk
FROM egzemplarz, zamowienie
WHERE egzemplarz.id_zamowienie=zamowienie.id
ORDER BY rok, miesiac;

SELECT DISTINCT EXTRACT(YEAR FROM zamowienie.data) rok, EXTRACT(MONTH FROM zamowienie.data) miesiac, COUNT(egzemplarz.id) OVER (PARTITION BY EXTRACT(YEAR FROM zamowienie.data) ORDER BY EXTRACT(MONTH FROM zamowienie.data) RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) sprzedano
FROM egzemplarz, zamowienie
WHERE egzemplarz.id_zamowienie=zamowienie.id
ORDER BY rok, miesiac;

SELECT DISTINCT oddzial.nazwa oddzial, EXTRACT(YEAR FROM zamowienie.data) rok, EXTRACT(MONTH FROM zamowienie.data) miesiac, COUNT(egzemplarz.id) OVER (PARTITION BY oddzial.nazwa, EXTRACT(YEAR FROM zamowienie.data) ORDER BY EXTRACT(MONTH FROM zamowienie.data) RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) sprzedano
FROM egzemplarz, zamowienie, oddzial
WHERE egzemplarz.id_zamowienie=zamowienie.id AND egzemplarz.id_oddzial=oddzial.id
ORDER BY oddzial, rok, miesiac;

SELECT DISTINCT producent.nazwa producent, EXTRACT(YEAR FROM zamowienie.data) rok, COUNT(egzemplarz.id) OVER (PARTITION BY producent.nazwa ORDER BY EXTRACT(YEAR FROM zamowienie.data) RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) wyprodukowano
FROM egzemplarz, zamowienie, producent
WHERE egzemplarz.id_zamowienie=zamowienie.id AND egzemplarz.id_oddzial=producent.id
ORDER BY producent, rok;

SELECT osoba.imie, osoba.nazwisko, adres.numer, adres.miasto, rok, kupil
FROM klient, osoba, adres,
(SELECT DISTINCT klient.id klientid, EXTRACT(YEAR FROM zamowienie.data) rok, COUNT(egzemplarz.id) OVER (PARTITION BY klient.id ORDER BY EXTRACT(YEAR FROM zamowienie.data) RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) kupil
FROM egzemplarz, zamowienie, klient
WHERE egzemplarz.id_zamowienie=zamowienie.id AND zamowienie.id_klient=klient.id
ORDER BY klient.id, rok)
WHERE klientid=klient.id AND klient.id_osoba=osoba.id AND osoba.id_adres=adres.id
ORDER BY osoba.nazwisko, osoba.imie, adres.numer, rok;
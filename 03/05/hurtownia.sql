--ranking klientow wedlug ilosci kupionych instrumentow
SELECT imie,nazwisko,numer,kupil, RANK() OVER (ORDER BY kupil DESC) AS ranking
FROM hurtownia_klient,
(SELECT DISTINCT hurtownia_egzemplarz.id_klient klientid, COUNT(hurtownia_egzemplarz.id) OVER (PARTITION BY hurtownia_egzemplarz.id_klient) kupil
FROM hurtownia_egzemplarz)
WHERE klientid=hurtownia_klient.id;

--ranking sprzedawcow wedlug ilosci sprzedanych instrumentow
SELECT imie,nazwisko,numer,miasto,sprzedal, RANK() OVER (ORDER BY sprzedal DESC) AS ranking
FROM hurtownia_pracownik,
(SELECT DISTINCT hurtownia_egzemplarz.id_pracownik pracownikid, COUNT(hurtownia_egzemplarz.id) OVER (PARTITION BY hurtownia_egzemplarz.id_pracownik) sprzedal
FROM hurtownia_egzemplarz)
WHERE pracownikid=hurtownia_pracownik.id;

--ranking instrumentow wedlug ich sprzedanej ilosci
SELECT instrument, sprzedano, RANK() OVER (ORDER BY sprzedano DESC) AS ranking FROM
(SELECT DISTINCT hurtownia_egzemplarz.nazwa_instrumentu instrument, COUNT(hurtownia_egzemplarz.id) OVER (PARTITION BY hurtownia_egzemplarz.nazwa_instrumentu) sprzedano
FROM hurtownia_egzemplarz);

--ranking metody platnosci wedlug ilosci ich uzyc
SELECT platnosc, uzyto, RANK() OVER (ORDER BY uzyto DESC) AS ranking FROM
(SELECT DISTINCT hurtownia_egzemplarz.platnosc platnosc, COUNT(hurtownia_egzemplarz.id) OVER (PARTITION BY hurtownia_egzemplarz.platnosc) uzyto
FROM hurtownia_egzemplarz);

--ranking oddzialow wedlug ilosci sprzedanych instrumentow
SELECT nazwa,numer, sprzedano, RANK() OVER (ORDER BY sprzedano DESC) AS ranking
FROM hurtownia_oddzial,
(SELECT DISTINCT hurtownia_egzemplarz.id_oddzial oddzialid, COUNT(hurtownia_egzemplarz.id) OVER (PARTITION BY hurtownia_egzemplarz.id_oddzial) sprzedano
FROM hurtownia_egzemplarz)
WHERE oddzialid=hurtownia_oddzial.id;
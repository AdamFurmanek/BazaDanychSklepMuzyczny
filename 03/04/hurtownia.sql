--miesieczne zestawienie zysku ze sprzedanych instrumentow od poczatku kazdego roku
SELECT DISTINCT EXTRACT(YEAR FROM hurtownia_data_sprzedazy.data) rok, EXTRACT(MONTH FROM hurtownia_data_sprzedazy.data) miesiac, SUM(hurtownia_egzemplarz.cena) OVER (PARTITION BY EXTRACT(YEAR FROM hurtownia_data_sprzedazy.data) ORDER BY EXTRACT(MONTH FROM hurtownia_data_sprzedazy.data) RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) zysk
FROM hurtownia_egzemplarz, hurtownia_data_sprzedazy
WHERE hurtownia_egzemplarz.id_data_sprzedazy=hurtownia_data_sprzedazy.id
ORDER BY rok, miesiac;

--miesieczne zestawienie ilosc sprzedanych instrumentow od poczatku kazdego roku
SELECT DISTINCT EXTRACT(YEAR FROM hurtownia_data_sprzedazy.data) rok, EXTRACT(MONTH FROM hurtownia_data_sprzedazy.data) miesiac, COUNT(hurtownia_egzemplarz.id) OVER (PARTITION BY EXTRACT(YEAR FROM hurtownia_data_sprzedazy.data) ORDER BY EXTRACT(MONTH FROM hurtownia_data_sprzedazy.data) RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) sprzedano
FROM hurtownia_egzemplarz, hurtownia_data_sprzedazy
WHERE hurtownia_egzemplarz.id_data_sprzedazy=hurtownia_data_sprzedazy.id
ORDER BY rok, miesiac;

--miesieczne zestawienie sprzedanych isntrumentow w oddzialach liczone od poczatku kazdego roku
SELECT DISTINCT hurtownia_oddzial.nazwa oddzial, EXTRACT(YEAR FROM hurtownia_data_sprzedazy.data) rok, EXTRACT(MONTH FROM hurtownia_data_sprzedazy.data) miesiac, COUNT(hurtownia_egzemplarz.id) OVER (PARTITION BY hurtownia_oddzial.nazwa, EXTRACT(YEAR FROM hurtownia_data_sprzedazy.data) ORDER BY EXTRACT(MONTH FROM hurtownia_data_sprzedazy.data) RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) sprzedano
FROM hurtownia_egzemplarz, hurtownia_data_sprzedazy, hurtownia_oddzial
WHERE hurtownia_egzemplarz.id_data_sprzedazy=hurtownia_data_sprzedazy.id AND hurtownia_egzemplarz.id_oddzial=hurtownia_oddzial.id
ORDER BY oddzial, rok, miesiac;

--roczne zestawienie produkcji instrumentow od danych producentow liczac od poczatku istnienia
SELECT DISTINCT hurtownia_producent.nazwa producent, EXTRACT(YEAR FROM hurtownia_data_produkcji.data) rok, COUNT(hurtownia_egzemplarz.id) OVER (PARTITION BY hurtownia_producent.nazwa ORDER BY EXTRACT(YEAR FROM hurtownia_data_produkcji.data) RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) wyprodukowano
FROM hurtownia_egzemplarz, hurtownia_data_produkcji, hurtownia_producent
WHERE hurtownia_egzemplarz.id_data_produkcji=hurtownia_data_produkcji.id AND hurtownia_egzemplarz.id_producent=hurtownia_producent.id
ORDER BY producent, rok;

--roczne zestawienie zakupow klientow liczac od poczatku istnienia sklepu
SELECT imie, nazwisko, numer, rok, kupil FROM hurtownia_klient,
(SELECT DISTINCT hurtownia_klient.id klientid, EXTRACT(YEAR FROM hurtownia_data_sprzedazy.data) rok, COUNT(hurtownia_egzemplarz.id) OVER (PARTITION BY hurtownia_klient.id ORDER BY EXTRACT(YEAR FROM hurtownia_data_sprzedazy.data) RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) kupil
FROM hurtownia_egzemplarz, hurtownia_data_sprzedazy, hurtownia_klient
WHERE hurtownia_egzemplarz.id_data_sprzedazy=hurtownia_data_sprzedazy.id AND hurtownia_egzemplarz.id_klient=hurtownia_klient.id
ORDER BY hurtownia_klient.id, rok)
WHERE hurtownia_klient.id=klientid
ORDER BY nazwisko, imie, numer, rok;
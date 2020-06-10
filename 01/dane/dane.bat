cd
SET nazwa=SYSTEM
SET haslo=123456
sqlldr %nazwa%/%haslo% control=1Rodzaj.txt skip=1
sqlldr %nazwa%/%haslo% control=2Instrument.txt skip=1
sqlldr %nazwa%/%haslo% control=3Adres.txt skip=1
sqlldr %nazwa%/%haslo% control=4Osoba.txt skip=1
sqlldr %nazwa%/%haslo% control=5Oddzial.txt skip=1
sqlldr %nazwa%/%haslo% control=6Producent.txt skip=1
sqlldr %nazwa%/%haslo% control=7Pracownik.txt skip=1
sqlldr %nazwa%/%haslo% control=8Klient.txt skip=1
sqlldr %nazwa%/%haslo% control=9Platnosc.txt skip=1
sqlldr %nazwa%/%haslo% control=10Zamowienie.txt skip=1
sqlldr %nazwa%/%haslo% control=11Egzemplarz.txt skip=1
del *.log
del *.bad
pause
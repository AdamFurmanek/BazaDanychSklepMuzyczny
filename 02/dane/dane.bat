cd
SET nazwa=SYSTEM
SET haslo=123456
sqlldr %nazwa%/%haslo% control=Oddzial.txt skip=1
sqlldr %nazwa%/%haslo% control=Pracownik.txt skip=1
sqlldr %nazwa%/%haslo% control=Klient.txt skip=1
sqlldr %nazwa%/%haslo% control=Data_produkcji.txt skip=1
sqlldr %nazwa%/%haslo% control=Producent.txt skip=1
sqlldr %nazwa%/%haslo% control=Data_sprzedazy.txt skip=1
sqlldr %nazwa%/%haslo% control=Egzemplarz.txt skip=1

del *.bad
pause
DROP TABLE egzemplarz;
DROP TABLE zamowienie;
DROP TABLE platnosc;
DROP TABLE klient;
DROP TABLE producent;
DROP TABLE pracownik;
DROP TABLE oddzial;
DROP TABLE osoba;
DROP TABLE adres;
DROP TABLE instrument;
DROP TABLE rodzaj;

CREATE TABLE  rodzaj(
    id NUMBER(6,0)NOT NULL,
    nazwa VARCHAR2(60)NOT NULL,
  
    CONSTRAINT rodzaj1 PRIMARY KEY (id)
);

CREATE TABLE instrument(
    id NUMBER(6,0)NOT NULL,
    nazwa VARCHAR2(60)NOT NULL,  
    id_rodzaj NUMBER(6,0)NOT NULL,
    
    CONSTRAINT instrument1 PRIMARY KEY (id),
    CONSTRAINT instrument2 FOREIGN KEY (id_rodzaj) REFERENCES rodzaj(id)
);

CREATE TABLE  adres(
    id NUMBER(6,0)NOT NULL,
    miasto VARCHAR2(20)NOT NULL, 
    numer VARCHAR2(20)NOT NULL, 
    
    CONSTRAINT adres1 PRIMARY KEY (id)
);

CREATE TABLE osoba(
    id NUMBER(6,0)NOT NULL,
    imie VARCHAR2(20)NOT NULL, 
    nazwisko VARCHAR2(20)NOT NULL, 
    id_adres NUMBER(6,0)NOT NULL,
    
    CONSTRAINT osoba1 PRIMARY KEY (id),
    CONSTRAINT osoba2 FOREIGN KEY (id_adres) REFERENCES adres(id)
);

CREATE TABLE oddzial(
    id NUMBER(6,0)NOT NULL,
    nazwa VARCHAR2(20)NOT NULL, 
    id_adres NUMBER(6,0)NOT NULL,
    
    CONSTRAINT oddzial1 PRIMARY KEY (id),
    CONSTRAINT oddzial2 FOREIGN KEY (id_adres) REFERENCES adres(id)
);

CREATE TABLE pracownik(
    id NUMBER(6,0)NOT NULL,
    wynagrodzenie NUMBER(6,0)NOT NULL,
    id_osoba NUMBER(6,0)NOT NULL,
    id_oddzial NUMBER(6,0)NOT NULL,
    
    CONSTRAINT pracownik1 PRIMARY KEY (id),
    CONSTRAINT pracownik2 FOREIGN KEY (id_osoba) REFERENCES osoba(id),
    CONSTRAINT pracownik3 FOREIGN KEY (id_oddzial) REFERENCES oddzial(id),
    CONSTRAINT pracownik4 CHECK (wynagrodzenie>0)
);

CREATE TABLE producent(
    id NUMBER(6,0)NOT NULL,
    nazwa VARCHAR2(20)NOT NULL, 
    
    id_adres NUMBER(6,0)NOT NULL,
    CONSTRAINT producent1 PRIMARY KEY (id),
    CONSTRAINT producent2 FOREIGN KEY (id_adres) REFERENCES adres(id)
);

CREATE TABLE klient(
    id NUMBER(6,0)NOT NULL,
    id_osoba NUMBER(6,0)NOT NULL,

    CONSTRAINT klient1 PRIMARY KEY (id),
    CONSTRAINT klient2 FOREIGN KEY (id_osoba) REFERENCES osoba(id)
);

CREATE TABLE platnosc(
    id NUMBER(6,0)NOT NULL,
    nazwa VARCHAR2(60)NOT NULL, 
    
    CONSTRAINT platnosc1 PRIMARY KEY (id)
);

CREATE TABLE zamowienie(
    id NUMBER(6,0)NOT NULL,
    data DATE NOT NULL,
    id_klient NUMBER(6,0)NOT NULL,
    id_platnosc NUMBER(6,0)NOT NULL,
    
    CONSTRAINT zamowienie1 PRIMARY KEY (id),
    CONSTRAINT zamowienie2 FOREIGN KEY (id_klient) REFERENCES klient(id),
    CONSTRAINT zamowienie3 FOREIGN KEY (id_platnosc) REFERENCES platnosc(id)
);

CREATE TABLE egzemplarz(
    id NUMBER(6,0)NOT NULL,
    data_produkcji DATE NOT NULL,
    cena NUMBER(6,0) NOT NULL,
    koszt NUMBER(6,0) NOT NULL,
    id_zamowienie NUMBER(6,0)NOT NULL,
    id_producent NUMBER(6,0)NOT NULL,
    id_oddzial NUMBER(6,0)NOT NULL,
    id_instrument NUMBER(6,0)NOT NULL,
    
    CONSTRAINT egzemplarz1 PRIMARY KEY (id),
    CONSTRAINT egzemplarz2 FOREIGN KEY (id_zamowienie) REFERENCES zamowienie(id),
    CONSTRAINT egzemplarz3 FOREIGN KEY (id_producent) REFERENCES producent(id),
    CONSTRAINT egzemplarz4 FOREIGN KEY (id_oddzial) REFERENCES oddzial(id),
    CONSTRAINT egzemplarz5 FOREIGN KEY (id_instrument) REFERENCES instrument(id)
);
    
DROP TABLE HURTOWNIA_EGZEMPLARZ;
DROP TABLE HURTOWNIA_ODDZIAL;
DROP TABLE HURTOWNIA_PRACOWNIK;
DROP TABLE HURTOWNIA_KLIENT;
DROP TABLE HURTOWNIA_DATA_PRODUKCJI;
DROP TABLE HURTOWNIA_PRODUCENT;
DROP TABLE HURTOWNIA_DATA_SPRZEDAZY;

CREATE TABLE hurtownia_oddzial(
    id NUMBER(6,0)NOT NULL,
    nazwa VARCHAR2(60)NOT NULL,
    numer VARCHAR2(20)NOT NULL, 
    
    CONSTRAINT hurtownia_oddzial1 PRIMARY KEY (id)
);

CREATE TABLE hurtownia_pracownik(
    id NUMBER(6,0)NOT NULL,
    imie VARCHAR2(20)NOT NULL, 
    nazwisko VARCHAR2(20)NOT NULL, 
    miasto VARCHAR2(30)NOT NULL, 
    numer VARCHAR2(20)NOT NULL,

    CONSTRAINT hurtownia_pracownik1 PRIMARY KEY (id)
);

CREATE TABLE hurtownia_klient(
    id NUMBER(6,0)NOT NULL,
    imie VARCHAR2(20)NOT NULL, 
    nazwisko VARCHAR2(20)NOT NULL,
    numer VARCHAR2(20)NOT NULL, 

    CONSTRAINT hurtownia_klient1 PRIMARY KEY (id)
);

CREATE TABLE hurtownia_data_produkcji(
    id NUMBER(6,0)NOT NULL,
    data DATE NOT NULL,
  
    CONSTRAINT hurtownia_data_produkcji1 PRIMARY KEY (id)
);

CREATE TABLE hurtownia_producent(
    id NUMBER(6,0)NOT NULL,
    nazwa VARCHAR2(60)NOT NULL,
    miasto VARCHAR2(30)NOT NULL, 
    numer VARCHAR2(20)NOT NULL, 
  
    CONSTRAINT hurtownia_producent1 PRIMARY KEY (id)
);

CREATE TABLE hurtownia_data_sprzedazy(
    id NUMBER(6,0)NOT NULL,
    data DATE NOT NULL,
        
    CONSTRAINT hurtownia_data_sprzedazy1 PRIMARY KEY (id)
);

CREATE TABLE hurtownia_egzemplarz(
    id NUMBER(6,0)NOT NULL,
    id_oddzial NUMBER(6,0)NOT NULL,
    id_pracownik NUMBER(6,0)NOT NULL,
    id_klient NUMBER(6,0)NOT NULL,
    id_data_produkcji NUMBER(6,0)NOT NULL,
    id_producent NUMBER(6,0)NOT NULL,
    id_data_sprzedazy NUMBER(6,0)NOT NULL,
    miasto_klienta VARCHAR2(30)NOT NULL, 
    miasto_sprzedazy VARCHAR2(30)NOT NULL, 
    rodzaj_instrumentu VARCHAR2(60)NOT NULL,
    platnosc VARCHAR2(60)NOT NULL,
    nazwa_instrumentu VARCHAR2(60)NOT NULL,
    numer_zamowienia NUMBER(6,0)NOT NULL,
    
    CONSTRAINT hurtownia_egzemplarz1 PRIMARY KEY (id),
    CONSTRAINT hurtownia_egzemplarz2 FOREIGN KEY (id_oddzial) REFERENCES hurtownia_oddzial(id),
    CONSTRAINT hurtownia_egzemplarz3 FOREIGN KEY (id_pracownik) REFERENCES hurtownia_pracownik(id),
    CONSTRAINT hurtownia_egzemplarz4 FOREIGN KEY (id_klient) REFERENCES hurtownia_klient(id),
    CONSTRAINT hurtownia_egzemplarz5 FOREIGN KEY (id_data_produkcji) REFERENCES hurtownia_data_produkcji(id),
    CONSTRAINT hurtownia_egzemplarz6 FOREIGN KEY (id_producent) REFERENCES hurtownia_producent(id),
    CONSTRAINT hurtownia_egzemplarz7 FOREIGN KEY (id_data_sprzedazy) REFERENCES hurtownia_data_sprzedazy(id)
);

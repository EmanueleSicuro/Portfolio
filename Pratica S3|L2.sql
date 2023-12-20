CREATE TABLE AEROPORTO (
    Citta VARCHAR(50),
    Nazione VARCHAR(50),
    NumPiste INT);

CREATE TABLE VOLO (
    IdVolo VARCHAR(10),
    GiornoSett VARCHAR(20),
    CittaPart VARCHAR(50),
    OraPart TIME,
    CittaArr VARCHAR(50),
    OraArr TIME,
    TipoAereo VARCHAR(50));

CREATE TABLE AEREO (
    TipoAereo VARCHAR(50),
    NumPasseggeri INT,
    QtaMerci INT);

INSERT INTO AEROPORTO (Citta, Nazione, NumPiste)
VALUES
    ('Roma', 'Italia', 3),
    ('Bordeaux', 'Francia', 4),
    ('Torino', 'Italia', NULL),
    ('Berlino', 'Germania', 2),
    ('Madrid', 'Spagna', 3),
    ('New York', 'Stati Uniti', NULL),
    ('Tokyo', 'Giappone', 5),
    ('Tirana', 'Albania', 4),
    ('Bologna', 'Italia', 3),
    ('La Valletta', 'Malta', NULL);

INSERT INTO VOLO (IdVolo, GiornoSett, CittaPart, OraPart, CittaArr, OraArr, TipoAereo)
VALUES
    ('ABC123', 'Lunedì', 'Roma', '08:00', 'Bordeaux', '10:00', 'Airbus A320'),
    ('DEF456', 'Martedì', 'Torino', '09:30', 'Madrid', '12:00', 'Boeing 737'),
    ('AZ274', 'Mercoledì', 'New York', '11:45', 'Tokyo', '16:30', 'Boeing 777'),
    ('JKL012', 'Giovedì', 'Tirana', '14:20', 'Bologna', '18:00', 'Airbus A350'),
    ('MNO345', 'Venerdì', 'La Valletta', '16:00', 'Torino', '08:30', 'Boeing 747'),
    ('PQR678', 'Sabato', 'Roma', '20:00', 'Berlino', '22:30', 'Airbus A330'),
    ('STU901', 'Domenica', 'Madrid', '13:15', 'Bordeaux', '15:30', 'Boeing 787'),
    ('VWX234', 'Lunedì', 'Berlino', '07:45', 'Roma', '10:15', 'Airbus A320'),
    ('YZA567', 'Martedì', 'Tokyo', '10:30', 'La Valletta', '14:45', 'Boeing 888'),
    ('BCD890', 'Mercoledì', 'Bologna', '18:45', 'Tirana', '23:30', 'Airbus A450');

INSERT INTO AEREO (TipoAereo, NumPasseggeri, QtaMerci)
VALUES
    ('Airbus A320', 180, 2000),
    ('Boeing 737', 150, 1800),
    ('Boeing 777', 300, 2500),
    ('Airbus A350', 250, 2200),
    ('Boeing 747', 400, 3000),
    ('Airbus A330', 220, 2100),
    ('Boeing 787', 270, 2300),
    ('Boeing 888', 400, 3500),
    ('Airbus A450', 200, 1900);

-- 1 Città con un aeroporto di cui non è noto il numero di piste
SELECT Citta
FROM AEROPORTO
WHERE NumPiste IS NULL;

-- 2 Tipi di aereo usati nei voli che partono da Torino
SELECT DISTINCT AEREO.TipoAereo
FROM AEREO
INNER JOIN VOLO ON AEREO.TipoAereo = VOLO.TipoAereo
WHERE VOLO.CittaPart = 'Torino';

-- 3 Città da cui partono voli diretti a Bologna
SELECT DISTINCT CittaPart
FROM VOLO
WHERE CittaArr = 'Bologna';

-- 4 Città da cui parte e arriva il volo con codice AZ274
SELECT CittaPart, CittaArr
FROM VOLO
WHERE IdVolo = 'AZ274';

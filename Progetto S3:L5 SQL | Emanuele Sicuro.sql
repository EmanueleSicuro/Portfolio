CREATE TABLE vendite (
    id_transazione INT PRIMARY KEY,
    categoria_prodotto VARCHAR(50),
    costo DECIMAL(10, 2),
    sconto DECIMAL(5, 2)
);

CREATE TABLE dettagli_vendite (
    id_transazione INT,
    data_transazione DATE,
    quantita INT,
    FOREIGN KEY (id_transazione) REFERENCES vendite(id_transazione)
);


INSERT INTO vendite (id_transazione, categoria_prodotto, costo, sconto)
VALUES
    (1, 'Elettronica', 499.99, 0.60),
    (2, 'Abbigliamento', 120.00, 0.25),
    (3, 'Casa', 300.00, 0.15),
    (4, 'Bevande', 800.00, 0.20),
    (5, 'Giardinaggio', 154.90, 0.55),
    (6, 'Abbigliamento', 74.99, 0.10),
    (7, 'Casa', 250.00, 0.05),
    (8, 'Elettronica', 600.00, 0.25),
    (9, 'Giardinaggio', 200.00, 0.20),
    (10, 'Abbigliamento', 100.00, 0.10),
    (11, 'Casa', 280.00, 0.18),
    (12, 'Elettronica', 700.00, 0.30),
    (13, 'Giardinaggio', 180.00, 0.15),
    (14, 'Bevande', 69.99, 0.05),
    (15, 'Bevande', 20.00, 0.22),
    (16, 'Elettronica', 550.00, 0.12),
    (17, 'Giardinaggio', 199.99, 0.08),
    (18, 'Abbigliamento', 110.00, 0.14),
    (19, 'Casa', 270.00, 0.10),
    (20, 'Elettronica', 750.00, 0.27),
    (21, 'Giardinaggio', 190.00, 0.06),
    (22, 'Abbigliamento', 95.00, 0.08),
    (23, 'Casa', 290.00, 0.12),
    (24, 'Elettronica', 680.00, 0.25),
    (25, 'Bevande', 40.00, 0.20),
    (26, 'Abbigliamento', 105.00, 0.15),
    (27, 'Casa', 310.00, 0.18),
    (28, 'Elettronica', 720.00, 0.30),
    (29, 'Giardinaggio', 170.00, 0.10),
    (30, 'Abbigliamento', 85.00, 0.20),
    (31, 'Casa', 260.00, 0.25),
    (32, 'Elettronica', 580.00, 0.30),
    (33, 'Giardinaggio', 230.00, 0.35),
    (34, 'Abbigliamento', 115.00, 0.40),
    (35, 'Casa', 330.00, 0.60);

INSERT INTO dettagli_vendite (id_transazione, data_transazione, quantita)
VALUES
    (1, '2023-01-02', 3),
    (2, '2023-03-10', 2),
    (3, '2023-04-29', 1),
    (4, '2023-01-05', 3),
    (5, '2023-09-26', 2),
    (6, '2023-01-07', 1),
    (7, '2023-02-18', 2),
    (8, '2023-07-01', 5),
    (9, '2023-05-11', 3),
    (10, '2023-10-06', 2),
    (11, '2023-01-12', 1),
    (12, '2023-03-10', 2),
    (13, '2023-05-04', 1),
    (14, '2023-09-15', 3),
    (15, '2023-10-06', 2),
    (16, '2023-01-02', 1),
    (17, '2023-09-18', 2),
    (18, '2023-02-09', 4),
    (19, '2023-08-20', 3),
    (20, '2023-07-07', 2),
    (21, '2023-01-31', 2),
    (22, '2023-02-28', 2),
    (23, '2023-01-04', 1),
    (24, '2023-01-25', 6),
    (25, '2023-12-05', 2),
    (26, '2023-07-17', 1),
    (27, '2023-04-28', 2),
    (28, '2023-01-29', 1),
    (29, '2023-10-10', 3),
    (30, '2023-08-31', 5),
    (31, '2023-02-01', 1),
    (32, '2023-02-02', 2),
    (33, '2023-06-23', 1),
    (34, '2023-11-14', 4),
    (35, '2023-12-05', 2);

-- QUERY 1 Selezionare tutte le vendite avvenute in una specifica data

SELECT v.*, dv.data_transazione, dv.quantita
FROM vendite v
JOIN dettagli_vendite dv ON v.id_transazione = dv.id_transazione
WHERE dv.data_transazione = '2023-12-05';

-- QUERY 2 Elenco delle vendite con sconti maggiori del 50%

SELECT *
FROM vendite
WHERE sconto > 0.50;

-- Calcolo del totale delle vendite (costo) per categoria

SELECT categoria_prodotto, SUM(costo) AS totale_vendite
FROM vendite
GROUP BY categoria_prodotto
ORDER BY totale_vendite DESC;

-- Trova il numero totale di prodotti venduti per ogni categoria
    
SELECT categoria_prodotto, SUM(quantita) AS totale_prodotti_venduti
FROM dettagli_vendite dv
JOIN vendite v ON dv.id_transazione = v.id_transazione
GROUP BY categoria_prodotto
ORDER BY totale_prodotti_venduti DESC;

-- Selezionare le vendite dell'ultimo trimestre

SELECT v.*, dv.data_transazione, dv.quantita
FROM vendite v
JOIN dettagli_vendite dv ON v.id_transazione = dv.id_transazione
WHERE dv.data_transazione >= DATE_SUB(DATE_FORMAT(NOW(), '%Y-%m-01'), INTERVAL 2 MONTH)
  AND dv.data_transazione <= LAST_DAY(NOW());

-- Raggruppare le vendite per mese e calcolare il totale delle vendite per ogni mese

SELECT YEAR(data_transazione) AS anno, MONTH(data_transazione) AS mese, SUM(costo) AS totale_vendite
FROM vendite v
JOIN dettagli_vendite dv ON v.id_transazione = dv.id_transazione
GROUP BY anno, mese
ORDER BY anno, mese;

--  Analisi degli Sconti
SELECT categoria_prodotto, AVG(sconto) AS sconto_medio
FROM vendite
GROUP BY categoria_prodotto
ORDER BY sconto_medio DESC
LIMIT 1;

-- Variazioni delle Vendite
-- Il primo mese esce null perchè la tabella parte da gennaio 2023

WITH vendite_per_mese AS (
    SELECT YEAR(data_transazione) AS anno,
           MONTH(data_transazione) AS mese,
           SUM(costo) AS totale_vendite
    FROM vendite v
    JOIN dettagli_vendite dv ON v.id_transazione = dv.id_transazione
    GROUP BY anno, mese
    ORDER BY anno, mese
)
SELECT anno,
       mese,
       totale_vendite,
       LAG(totale_vendite) OVER (ORDER BY anno, mese) AS vendite_mese_precedente,
       CASE
           WHEN LAG(totale_vendite) OVER (ORDER BY anno, mese) IS NULL THEN NULL
           ELSE totale_vendite - LAG(totale_vendite) OVER (ORDER BY anno, mese)
       END AS variazione
FROM vendite_per_mese;

-- Analisi Stagionale
SELECT
    CASE
        WHEN MONTH(data_transazione) BETWEEN 3 AND 5 THEN 'Primavera'
        WHEN MONTH(data_transazione) BETWEEN 6 AND 8 THEN 'Estate'
        WHEN MONTH(data_transazione) BETWEEN 9 AND 11 THEN 'Autunno'
        ELSE 'Inverno'
    END AS stagione,
    SUM(costo) AS vendite_totali
FROM vendite v
JOIN dettagli_vendite dv ON v.id_transazione = dv.id_transazione
GROUP BY stagione
ORDER BY vendite_totali DESC;

--  Clienti Fedeli, campi di esempio

/* SELECT IDCliente, COUNT(IDVendita) AS NumeroAcquisti
FROM clienti
GROUP BY IDCliente
ORDER BY NumeroAcquisti DESC
LIMIT 5;/*







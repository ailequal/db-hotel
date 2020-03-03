-- Seleziona tutti gli ospiti che sono stati identificati con la carta di identità
SELECT `*`
FROM `ospiti`
WHERE `document_type` = 'CI';

-- Seleziona tutti gli ospiti che sono nati dopo il 1988
SELECT `*`
FROM `ospiti`
WHERE `date_of_birth` > '1988-01-01';

-- Seleziona tutti gli ospiti che hanno più di 20 anni (al momento dell’esecuzione della query)
SELECT `*`
FROM `ospiti`
WHERE `date_of_birth` < '2000-01-01';

-- Seleziona tutti gli ospiti il cui nome inizia con la D
SELECT `*`
FROM `ospiti`
WHERE `name` LIKE 'D%';

-- Calcola il totale degli ordini accepted
SELECT COUNT(id)
FROM `pagamenti`
WHERE `status` = 'accepted';

-- Qual è il prezzo massimo pagato?
SELECT `*`
FROM `pagamenti`
WHERE `status` = 'accepted'
ORDER BY `price` DESC LIMIT 1;

-- Seleziona gli ospiti riconosciuti con patente e nati nel 1975
SELECT `*`
FROM `ospiti`
WHERE `document_type` = 'Driver License'
AND `date_of_birth` LIKE '1975-__-__ %';

-- Quanti paganti sono anche ospiti?
SELECT COUNT(id)
FROM `paganti`
WHERE `ospite_id` IS NOT NULL
OR `ospite_id` <> '';

-- Quanti posti letto ha l’hotel in totale?
SELECT SUM(beds)
FROM `stanze`;

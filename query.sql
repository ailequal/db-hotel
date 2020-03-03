-- Queres - Parte 01
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


-- Group by - Parte 02
-- Conta gli ospiti raggruppandoli per anno di nascita
SELECT EXTRACT(YEAR FROM `date_of_birth`) `year`, COUNT(`id`) `total`
FROM `ospiti`
GROUP BY EXTRACT(YEAR FROM `date_of_birth`);

-- Somma i prezzi dei pagamenti raggruppandoli per status
SELECT `status`, SUM(price) `total`
FROM `pagamenti`
GROUP BY `status`;

-- Conta quante volte è stata prenotata ogni stanza
SELECT `stanza_id` `room`, COUNT(`id`) `total_reservation`
FROM `prenotazioni`
GROUP BY `stanza_id`;

-- Fai una analisi per vedere se ci sono ore in cui le prenotazioni sono più frequenti
SELECT EXTRACT(HOUR FROM `created_at`) `hours`, COUNT(`id`) `total`
FROM `prenotazioni`
GROUP BY EXTRACT(HOUR FROM `created_at`)
ORDER BY `total` DESC;

-- Quante prenotazioni ha fatto l’ospite che ha fatto più prenotazioni?
SELECT `ospite_id`, COUNT(`prenotazione_id`) `total`
FROM `prenotazioni_has_ospiti`
GROUP BY `ospite_id`;


-- Join - Parte 03
-- Come si chiamano gli ospiti che hanno fatto più di due prenotazioni?
SELECT `name`, COUNT(`ospite_id`) `total_reservation`
FROM `ospiti`
INNER JOIN `prenotazioni_has_ospiti`
ON `ospiti`.id = `prenotazioni_has_ospiti`.ospite_id
GROUP BY `name`
HAVING COUNT(`ospite_id`) > 2;

-- Stampare tutti gli ospiti per ogni prenotazione
SELECT `name`, `prenotazione_id`
FROM `ospiti`
INNER JOIN `prenotazioni_has_ospiti`
ON `ospiti`.id = `prenotazioni_has_ospiti`.ospite_id
ORDER BY `name`;

-- Stampare Nome, Cognome, Prezzo e Pagante per tutte le prenotazioni fatte a Maggio 2018
SELECT `name`, `lastname`, `price`, `pagamenti`.created_at
FROM `paganti`
INNER JOIN `pagamenti`
ON `paganti`.id = `pagamenti`.pagante_id
WHERE `pagamenti`.created_at LIKE '2018-05-%'
ORDER BY `name`;

-- Fai la somma di tutti i prezzi delle prenotazioni per le stanze del primo piano
SELECT SUM(`price`) `total price first floor`
FROM `prenotazioni`
INNER JOIN `pagamenti`
ON `prenotazioni`.id = `pagamenti`.prenotazione_id
WHERE `stanza_id` = 1
OR `stanza_id` = 2
OR `stanza_id` = 3
OR `stanza_id` = 4
OR `stanza_id` = 5
OR `stanza_id` = 6;

-- Prendi i dati di fatturazione per la prenotazione con id=7
SELECT `paganti`.name, `paganti`.lastname, `paganti`.address
FROM `prenotazioni`
INNER JOIN pagamenti
ON `pagamenti`.prenotazione_id = `prenotazioni`.id
INNER JOIN `paganti`
ON `pagamenti`.pagante_id = `paganti`.id
WHERE `prenotazioni`.id = 7

-- Le stanze sono state tutte prenotate almeno una volta? (Visualizzare le stanze non ancora prenotate)
SELECT *
FROM `stanze`
LEFT JOIN prenotazioni
ON `prenotazioni`.stanza_id = `stanze`.id
WHERE `prenotazioni`.stanza_id IS NULL

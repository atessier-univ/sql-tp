-- Toutes les lignes de la tables etudiants
SELECT *
FROM etudiants;

-- Toutes les lignes de la table materiels
SELECT *
FROM materiels;

-- Toutes les lignes de la table reservations dont les reservations ont commencé avant le 2025-05-01
SELECT *
FROM reservations
WHERE date_debut >= '2025-05-01';
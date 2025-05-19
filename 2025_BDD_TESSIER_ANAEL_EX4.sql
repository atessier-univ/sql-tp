-- Requête d’aggrégation pour calculer le nombre total de réservations effectuées sur une période donnée
SELECT COUNT(*)
FROM reservations
WHERE 
    date_debut BETWEEN '2025-05-01' AND '2025-05-20';

-- Requête d’aggrégation pour calculer le nombre d’utilisateur ayant emprunté du matériel
SELECT COUNT(DISTINCT etudiant_id)
FROM reservations
WHERE 
    date_debut <= CURRENT_DATE
    AND date_fin >= CURRENT_DATE;
-- Requête de modification de la quantité disponible d’un matériel
UPDATE materiels
SET quantite = quantite+1
WHERE materiel_id = 2;

-- Requête de modification de la quantité de tous les matériels qui sont en cours d'emprunt et la date de retour prévue dans plus de 2 jours
UPDATE materiels
SET quantite = quantite+1
WHERE materiel_id IN 
(
    SELECT materiel_id 
    FROM reservations
    WHERE date_debut <= CURRENT_DATE 
    AND date_fin >= CURRENT_DATE + 2
);
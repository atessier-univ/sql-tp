-- Requête de suppression d’une réservation existante
DELETE FROM reservations
WHERE reservation_id = 2;

-- Requête de suppression d'une réservation ou la date de retour prévue est passée.
DELETE FROM reservations
WHERE reservation_id IN (SELECT reservation_id 
                        FROM reservations
                        WHERE date_fin < CURRENT_DATE
                        LIMIT 1);

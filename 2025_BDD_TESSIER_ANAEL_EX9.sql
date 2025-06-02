-- 1. Mettez à jour le modèle de données existant en ajoutant une nouvelle table "RetourMatériel" 
-- avec les colonnes suivantes : 
--      id_retour (clé primaire) 
--      id_reservation (clé étrangère référençant la table "Reservation") 
--      date_retour (date à laquelle le matériel a été rendu) 
--      retard (indicateur de retard, par exemple, un booléen)
CREATE TABLE IF NOT EXISTS retourmateriels (
    retour_id SERIAL,
    reservation_id INT NOT NULL,
    date_retours DATE NOT NULL DEFAULT CURRENT_DATE,
    retard BOOLEAN NOT NULL,
    PRIMARY KEY(retour_id),
    FOREIGN KEY(reservation_id) REFERENCES reservations(reservation_id)
);

-- 2. Modifiez la table "Reservation" en ajoutant une nouvelle colonne "date_retour_effectif" pour enregistrer la date à laquelle le matériel a été rendu
ALTER TABLE IF EXISTS reservations
    ADD date_retour_effectif DATE;

-- 3. Modifiez les contraintes SQL existantes pour prendre en compte les retours de matériel et les retards éventuels lors de la mise à jour des réservations.
ALTER TABLE IF EXISTS reservations
    ADD CHECK (date_retour_effectif >= date_debut);

-- 4. Implémentez une fonctionnalité permettant de calculer automatiquement le retard sur le retour du matériel, si applicable.
UPDATE retourmateriels as rm
SET retard =
    (SELECT
        CASE WHEN (r.date_fin - r.date_retour_effectif < 0) THEN True
        ELSE False
        END as retard
    FROM reservations as r
    WHERE rm.reservation_id = r.reservation_id)
;

-- 5. Implémentez une fonctionnalité permettant de vérifier si un retour est en retard 
-- et d'afficher le montant des pénalités, le cas échéant. 
-- Testez votre application en effectuant des retours de matériel, 
-- certains à l'heure et d'autres en retard, pour vérifier que les contraintes 
-- sont correctement appliquées et que les pénalités sont calculées de manière appropriée.
SELECT 
    reservation_id,
    r.date_fin - r.date_retour_effectif as temp_retard
FROM reservations as r
JOIN retourmateriels as rm ON rm.reservation_id = r.reservation_id
WHERE rm.retard = True;

-- Afficher tous les utilisateurs ayant emprunté au moins un équipement
SELECT DISTINCT e.etudiant_id, e.nom, e.prenom
FROM etudiants as e
JOIN reservations as r ON r.etudiant_id = e.etudiant_id;

-- Afficher les équipements n’ayant jamais été empruntés
SELECT DISTINCT m.materiel_id, m.nom, m.quantite
FROM materiels as m
LEFT JOIN reservations as r ON r.materiel_id = m.materiel_id
WHERE reservation_id IS NULL;

-- Afficher les équipements ayant été emprunté plus de 3 fois
    -- Insertion de 3 reservations pour 1 materiel
INSERT INTO reservations (date_debut, date_fin, etudiant_id, materiel_id) VALUES
   ('2025-04-10', '2025-04-20', 1, 3),
   ('2025-04-10', '2025-04-20', 1, 3),
   ('2025-04-10', '2025-04-20', 1, 3);
    -- Querry
SELECT m.materiel_id, m.nom, m.quantite
From reservations as r
JOIN materiels as m ON m.materiel_id = r.materiel_id
GROUP BY m.materiel_id
HAVING COUNT(*) > 3;

-- Afficher le nombre d’emprunts pour chaque utilisateur, ordonné par numéro d'étudiant. Les utilisateurs n'ayant pas de réservations en cours doivent également être affichés avec la valeur 0 dans le nombre d'emprunts.
SELECT e.etudiant_id,
	e.nom,
	e.prenom,
	CASE 
        WHEN COUNT(r.reservation_id) IS NULL THEN 0
        ELSE  COUNT(r.reservation_id)
	END
    as nbr_reservation
FROM etudiants as e
LEFT JOIN reservations as r ON e.etudiant_id = r.etudiant_id
GROUP BY e.etudiant_id;
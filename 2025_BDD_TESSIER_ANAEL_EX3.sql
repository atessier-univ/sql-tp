-- requête de jointure sur les utilisateurs ayant effectué une réservation
SELECT e.nom, e.prenom, r.date_debut, r.date_fin, r.materiel_id
FROM reservations as r
JOIN etudiants as e ON e.etudiant_id = r.etudiant_id;

-- requête de jointure pour récupérer les informations sur le matériel emprunté par un utilisateur donné
SELECT e.nom, e.prenom, m.nom, m.quantite, r.date_debut, r.date_fin, r.materiel_id
FROM reservations as r
JOIN materiels as m ON m.materiel_id = r.materiel_id
JOIN etudiants as e ON e.etudiant_id = r.etudiant_id
WHERE e.nom = 'OISEAU';
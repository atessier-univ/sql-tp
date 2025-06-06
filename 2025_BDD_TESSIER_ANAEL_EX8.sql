-- Mettez à jour le modèle de données existant en ajoutant une nouvelle table "disponibilite"
DROP TABLE IF EXISTS disponibilites;
CREATE TABLE IF NOT EXISTS disponibilites(
    disponibilite_id SERIAL,
    date_debut DATE NOT NULL DEFAULT CURRENT_DATE,
    date_fin DATE NOT NULL CHECK (date_debut <= date_fin),
    materiel_id INT NOT NULL,
    PRIMARY KEY(disponibilite_id),
    FOREIGN KEY(materiel_id) REFERENCES materiels(materiel_id)
);

-- Modifiez la table "reservation" en ajoutant une nouvelle colonne "id_disponibilite"
ALTER TABLE IF EXISTS reservations
ADD IF NOT EXISTS disponibilite_id INT NOT NULL,    -- Permet de contraindre la création de réservation dans des périodes possible mais problème si déjà des data dans la table
ADD FOREIGN KEY(disponibilite_id) REFERENCES disponibilites(disponibilite_id);

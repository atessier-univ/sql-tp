CREATE TABLE Personnes(
   etudiant_id INT,
   nom VARCHAR(100) NOT NULL,
   prenom VARCHAR(100) NOT NULL,
   numero_etudiant INT NOT NULL,
   PRIMARY KEY(etudiant_id),
   UNIQUE(numero_etudiant)
);

CREATE TABLE materiels(
   materiel_id INT,
   nom VARCHAR(100) NOT NULL,
   PRIMARY KEY(materiel_id)
);

CREATE TABLE reservations(
   reservation_id INT,
   date_debut DATE,
   date_fin DATE,
   etudiant_id INT,
   materiel_id INT,
   PRIMARY KEY(reservation_id),
   FOREIGN KEY(etudiant_id) REFERENCES Personnes(etudiant_id),
   FOREIGN KEY(materiel_id) REFERENCES materiels(materiel_id)
);

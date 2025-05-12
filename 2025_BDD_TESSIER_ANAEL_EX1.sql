-- Table personnes
-- clef primaire pour chaque etudiant, en serial pour AUTOINCREMENT
-- nom et prenom en VARCHAR(100) car taille variable, non null car toute personnes à un nom
-- N° étudiant, propre à chaque étudiant, non null car chaque étudiant en a un
CREATE TABLE etudiants(
   etudiant_id SERIAL,
   nom VARCHAR(100) NOT NULL,
   prenom VARCHAR(100) NOT NULL,
   numero_etudiant INT NOT NULL UNIQUE,
   PRIMARY KEY(etudiant_id)
);

CREATE TABLE materiels(
   materiel_id SERIAL,
   nom VARCHAR(100) NOT NULL UNIQUE,
   PRIMARY KEY(materiel_id)
);

CREATE TABLE reservations(
   reservation_id SERIAL,
   date_debut DATE,
   date_fin DATE,
   etudiant_id INT,
   materiel_id INT,
   PRIMARY KEY(reservation_id),
   FOREIGN KEY(etudiant_id) REFERENCES Personnes(etudiant_id),
   FOREIGN KEY(materiel_id) REFERENCES materiels(materiel_id)
);

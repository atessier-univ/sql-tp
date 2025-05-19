-- Table personnes
-- clef primaire pour chaque etudiant, en serial pour AUTOINCREMENT
-- 'nom' et 'prenom' en VARCHAR(100) car taille variable, non null car toute personnes à un nom
-- N° étudiant, propre à chaque étudiant, non null car chaque étudiant en a un
CREATE TABLE etudiants(
   etudiant_id SERIAL,
   nom VARCHAR(100) NOT NULL,
   prenom VARCHAR(100) NOT NULL,
   numero_etudiant INT NOT NULL UNIQUE,
   PRIMARY KEY(etudiant_id)
);


-- Table du materiel
-- Clef primaire pour chaque materiel, en serial pour AUTOINCREMENT
-- 'nom' en VARCHAR(100) car taille variable
CREATE TABLE materiels(
   materiel_id SERIAL,
   nom VARCHAR(100) NOT NULL UNIQUE,
   PRIMARY KEY(materiel_id)
);


-- Table des reservation
-- Clef primaire reservation_id en serial pour AUTOINCREMENT
-- FK ne peuvent pas être vide : quand on reserve, il y a obligatoirement une personne qui reserve un materiel
-- Date de début ne peut être nulle, par défaut elle prend la date actuelle
-- Date de fin est une date prévue et donc ne peut être nule
CREATE TABLE reservations(
   reservation_id SERIAL,
   date_debut DATE NOT NULL DEFAULT CURRENT_DATE,
   date_fin DATE NOT NULL,
   etudiant_id INT NOT NULL,
   materiel_id INT NOT NULL,
   PRIMARY KEY(reservation_id),
   FOREIGN KEY(etudiant_id) REFERENCES etudiants(etudiant_id),
   FOREIGN KEY(materiel_id) REFERENCES materiels(materiel_id)
); 

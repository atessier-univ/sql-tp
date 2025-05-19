DROP TABLE IF EXISTS etudiants CASCADE;
DROP TABLE IF EXISTS materiels CASCADE;
DROP TABLE IF EXISTS reservations CASCADE;

-- Table personnes
-- clef primaire pour chaque etudiant, en serial pour AUTOINCREMENT
-- 'nom' et 'prenom' en VARCHAR(100) car taille variable, non null car toute personnes à un nom
-- N° étudiant, propre à chaque étudiant, non null car chaque étudiant en a un, INT suffit car 8 Digit
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
-- quantite de materiel, existant ne peut être nulle, de base, il y en a 1, verifie que le chiffre n'est pas négatif
CREATE TABLE materiels(
   materiel_id SERIAL,
   nom VARCHAR(100) NOT NULL UNIQUE,
   quantite INT NOT NULL DEFAULT 1 CHECK (quantite >= 0),
   PRIMARY KEY(materiel_id)
);


-- Table des reservation
-- Clef primaire reservation_id en serial pour AUTOINCREMENT
-- FK ne peuvent pas être vide : quand on reserve, il y a obligatoirement une personne qui reserve un materiel
-- Date de début ne peut être nulle, par défaut elle prend la date actuelle
-- Date de fin est une date prévue et donc ne peut être nule
-- Date de fin ne peut être avant la date de début
CREATE TABLE reservations(
   reservation_id SERIAL,
   date_debut DATE NOT NULL DEFAULT CURRENT_DATE,
   date_fin DATE NOT NULL CHECK (date_debut <= date_fin),
   etudiant_id INT NOT NULL,
   materiel_id INT NOT NULL,
   PRIMARY KEY(reservation_id),
   FOREIGN KEY(etudiant_id) REFERENCES etudiants(etudiant_id),
   FOREIGN KEY(materiel_id) REFERENCES materiels(materiel_id)
); 

-- AJOUT de 10 lignes dans materiels 
INSERT INTO materiels (nom, quantite) VALUES
   ('PC', 15),
   ('Fer à souder', 10),
   ('Multimetre', 3),
   ('Osciloscope', 12),
   ('BreadBoard', 26),
   ('Alimentation de laboratoire', 11),
   ('Analyseur de spectre', 1),
   ('Carte de test PIC24', 8),
   ('FPGA', 6),
   ('Boîte à outils', 7);

-- AJOUT de 10 lignes dans etudiants 
INSERT INTO etudiants (prenom, nom, numero_etudiant) VALUES
   ('Jean', 'DUPONT', 22001111),
   ('Paul', 'RIVIERE', 22001112),
   ('Phillipe', 'ETANG', 22001113),
   ('Alexis', 'OISEAU', 22001114),
   ('Marianne', 'MARTIN', 22001115),
   ('Sarah', 'CROCHE', 22001116),
   ('Lucie', 'CHATEAU', 22001117),
   ('Ambre', 'CAILLOUX', 22001118),
   ('Elisabeth', 'McBETH', 22001119),
   ('Jean', 'BON', 22001120);

-- AJOUT de 5 lignes dans reservations 
INSERT INTO reservations (date_debut, date_fin, etudiant_id, materiel_id) VALUES
   ('2025-04-10', '2025-04-20', 1, 3),
   ('2025-04-15', '2025-04-18', 6, 2),
   ('2025-05-18', '2025-05-25', 7, 9),
   ('2025-04-12', '2025-04-23', 4, 10),
   ('2025-05-01', '2025-05-12', 9, 8);

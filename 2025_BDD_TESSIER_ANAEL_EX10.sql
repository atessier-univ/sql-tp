alter table reservations drop constraint reservations_etudiant_id_fkey;
alter table reservations drop constraint reservations_materiel_id_fkey;

TRUNCATE TABLE reservations RESTART IDENTITY CASCADE;
TRUNCATE TABLE disponibilites RESTART IDENTITY CASCADE;
TRUNCATE TABLE materiels RESTART IDENTITY CASCADE;
TRUNCATE TABLE etudiants RESTART IDENTITY CASCADE;


-- Insert 1,000,000 rows into etudiants
DO $$
DECLARE
    i INT;
BEGIN
    FOR i IN 1..100000 LOOP
        INSERT INTO etudiants (numero_etudiant, nom, prenom)
        VALUES (
            i,
            'nom_' || i,
            'prenom_' || i
        );
    END LOOP;
END $$;

-- Insert 1,000,000 rows into materiels
DO $$
DECLARE
    i INT;
BEGIN
    FOR i IN 1..100000 LOOP
        INSERT INTO materiels (materiel_id, nom, quantite)
        VALUES (
            i,
            'materiel_' || i,
            (random() * 20)::INT + 1 -- Random quantity between 1 and 20 for the available quantity
        );
    END LOOP;
END $$;

-- Insert 2,000,000 rows into disponibilites
DO $$
DECLARE
    i INT;
    start_date DATE;
    end_date DATE;
BEGIN
    FOR i IN 1..200000 LOOP
        -- Generate random start and end dates
        start_date := DATE '2025-01-01' + (random() * 365)::INT;
        end_date := start_date + (random() * 30)::INT;

        INSERT INTO disponibilites ( materiel_id, date_debut, date_fin)
        VALUES (
            (random() * 199999)::INT + 1, -- Random id_materiel between 1 and 1,000,000
            start_date,
            end_date
        );
    END LOOP;
END $$;

-- Insert 2,000,000 rows into reservations
DO $$
DECLARE
    i INT;
    reservation_date DATE;
    return_date DATE;
	effective_return_date DATE;
BEGIN
    FOR i IN 1..200000 LOOP
        -- Generate random reservations and return dates
        reservation_date := DATE '2025-01-01' + (random() * 365)::INT;
        return_date := reservation_date + (random() * 15)::INT;
		effective_return_date := reservation_date + (random() * 15)::INT;

        INSERT INTO reservations (date_debut, date_fin, etudiant_id, materiel_id)
        VALUES (
            reservation_date,
            return_date,
            (random() * 999999)::INT + 1, -- Random numero_etudiant between 1 and 1,000,000
            (random() * 999999)::INT + 1  -- Random identifiant_materiel between 1 and 1,000,000
        );
    END LOOP;
END $$;

-- 5. Exécutez une recherche impliquant des jointures entre les tables:
SELECT *
FROM reservations as r
JOIN etudiants as e ON e.etudiant_id = r.etudiant_id
JOIN materiels as m ON m.materiel_id = r.materiel_id
JOIN disponibilites as d ON  d.materiel_id = r.materiel_id;

-- Affichez le plan d' exécution de la requête à l'aide de l'instruction EXPLAIN ANALYZE
SELECT *
FROM reservations as r
JOIN etudiants as e ON e.etudiant_id = r.etudiant_id
JOIN materiels as m ON m.materiel_id = r.materiel_id
JOIN disponibilites as d ON  d.materiel_id = r.materiel_id
WHERE e.nom = 'nom_1';

-- Présence de Seq Scan ce qui ralentit la requète, temps = 0.141

-- 7. Créer des index pour le champ en question ainsi que les clés étrangères impliquées
CREATE INDEX IF NOT EXISTS dispo_materiel_id_idx ON disponibilites (materiel_id);   --> voir GraphicalExecutionPlan1.png
CREATE INDEX IF NOT EXISTS etudiant_nom_idx ON etudiants (nom);                     --> voir GraphicalExecutionPlan2.png

-- 9. Création des index pour l'opérateur like
SELECT *
FROM reservations as r
JOIN etudiants as e ON e.etudiant_id = r.etudiant_id
JOIN materiels as m ON m.materiel_id = r.materiel_id
JOIN disponibilites as d ON  d.materiel_id = r.materiel_id
WHERE e.nom LIKE '%nom_1%';

--> voir GraphicalExecutionPlan3.png

CREATE INDEX IF NOT EXISTS etudiant_pk_idx ON etudiants (etudiant_id); 
CREATE INDEX IF NOT EXISTS reservation_pk_idx ON reservations (reservation_id);
CREATE INDEX IF NOT EXISTS reservation_etudiant_id_idx ON reservations (etudiant_id); 

-->  voir GraphicalExecutionPlan4.png

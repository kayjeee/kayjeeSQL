SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = TRUE;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;
-- Update the species column to 'unspecified'
BEGIN;
UPDATE animals
SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Update species column based on name
BEGIN;
-- Set species to 'digimon' for animals whose name ends with 'mon'
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

-- Set species to 'pokemon' for animals that don't have a species already set
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL OR species = '';

SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

-- Delete all records in the animals table (rollback will undo the deletion)
BEGIN;
DELETE FROM animals;
ROLLBACK;

-- Delete animals born after Jan 1st, 2022, update their weights and rollback to the savepoint
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT first_save;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT first_save;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

-- RESPOND TO QUESTIONS

-- How many animals are there?
SELECT COUNT(*) AS total_animals FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) AS never_escaped FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) AS average_weight FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, SUM(escape_attempts) AS total_escape_attempts
FROM animals
GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT neutered, MIN(weight_kg), MAX(weight_kg)
FROM animals
GROUP BY neutered;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) AS average_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

-- Query 1: Who was the last animal seen by William Tatcher?
SELECT a.name AS last_animal_seen
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets vt ON v.vet_id = vt.id
WHERE vt.name = 'William Tatcher'
ORDER BY v.visit_date DESC
LIMIT 1;

-- Query 2: How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT v.animal_id) AS animals_seen_count
FROM visits v
JOIN vets vt ON v.vet_id = vt.id
WHERE vt.name = 'Stephanie Mendez';

-- Query 3: List all vets and their specialties, including vets with no specialties.
SELECT vt.name AS vet_name, COALESCE(s.name, 'No specialty') AS specialty
FROM vets vt
LEFT JOIN specializations sp ON vt.id = sp.vet_id
LEFT JOIN species s ON sp.species_id = s.id
ORDER BY vt.name;

-- Query 4: List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.name AS animal_name, v.visit_date
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets vt ON v.vet_id = vt.id
WHERE vt.name = 'Stephanie Mendez'
AND v.visit_date BETWEEN '2020-04-01' AND '2020-08-30'
ORDER BY v.visit_date;

-- Query 5: What animal has the most visits to vets?
SELECT a.name AS animal_name, COUNT(v.animal_id) AS visit_count
FROM animals a
JOIN visits v ON a.id = v.animal_id
GROUP BY a.name
ORDER BY visit_count DESC
LIMIT 1;

-- Query 6: Who was Maisy Smith's first visit?
SELECT a.name AS animal_name, v.visit_date
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets vt ON v.vet_id = vt.id
WHERE vt.name = 'Maisy Smith'
ORDER BY v.visit_date
LIMIT 1;

-- Query 7: Details for most recent visit: animal information, vet information, and date of visit.
SELECT a.name AS animal_name, vt.name AS vet_name, v.visit_date
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets vt ON v.vet_id = vt.id
ORDER BY v.visit_date DESC
LIMIT 1;

-- Query 8: How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) AS visits_count
FROM visits v
JOIN vets vt ON v.vet_id = vt.id
JOIN animals a ON v.animal_id = a.id
LEFT JOIN specializations sp ON vt.id = sp.vet_id AND a.species_id = sp.species_id
WHERE sp.vet_id IS NULL;

-- Query 9: What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT s.name AS specialty, COUNT(*) AS visits_count
FROM visits v
JOIN vets vt ON v.vet_id = vt.id
JOIN animals a ON v.animal_id = a.id
JOIN specializations sp ON vt.id = sp.vet_id AND a.species_id = sp.species_id
JOIN species s ON sp.species_id = s.id
WHERE vt.name = 'Maisy Smith'
GROUP BY s.name
ORDER BY visits_count DESC
LIMIT 1;


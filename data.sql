-- data.sql

-- INSERT animals data
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES ('Agumon', '2020-02-03', 0, TRUE, 10.23, NULL);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES ('Gabumon', '2018-11-15', 2, TRUE, 8, NULL);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES ('Pikachu', '2021-01-07', 1, FALSE, 15.04, NULL);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES ('Devimon', '2017-05-12', 5, TRUE, 11, NULL);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES ('Charmander', '2020-02-08', 0, FALSE, -11, NULL);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES ('Plantmon', '2021-11-15', 2, TRUE, -5.7, NULL);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES ('Squirtle', '1993-04-02', 3, FALSE, -12.13, NULL);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES ('Angemon', '2005-06-12', 1, TRUE, -45, NULL);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES ('Boarmon', '2005-06-07', 7, TRUE, 20.4, NULL);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES ('Blossom', '1998-10-13', 3, TRUE, 17, NULL);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species)
VALUES ('Ditto', '2022-05-14', 4, TRUE, 22, NULL);

-- Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that the species columns went back to the state before the transaction.
BEGIN;

UPDATE animals SET species = 'unspecified';

-- Verify the change (optional)
SELECT * FROM animals;

ROLLBACK;

-- Verify that the species column went back to the original state (optional)
SELECT * FROM animals;


BEGIN;

-- Update species to 'digimon' for animals whose name ends in 'mon'
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

-- Update species to 'pokemon' for animals without a species set
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

-- Verify the changes (optional)
SELECT * FROM animals;

-- Inside a transaction delete all records in the animals table, then roll back the transaction.
BEGIN;

-- Delete all records in the animals table
DELETE FROM animals;

-- Verify that records were deleted (optional)
SELECT * FROM animals;

ROLLBACK;

-- Verify that all records in the animals table still exist (optional)
SELECT * FROM animals;

-- Inside a transaction:
-- Update the animals table by setting the species column to digimon for all animals that have a name ending in 'mon'.
-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
-- Verify that changes were made.
BEGIN;

-- Update species to 'digimon' for animals whose name ends in 'mon'
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

-- Update species to 'pokemon' for animals without a species set
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

-- Verify the changes (optional)
SELECT * FROM animals;

-- Answering the additional questions

-- How many animals are there?
SELECT COUNT(*) AS total_animals FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) AS never_escaped FROM animals WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) AS average_weight FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, MAX(escape_attempts) AS max_escape_attempts FROM animals GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) AS average_escape_attempts FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

-- Rollback the transaction
ROLLBACK;

-- data.sql

-- Create the species table
CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

-- Create the owners table
CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    age INTEGER
);

-- Create the animals table
CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INTEGER NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg NUMERIC NOT NULL,
    species_id INTEGER REFERENCES species(id),
    owner_id INTEGER REFERENCES owners(id)
);

-- Create the vets table
CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INTEGER NOT NULL,
    date_of_graduation DATE NOT NULL
);

-- Create the specializations join table
CREATE TABLE specializations (
    vet_id INTEGER REFERENCES vets(id),
    species_id INTEGER REFERENCES species(id),
    PRIMARY KEY (vet_id, species_id)
);

-- Create the visits join table
CREATE TABLE visits (
    vet_id INTEGER REFERENCES vets(id),
    animal_id INTEGER REFERENCES animals(id),
    visit_date DATE NOT NULL,
    PRIMARY KEY (vet_id, animal_id, visit_date)
);

-- INSERT animals data
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg, species_id, owner_id)
VALUES ('Agumon', '2020-02-03', 0, TRUE, 10.23, 2, 1),
       ('Gabumon', '2018-11-15', 2, TRUE, 8, 2, 2),
       ('Pikachu', '2021-01-07', 1, FALSE, 15.04, 1, 2),
       ('Devimon', '2017-05-12', 5, TRUE, 11, 2, 3),
       ('Charmander', '2020-02-08', 0, FALSE, -11, 1, 4),
       ('Plantmon', '2021-11-15', 2, TRUE, -5.7, 2, 3),
       ('Squirtle', '1993-04-02', 3, FALSE, -12.13, 1, 4),
       ('Angemon', '2005-01-12', 1, TRUE, -45, 2, 5),
       ('Boarmon', '2005-01-07', 7, TRUE, 20.4, 2, 5),
       ('Blossom', '1998-10-13', 3, TRUE, 17, 1, 4),
       ('Ditto', '2022-05-14', 4, TRUE, 22, 1, NULL);

-- INSERT owners data
INSERT INTO owners (full_name, age) VALUES 
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);

-- INSERT species data
INSERT INTO species (name) VALUES ('Pokemon'), ('Digimon');

-- INSERT into vets table
INSERT INTO vets (name, age, date_of_graduation) VALUES 
    ('William Tatcher', 45, '2000-04-23'),
    ('Maisy Smith', 26, '2019-01-17'),
    ('Stephanie Mendez', 64, '1981-05-04'),
    ('Jack Harkness', 38, '2008-01-08');

-- INSERT into specializations table
INSERT INTO specializations (vet_id, species_id)
VALUES ((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM species WHERE name = 'Pokemon'));
INSERT INTO specializations (vet_id, species_id)
VALUES ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Pokemon'));
INSERT INTO specializations (vet_id, species_id)
VALUES ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM species WHERE name = 'Digimon'));
INSERT INTO specializations (vet_id, species_id)
VALUES ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM species WHERE name = 'Digimon'));

-- INSERT into visits table
INSERT INTO visits (vet_id, animal_id, visit_date)
VALUES ((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM animals WHERE name = 'Agumon'), '2020-05-24');
INSERT INTO visits (vet_id, animal_id, visit_date)
VALUES ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Agumon'), '2020-07-22');
INSERT INTO visits (vet_id, animal_id, visit_date)
VALUES ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Gabumon'), '2021-02-02');
INSERT INTO visits (vet_id, animal_id, visit_date)
VALUES ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Pikachu'), '2020-01-05');
INSERT INTO visits (vet_id, animal_id, visit_date)
VALUES ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Pikachu'), '2020-03-08');
INSERT INTO visits (vet_id, animal_id, visit_date)
VALUES ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Pikachu'), '2020-05-14');
INSERT INTO visits (vet_id, animal_id, visit_date)
VALUES ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name = 'Devimon'), '2021-05-04');
INSERT INTO visits (vet_id, animal_id, visit_date)
VALUES ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Charmander'), '2021-02-24');
INSERT INTO visits (vet_id, animal_id, visit_date)
VALUES ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Plantmon'), '2019-12-21');
INSERT INTO visits (vet_id, animal_id, visit_date)
VALUES ((SELECT id FROM vets WHERE name = 'William Tatcher'), (SELECT id FROM animals WHERE name = 'Plantmon'), '2020-08-10');
INSERT INTO visits (vet_id, animal_id, visit_date)
VALUES ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Plantmon'), '2021-04-07');
INSERT INTO visits (vet_id, animal_id, visit_date)
VALUES ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'), (SELECT id FROM animals WHERE name

/* Database schema to keep the structure of the entire database. */

-- Create a temporary 'animals' table with a single column 'name'.
CREATE TABLE animals (
    name varchar(100)
);

-- Create the database 'vet_clinic' if it does not already exist.
CREATE DATABASE IF NOT EXISTS vet_clinic;

-- Switch to use the 'vet_clinic' database.
USE vet_clinic;

-- Create the 'animals' table with the specified columns.
CREATE TABLE IF NOT EXISTS animals (
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT, -- Unique identifier for each animal (auto-incremented).
  name VARCHAR(100) NOT NULL, -- Name of the animal (required, cannot be null).
  date_of_birth DATE NOT NULL, -- Date of birth of the animal (required, cannot be null).
  escape_attempts INT NOT NULL, -- Number of escape attempts of the animal (required, cannot be null).
  neutered BOOLEAN, -- Boolean flag indicating if the animal is neutered (optional).
  weight_kg DECIMAL(5, 2) NOT NULL, -- Weight of the animal in kilograms (required, cannot be null).
  species VARCHAR(50) -- Species of the animal (optional).
);

-- Add the 'species' column to the 'animals' table.
ALTER TABLE animals ADD COLUMN species VARCHAR(50);

-- Create the 'owners' table with the specified columns.
CREATE TABLE owners (
    id SERIAL PRIMARY KEY, -- Unique identifier for each owner (auto-incremented).
    full_name VARCHAR(255) NOT NULL, -- Full name of the owner (required, cannot be null).
    age INTEGER NOT NULL -- Age of the owner (required, cannot be null).
);

-- Create the 'species' table with the specified columns.
CREATE TABLE species (
    id SERIAL PRIMARY KEY, -- Unique identifier for each species (auto-incremented).
    name VARCHAR(255) NOT NULL -- Name of the species (required, cannot be null).
);

-- Remove the 'species' column from the 'animals' table.
ALTER TABLE animals DROP COLUMN species;

-- Add the 'species_id' column to the 'animals' table and make it a foreign key referencing the 'species' table.
ALTER TABLE animals ADD COLUMN species_id BIGINT REFERENCES species (id);

-- Add a constraint to ensure uniqueness of the 'species_id' in the 'animals' table.
ALTER TABLE animals ADD CONSTRAINT species_constraint UNIQUE (species_id);

-- Add the 'owner_id' column to the 'animals' table and make it a foreign key referencing the 'owners' table.
ALTER TABLE animals ADD COLUMN owner_id BIGINT REFERENCES owners (id);

-- Add a constraint to ensure uniqueness of the 'owner_id' in the 'animals' table.
ALTER TABLE animals ADD CONSTRAINT animal_owners_id UNIQUE (owner_id);

-- Create the 'vets' table with the specified columns.
CREATE TABLE vets (
    id SERIAL PRIMARY KEY, -- Unique identifier for each vet (auto-incremented).
    name VARCHAR(255) NOT NULL, -- Name of the vet (required, cannot be null).
    age INTEGER NOT NULL, -- Age of the vet (required, cannot be null).
    date_of_graduation DATE -- Date of graduation of the vet (optional).
);

-- Create the 'specializations' table to handle the many-to-many relationship between 'vets' and 'species'.
CREATE TABLE specializations (
  id SERIAL PRIMARY KEY, -- Unique identifier for each specialization (auto-incremented).
  vet_id INT, -- Foreign key referencing the 'vets' table.
  species_id INT, -- Foreign key referencing the 'species' table.
  FOREIGN KEY (vet_id) REFERENCES vets(id), -- Ensure the vet_id references an existing vet.
  FOREIGN KEY (species_id) REFERENCES species(id) -- Ensure the species_id references an existing species.
);

-- Create the 'visits' table to handle the many-to-many relationship between 'vets' and 'animals'.
CREATE TABLE visits (
  id SERIAL PRIMARY KEY, -- Unique identifier for each visit (auto-incremented).
  vet_id INT, -- Foreign key referencing the 'vets' table.
  animal_id INT, -- Foreign key referencing the 'animals' table.
  visit_date DATE, -- Date of the visit (optional).
  FOREIGN KEY (vet_id) REFERENCES vets(id), -- Ensure the vet_id references an existing vet.
  FOREIGN KEY (animal_id) REFERENCES animals(id) -- Ensure the animal_id references an existing animal.
);

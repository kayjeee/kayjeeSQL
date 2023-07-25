/* Populate database with sample data. */
-- data.sql
USE vet_clinic;

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES
('Agumon', '2020-02-03', 0, TRUE, 10.23),
('Gabumon', '2018-11-15', 2, TRUE, 8),
('Pikachu', '2021-01-07', 1, FALSE, 15.04),
('Devimon', '2017-05-12', 5, TRUE, 11);

INSERT INTO animals (name) VALUES ('Luna');
INSERT INTO animals (name) VALUES ('Daisy');
INSERT INTO animals (name) VALUES ('Charlie');

/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    name varchar(100)
);

CREATE DATABASE IF NOT EXISTS vet_clinic;

USE vet_clinic;

CREATE TABLE IF NOT EXISTS animals (
  id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  date_of_birth DATE NOT NULL,
  escape_attempts INT NOT NULL,
  neutered BOOLEAN,
  weight_kg DECIMAL(5, 2) NOT NULL,
  species VARCHAR(50)
);
-- Add the 'species' column to the 'animals' table
ALTER TABLE animals ADD COLUMN species VARCHAR(50);
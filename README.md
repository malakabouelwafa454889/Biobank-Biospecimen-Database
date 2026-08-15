# Biobank and Biospecimen Management System

## Project Overview

This project implements a relational database for managing biological specimens in a biotechnology biobank.

The system manages donors, consent records, sample collection events, biological samples, sample types, storage locations, aliquots, researchers, research projects, test requests, and sample usage.

## DBMS

MySQL

The database was designed and implemented using MySQL Workbench.

## Main Features

- Donor management
- Consent management
- Biospecimen collection
- Sample management
- Sample type management
- Storage location management
- Aliquot management
- Researcher management
- Research project management
- Researcher-project assignments
- Laboratory test requests
- Sample usage tracking
- Data integrity constraints
- Views
- Trigger
- Stored procedure

## Database Design

The database contains 13 relational tables and includes one-to-many and many-to-many relationships.

The many-to-many relationship between researchers and research projects is resolved using the 'researcher_project' associative table.

## SQL Files

- 'Biobank and Biospecimen Management System.sql' - creates the database tables, keys, constraints, and indexes.
- 'load_data.sql' - inserts the project test data.
- 'queries.sql' - contains retrieval, joins, aggregation, subqueries, INSERT, UPDATE, and DELETE operations.
- 'views.sql'- creates the database views.
- 'triggers_procedures.sql' - contains the trigger and stored procedure.
- 'testing.sql'- contains database testing and verification queries.


## ER Diagram

The final ER diagram is available in the `diagrams` folder.

## Project Status

Database implementation completed.

## Video Presentation 
https://drive.google.com/file/d/1IybKgXMtbSOJpaDpO__TK44GwixzEEtj/view?usp=sharing

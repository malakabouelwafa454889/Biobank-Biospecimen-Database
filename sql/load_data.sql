USE biobank_db;


-- 1. DONOR
INSERT INTO donor
(
    donor_code,
    date_of_birth,
    sex,
    blood_type,
    registration_date,
    status
)
VALUES
('D001', '1995-04-12', 'Female', 'A+',  '2026-01-10', 'Active'),
('D002', '1988-07-23', 'Male',   'O+',  '2026-01-12', 'Active'),
('D003', '1992-11-05', 'Female', 'B+',  '2026-01-15', 'Active'),
('D004', '1985-02-18', 'Male',   'AB+', '2026-01-18', 'Active'),
('D005', '1999-09-30', 'Female', 'O-',  '2026-01-20', 'Active'),
('D006', '1990-06-14', 'Male',   'A-',  '2026-01-22', 'Active'),
('D007', '1997-03-08', 'Female', 'B-',  '2026-01-25', 'Active'),
('D008', '1982-12-19', 'Male',   'AB-', '2026-01-28', 'Active'),
('D009', '1994-08-27', 'Female', 'O+',  '2026-02-01', 'Active'),
('D010', '1989-05-16', 'Male',   'A+',  '2026-02-05', 'Inactive');


-- 2. CONSENT
INSERT INTO consent
(
    donor_id,
    consent_date,
    consent_type,
    consent_status,
    expiry_date
)
VALUES
(1,  '2026-01-10', 'General Research',   'Active',   '2028-01-10'),
(2,  '2026-01-12', 'General Research',   'Active',   '2028-01-12'),
(3,  '2026-01-15', 'Genetic Research',   'Active',   '2028-01-15'),
(4,  '2026-01-18', 'General Research',   'Active',   '2028-01-18'),
(5,  '2026-01-20', 'Biomarker Research','Active',   '2028-01-20'),
(6,  '2026-01-22', 'Genetic Research',   'Active',   '2028-01-22'),
(7,  '2026-01-25', 'General Research',   'Active',   '2028-01-25'),
(8,  '2026-01-28', 'Biomarker Research','Active',   '2028-01-28'),
(9,  '2026-02-01', 'General Research',   'Active',   '2028-02-01'),
(10, '2026-02-05', 'General Research',   'Withdrawn', '2028-02-05');


-- 3. SAMPLE TYPE
INSERT INTO sample_type
(
    type_name,
    description
)
VALUES
('Whole Blood', 'Whole blood specimen collected for biomedical research'),
('Plasma',      'Plasma isolated from whole blood'),
('Serum',       'Serum separated from blood'),
('DNA',         'Purified DNA biological material'),
('RNA',         'Purified RNA biological material'),
('Tissue',      'Biological tissue specimen'),
('Urine',       'Urine specimen for laboratory analysis'),
('Saliva',      'Saliva specimen for molecular research'),
('PBMC',        'Peripheral blood mononuclear cells'),
('Tumor Tissue','Tumor tissue specimen for research');


-- 4. COLLECTION EVENT
INSERT INTO collection_event
(
    donor_id,
    collection_date,
    collection_site,
    collector_name,
    notes
)
VALUES
(1,  '2026-01-10 09:30:00', 'Cairo Biobank Center',       'Dr. Ahmed Hassan', 'Routine blood collection'),
(2,  '2026-01-12 10:00:00', 'Cairo Biobank Center',       'Dr. Sara Ali',     'Routine blood collection'),
(3,  '2026-01-15 08:45:00', 'Alexandria Research Center','Dr. Omar Khaled',  'Genetic research collection'),
(4,  '2026-01-18 11:15:00', 'Cairo Biobank Center',       'Dr. Mona Samir',   'Routine collection'),
(5,  '2026-01-20 09:00:00', 'Giza Medical Center',        'Dr. Ahmed Hassan', 'Biomarker study collection'),
(6,  '2026-01-22 12:30:00', 'Giza Medical Center',        'Dr. Sara Ali',     'Genetic research collection'),
(7,  '2026-01-25 10:45:00', 'Cairo Biobank Center',       'Dr. Omar Khaled',  'Routine collection'),
(8,  '2026-01-28 09:15:00', 'Alexandria Research Center','Dr. Mona Samir',   'Biomarker study collection'),
(9,  '2026-02-01 11:00:00', 'Cairo Biobank Center',       'Dr. Ahmed Hassan', 'Routine collection'),
(10, '2026-02-05 08:30:00', 'Giza Medical Center',        'Dr. Sara Ali',     'Research collection');


-- 5. SAMPLE
INSERT INTO sample
(
    sample_code,
    collection_id,
    sample_type_id,
    initial_volume_ml,
    remaining_volume_ml,
    collection_date,
    status
)
VALUES
('S001',  1,  1, 20.00, 18.00, '2026-01-10 09:30:00', 'Available'),
('S002',  2,  2, 15.00, 12.00, '2026-01-12 10:00:00', 'Available'),
('S003',  3,  3, 18.00, 15.00, '2026-01-15 08:45:00', 'Available'),
('S004',  4,  4, 10.00,  8.00, '2026-01-18 11:15:00', 'Available'),
('S005',  5,  5,  8.00,   6.00, '2026-01-20 09:00:00', 'In Use'),
('S006',  6,  6, 25.00, 20.00, '2026-01-22 12:30:00', 'Available'),
('S007',  7,  7, 30.00, 27.00, '2026-01-25 10:45:00', 'Available'),
('S008',  8,  8, 12.00, 10.00, '2026-01-28 09:15:00', 'Available'),
('S009',  9,  9, 16.00, 13.00, '2026-02-01 11:00:00', 'Available'),
('S010', 10, 10, 22.00, 18.00, '2026-02-05 08:30:00', 'Available');


-- 6. STORAGE LOCATION
INSERT INTO storage_location
(
    freezer_code,
    rack_code,
    box_code,
    position_code,
    temperature_c,
    capacity,
    status
)
VALUES
('F01', 'R01', 'B01', 'P01', -80.00, 10, 'Available'),
('F01', 'R01', 'B01', 'P02', -80.00, 10, 'Available'),
('F01', 'R01', 'B01', 'P03', -80.00, 10, 'Available'),
('F01', 'R02', 'B02', 'P01', -80.00, 10, 'Available'),
('F01', 'R02', 'B02', 'P02', -80.00, 10, 'Available'),
('F02', 'R01', 'B01', 'P01', -70.00, 15, 'Available'),
('F02', 'R01', 'B01', 'P02', -70.00, 15, 'Available'),
('F02', 'R01', 'B01', 'P03', -70.00, 15, 'Available'),
('F02', 'R02', 'B02', 'P01', -70.00, 15, 'Available'),
('F02', 'R02', 'B02', 'P02', -70.00, 15, 'Available');


-- 7. ALIQUOT
INSERT INTO aliquot
(
    aliquot_code,
    sample_id,
    location_id,
    volume_ml,
    created_date,
    status
)
VALUES
('A001',  1,  1, 5.00, '2026-01-10 10:00:00', 'Stored'),
('A002',  2,  2, 4.00, '2026-01-12 10:30:00', 'Stored'),
('A003',  3,  3, 5.00, '2026-01-15 09:15:00', 'Stored'),
('A004',  4,  4, 3.00, '2026-01-18 11:45:00', 'Stored'),
('A005',  5,  5, 2.00, '2026-01-20 09:30:00', 'Stored'),
('A006',  6,  6, 6.00, '2026-01-22 13:00:00', 'Stored'),
('A007',  7,  7, 7.00, '2026-01-25 11:15:00', 'Stored'),
('A008',  8,  8, 3.00, '2026-01-28 09:45:00', 'Stored'),
('A009',  9,  9, 4.00, '2026-02-01 11:30:00', 'Stored'),
('A010', 10, 10, 5.00, '2026-02-05 09:00:00', 'Stored');


-- 8. RESEARCHER
INSERT INTO researcher
(
    researcher_code,
    first_name,
    last_name,
    email,
    department,
    role
)
VALUES
('R001', 'Mariam',  'Ali',     'mariam.ali@biobank.com',      'Molecular Biology', 'Researcher'),
('R002', 'Ahmed',   'Hassan',  'ahmed.hassan@biobank.com',    'Genetics',          'Principal Investigator'),
('R003', 'Sara',    'Mohamed',  'sara.mohamed@biobank.com',   'Biochemistry',     'Researcher'),
('R004', 'Omar',    'Khaled',  'omar.khaled@biobank.com',     'Molecular Biology', 'Research Scientist'),
('R005', 'Mona',    'Samir',    'mona.samir@biobank.com',      'Genomics',          'Researcher'),
('R006', 'Youssef', 'Nabil',    'youssef.nabil@biobank.com',   'Immunology',        'Researcher'),
('R007', 'Nour',    'Ibrahim',  'nour.ibrahim@biobank.com',    'Biotechnology',     'Research Scientist'),
('R008', 'Karim',   'Mostafa',  'karim.mostafa@biobank.com',   'Genetics',          'Researcher'),
('R009', 'Laila',   'Fathy',    'laila.fathy@biobank.com',     'Pathology',         'Researcher'),
('R010', 'Hany',    'Adel',     'hany.adel@biobank.com',       'Molecular Biology', 'Lab Scientist');


-- 9. RESEARCH PROJECT
INSERT INTO research_project
(
    project_code,
    project_name,
    description,
    start_date,
    end_date,
    status
)
VALUES
('P001', 'Biomarker Discovery Study',
 'Identification of potential biomarkers using stored biological samples',
 '2026-01-01', '2027-01-01', 'Active'),

('P002', 'Cancer Genomics Study',
 'Genomic investigation of cancer-related biological samples',
 '2026-01-15', '2027-06-30', 'Active'),

('P003', 'Protein Expression Analysis',
 'Analysis of protein expression patterns in biological specimens',
 '2026-02-01', '2027-02-01', 'Active'),

('P004', 'Genetic Disease Research',
 'Investigation of genetic markers associated with inherited diseases',
 '2026-02-10', '2027-12-31', 'Active'),
 
 ('P005', 'Immunology Sample Study',
 'Study of immune-related biomarkers and biological responses',
 '2026-03-01', '2027-03-01', 'Planned'),

('P006', 'Molecular Diagnostics Study',
 'Evaluation of molecular diagnostic laboratory methods',
 '2026-03-15', '2027-09-30', 'Active'),

('P007', 'Precision Medicine Research',
 'Investigation of biological markers for personalized medicine',
 '2026-04-01', '2028-01-01', 'Planned'),

('P008', 'RNA Biomarker Investigation',
 'Analysis of RNA-based biomarkers in stored specimens',
 '2026-04-15', '2027-10-15', 'Active'),

('P009', 'Biological Sample Quality Study',
 'Evaluation of sample quality during long-term storage',
 '2026-05-01', '2026-12-31', 'Active'),

('P010', 'Translational Medicine Project',
 'Research supporting translation of laboratory findings into clinical applications',
 '2026-05-15', '2028-05-15', 'Planned');
 
 
 -- 10. RESEARCHER_PROJECT
INSERT INTO researcher_project
(
    researcher_id,
    project_id,
    assigned_date,
    project_role
)
VALUES
(1,  1,  '2026-01-05', 'Principal Researcher'),
(2,  1,  '2026-01-05', 'Supervisor'),
(3,  2,  '2026-01-20', 'Researcher'),
(4,  3,  '2026-02-05', 'Research Scientist'),
(5,  4,  '2026-02-15', 'Principal Researcher'),
(6,  5,  '2026-03-05', 'Researcher'),
(7,  6,  '2026-03-20', 'Research Scientist'),
(8,  7,  '2026-04-05', 'Researcher'),
(9,  8,  '2026-04-20', 'Researcher'),
(10, 9,  '2026-05-05', 'Lab Scientist');


-- 11. TEST TYPE
INSERT INTO test_type
(
    test_name,
    description,
    standard_unit
)
VALUES
('DNA Concentration',  'Measurement of DNA concentration',       'ng/uL'),
('RNA Concentration',  'Measurement of RNA concentration',       'ng/uL'),
('PCR Analysis',       'Polymerase chain reaction analysis',     'Positive/Negative'),
('ELISA',              'Enzyme-linked immunosorbent assay',     'IU/mL'),
('Protein Concentration','Measurement of protein concentration','mg/mL'),
('DNA Purity',         'Assessment of DNA purity',               'Ratio'),
('RNA Purity',         'Assessment of RNA purity',               'Ratio'),
('Cell Viability',     'Measurement of viable cells',            '%'),
('Biomarker Assay',    'Measurement of selected biomarkers',    'ng/mL'),
('Sequencing Quality', 'Assessment of sequencing sample quality','Score');


-- 12. TEST REQUEST
INSERT INTO test_request
(
    sample_id,
    researcher_id,
    test_type_id,
    request_date,
    completion_date,
    result,
    status
)
VALUES
(1,  1,  1,  '2026-01-12', '2026-01-13',
 'DNA concentration: 42.5 ng/uL', 'Completed'),

(2,  2,  2,  '2026-01-14', '2026-01-15',
 'RNA concentration: 31.2 ng/uL', 'Completed'),

(3,  3,  3,  '2026-01-17', '2026-01-18',
 'PCR result: Positive', 'Completed'),

(4,  4,  4,  '2026-01-20', '2026-01-21',
 'ELISA result: 15.8 IU/mL', 'Completed'),

(5,  5,  5,  '2026-01-22', '2026-01-23',
 'Protein concentration: 4.7 mg/mL', 'Completed'),

(6,  6,  6,  '2026-01-24', '2026-01-25',
 'DNA purity ratio: 1.82', 'Completed'),
 
 (7,  7,  7,  '2026-01-27', '2026-01-28',
 'RNA purity ratio: 2.01', 'Completed'),

(8,  8,  8,  '2026-01-30', '2026-01-31',
 'Cell viability: 94%', 'Completed'),

(9,  9,  9,  '2026-02-03', NULL,
 NULL, 'In Progress'),

(10, 10, 10, '2026-02-07', NULL,
 NULL, 'Requested');
 
 
 -- 13. SAMPLE USAGE
INSERT INTO sample_usage
(
    sample_id,
    researcher_id,
    project_id,
    usage_date,
    volume_used_ml,
    purpose,
    notes
)
VALUES
(1,  1,  1, '2026-01-15', 1.00,
 'Biomarker analysis', 'Initial biomarker screening'),

(2,  2,  1, '2026-01-18', 1.50,
 'Biomarker analysis', 'Protein biomarker investigation'),

(3,  3,  2, '2026-01-20', 1.00,
 'Cancer genomics', 'Genomic analysis'),

(4,  4,  3, '2026-01-23', 0.50,
 'Protein analysis', 'Protein expression study'),

(5,  5,  4, '2026-01-25', 1.00,
 'Genetic analysis', 'Genetic marker investigation'),
 
 (6,  6,  5, '2026-01-28', 2.00,
 'Immunology research', 'Immune response analysis'),

(7,  7,  6, '2026-02-01', 1.00,
 'Molecular diagnostics', 'Diagnostic method evaluation'),

(8,  8,  7, '2026-02-05', 0.50,
 'Precision medicine', 'Biomarker profiling'),

(9,  9,  8, '2026-02-08', 1.00,
 'RNA biomarker study', 'RNA analysis'),

(10, 10, 9, '2026-02-10', 1.50,
 'Sample quality study', 'Long-term storage evaluation');
 
 







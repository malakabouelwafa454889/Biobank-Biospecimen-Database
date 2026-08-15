CREATE DATABASE biobank_db;
USE biobank_db;

-- 1. DONOR
CREATE TABLE donor (
    donor_id INT AUTO_INCREMENT PRIMARY KEY,
    donor_code VARCHAR(20) NOT NULL UNIQUE,
    date_of_birth DATE NOT NULL,
    sex ENUM('Male', 'Female', 'Other') NOT NULL,
    blood_type VARCHAR(5),
    registration_date DATE NOT NULL,
    status ENUM('Active', 'Inactive') NOT NULL DEFAULT 'Active',

    CONSTRAINT chk_donor_registration
        CHECK (registration_date >= '2000-01-01')
);


-- 2. CONSENT
CREATE TABLE consent (
    consent_id INT AUTO_INCREMENT PRIMARY KEY,
    donor_id INT NOT NULL,
    consent_date DATE NOT NULL,
    consent_type VARCHAR(100) NOT NULL,
    consent_status ENUM('Active', 'Withdrawn', 'Expired') NOT NULL,
    expiry_date DATE,

    CONSTRAINT fk_consent_donor
        FOREIGN KEY (donor_id)
        REFERENCES donor(donor_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT chk_consent_dates
        CHECK (
            expiry_date IS NULL
            OR expiry_date >= consent_date
        )
);

-- 3. SAMPLE TYPE
CREATE TABLE sample_type (
    sample_type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255)
);

-- 4. COLLECTION EVENT
CREATE TABLE collection_event (
    collection_id INT AUTO_INCREMENT PRIMARY KEY,
    donor_id INT NOT NULL,
    collection_date DATETIME NOT NULL,
    collection_site VARCHAR(100) NOT NULL,
    collector_name VARCHAR(100) NOT NULL,
    notes VARCHAR(500),

    CONSTRAINT fk_collection_donor
        FOREIGN KEY (donor_id)
        REFERENCES donor(donor_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- 5. SAMPLE

CREATE TABLE sample (
    sample_id INT AUTO_INCREMENT PRIMARY KEY,
    sample_code VARCHAR(30) NOT NULL UNIQUE,
    collection_id INT NOT NULL,
    sample_type_id INT NOT NULL,
    initial_volume_ml DECIMAL(10,2) NOT NULL,
    remaining_volume_ml DECIMAL(10,2) NOT NULL,
    collection_date DATETIME NOT NULL,
    status ENUM(
        'Available',
        'In Use',
        'Depleted',
        'Discarded'
    ) NOT NULL DEFAULT 'Available',

    CONSTRAINT fk_sample_collection
        FOREIGN KEY (collection_id)
        REFERENCES collection_event(collection_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
        
         CONSTRAINT fk_sample_type
        FOREIGN KEY (sample_type_id)
        REFERENCES sample_type(sample_type_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT chk_sample_initial_volume
        CHECK (initial_volume_ml > 0),

    CONSTRAINT chk_sample_remaining_volume
        CHECK (
            remaining_volume_ml >= 0
            AND remaining_volume_ml <= initial_volume_ml
        )
);

-- 6. STORAGE LOCATION
CREATE TABLE storage_location (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    freezer_code VARCHAR(20) NOT NULL,
    rack_code VARCHAR(20) NOT NULL,
    box_code VARCHAR(20) NOT NULL,
    position_code VARCHAR(10) NOT NULL,
    temperature_c DECIMAL(5,2) NOT NULL,
    capacity INT NOT NULL DEFAULT 10,
    status ENUM(
        'Available',
        'Full',
        'Maintenance'
    ) NOT NULL DEFAULT 'Available',

    CONSTRAINT uq_storage_position
        UNIQUE (
            freezer_code,
            rack_code,
            box_code,
            position_code
        ),

    CONSTRAINT chk_storage_capacity
        CHECK (capacity > 0),

    CONSTRAINT chk_storage_temperature
        CHECK (temperature_c <= -20)
);

-- 7. ALIQUOT
CREATE TABLE aliquot (
    aliquot_id INT AUTO_INCREMENT PRIMARY KEY,
    aliquot_code VARCHAR(30) NOT NULL UNIQUE,
    sample_id INT NOT NULL,
    location_id INT NOT NULL,
    volume_ml DECIMAL(10,2) NOT NULL,
    created_date DATETIME NOT NULL,
    status ENUM(
        'Stored',
        'Used',
        'Discarded'
    ) NOT NULL DEFAULT 'Stored',

    CONSTRAINT fk_aliquot_sample
        FOREIGN KEY (sample_id)
        REFERENCES sample(sample_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_aliquot_location
        FOREIGN KEY (location_id)
        REFERENCES storage_location(location_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT chk_aliquot_volume
        CHECK (volume_ml > 0)
);

-- 8. RESEARCHER
CREATE TABLE researcher (
    researcher_id INT AUTO_INCREMENT PRIMARY KEY,
    researcher_code VARCHAR(20) NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    department VARCHAR(100) NOT NULL,
    role VARCHAR(50) NOT NULL
);

-- 9. RESEARCH PROJECT
CREATE TABLE research_project (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    project_code VARCHAR(20) NOT NULL UNIQUE,
    project_name VARCHAR(150) NOT NULL,
    description VARCHAR(500),
    start_date DATE NOT NULL,
    end_date DATE,
    status ENUM(
        'Planned',
        'Active',
        'Completed',
        'Cancelled'
    ) NOT NULL DEFAULT 'Planned',

    CONSTRAINT chk_project_dates
        CHECK (
            end_date IS NULL
            OR end_date >= start_date
        )
);

-- 10. RESEARCHER_PROJECT
CREATE TABLE researcher_project (
    researcher_id INT NOT NULL,
    project_id INT NOT NULL,
    assigned_date DATE NOT NULL,
    project_role VARCHAR(50) NOT NULL,

    PRIMARY KEY (researcher_id, project_id),

    CONSTRAINT fk_rp_researcher
        FOREIGN KEY (researcher_id)
        REFERENCES researcher(researcher_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_rp_project
        FOREIGN KEY (project_id)
        REFERENCES research_project(project_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- 11. TEST TYPE
CREATE TABLE test_type (
    test_type_id INT AUTO_INCREMENT PRIMARY KEY,
    test_name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255),
    standard_unit VARCHAR(30)
);

-- 12. TEST REQUEST
CREATE TABLE test_request (
    test_request_id INT AUTO_INCREMENT PRIMARY KEY,
    sample_id INT NOT NULL,
    researcher_id INT NOT NULL,
    test_type_id INT NOT NULL,
    request_date DATE NOT NULL,
    completion_date DATE,
    result VARCHAR(500),
    status ENUM(
        'Requested',
        'In Progress',
        'Completed',
        'Cancelled'
    ) NOT NULL DEFAULT 'Requested',

    CONSTRAINT fk_test_sample
        FOREIGN KEY (sample_id)
        REFERENCES sample(sample_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
        
        CONSTRAINT fk_test_researcher
        FOREIGN KEY (researcher_id)
        REFERENCES researcher(researcher_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_test_type
        FOREIGN KEY (test_type_id)
        REFERENCES test_type(test_type_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT chk_test_dates
        CHECK (
            completion_date IS NULL
            OR completion_date >= request_date
        )
);

-- 13. SAMPLE USAGE
CREATE TABLE sample_usage (
    usage_id INT AUTO_INCREMENT PRIMARY KEY,
    sample_id INT NOT NULL,
    researcher_id INT NOT NULL,
    project_id INT NOT NULL,
    usage_date DATE NOT NULL,
    volume_used_ml DECIMAL(10,2) NOT NULL,
    purpose VARCHAR(255) NOT NULL,
    notes VARCHAR(500),

    CONSTRAINT fk_usage_sample
        FOREIGN KEY (sample_id)
        REFERENCES sample(sample_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_usage_researcher
        FOREIGN KEY (researcher_id)
        REFERENCES researcher(researcher_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_usage_project
        FOREIGN KEY (project_id)
        REFERENCES research_project(project_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT chk_usage_volume
        CHECK (volume_used_ml > 0)
);


CREATE INDEX idx_consent_donor
ON consent(donor_id);

CREATE INDEX idx_collection_donor
ON collection_event(donor_id);

CREATE INDEX idx_sample_collection
ON sample(collection_id);

CREATE INDEX idx_sample_type
ON sample(sample_type_id);

CREATE INDEX idx_aliquot_sample
ON aliquot(sample_id);

CREATE INDEX idx_aliquot_location
ON aliquot(location_id);

CREATE INDEX idx_test_request_sample
ON test_request(sample_id);

CREATE INDEX idx_test_request_researcher
ON test_request(researcher_id);

CREATE INDEX idx_sample_usage_sample
ON sample_usage(sample_id);

CREATE INDEX idx_sample_usage_project
ON sample_usage(project_id);


SHOW TABLES;


DESCRIBE donor;
DESCRIBE consent;
DESCRIBE sample_type;
DESCRIBE collection_event;
DESCRIBE sample;
DESCRIBE storage_location;
DESCRIBE aliquot;
DESCRIBE researcher;
DESCRIBE research_project;
DESCRIBE researcher_project;
DESCRIBE test_type;
DESCRIBE test_request;
DESCRIBE sample_usage;
















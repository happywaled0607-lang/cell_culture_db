CREATE DATABASE cell_culture_db;
USE cell_culture_db;


-- 1. Researchers Table
CREATE TABLE researchers (
    researcher_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    role VARCHAR(50) DEFAULT 'Lab Technician',
    department VARCHAR(100) NOT NULL
);

-- 2. Incubators Table
CREATE TABLE incubators (
    incubator_id INT AUTO_INCREMENT PRIMARY KEY,
    model_number VARCHAR(50) NOT NULL,
    temp_setting_c DECIMAL(4,1) NOT NULL CHECK (temp_setting_c BETWEEN 20.0 AND 45.0),
    co2_level_pct DECIMAL(3,1) NOT NULL CHECK (co2_level_pct BETWEEN 0.0 AND 20.0),
    status VARCHAR(30) DEFAULT 'Operational' CHECK (status IN ('Operational', 'Maintenance', 'Offline'))
);

-- 3. Media Types Table
CREATE TABLE media_types (
    media_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    formulation_details TEXT,
    storage_temp_c DECIMAL(3,1) DEFAULT 4.0
);

-- 4. Cell Lines Table
CREATE TABLE cell_lines (
    cell_line_id INT AUTO_INCREMENT PRIMARY KEY,
    cell_line_name VARCHAR(100) UNIQUE NOT NULL,
    organism VARCHAR(100) NOT NULL,
    tissue_source VARCHAR(100) NOT NULL,
    biosafety_level INT DEFAULT 1 CHECK (biosafety_level BETWEEN 1 AND 4)
);

-- 5. Culture Vessels Table
CREATE TABLE culture_vessels (
    vessel_id INT AUTO_INCREMENT PRIMARY KEY,
    vessel_type VARCHAR(50) NOT NULL, -- e.g., T-75 Flask, 6-Well Plate, Dish
    capacity_ml DECIMAL(6,2) NOT NULL,
    surface_area_cm2 DECIMAL(6,2) NOT NULL
);

-- 6. Experiments Table
CREATE TABLE experiments (
    experiment_id INT AUTO_INCREMENT PRIMARY KEY,
    researcher_id INT NOT NULL,
    title VARCHAR(150) NOT NULL,
    objective TEXT,
    start_date DATE NOT NULL,
    status VARCHAR(30) DEFAULT 'Planning' CHECK (status IN ('Planning', 'Active', 'Completed', 'Terminated')),
    FOREIGN KEY (researcher_id) REFERENCES researchers(researcher_id) ON DELETE RESTRICT
);

-- 7. Experiment Cell Lines (M:N Associative Table)
CREATE TABLE experiment_cell_lines (
    experiment_id INT NOT NULL,
    cell_line_id INT NOT NULL,
    target_outcome VARCHAR(150),
    PRIMARY KEY (experiment_id, cell_line_id),
    FOREIGN KEY (experiment_id) REFERENCES experiments(experiment_id) ON DELETE CASCADE,
    FOREIGN KEY (cell_line_id) REFERENCES cell_lines(cell_line_id) ON DELETE RESTRICT
);

-- 8. Passages Table
CREATE TABLE passages (
    passage_id INT AUTO_INCREMENT PRIMARY KEY,
    cell_line_id INT NOT NULL,
    vessel_id INT NOT NULL,
    media_id INT NOT NULL,
    incubator_id INT NOT NULL,
    experiment_id INT NOT NULL,
    passage_number INT NOT NULL CHECK (passage_number >= 0),
    seeding_density DECIMAL(10,2) NOT NULL,
    passage_date DATE NOT NULL,
    FOREIGN KEY (cell_line_id) REFERENCES cell_lines(cell_line_id) ON DELETE RESTRICT,
    FOREIGN KEY (vessel_id) REFERENCES culture_vessels(vessel_id) ON DELETE RESTRICT,
    FOREIGN KEY (media_id) REFERENCES media_types(media_id) ON DELETE RESTRICT,
    FOREIGN KEY (incubator_id) REFERENCES incubators(incubator_id) ON DELETE RESTRICT,
    FOREIGN KEY (experiment_id) REFERENCES experiments(experiment_id) ON DELETE CASCADE
);

-- 9. Observations Table
CREATE TABLE observations (
    observation_id INT AUTO_INCREMENT PRIMARY KEY,
    passage_id INT NOT NULL,
    researcher_id INT NOT NULL,
    observation_date DATETIME NOT NULL,
    confluence_pct INT NOT NULL CHECK (confluence_pct BETWEEN 0 AND 100),
    morphology_notes TEXT,
    FOREIGN KEY (passage_id) REFERENCES passages(passage_id) ON DELETE CASCADE,
    FOREIGN KEY (researcher_id) REFERENCES researchers(researcher_id) ON DELETE RESTRICT
);

-- 10. Contamination Tests Table
CREATE TABLE contamination_tests (
    test_id INT AUTO_INCREMENT PRIMARY KEY,
    passage_id INT NOT NULL,
    test_type VARCHAR(50) NOT NULL, -- e.g., Mycoplasma PCR, Bacterial Culture, Sterility
    test_date DATE NOT NULL,
    result_status VARCHAR(20) NOT NULL CHECK (result_status IN ('Negative', 'Positive', 'Pending')),
    FOREIGN KEY (passage_id) REFERENCES passages(passage_id) ON DELETE CASCADE
);

-- 11. Cryopreserved Stocks Table
CREATE TABLE cryopreserved_stocks (
    stock_id INT AUTO_INCREMENT PRIMARY KEY,
    passage_id INT NOT NULL,
    vial_code VARCHAR(50) UNIQUE NOT NULL,
    storage_location VARCHAR(100) NOT NULL, -- e.g., Liquid Nitrogen Tank A, Rack 2, Box B
    freeze_date DATE NOT NULL,
    total_vials INT NOT NULL CHECK (total_vials >= 0),
    FOREIGN KEY (passage_id) REFERENCES passages(passage_id) ON DELETE RESTRICT
);
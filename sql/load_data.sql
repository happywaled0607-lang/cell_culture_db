USE cell_culture_db;



-- 1. Insert Researchers 
INSERT INTO researchers (full_name, email, role, department) VALUES
('Dr. Youssif Abo El-Ezz', '3zz_1of1_6.7.25@lab.edu', 'Principal Investigator', 'Cellular Oncology'),
('Sarah Mahmoud', 'sarah.m@lab.edu', 'Senior Lab Technician', 'Tissue Engineering'),
('Omar Farouk', 'omar.farouk@lab.edu', 'Research Associate', 'Immunology'),
('Nour El-Din', 'nour.din@lab.edu', 'Lab Assistant', 'Cellular Oncology'),
('Dr. Mona Zaki', 'mona.zaki@lab.edu', 'Senior Scientist', 'Stem Cell Biology'),
('Khaled El-Sayed', 'khaled.sayed@lab.edu', 'Quality Control Specialist', 'Quality Assurance'),
('Youssef Ali', 'youssef.ali@lab.edu', 'Bio-programmer', 'Computational Biology'),
('Hoda Mansour', 'hoda.m@lab.edu', 'Lab Technician', 'Tissue Engineering'),
('Tarek Gamal', 'tarek.g@lab.edu', 'Research Fellow', 'Immunology'),
('Rania Nabil', 'rania.nabil@lab.edu', 'Lab Assistant', 'Stem Cell Biology');

-- 2. Insert Incubators 
INSERT INTO incubators (model_number, temp_setting_c, co2_level_pct, status) VALUES
('Thermo-Heracell-150i', 37.0, 5.0, 'Operational'),
('Thermo-Heracell-240i', 37.0, 5.0, 'Operational'),
('Eppendorf-Galaxy-48R', 37.0, 5.0, 'Operational'),
('Binder-CB170', 37.0, 7.5, 'Operational'),
('Panasonic-MCO-19AIC', 37.0, 5.0, 'Maintenance'),
('Memmert-ICO150', 36.5, 5.0, 'Operational'),
('Esco-CelCulture', 37.0, 5.0, 'Operational'),
('Thermo-Forma-3110', 37.0, 10.0, 'Operational'),
('NuAire-In-VitroCell', 37.0, 5.0, 'Offline'),
('Sheldon-Lap-CO2', 37.0, 5.0, 'Operational');

-- 3. Insert Media Types 
INSERT INTO media_types (name, formulation_details, storage_temp_c) VALUES
('DMEM High Glucose', 'Contains 4.5g/L D-Glucose, L-Glutamine, and Sodium Pyruvate', 4.0),
('RPMI-1640', 'Formulated with HEPES buffer and L-Glutamine for suspension cells', 4.0),
('EMEM', 'Eagle Minimum Essential Medium supplemented with non-essential amino acids', 4.0),
('F-12K Medium', 'Kaighn Modification of Ham F-12 Medium for specialized cell lines', 4.0),
('IMDM', 'Iscove Modified Dulbecco Medium for high-density hematopoietic cultures', 4.0),
('McCoy 5A', 'Modified medium supporting growth of primary mucosal cell types', 4.0),
('Leibovitz L-15', 'Designed for CO2-free incubator systems', 4.0),
('Ham F-12', 'Nutrient mixture for serum-free clonal growth', 4.0),
('StemFlex Medium', 'Feeder-free stem cell culture medium', 4.0),
('Opti-MEM I', 'Reduced-serum media optimized for transfection procedures', 4.0);

-- 4. Insert Cell Lines 
INSERT INTO cell_lines (cell_line_name, organism, tissue_source, biosafety_level) VALUES
('HeLa', 'Homo sapiens', 'Cervical Adenocarcinoma', 2),
('HEK293T', 'Homo sapiens', 'Embryonic Kidney', 2),
('CHO-K1', 'Cricetulus griseus', 'Ovary', 1),
('MCF-7', 'Homo sapiens', 'Mammary Gland Adenocarcinoma', 1),
('NIH-3T3', 'Mus musculus', 'Embryonic Fibroblast', 1),
('Jurkat', 'Homo sapiens', 'Peripheral Blood T-Lymphocyte', 1),
('A549', 'Homo sapiens', 'Lung Carcinoma', 2),
('Vero', 'Chlorocebus aethiops', 'Kidney Epithelium', 1),
('RAW 264.7', 'Mus musculus', 'Abelson Murine Leukemia Macrophage', 2),
('C2C12', 'Mus musculus', 'Skeletal Muscle Myoblast', 1);

-- 5. Insert Culture Vessels 
INSERT INTO culture_vessels (vessel_type, capacity_ml, surface_area_cm2) VALUES
('T-25 Flask', 25.0, 25.0),
('T-75 Flask', 75.0, 75.0),
('T-175 Flask', 175.0, 175.0),
('6-Well Plate', 15.0, 9.6),
('12-Well Plate', 12.0, 3.8),
('24-Well Plate', 12.0, 1.9),
('96-Well Plate', 10.0, 0.32),
('100mm Culture Dish', 20.0, 55.0),
('60mm Culture Dish', 10.0, 21.0),
('Erlenmeyer Spinner Flask', 250.0, 150.0);

-- 6. Insert Experiments 
INSERT INTO experiments (researcher_id, title, objective, start_date, status) VALUES
(1, 'Chemotherapy Drug Resistance Test', 'Evaluate paclitaxel cytotoxicity on cervical cancer lines', '2026-01-10', 'Completed'),
(2, 'CRISPR Cas9 Transfection Efficiency', 'Optimize lipofectamine transfection protocol in HEK293T', '2026-02-01', 'Active'),
(3, 'Monoclonal Antibody Yield Analysis', 'Measure protein production rate in CHO-K1 suspension', '2026-02-15', 'Active'),
(4, 'Estrogen Receptor Signaling', 'Track MCF-7 proliferation under estradiol exposure', '2026-03-01', 'Planning'),
(5, 'Fibroblast Wound Healing Assay', 'Measure migration rate of NIH-3T3 cells post-scratch', '2026-03-10', 'Active'),
(6, 'T-Cell Activation Dynamics', 'Monitor interleukin production upon Jurkat stimulation', '2026-04-05', 'Planning'),
(7, 'Viral Vector Replication Safety', 'Test lentiviral packaging in Vero cell line', '2026-04-20', 'Planning'),
(8, 'Macrophage Inflammatory Response', 'Analyze RAW 264.7 cytokine release after LPS exposure', '2026-05-01', 'Active'),
(9, 'Myoblast Differentiation Study', 'Induce muscle tube formation in C2C12 cell cultures', '2026-05-12', 'Planning'),
(10, 'A549 Hypoxia Adaptation Analysis', 'Measure cell survival rate under 1% oxygen tension', '2026-06-01', 'Active');

-- 7. Insert Experiment Cell Lines 
INSERT INTO experiment_cell_lines (experiment_id, cell_line_id, target_outcome) VALUES
(1, 1, 'Determine IC50 values'),
(2, 2, 'Achieve >80% GFP expression'),
(3, 3, 'Harvest 2g/L IgG antibody'),
(4, 4, 'Quantify proliferation index'),
(5, 5, 'Calculate wound closure speed'),
(6, 6, 'Measure IL-2 secretion level'),
(7, 8, 'Verify viral plaque formation'),
(8, 9, 'Quantify TNF-alpha production'),
(9, 10, 'Observe multi-nucleated myotubes'),
(10, 7, 'Analyze HIF-1alpha protein expression');

-- 8. Insert Passages 
INSERT INTO passages (cell_line_id, vessel_id, media_id, incubator_id, experiment_id, passage_number, seeding_density, passage_date) VALUES
(1, 2, 1, 1, 1, 5, 500000.00, '2026-01-12'),
(2, 2, 1, 2, 2, 12, 1000000.00, '2026-02-03'),
(3, 10, 2, 3, 3, 8, 2000000.00, '2026-02-16'),
(4, 1, 3, 4, 4, 3, 250000.00, '2026-03-02'),
(5, 2, 1, 1, 5, 15, 600000.00, '2026-03-11'),
(6, 4, 2, 6, 6, 20, 1500000.00, '2026-04-06'),
(7, 2, 1, 7, 10, 9, 700000.00, '2026-04-21'),
(8, 3, 5, 8, 7, 4, 800000.00, '2026-05-02'),
(9, 2, 1, 1, 8, 11, 450000.00, '2026-05-13'),
(10, 1, 1, 10, 9, 6, 300000.00, '2026-06-02');

-- 9. Insert Observations 
INSERT INTO observations (passage_id, researcher_id, observation_date, confluence_pct, morphology_notes) VALUES
(1, 2, '2026-01-14 10:00:00', 85, 'Normal epithelial morphology, healthy attachment.'),
(2, 2, '2026-02-05 11:30:00', 90, 'High confluence, ready for transfection.'),
(3, 3, '2026-02-18 09:15:00', 70, 'Suspension cells forming healthy clusters.'),
(4, 4, '2026-03-04 14:00:00', 60, 'Slightly slow doubling time, media changed.'),
(5, 2, '2026-03-13 16:20:00', 95, 'Monolayer complete, scratch assay initiated.'),
(6, 3, '2026-04-08 10:45:00', 80, 'Cells floating normally in suspension culture.'),
(7, 1, '2026-04-23 12:00:00', 75, 'Epithelial sheet forming well under 5% CO2.'),
(8, 6, '2026-05-04 15:30:00', 85, 'Good cell density, zero signs of stress.'),
(9, 2, '2026-05-15 09:00:00', 50, 'Elongated myogenic cells developing intact.'),
(10, 4, '2026-06-04 11:10:00', 88, 'Hypoxic conditions tolerated, high viability.');

-- 10. Insert Contamination Tests 
INSERT INTO contamination_tests (passage_id, test_type, test_date, result_status) VALUES
(1, 'Mycoplasma PCR', '2026-01-13', 'Negative'),
(2, 'Sterility Broth Test', '2026-02-04', 'Negative'),
(3, 'Bacterial Culture', '2026-02-17', 'Negative'),
(4, 'Mycoplasma PCR', '2026-03-03', 'Negative'),
(5, 'Sterility Broth Test', '2026-03-12', 'Negative'),
(6, 'Fungal Culture', '2026-04-07', 'Negative'),
(7, 'Mycoplasma PCR', '2026-04-22', 'Negative'),
(8, 'Bacterial Culture', '2026-05-03', 'Negative'),
(9, 'Endotoxin Assay', '2026-05-14', 'Negative'),
(10, 'Mycoplasma PCR', '2026-06-03', 'Negative');

-- 11. Insert Cryopreserved Stocks 
INSERT INTO cryopreserved_stocks (passage_id, vial_code, storage_location, freeze_date, total_vials) VALUES
(1, 'HELA-P5-V1', 'LN2-Tank-A / Rack-1 / Box-A', '2026-01-15', 10),
(2, 'HEK-P12-V1', 'LN2-Tank-A / Rack-1 / Box-B', '2026-02-06', 15),
(3, 'CHO-P8-V1', 'LN2-Tank-B / Rack-2 / Box-A', '2026-02-19', 20),
(4, 'MCF7-P3-V1', 'LN2-Tank-A / Rack-2 / Box-C', '2026-03-05', 8),
(5, '3T3-P15-V1', 'LN2-Tank-B / Rack-1 / Box-D', '2026-03-14', 12),
(6, 'JRK-P20-V1', 'LN2-Tank-C / Rack-3 / Box-A', '2026-04-09', 25),
(7, 'A549-P9-V1', 'LN2-Tank-A / Rack-3 / Box-B', '2026-04-24', 10),
(8, 'VERO-P4-V1', 'LN2-Tank-B / Rack-3 / Box-C', '2026-05-05', 14),
(9, 'RAW-P11-V1', 'LN2-Tank-C / Rack-1 / Box-A', '2026-05-16', 18),
(10, 'C2C12-P6-V1', 'LN2-Tank-A / Rack-4 / Box-A', '2026-06-05', 10);
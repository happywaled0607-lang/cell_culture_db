USE cell_culture_db;

-- View 1: Active Culture Passages Overview
CREATE OR REPLACE VIEW vw_active_passages AS
SELECT 
    p.passage_id,
    cl.cell_line_name,
    cl.organism,
    cv.vessel_type,
    inc.model_number AS incubator,
    e.title AS experiment_title,
    r.full_name AS researcher_name,
    p.passage_number,
    p.passage_date
FROM passages p
JOIN cell_lines cl ON p.cell_line_id = cl.cell_line_id
JOIN culture_vessels cv ON p.vessel_id = cv.vessel_id
JOIN incubators inc ON p.incubator_id = inc.incubator_id
JOIN experiments e ON p.experiment_id = e.experiment_id
JOIN researchers r ON e.researcher_id = r.researcher_id;

-- View 2: Cryopreservation Inventory Summary
CREATE OR REPLACE VIEW vw_cryo_inventory AS
SELECT 
    cs.stock_id,
    cl.cell_line_name,
    cs.vial_code,
    cs.storage_location,
    cs.total_vials,
    cs.freeze_date
FROM cryopreserved_stocks cs
JOIN passages p ON cs.passage_id = p.passage_id
JOIN cell_lines cl ON p.cell_line_id = cl.cell_line_id;
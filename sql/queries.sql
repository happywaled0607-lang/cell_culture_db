USE cell_culture_db;

-- 1. Multi-table JOIN: Detailed passage record with cell line, vessel, media, and incubator info
SELECT 
    p.passage_id,
    cl.cell_line_name,
    cv.vessel_type,
    mt.name AS media_name,
    inc.model_number AS incubator_model,
    p.passage_number,
    p.passage_date
FROM passages p
JOIN cell_lines cl ON p.cell_line_id = cl.cell_line_id
JOIN culture_vessels cv ON p.vessel_id = cv.vessel_id
JOIN media_types mt ON p.media_id = mt.media_id
JOIN incubators inc ON p.incubator_id = inc.incubator_id;

-- 2. Aggregation & GROUP BY: Average confluence percentage per Cell Line
SELECT 
    cl.cell_line_name,
    COUNT(obs.observation_id) AS total_observations,
    ROUND(AVG(obs.confluence_pct), 2) AS avg_confluence_pct
FROM cell_lines cl
JOIN passages p ON cl.cell_line_id = p.cell_line_id
JOIN observations obs ON p.passage_id = obs.passage_id
GROUP BY cl.cell_line_id, cl.cell_line_name;

-- 3. Nested Subquery: Retrieve cell lines with verified negative contamination tests
SELECT cell_line_id, cell_line_name, organism, biosafety_level
FROM cell_lines
WHERE cell_line_id IN (
    SELECT DISTINCT p.cell_line_id
    FROM passages p
    JOIN contamination_tests ct ON p.passage_id = ct.passage_id
    WHERE ct.result_status = 'Negative'
);

-- 4. Multi-table Aggregation: Total cryopreserved vials available per Cell Line
SELECT 
    cl.cell_line_name,
    SUM(cs.total_vials) AS total_frozen_vials
FROM cryopreserved_stocks cs
JOIN passages p ON cs.passage_id = p.passage_id
JOIN cell_lines cl ON p.cell_line_id = cl.cell_line_id
GROUP BY cl.cell_line_id, cl.cell_line_name
ORDER BY total_frozen_vials DESC;

-- 5. Data Modification: UPDATE incubator status post-maintenance
UPDATE incubators
SET status = 'Operational'
WHERE incubator_id = 5;

-- 6. Data Modification: DELETE test record safely using primary key
DELETE FROM contamination_tests
WHERE test_id = 10 AND result_status = 'Pending';
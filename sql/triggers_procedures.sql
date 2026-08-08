USE cell_culture_db;

-- 1. Stored Procedure: Fetch cell line activity summary
DELIMITER //
CREATE PROCEDURE sp_get_cell_line_summary(IN p_cell_line_id INT)
BEGIN
    SELECT 
        cl.cell_line_name,
        cl.organism,
        cl.biosafety_level,
        COUNT(DISTINCT p.passage_id) AS total_passages,
        COALESCE(SUM(cs.total_vials), 0) AS total_vials_in_stock
    FROM cell_lines cl
    LEFT JOIN passages p ON cl.cell_line_id = p.cell_line_id
    LEFT JOIN cryopreserved_stocks cs ON p.passage_id = cs.passage_id
    WHERE cl.cell_line_id = p_cell_line_id
    GROUP BY cl.cell_line_id, cl.cell_line_name, cl.organism, cl.biosafety_level;
END //
DELIMITER ;

-- 2. Stored Function: Count active experiments for a given researcher
DELIMITER //
CREATE FUNCTION fn_get_active_experiments(p_researcher_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE active_count INT;
    SELECT COUNT(*) INTO active_count
    FROM experiments
    WHERE researcher_id = p_researcher_id AND status = 'Active';
    RETURN active_count;
END //
DELIMITER ;
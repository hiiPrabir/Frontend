DELIMITER //

CREATE TRIGGER Check_Toxicity_Alert
BEFORE INSERT ON Side_Effect
FOR EACH ROW
BEGIN
    -- If the toxicity grade is 3 (Severe) or 4 (Life-threatening)
    IF NEW.toxicity_grade >= 3 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'CLINICAL ALERT: High toxicity grade detected! Therapy review required immediately.';
    END IF;
END; //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE Calculate_And_Insert_QALY(
    IN p_therapy_id VARCHAR(20), 
    IN p_treatment_cost DECIMAL(10,2), 
    IN p_improvement_score FLOAT
)
BEGIN
    DECLARE calculated_qaly FLOAT;
    DECLARE new_cost_id VARCHAR(20);
    
    -- Generate a simple ID for the cost record
    SET new_cost_id = CONCAT('CST-', p_therapy_id);

    -- Calculate the QALY score (Assuming improvement score is a percentage 0-100)
    -- Example: An 85% improvement yields a 0.85 QALY multiplier.
    SET calculated_qaly = p_improvement_score / 100.0;

    -- Automatically insert the final calculated record into the database
    INSERT INTO Cost_Analysis (cost_id, treatment_cost, qaly_score, therapy_id)
    VALUES (new_cost_id, p_treatment_cost, calculated_qaly, p_therapy_id);
    
END; //

DELIMITER ;

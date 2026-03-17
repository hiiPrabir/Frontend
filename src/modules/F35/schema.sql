-- 1. Patient Table
CREATE TABLE Patient (
    patient_id VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    gender VARCHAR(10)
);

-- 2. Therapy Table
CREATE TABLE Therapy (
    therapy_id VARCHAR(20) PRIMARY KEY,
    therapy_name VARCHAR(100),
    drug_name VARCHAR(100),
    dosage VARCHAR(50),
    duration VARCHAR(50),
    patient_id VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);

-- 3. Response Table
CREATE TABLE Response (
    response_id VARCHAR(20) PRIMARY KEY,
    improvement_score FLOAT,
    symptom_relief VARCHAR(100),
    outcome_date DATE,
    therapy_id VARCHAR(20),
    FOREIGN KEY (therapy_id) REFERENCES Therapy(therapy_id)
);

-- 4. Side Effect Table
CREATE TABLE Side_Effect (
    effect_id VARCHAR(20) PRIMARY KEY,
    toxicity_grade INT,
    severity VARCHAR(50),
    description TEXT,
    therapy_id VARCHAR(20),
    FOREIGN KEY (therapy_id) REFERENCES Therapy(therapy_id)
);

-- 5. Cost Analysis Table (With the required QALY metric)
CREATE TABLE Cost_Analysis (
    cost_id VARCHAR(20) PRIMARY KEY,
    treatment_cost DECIMAL(10, 2),
    qaly_score FLOAT,
    therapy_id VARCHAR(20),
    FOREIGN KEY (therapy_id) REFERENCES Therapy(therapy_id)
);
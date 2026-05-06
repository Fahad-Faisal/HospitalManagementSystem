

-- Patient table
CREATE TABLE IF NOT EXISTS patient (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    patient_id VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address TEXT,
    date_of_birth DATE,
    gender VARCHAR(10),
    blood_group VARCHAR(5),
    password VARCHAR(100) NOT NULL
);

-- ==================== CREATE (Insert) ====================
-- Add new patient
INSERT INTO patient (patient_id, name, email, phone, address, date_of_birth, gender, blood_group, password) 
VALUES ('PAT011', 'New Patient', 'new.patient@email.com', '+1-555-1111', '123 New St, City, State', '1990-01-01', 'Male', 'O+', 'patient123');

-- Add multiple patients at once
INSERT INTO patient (patient_id, name, email, phone, address, date_of_birth, gender, blood_group, password) VALUES
('PAT012', 'John Doe', 'john.doe@email.com', '+1-555-1112', '456 Oak St', '1985-05-10', 'Male', 'A+', 'patient123'),
('PAT013', 'Jane Smith', 'jane.smith@email.com', '+1-555-1113', '789 Pine St', '1990-08-15', 'Female', 'B+', 'patient123');

-- ==================== READ (Select) ====================
-- Get all patients
SELECT * FROM patient;

-- Get patient by ID
SELECT * FROM patient WHERE id = 1;

-- Get patient by patient_id
SELECT * FROM patient WHERE patient_id = 'PAT001';

-- Get patient by email
SELECT * FROM patient WHERE email = 'alice.brown@email.com';

-- Search patients by name (partial match)
SELECT * FROM patient WHERE name LIKE '%Alice%';

-- Get patients by blood group
SELECT * FROM patient WHERE blood_group = 'A+';

-- Get patients by gender
SELECT * FROM patient WHERE gender = 'Female';

-- Get patients by age range
SELECT * FROM patient WHERE date_of_birth BETWEEN '1980-01-01' AND '1990-12-31';

-- Get patient count
SELECT COUNT(*) as total_patients FROM patient;

-- Get patients with their appointment count
SELECT p.*, COUNT(a.id) as appointment_count 
FROM patient p
LEFT JOIN appointment a ON p.id = a.patient_id
GROUP BY p.id;

-- Get recent patients (last 30 days)
SELECT * FROM patient WHERE id > (SELECT MAX(id) - 10 FROM patient);

-- ==================== UPDATE ====================
-- Update patient name
UPDATE patient SET name = 'Updated Name' WHERE id = 1;

-- Update patient contact information
UPDATE patient SET phone = '+1-555-9999', email = 'newemail@email.com' WHERE patient_id = 'PAT001';

-- Update patient address
UPDATE patient SET address = '456 New Address, City, State 12345' WHERE id = 2;

-- Update patient blood group
UPDATE patient SET blood_group = 'AB+' WHERE id = 3;

-- Update patient password
UPDATE patient SET password = 'newpassword123' WHERE patient_id = 'PAT001';

-- Update multiple fields
UPDATE patient 
SET name = 'Updated Name', 
    phone = '+1-555-8888', 
    address = 'Updated Address'
WHERE id = 5;

-- ==================== DELETE ====================
-- Delete patient by ID
DELETE FROM patient WHERE id = 999;

-- Delete patient by patient_id
DELETE FROM patient WHERE patient_id = 'PAT999';

-- Delete patients without any appointments
DELETE FROM patient WHERE id NOT IN (SELECT DISTINCT patient_id FROM appointment);

-- Delete patients older than certain date
DELETE FROM patient WHERE date_of_birth < '1960-01-01';

-- Create database
CREATE DATABASE IF NOT EXISTS hospital_db;
USE hospital_db;

-- =====================================================
-- 2. CREATE ALL TABLES
-- =====================================================

-- Admin table
CREATE TABLE IF NOT EXISTS admin (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    name VARCHAR(100),
    email VARCHAR(100)
);

-- Patient table

-- Treatment table
CREATE TABLE IF NOT EXISTS treatment (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    appointment_id BIGINT UNIQUE NOT NULL,
    doctor_id BIGINT NOT NULL,
    patient_id BIGINT NOT NULL,
    diagnosis TEXT,
    symptoms TEXT,
    treatment_plan TEXT,
    treatment_date DATETIME,
    notes TEXT,
    FOREIGN KEY (appointment_id) REFERENCES appointment(id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctor(id),
    FOREIGN KEY (patient_id) REFERENCES patient(id)
);

-- Prescription table
CREATE TABLE IF NOT EXISTS prescription (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    treatment_id BIGINT NOT NULL,
    medicine_name VARCHAR(200),
    dosage VARCHAR(100),
    frequency VARCHAR(100),
    duration INT,
    instructions TEXT,
    FOREIGN KEY (treatment_id) REFERENCES treatment(id) ON DELETE CASCADE
);


-- Patient History table
CREATE TABLE IF NOT EXISTS patient_history (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    patient_id BIGINT NOT NULL,
    diagnosis TEXT,
    treatment TEXT,
    notes TEXT,
    record_date DATETIME,
    FOREIGN KEY (patient_id) REFERENCES patient(id) ON DELETE CASCADE
);

-- =====================================================
-- 3. INSERT DEMO DATA
-- =====================================================

-- Insert Admin
INSERT INTO admin (username, password, name, email) VALUES
('admin', 'admin123', 'System Administrator', 'admin@cityhospital.com'),
('admin2', 'admin123', 'John Admin', 'john.admin@cityhospital.com');


-- Insert Treatments
INSERT INTO treatment (appointment_id, doctor_id, patient_id, diagnosis, symptoms, treatment_plan, treatment_date, notes) VALUES
-- Treatment for appointment 1
(1, 1, 1, 'Hypertension and Mild Angina', 'Chest pain, shortness of breath, high BP', 'Prescribed Lisinopril 10mg daily, regular exercise, low sodium diet', DATE_SUB(NOW(), INTERVAL 30 DAY), 'Patient responded well to medication'),

-- Treatment for appointment 2
(2, 2, 2, 'Chronic Migraine', 'Severe headaches, sensitivity to light, nausea', 'Prescribed Sumatriptan for acute attacks, Propranolol for prevention', DATE_SUB(NOW(), INTERVAL 25 DAY), 'Recommended stress management'),

-- Treatment for appointment 3
(3, 3, 3, 'Acute Bronchitis', 'Fever, persistent cough, chest congestion', 'Prescribed Amoxicillin 500mg three times daily for 7 days', DATE_SUB(NOW(), INTERVAL 20 DAY), 'Advise rest and fluids'),

-- Treatment for appointment 4
(4, 4, 4, 'ACL Sprain', 'Knee swelling, pain on movement, difficulty walking', 'RICE therapy, prescribed Ibuprofen 400mg, physical therapy referral', DATE_SUB(NOW(), INTERVAL 18 DAY), 'Follow-up in 2 weeks'),

-- Treatment for appointment 5
(5, 5, 5, 'Contact Dermatitis', 'Red rash, itching, skin inflammation', 'Prescribed topical corticosteroid, antihistamines', DATE_SUB(NOW(), INTERVAL 15 DAY), 'Avoid identified irritants'),

-- Treatment for appointment 6
(6, 6, 6, 'Routine Gynecological Checkup', 'No symptoms, routine annual exam', 'All tests normal, advised regular checkups', DATE_SUB(NOW(), INTERVAL 12 DAY), 'Pap smear results normal'),

-- Treatment for appointment 7
(7, 7, 7, 'Generalized Anxiety Disorder', 'Excessive worry, difficulty sleeping, restlessness', 'Prescribed Sertraline 50mg daily, CBT therapy recommended', DATE_SUB(NOW(), INTERVAL 10 DAY), 'Follow-up in 4 weeks'),

-- Treatment for appointment 8
(8, 8, 8, 'Computer Vision Syndrome', 'Eye strain, dry eyes, blurred vision', 'Prescribed lubricating eye drops, 20-20-20 rule', DATE_SUB(NOW(), INTERVAL 8 DAY), 'Recommended blue light glasses');

-- Insert Prescriptions
INSERT INTO prescription (treatment_id, medicine_name, dosage, frequency, duration, instructions) VALUES
-- Prescriptions for treatment 1
(1, 'Lisinopril', '10mg', 'Once daily', 30, 'Take in the morning with food'),
(1, 'Aspirin', '81mg', 'Once daily', 30, 'Take with food to prevent stomach upset'),

-- Prescriptions for treatment 2
(2, 'Sumatriptan', '50mg', 'As needed for migraine', 10, 'Take at first sign of migraine'),
(2, 'Propranolol', '40mg', 'Twice daily', 30, 'Take consistently for prevention'),

-- Prescriptions for treatment 3
(3, 'Amoxicillin', '500mg', 'Three times daily', 7, 'Complete full course even if feeling better'),
(3, 'Acetaminophen', '500mg', 'As needed for fever', 5, 'Take every 6 hours for fever'),

-- Prescriptions for treatment 4
(4, 'Ibuprofen', '400mg', 'Three times daily', 10, 'Take with food, not on empty stomach'),
(4, 'Topical Diclofenac', NULL, 'Apply 2-3 times daily', 14, 'Apply to affected area only'),

-- Prescriptions for treatment 5
(5, 'Hydrocortisone Cream', '1%', 'Apply twice daily', 14, 'Apply thin layer to affected area'),
(5, 'Cetirizine', '10mg', 'Once daily', 10, 'Take at bedtime if drowsiness occurs'),

-- Prescriptions for treatment 6
(6, 'Prenatal Vitamins', NULL, 'Once daily', 90, 'Take with food for better absorption'),

-- Prescriptions for treatment 7
(7, 'Sertraline', '50mg', 'Once daily', 30, 'Take in the morning, may take 2-4 weeks for full effect'),
(7, 'Melatonin', '3mg', 'As needed for sleep', 30, 'Take 30 minutes before bedtime'),

-- Prescriptions for treatment 8
(8, 'Artificial Tears', NULL, 'As needed', 30, 'Use 1-2 drops per eye as needed for dryness'),
(8, 'Omega-3 Supplements', '1000mg', 'Once daily', 30, 'Take with food to support eye health');



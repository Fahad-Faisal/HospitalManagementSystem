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

-- Doctor table
CREATE TABLE IF NOT EXISTS doctor (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    doctor_id VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20) NOT NULL,
    specialization VARCHAR(100),
    qualification VARCHAR(200),
    experience INT,
    password VARCHAR(100) NOT NULL
);

-- Doctor Availability table
CREATE TABLE IF NOT EXISTS doctor_availability (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    doctor_id BIGINT NOT NULL,
    start_time DATETIME,
    end_time DATETIME,
    day_of_week VARCHAR(20),
    is_available BOOLEAN DEFAULT TRUE,
    duration VARCHAR(50),
    FOREIGN KEY (doctor_id) REFERENCES doctor(id) ON DELETE CASCADE
);

-- Appointment table
CREATE TABLE IF NOT EXISTS appointment (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    patient_id BIGINT NOT NULL,
    doctor_id BIGINT NOT NULL,
    appointment_date_time DATETIME NOT NULL,
    reason TEXT,
    status VARCHAR(20) DEFAULT 'SCHEDULED',
    FOREIGN KEY (patient_id) REFERENCES patient(id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES doctor(id) ON DELETE CASCADE
);

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

-- Billing table
CREATE TABLE IF NOT EXISTS billing (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    bill_number VARCHAR(50) UNIQUE NOT NULL,
    patient_id BIGINT NOT NULL,
    consultation_fee DECIMAL(10,2) DEFAULT 0,
    medicine_fee DECIMAL(10,2) DEFAULT 0,
    lab_fee DECIMAL(10,2) DEFAULT 0,
    other_charges DECIMAL(10,2) DEFAULT 0,
    total_amount DECIMAL(10,2) DEFAULT 0,
    tax DECIMAL(10,2) DEFAULT 0,
    discount DECIMAL(10,2) DEFAULT 0,
    net_amount DECIMAL(10,2) DEFAULT 0,
    bill_date DATETIME,
    status VARCHAR(20) DEFAULT 'PENDING',
    notes TEXT,
    FOREIGN KEY (patient_id) REFERENCES patient(id) ON DELETE CASCADE
);

-- Payment table
CREATE TABLE IF NOT EXISTS payment (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    billing_id BIGINT UNIQUE NOT NULL,
    amount DECIMAL(10,2),
    payment_method VARCHAR(20),
    transaction_id VARCHAR(100),
    payment_date DATETIME,
    status VARCHAR(20),
    FOREIGN KEY (billing_id) REFERENCES billing(id) ON DELETE CASCADE
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

-- Insert Doctors
INSERT INTO doctor (doctor_id, name, email, phone, specialization, qualification, experience, password) VALUES
('DOC001', 'Dr. John Smith', 'john.smith@cityhospital.com', '+1-555-0101', 'Cardiologist', 'MD, FACC', 15, 'doctor123'),
('DOC002', 'Dr. Sarah Johnson', 'sarah.johnson@cityhospital.com', '+1-555-0102', 'Neurologist', 'MD, PhD', 12, 'doctor123'),
('DOC003', 'Dr. Michael Brown', 'michael.brown@cityhospital.com', '+1-555-0103', 'Pediatrician', 'MD, FAAP', 10, 'doctor123'),
('DOC004', 'Dr. Emily Davis', 'emily.davis@cityhospital.com', '+1-555-0104', 'Orthopedic', 'MD, FACS', 8, 'doctor123'),
('DOC005', 'Dr. James Wilson', 'james.wilson@cityhospital.com', '+1-555-0105', 'Dermatologist', 'MD, FAAD', 7, 'doctor123'),
('DOC006', 'Dr. Lisa Anderson', 'lisa.anderson@cityhospital.com', '+1-555-0106', 'Gynecologist', 'MD, FACOG', 11, 'doctor123'),
('DOC007', 'Dr. Robert Taylor', 'robert.taylor@cityhospital.com', '+1-555-0107', 'Psychiatrist', 'MD, PhD', 9, 'doctor123'),
('DOC008', 'Dr. Maria Garcia', 'maria.garcia@cityhospital.com', '+1-555-0108', 'Ophthalmologist', 'MD, FACS', 6, 'doctor123');

-- Insert Patients
INSERT INTO patient (patient_id, name, email, phone, address, date_of_birth, gender, blood_group, password) VALUES
('PAT001', 'Alice Brown', 'alice.brown@email.com', '+1-555-1001', '123 Main St, New York, NY 10001', '1990-05-15', 'Female', 'A+', 'patient123'),
('PAT002', 'Bob Miller', 'bob.miller@email.com', '+1-555-1002', '456 Oak Ave, Los Angeles, CA 90001', '1985-08-22', 'Male', 'O+', 'patient123'),
('PAT003', 'Carol White', 'carol.white@email.com', '+1-555-1003', '789 Pine Rd, Chicago, IL 60601', '1992-03-10', 'Female', 'B+', 'patient123'),
('PAT004', 'David Green', 'david.green@email.com', '+1-555-1004', '321 Elm St, Houston, TX 77001', '1988-11-30', 'Male', 'AB+', 'patient123'),
('PAT005', 'Emma Black', 'emma.black@email.com', '+1-555-1005', '654 Maple Dr, Phoenix, AZ 85001', '1995-07-18', 'Female', 'A-', 'patient123'),
('PAT006', 'Frank Harris', 'frank.harris@email.com', '+1-555-1006', '987 Cedar Ln, Philadelphia, PA 19101', '1982-02-25', 'Male', 'O-', 'patient123'),
('PAT007', 'Grace Lee', 'grace.lee@email.com', '+1-555-1007', '147 Birch Blvd, San Antonio, TX 78201', '1993-09-12', 'Female', 'B-', 'patient123'),
('PAT008', 'Henry Clark', 'henry.clark@email.com', '+1-555-1008', '258 Walnut Ct, San Diego, CA 92101', '1987-04-05', 'Male', 'AB-', 'patient123'),
('PAT009', 'Ivy Martinez', 'ivy.martinez@email.com', '+1-555-1009', '369 Spruce Way, Dallas, TX 75201', '1991-12-20', 'Female', 'A+', 'patient123'),
('PAT010', 'Jack Robinson', 'jack.robinson@email.com', '+1-555-1010', '741 Ash Ave, San Jose, CA 95101', '1984-06-28', 'Male', 'O+', 'patient123');

-- Insert Doctor Availability (next 7 days)
INSERT INTO doctor_availability (doctor_id, start_time, end_time, day_of_week, is_available) VALUES
-- Dr. John Smith (Cardiologist)
(1, DATE_ADD(CURDATE(), INTERVAL 0 DAY) + INTERVAL 9 HOUR, DATE_ADD(CURDATE(), INTERVAL 0 DAY) + INTERVAL 17 HOUR, 'MONDAY', TRUE),
(1, DATE_ADD(CURDATE(), INTERVAL 1 DAY) + INTERVAL 9 HOUR, DATE_ADD(CURDATE(), INTERVAL 1 DAY) + INTERVAL 17 HOUR, 'TUESDAY', TRUE),
(1, DATE_ADD(CURDATE(), INTERVAL 2 DAY) + INTERVAL 9 HOUR, DATE_ADD(CURDATE(), INTERVAL 2 DAY) + INTERVAL 13 HOUR, 'WEDNESDAY', TRUE),
(1, DATE_ADD(CURDATE(), INTERVAL 3 DAY) + INTERVAL 9 HOUR, DATE_ADD(CURDATE(), INTERVAL 3 DAY) + INTERVAL 17 HOUR, 'THURSDAY', TRUE),

-- Dr. Sarah Johnson (Neurologist)
(2, DATE_ADD(CURDATE(), INTERVAL 0 DAY) + INTERVAL 10 HOUR, DATE_ADD(CURDATE(), INTERVAL 0 DAY) + INTERVAL 18 HOUR, 'MONDAY', TRUE),
(2, DATE_ADD(CURDATE(), INTERVAL 1 DAY) + INTERVAL 10 HOUR, DATE_ADD(CURDATE(), INTERVAL 1 DAY) + INTERVAL 18 HOUR, 'TUESDAY', TRUE),
(2, DATE_ADD(CURDATE(), INTERVAL 3 DAY) + INTERVAL 10 HOUR, DATE_ADD(CURDATE(), INTERVAL 3 DAY) + INTERVAL 16 HOUR, 'THURSDAY', TRUE),
(2, DATE_ADD(CURDATE(), INTERVAL 4 DAY) + INTERVAL 10 HOUR, DATE_ADD(CURDATE(), INTERVAL 4 DAY) + INTERVAL 18 HOUR, 'FRIDAY', TRUE),

-- Dr. Michael Brown (Pediatrician)
(3, DATE_ADD(CURDATE(), INTERVAL 0 DAY) + INTERVAL 8 HOUR, DATE_ADD(CURDATE(), INTERVAL 0 DAY) + INTERVAL 16 HOUR, 'MONDAY', TRUE),
(3, DATE_ADD(CURDATE(), INTERVAL 2 DAY) + INTERVAL 8 HOUR, DATE_ADD(CURDATE(), INTERVAL 2 DAY) + INTERVAL 16 HOUR, 'WEDNESDAY', TRUE),
(3, DATE_ADD(CURDATE(), INTERVAL 4 DAY) + INTERVAL 8 HOUR, DATE_ADD(CURDATE(), INTERVAL 4 DAY) + INTERVAL 16 HOUR, 'FRIDAY', TRUE),

-- Dr. Emily Davis (Orthopedic)
(4, DATE_ADD(CURDATE(), INTERVAL 1 DAY) + INTERVAL 9 HOUR, DATE_ADD(CURDATE(), INTERVAL 1 DAY) + INTERVAL 17 HOUR, 'TUESDAY', TRUE),
(4, DATE_ADD(CURDATE(), INTERVAL 2 DAY) + INTERVAL 9 HOUR, DATE_ADD(CURDATE(), INTERVAL 2 DAY) + INTERVAL 17 HOUR, 'WEDNESDAY', TRUE),
(4, DATE_ADD(CURDATE(), INTERVAL 4 DAY) + INTERVAL 9 HOUR, DATE_ADD(CURDATE(), INTERVAL 4 DAY) + INTERVAL 17 HOUR, 'FRIDAY', TRUE);

-- Insert Appointments
INSERT INTO appointment (patient_id, doctor_id, appointment_date_time, reason, status) VALUES
-- Past appointments
(1, 1, DATE_SUB(NOW(), INTERVAL 30 DAY), 'Chest pain and shortness of breath', 'COMPLETED'),
(2, 2, DATE_SUB(NOW(), INTERVAL 25 DAY), 'Severe headaches and migraines', 'COMPLETED'),
(3, 3, DATE_SUB(NOW(), INTERVAL 20 DAY), 'Fever and cough in child', 'COMPLETED'),
(4, 4, DATE_SUB(NOW(), INTERVAL 18 DAY), 'Knee pain after sports injury', 'COMPLETED'),
(5, 5, DATE_SUB(NOW(), INTERVAL 15 DAY), 'Skin rash and itching', 'COMPLETED'),
(6, 6, DATE_SUB(NOW(), INTERVAL 12 DAY), 'Annual gynecological checkup', 'COMPLETED'),
(7, 7, DATE_SUB(NOW(), INTERVAL 10 DAY), 'Anxiety and depression', 'COMPLETED'),
(8, 8, DATE_SUB(NOW(), INTERVAL 8 DAY), 'Vision problems and eye strain', 'COMPLETED'),

-- Today's appointments
(1, 1, DATE_ADD(CURDATE(), INTERVAL 9 HOUR), 'Follow-up for heart condition', 'SCHEDULED'),
(2, 2, DATE_ADD(CURDATE(), INTERVAL 10 HOUR), 'Neurological evaluation', 'SCHEDULED'),
(3, 3, DATE_ADD(CURDATE(), INTERVAL 11 HOUR), 'Child vaccination', 'SCHEDULED'),
(4, 4, DATE_ADD(CURDATE(), INTERVAL 14 HOUR), 'Back pain consultation', 'SCHEDULED'),
(5, 5, DATE_ADD(CURDATE(), INTERVAL 15 HOUR), 'Acne treatment follow-up', 'SCHEDULED'),

-- Future appointments
(6, 6, DATE_ADD(CURDATE(), INTERVAL 3 DAY) + INTERVAL 10 HOUR, 'Pregnancy consultation', 'SCHEDULED'),
(7, 7, DATE_ADD(CURDATE(), INTERVAL 4 DAY) + INTERVAL 11 HOUR, 'Therapy session', 'SCHEDULED'),
(8, 8, DATE_ADD(CURDATE(), INTERVAL 5 DAY) + INTERVAL 14 HOUR, 'Cataract evaluation', 'SCHEDULED'),
(9, 1, DATE_ADD(CURDATE(), INTERVAL 6 DAY) + INTERVAL 9 HOUR, 'Heart checkup', 'SCHEDULED'),
(10, 2, DATE_ADD(CURDATE(), INTERVAL 7 DAY) + INTERVAL 10 HOUR, 'Migraine treatment', 'SCHEDULED'),

-- Cancelled appointments
(1, 3, DATE_SUB(NOW(), INTERVAL 5 DAY), 'Child fever', 'CANCELLED'),
(2, 4, DATE_SUB(NOW(), INTERVAL 3 DAY), 'Sports injury', 'CANCELLED');

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

-- Insert Bills
INSERT INTO billing (bill_number, patient_id, consultation_fee, medicine_fee, lab_fee, other_charges, total_amount, tax, discount, net_amount, bill_date, status) VALUES
('BILL2024001', 1, 150.00, 45.00, 100.00, 0, 295.00, 29.50, 0, 324.50, DATE_SUB(NOW(), INTERVAL 30 DAY), 'PAID'),
('BILL2024002', 2, 200.00, 60.00, 150.00, 0, 410.00, 41.00, 20.00, 431.00, DATE_SUB(NOW(), INTERVAL 25 DAY), 'PAID'),
('BILL2024003', 3, 120.00, 35.00, 50.00, 0, 205.00, 20.50, 0, 225.50, DATE_SUB(NOW(), INTERVAL 20 DAY), 'PAID'),
('BILL2024004', 4, 180.00, 25.00, 200.00, 50.00, 455.00, 45.50, 50.00, 450.50, DATE_SUB(NOW(), INTERVAL 18 DAY), 'PAID'),
('BILL2024005', 5, 130.00, 40.00, 0, 0, 170.00, 17.00, 0, 187.00, DATE_SUB(NOW(), INTERVAL 15 DAY), 'PAID'),
('BILL2024006', 6, 250.00, 30.00, 300.00, 0, 580.00, 58.00, 100.00, 538.00, DATE_SUB(NOW(), INTERVAL 12 DAY), 'PAID'),
('BILL2024007', 7, 200.00, 55.00, 0, 0, 255.00, 25.50, 0, 280.50, DATE_SUB(NOW(), INTERVAL 10 DAY), 'PENDING'),
('BILL2024008', 8, 150.00, 20.00, 100.00, 0, 270.00, 27.00, 0, 297.00, DATE_SUB(NOW(), INTERVAL 8 DAY), 'PENDING'),
('BILL2024009', 1, 150.00, 0, 0, 0, 150.00, 15.00, 0, 165.00, NOW(), 'PENDING'),
('BILL2024010', 2, 200.00, 0, 0, 0, 200.00, 20.00, 0, 220.00, NOW(), 'PENDING');

-- Insert Payments
INSERT INTO payment (billing_id, amount, payment_method, transaction_id, payment_date, status) VALUES
(1, 324.50, 'CARD', 'TXN001234', DATE_SUB(NOW(), INTERVAL 30 DAY), 'SUCCESS'),
(2, 431.00, 'CASH', NULL, DATE_SUB(NOW(), INTERVAL 25 DAY), 'SUCCESS'),
(3, 225.50, 'ONLINE', 'ONLINE12345', DATE_SUB(NOW(), INTERVAL 20 DAY), 'SUCCESS'),
(4, 450.50, 'CARD', 'TXN005678', DATE_SUB(NOW(), INTERVAL 18 DAY), 'SUCCESS'),
(5, 187.00, 'CASH', NULL, DATE_SUB(NOW(), INTERVAL 15 DAY), 'SUCCESS'),
(6, 538.00, 'ONLINE', 'ONLINE67890', DATE_SUB(NOW(), INTERVAL 12 DAY), 'SUCCESS');

-- Insert Patient History
INSERT INTO patient_history (patient_id, diagnosis, treatment, notes, record_date) VALUES
(1, 'Hypertension', 'Lifestyle changes and medication', 'BP under control with medication', DATE_SUB(NOW(), INTERVAL 30 DAY)),
(2, 'Chronic Migraine', 'Preventive and acute treatment', 'Reduced frequency of attacks', DATE_SUB(NOW(), INTERVAL 25 DAY)),
(3, 'Acute Bronchitis', 'Antibiotics and rest', 'Full recovery', DATE_SUB(NOW(), INTERVAL 20 DAY)),
(4, 'ACL Sprain', 'Physical therapy', 'Improving gradually', DATE_SUB(NOW(), INTERVAL 18 DAY)),
(5, 'Contact Dermatitis', 'Topical steroids', 'Skin cleared', DATE_SUB(NOW(), INTERVAL 15 DAY));

-- =====================================================
-- 4. USEFUL QUERIES FOR TESTING
-- =====================================================

-- Basic SELECT Queries
SELECT * FROM patient;
SELECT * FROM doctor;
SELECT * FROM appointment;
SELECT * FROM treatment;
SELECT * FROM prescription;
SELECT * FROM billing;
SELECT * FROM payment;

-- JOIN Queries
-- Get all appointments with patient and doctor details
SELECT a.id, p.name as patient_name, d.name as doctor_name, a.appointment_date_time, a.status 
FROM appointment a
JOIN patient p ON a.patient_id = p.id
JOIN doctor d ON a.doctor_id = d.id;

-- Get treatments with prescriptions
SELECT t.id, p.name as patient_name, d.name as doctor_name, t.diagnosis, pr.medicine_name, pr.dosage
FROM treatment t
JOIN patient p ON t.patient_id = p.id
JOIN doctor d ON t.doctor_id = d.id
LEFT JOIN prescription pr ON t.id = pr.treatment_id;

-- Get billing with payment details
SELECT b.bill_number, p.name as patient_name, b.net_amount, b.status, 
       pay.amount as paid_amount, pay.payment_method, pay.payment_date
FROM billing b
JOIN patient p ON b.patient_id = p.id
LEFT JOIN payment pay ON b.id = pay.billing_id;

-- Aggregate Queries
-- Count appointments by status
SELECT status, COUNT(*) as count FROM appointment GROUP BY status;

-- Total revenue by month
SELECT DATE_FORMAT(bill_date, '%Y-%m') as month, SUM(net_amount) as total_revenue 
FROM billing WHERE status = 'PAID' 
GROUP BY DATE_FORMAT(bill_date, '%Y-%m')
ORDER BY month DESC;

-- Doctor performance
SELECT d.name, COUNT(a.id) as total_appointments, 
       SUM(CASE WHEN a.status = 'COMPLETED' THEN 1 ELSE 0 END) as completed,
       SUM(CASE WHEN a.status = 'CANCELLED' THEN 1 ELSE 0 END) as cancelled
FROM doctor d
LEFT JOIN appointment a ON d.id = a.doctor_id
GROUP BY d.id, d.name;

-- Top prescribed medicines
SELECT medicine_name, COUNT(*) as prescription_count
FROM prescription
GROUP BY medicine_name
ORDER BY prescription_count DESC
LIMIT 10;

-- Patient appointment history
SELECT p.name, COUNT(a.id) as total_appointments, 
       MIN(a.appointment_date_time) as first_visit,
       MAX(a.appointment_date_time) as last_visit
FROM patient p
LEFT JOIN appointment a ON p.id = a.patient_id
GROUP BY p.id, p.name;

-- Subquery Examples
-- Find doctors with more than 5 appointments
SELECT d.name, d.specialization, 
       (SELECT COUNT(*) FROM appointment a WHERE a.doctor_id = d.id) as appointment_count
FROM doctor d
WHERE (SELECT COUNT(*) FROM appointment a WHERE a.doctor_id = d.id) > 2;

-- Patients with pending bills
SELECT p.name, p.email, 
       (SELECT COUNT(*) FROM billing b WHERE b.patient_id = p.id AND b.status = 'PENDING') as pending_bills
FROM patient p
WHERE (SELECT COUNT(*) FROM billing b WHERE b.patient_id = p.id AND b.status = 'PENDING') > 0;

-- UPDATE Queries
-- Update appointment status
UPDATE appointment SET status = 'COMPLETED' WHERE id = 1;

-- Update bill status after payment
UPDATE billing SET status = 'PAID' WHERE id = 7;

-- Delete Queries
-- Delete cancelled appointment
DELETE FROM appointment WHERE status = 'CANCELLED' AND appointment_date_time < DATE_SUB(NOW(), INTERVAL 30 DAY);

-- Complex Queries with Multiple Joins
-- Complete patient treatment history with prescriptions
SELECT 
    p.name as patient_name,
    p.patient_id,
    d.name as doctor_name,
    a.appointment_date_time,
    t.diagnosis,
    t.treatment_plan,
    GROUP_CONCAT(CONCAT(pr.medicine_name, ' (', pr.dosage, ')') SEPARATOR ', ') as medicines
FROM patient p
JOIN appointment a ON p.id = a.patient_id
JOIN doctor d ON a.doctor_id = d.id
LEFT JOIN treatment t ON a.id = t.appointment_id
LEFT JOIN prescription pr ON t.id = pr.treatment_id
GROUP BY p.id, a.id, t.id;

-- Revenue analysis with patient details
SELECT 
    p.name,
    p.patient_id,
    COUNT(b.id) as bill_count,
    SUM(b.net_amount) as total_spent,
    AVG(b.net_amount) as average_bill,
    MAX(b.bill_date) as last_bill_date
FROM patient p
JOIN billing b ON p.id = b.patient_id
WHERE b.status = 'PAID'
GROUP BY p.id
ORDER BY total_spent DESC;

-- =====================================================
-- 5. CLEANUP QUERIES (Use with caution)
-- =====================================================

-- Delete all test data
-- DELETE FROM payment;
-- DELETE FROM billing;
-- DELETE FROM prescription;
-- DELETE FROM treatment;
-- DELETE FROM appointment;
-- DELETE FROM patient_history;
-- DELETE FROM doctor_availability;
-- DELETE FROM patient;
-- DELETE FROM doctor;
-- DELETE FROM admin;

-- Drop all tables
-- DROP TABLE IF EXISTS payment;
-- DROP TABLE IF EXISTS billing;
-- DROP TABLE IF EXISTS prescription;
-- DROP TABLE IF EXISTS treatment;
-- DROP TABLE IF EXISTS appointment;
-- DROP TABLE IF EXISTS patient_history;
-- DROP TABLE IF EXISTS doctor_availability;
-- DROP TABLE IF EXISTS patient;
-- DROP TABLE IF EXISTS doctor;
-- DROP TABLE IF EXISTS admin;

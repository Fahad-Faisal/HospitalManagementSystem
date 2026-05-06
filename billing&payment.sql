-- ==================== CREATE ====================
-- Create new bill
INSERT INTO billing (bill_number, patient_id, consultation_fee, medicine_fee, lab_fee, other_charges, total_amount, tax, discount, net_amount, bill_date, status) 
VALUES ('BILL2025001', 1, 150.00, 45.00, 100.00, 0, 295.00, 29.50, 0, 324.50, NOW(), 'PENDING');

-- ==================== READ ====================
-- Get all bills
SELECT * FROM billing;

-- Get bill by ID
SELECT * FROM billing WHERE id = 1;

-- Get bill by bill number
SELECT * FROM billing WHERE bill_number = 'BILL2024001';

-- Get bills for specific patient
SELECT * FROM billing WHERE patient_id = 1;

-- Get pending bills
SELECT * FROM billing WHERE status = 'PENDING';

-- Get paid bills
SELECT * FROM billing WHERE status = 'PAID';

-- Get bills with patient details
SELECT b.*, p.name as patient_name, p.patient_id 
FROM billing b
JOIN patient p ON b.patient_id = p.id;

-- Get total revenue by date range
SELECT SUM(net_amount) as total_revenue 
FROM billing 
WHERE status = 'PAID' 
AND bill_date BETWEEN '2024-12-01' AND '2024-12-31';

-- Get monthly revenue
SELECT DATE_FORMAT(bill_date, '%Y-%m') as month, SUM(net_amount) as revenue 
FROM billing 
WHERE status = 'PAID' 
GROUP BY DATE_FORMAT(bill_date, '%Y-%m')
ORDER BY month DESC;

-- ==================== UPDATE ====================
-- Update bill status to PAID
UPDATE billing SET status = 'PAID' WHERE id = 7;

-- Update bill amounts
UPDATE billing 
SET consultation_fee = 200.00, 
    medicine_fee = 60.00,
    total_amount = 260.00,
    net_amount = 286.00
WHERE id = 9;

-- Apply discount
UPDATE billing SET discount = 50.00, net_amount = net_amount - 50.00 WHERE id = 8;

-- ==================== DELETE ====================
-- Delete bill by ID
DELETE FROM billing WHERE id = 99;

-- Delete pending bills older than 90 days
DELETE FROM billing WHERE status = 'PENDING' AND bill_date < DATE_SUB(NOW(), INTERVAL 90 DAY);
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

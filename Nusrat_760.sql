CREATE TABLE appointment (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,

    patient_id BIGINT NOT NULL,
    doctor_id BIGINT NOT NULL,

    appointment_date_time DATETIME NOT NULL,

    reason VARCHAR(255),
    status VARCHAR(50),

    CONSTRAINT fk_patient
        FOREIGN KEY (patient_id)
        REFERENCES patient(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_doctor
        FOREIGN KEY (doctor_id)
        REFERENCES doctor(id)
        ON DELETE CASCADE
);



-- ==================== CREATE ====================
-- Book new appointment
INSERT INTO appointment (patient_id, doctor_id, appointment_date_time, reason, status) 
VALUES (1, 1, '2024-12-20 10:00:00', 'Regular checkup', 'SCHEDULED');


-- ==================== READ ====================
-- Get all appointments
SELECT * FROM appointment;

-- Get appointments by patient
SELECT * FROM appointment WHERE patient_id = 1;

-- Get appointments by doctor
SELECT * FROM appointment WHERE doctor_id = 2;

-- Get upcoming appointments
SELECT * FROM appointment 
WHERE appointment_date_time > NOW() AND status = 'SCHEDULED';


-- ==================== UPDATE ====================
-- Cancel appointment
UPDATE appointment 
SET status = 'CANCELLED' 
WHERE id = 1;

-- Reschedule appointment
UPDATE appointment 
SET appointment_date_time = '2024-12-25 15:00:00' 
WHERE id = 1;


-- ==================== DELETE ====================
-- Delete appointment
DELETE FROM appointment 
WHERE id = 1;

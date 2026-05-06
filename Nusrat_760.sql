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

